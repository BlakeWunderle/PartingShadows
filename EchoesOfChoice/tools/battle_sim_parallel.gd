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

var _json_path := ""


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
			_:
				passthrough.append(args[i])
				# Forward the value of flags that take an argument.
				if args[i] in ["--sims", "--sample", "--progression",
						"--story", "--tier"] and i + 1 < args.size():
					i += 1
					passthrough.append(args[i])
		i += 1

	jobs = clampi(jobs, 1, 32)

	# Ensure a run mode is present. Parallel coordinator needs --all or
	# --progression; single stage names don't benefit from parallelism.
	if not passthrough.has("--all") and not passthrough.has("--progression"):
		passthrough.append("--all")

	# Ensure user:// directory exists for worker temp files.
	DirAccess.make_dir_recursive_absolute(OS.get_user_data_dir())

	print("=== Parallel Battle Simulator ===")
	print("  Workers: %d" % jobs)
	print("  Args: %s\n" % " ".join(passthrough))

	# Spawn workers. Use the console exe for headless operation.
	var godot_exe := OS.get_executable_path()
	# On Windows, Godot ships both a GUI exe and a console exe. The console
	# variant has _console in its name. OS.get_executable_path() may return
	# either depending on which was launched. Ensure we use the console one.
	if not godot_exe.contains("_console") and FileAccess.file_exists(
			godot_exe.replace(".exe", "_console.exe")):
		godot_exe = godot_exe.replace(".exe", "_console.exe")
	var pids: Array[int] = []

	for wi in jobs:
		var worker_json := "user://sim_worker_%d.json" % wi
		# Clean up any stale worker files.
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
		if pid <= 0:
			print("  ERROR: Failed to spawn worker %d" % wi)
		else:
			pids.append(pid)
			print("  Worker %d/%d started (PID %d)" % [wi, jobs, pid])

	if pids.is_empty():
		print("\nERROR: No workers started.")
		quit(1)
		return

	print("\n  Waiting for %d workers..." % pids.size())
	var sw := Time.get_ticks_msec()

	# Poll until all workers are done.
	while true:
		var still_running := false
		for pid: int in pids:
			if OS.is_process_running(pid):
				still_running = true
				break
		if not still_running:
			break
		OS.delay_msec(500)

	var elapsed := (Time.get_ticks_msec() - sw) / 1000.0
	print("  All workers finished in %.1fs\n" % elapsed)

	# Merge results.
	var all_stages := []
	var workers_ok := 0
	for wi in jobs:
		var worker_json := "user://sim_worker_%d.json" % wi
		if not FileAccess.file_exists(worker_json):
			print("  WARNING: Worker %d produced no output" % wi)
			continue

		var file := FileAccess.open(worker_json, FileAccess.READ)
		if file == null:
			print("  WARNING: Could not read worker %d output" % wi)
			continue

		var json_text := file.get_as_text()
		file.close()

		var json := JSON.new()
		if json.parse(json_text) != OK:
			print("  WARNING: Worker %d JSON parse error" % wi)
			continue

		var data: Dictionary = json.data
		if data.has("stages"):
			all_stages.append_array(data.stages)
		workers_ok += 1

		# Clean up temp file.
		DirAccess.remove_absolute(
			ProjectSettings.globalize_path(worker_json))

	if all_stages.is_empty():
		print("ERROR: No results collected from workers.")
		quit(1)
		return

	# Sort by story then progression stage.
	all_stages.sort_custom(func(a: Dictionary, b: Dictionary) -> bool:
		if a.story != b.story:
			return a.story < b.story
		return a.progression_stage < b.progression_stage)

	# Print unified summary.
	print("=" .repeat(80))
	print("  PARALLEL SIMULATION SUMMARY (%d workers, %d stages)" % [
		workers_ok, all_stages.size()])
	print("=" .repeat(80))
	print("  %-25s %10s %10s %14s %12s" % [
		"Battle", "Win Rate", "Target", "Range", "Status"])
	print("  " + "-".repeat(71))

	var total_wr := 0.0
	var pass_count := 0
	var total_ms := 0
	for s: Dictionary in all_stages:
		var low: float = s.target_win_rate - 0.03
		var high: float = s.target_win_rate + 0.03
		var range_str := "%d%% - %d%%" % [int(low * 100), int(high * 100)]
		print("  %-25s %9.1f%% %9d%% %14s %12s" % [
			s.stage_name, s.overall_win_rate * 100,
			int(s.target_win_rate * 100), range_str, s.status])
		total_wr += s.overall_win_rate
		if s.status == "PASS":
			pass_count += 1
		total_ms += int(s.get("elapsed_ms", 0))

	print("\n  Passed: %d/%d" % [pass_count, all_stages.size()])
	print("  Average win rate: %.1f%%" % [total_wr / all_stages.size() * 100])
	print("  Worker sim time: %.1fs (sum of all workers)" % [total_ms / 1000.0])
	print("  Wall clock time: %.1fs" % elapsed)
	print("  Speedup: %.1fx" % [total_ms / 1000.0 / maxf(elapsed, 0.001)])

	# Write merged JSON if requested.
	if _json_path != "":
		var json_str := JSON.stringify({"stages": all_stages}, "\t")
		var out_file := FileAccess.open(_json_path, FileAccess.WRITE)
		if out_file:
			out_file.store_string(json_str)
			out_file.close()
			print("\n  JSON report written to: %s" % _json_path)
		else:
			print("\n  ERROR: Could not write JSON report to: %s" % _json_path)

	quit()
