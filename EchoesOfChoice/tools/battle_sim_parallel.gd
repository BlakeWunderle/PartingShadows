extends SceneTree

## Parallel battle simulation coordinator.
## Splits stages across multiple Godot worker processes for faster runs.
##
## Usage: godot --path EchoesOfChoice --headless \
##        --script res://tools/battle_sim_parallel.gd -- [options]
##
## Options:
##   --jobs <n>   Number of worker processes (default: CPU count)
##   All other options are forwarded to battle_simulator.gd workers.

const SR := preload("res://scripts/tools/simulation_runner.gd")
const SC := preload("res://scripts/tools/sim_cache.gd")
const BSDB := preload("res://scripts/tools/battle_stage_db.gd")

var _json_path := ""
var _progressive := false
var _from_prog := 0
var _compact := false


func _init() -> void:
	var args := OS.get_cmdline_user_args()
	var jobs: int = OS.get_processor_count()
	var passthrough: Array[String] = []

	# Parse coordinator-specific args; collect the rest for workers.
	var i := 0
	while i < args.size():
		match args[i]:
			"--jobs":
				if i + 1 < args.size():
					jobs = int(args[i + 1])
					i += 1
			"--json":
				if i + 1 < args.size():
					_json_path = args[i + 1]
					i += 1
			"--progressive":
				_progressive = true
			"--compact":
				_compact = true
				passthrough.append("--compact")
			"--from":
				if i + 1 < args.size():
					_from_prog = int(args[i + 1])
					i += 1
			_:
				passthrough.append(args[i])
				# Forward the value of flags that take an argument.
				if args[i] in ["--sims", "--sample", "--progression",
						"--story", "--tier"] and i + 1 < args.size():
					i += 1
					passthrough.append(args[i])
		i += 1

	jobs = clampi(jobs, 1, 32)

	if _progressive:
		_run_progressive(jobs, passthrough)
		return

	# Ensure a run mode is present. Parallel coordinator needs --all or
	# --progression; single stage names don't benefit from parallelism.
	if not passthrough.has("--all") and not passthrough.has("--progression"):
		passthrough.append("--all")

	print("=== Parallel Battle Simulator ===")
	print("  Workers: %d" % jobs)
	print("  Args: %s\n" % " ".join(passthrough))

	var sw := Time.get_ticks_msec()
	var all_stages := _spawn_and_collect(jobs, passthrough)
	var elapsed := (Time.get_ticks_msec() - sw) / 1000.0

	if all_stages.is_empty():
		print("ERROR: No results collected from workers.")
		quit(1)
		return

	# Sort by story then progression stage.
	all_stages.sort_custom(func(a: Dictionary, b: Dictionary) -> bool:
		if a.story != b.story:
			return a.story < b.story
		return a.progression_stage < b.progression_stage)

	print("  Workers finished in %.1fs\n" % elapsed)

	var pass_count := 0
	var fail_count := 0
	for s: Dictionary in all_stages:
		if s.status == "PASS":
			pass_count += 1
		else:
			fail_count += 1

	if _compact:
		# Compact: one line per stage, only FAIL stages get detail.
		for s: Dictionary in all_stages:
			var line := "  %s: %.1f%% (target %d%%) %s" % [
				s.stage_name, s.overall_win_rate * 100,
				int(s.target_win_rate * 100), s.status]
			print(line)
		print("\n  Results: %d PASS, %d FAIL" % [pass_count, fail_count])
	else:
		# Verbose summary table.
		print("=" .repeat(80))
		print("  PARALLEL SIMULATION SUMMARY (%d workers, %d stages)" % [
			jobs, all_stages.size()])
		print("=" .repeat(80))
		print("  %-25s %10s %10s %14s %12s" % [
			"Battle", "Win Rate", "Target", "Range", "Status"])
		print("  " + "-".repeat(71))

		var total_wr := 0.0
		var total_ms := 0
		for s: Dictionary in all_stages:
			var low: float = s.target_win_rate - 0.03
			var high: float = s.target_win_rate + 0.03
			var range_str := "%d%% - %d%%" % [int(low * 100), int(high * 100)]
			print("  %-25s %9.1f%% %9d%% %14s %12s" % [
				s.stage_name, s.overall_win_rate * 100,
				int(s.target_win_rate * 100), range_str, s.status])
			total_wr += s.overall_win_rate
			total_ms += int(s.get("elapsed_ms", 0))

		print("\n  Passed: %d/%d" % [pass_count, all_stages.size()])
		print("  Average win rate: %.1f%%" % [total_wr / all_stages.size() * 100])
		print("  Worker sim time: %.1fs (sum of all workers)" % [total_ms / 1000.0])
		print("  Wall clock time: %.1fs" % elapsed)
		print("  Speedup: %.1fx" % [total_ms / 1000.0 / maxf(elapsed, 0.001)])

	_write_json(all_stages)
	quit()


func _run_progressive(jobs: int, passthrough: Array[String]) -> void:
	# Build stage list applying same filters workers would use.
	var stages := BSDB.get_all_stages()
	var story_filter := 0
	var tier_filter := ""
	for fi in passthrough.size():
		if passthrough[fi] == "--story" and fi + 1 < passthrough.size():
			story_filter = int(passthrough[fi + 1])
		if passthrough[fi] == "--tier" and fi + 1 < passthrough.size():
			tier_filter = passthrough[fi + 1]
	if story_filter > 0:
		stages = stages.filter(
			func(s: Dictionary) -> bool: return s.story == story_filter)
	if tier_filter != "":
		stages = stages.filter(
			func(s: Dictionary) -> bool: return s.tier == tier_filter)

	# Group by progression.
	var by_prog := {}
	for s: Dictionary in stages:
		var p: int = s.progression_stage
		if p < _from_prog:
			continue
		if not by_prog.has(p):
			by_prog[p] = []
		by_prog[p].append(s)
	var prog_keys: Array = by_prog.keys()
	prog_keys.sort()

	print("=== Parallel Progressive Simulator ===")
	print("  Workers: %d | Progressions: %s\n" % [jobs, prog_keys])

	var grand_sw := Time.get_ticks_msec()
	var all_stages: Array = []

	for prog: int in prog_keys:
		print("\n" + "=".repeat(60))
		print("  PROGRESSION %d  (%d battles)" % [prog, by_prog[prog].size()])
		print("=".repeat(60))

		# Build worker args for this progression only.
		var prog_args: Array[String] = []
		prog_args.append_array(passthrough)
		prog_args.append("--progression")
		prog_args.append(str(prog))

		var prog_stages := _spawn_and_collect(jobs, prog_args)
		if prog_stages.is_empty():
			print("  ERROR: No results for progression %d" % prog)
			break

		all_stages.append_array(prog_stages)

		# Check for failures.
		var failed := []
		for s: Dictionary in prog_stages:
			print("  %s: %.1f%% (%s)" % [
				s.stage_name, s.overall_win_rate * 100, s.status])
			if s.status != "PASS":
				failed.append(s)

		if not failed.is_empty():
			print("\n  PROGRESSION %d FAILED (%d/%d):" % [
				prog, failed.size(), prog_stages.size()])
			for f: Dictionary in failed:
				print("    %s: %.1f%% (target %d%%)" % [
					f.stage_name, f.overall_win_rate * 100,
					int(f.target_win_rate * 100)])
			break
		else:
			print("  PROGRESSION %d: ALL PASS" % prog)

	var elapsed := (Time.get_ticks_msec() - grand_sw) / 1000.0
	_print_progressive_summary(all_stages, elapsed)
	_write_json(all_stages)
	quit()


func _spawn_and_collect(jobs: int, passthrough: Array[String]) -> Array:
	DirAccess.make_dir_recursive_absolute(OS.get_user_data_dir())
	var godot_exe := OS.get_executable_path()
	if not godot_exe.contains("_console") and FileAccess.file_exists(
			godot_exe.replace(".exe", "_console.exe")):
		godot_exe = godot_exe.replace(".exe", "_console.exe")

	var pids: Array[int] = []
	for wi in jobs:
		var worker_json := "user://sim_worker_%d.json" % wi
		if FileAccess.file_exists(worker_json):
			DirAccess.remove_absolute(
				ProjectSettings.globalize_path(worker_json))

		var worker_args: Array[String] = [
			"--path", ProjectSettings.globalize_path("res://"),
			"--headless",
			"--script", "res://tools/battle_simulator.gd",
			"--",
		]
		worker_args.append_array(passthrough)
		worker_args.append("--worker")
		worker_args.append("%d/%d" % [wi, jobs])
		worker_args.append("--json")
		worker_args.append(worker_json)

		var pid := OS.create_process(godot_exe, worker_args)
		if pid > 0:
			pids.append(pid)

	# Wait for all workers.
	while true:
		var still_running := false
		for pid: int in pids:
			if OS.is_process_running(pid):
				still_running = true
				break
		if not still_running:
			break
		OS.delay_msec(500)

	# Collect results.
	var results: Array = []
	for wi in jobs:
		var worker_json := "user://sim_worker_%d.json" % wi
		if not FileAccess.file_exists(worker_json):
			continue
		var file := FileAccess.open(worker_json, FileAccess.READ)
		if file == null:
			continue
		var json := JSON.new()
		if json.parse(file.get_as_text()) == OK and json.data is Dictionary:
			var data: Dictionary = json.data
			if data.has("stages"):
				results.append_array(data.stages)
		file.close()
		DirAccess.remove_absolute(
			ProjectSettings.globalize_path(worker_json))

	results.sort_custom(func(a: Dictionary, b: Dictionary) -> bool:
		return a.get("stage_name", "") < b.get("stage_name", ""))
	return results


func _print_progressive_summary(all_stages: Array, elapsed: float) -> void:
	if all_stages.is_empty():
		return
	print("\n" + "=".repeat(60))
	print("  PROGRESSIVE SUMMARY (%d stages, %.1fs)" % [
		all_stages.size(), elapsed])
	print("=".repeat(60))
	print("  %-25s %10s %10s %12s" % ["Battle", "Win Rate", "Target", "Status"])
	print("  " + "-".repeat(57))
	var pass_count := 0
	for s: Dictionary in all_stages:
		print("  %-25s %9.1f%% %9d%% %12s" % [
			s.stage_name, s.overall_win_rate * 100,
			int(s.target_win_rate * 100), s.status])
		if s.status == "PASS":
			pass_count += 1
	print("\n  Passed: %d/%d" % [pass_count, all_stages.size()])


func _write_json(all_stages: Array) -> void:
	if _json_path == "" or all_stages.is_empty():
		return
	var json_str := JSON.stringify({"stages": all_stages}, "\t")
	var out_file := FileAccess.open(_json_path, FileAccess.WRITE)
	if out_file:
		out_file.store_string(json_str)
		out_file.close()
		print("\n  JSON report written to: %s" % _json_path)
	else:
		print("\n  ERROR: Could not write JSON report to: %s" % _json_path)
