extends SceneTree

## CLI tool for running battle simulations.
## Usage: godot --path EchoesOfChoiceGame --headless --script res://tools/battle_simulator.gd -- [args]

const SR := preload("res://scripts/tools/simulation_runner.gd")
const BSDB := preload("res://scripts/tools/battle_stage_db.gd")
const PC := preload("res://scripts/tools/party_composer.gd")
const SRep := preload("res://scripts/tools/sim_report.gd")

var _json_path := ""
var _all_results: Array = []
var _all_stages: Array = []


func _init() -> void:
	var stages := BSDB.get_all_stages()
	var args := OS.get_cmdline_user_args()

	var sims_per_combo := 1000
	var auto_sims := false
	var sims_explicit := false
	var run_all := false
	var show_list := false
	var show_help := false
	var progression_filter := -1
	var sample_size := 0
	var stage_name := ""
	var story_filter := 0
	var tier_filter := ""
	var worker_index := -1
	var worker_count := 0

	var i := 0
	while i < args.size():
		match args[i]:
			"--sims":
				if i + 1 < args.size():
					sims_per_combo = int(args[i + 1])
					sims_explicit = true
					i += 1
			"--auto":
				auto_sims = true
			"--all":
				run_all = true
			"--progression":
				if i + 1 < args.size():
					progression_filter = int(args[i + 1])
					i += 1
			"--sample":
				if i + 1 < args.size():
					sample_size = int(args[i + 1])
					i += 1
			"--story":
				if i + 1 < args.size():
					story_filter = int(args[i + 1])
					i += 1
			"--tier":
				if i + 1 < args.size():
					tier_filter = args[i + 1]
					i += 1
			"--json":
				if i + 1 < args.size():
					_json_path = args[i + 1]
					i += 1
			"--worker":
				if i + 1 < args.size():
					var parts := args[i + 1].split("/")
					if parts.size() == 2:
						worker_index = int(parts[0])
						worker_count = int(parts[1])
					i += 1
			"--list":
				show_list = true
			"--help":
				show_help = true
			_:
				if not args[i].begins_with("--"):
					stage_name = args[i]
		i += 1

	if story_filter > 0:
		stages = stages.filter(
			func(s: Dictionary) -> bool: return s.story == story_filter)

	if tier_filter != "":
		stages = stages.filter(
			func(s: Dictionary) -> bool: return s.tier == tier_filter)

	# Worker mode: take only this worker's slice of stages (round-robin).
	var _worker_mode: bool = worker_index >= 0 and worker_count > 0
	if _worker_mode:
		var my_stages := []
		for si in stages.size():
			if si % worker_count == worker_index:
				my_stages.append(stages[si])
		stages = my_stages

	if show_list:
		_print_stage_list(stages)
		quit()
		return

	if show_help:
		_print_help()
		quit()
		return

	if auto_sims and sims_explicit and not _worker_mode:
		print("Warning: --auto overrides --sims. Using auto-calculated sim counts.\n")

	if not _worker_mode:
		print("=== Echoes of Choice Battle Simulator ===\n")

	if run_all:
		_run_stages(stages, sims_per_combo, auto_sims, sample_size, _worker_mode)
	elif progression_filter >= 0:
		var prog_stages := stages.filter(
			func(s: Dictionary) -> bool: return s.progression_stage == progression_filter)
		if prog_stages.is_empty():
			if not _worker_mode:
				print("No battles found for progression stage %d.\n" % progression_filter)
				_print_stage_list(stages)
		else:
			_run_stages(prog_stages, sims_per_combo, auto_sims, sample_size, _worker_mode)
	elif stage_name != "":
		var stage: Dictionary = {}
		for s: Dictionary in stages:
			if s.name.to_lower() == stage_name.to_lower():
				stage = s
				break
		if stage.is_empty():
			if not _worker_mode:
				print("Stage '%s' not found.\n" % stage_name)
				_print_stage_list(stages)
		else:
			_run_single(stage, sims_per_combo, auto_sims, sample_size, _worker_mode)
	else:
		if not _worker_mode:
			_print_help()

	if _json_path != "" and not _all_results.is_empty():
		_write_json_report()

	quit()


func _run_single(stage: Dictionary, sims_per_combo: int,
		auto_sims: bool, sample_size: int, quiet: bool = false) -> void:
	if auto_sims:
		var parties := SR._get_parties(stage)
		var count: int = mini(sample_size, parties.size()) if sample_size > 0 else parties.size()
		sims_per_combo = SR.calculate_sims_for_party_count(count)
		if not quiet:
			print("  Auto: %d party combos -> %d sims/combo (%d total battles)" % [
				count, sims_per_combo, count * sims_per_combo])

	if not quiet:
		print("\nRunning %d sims/combo for %s..." % [sims_per_combo, stage.name])
	var sw := Time.get_ticks_msec()
	var result := SR.simulate_stage(stage, sims_per_combo, sample_size)
	var elapsed := (Time.get_ticks_msec() - sw) / 1000.0

	_all_results.append(result)
	_all_stages.append(stage)

	if not quiet:
		SR.print_summary([result])
		SR.print_combo_extremes(result)
		SR.print_class_breakdown(result)
		print("\n  Time: %.1fs" % elapsed)


func _run_stages(stages: Array, sims_per_combo: int,
		auto_sims: bool, sample_size: int, quiet: bool = false) -> void:
	if not quiet:
		for stage: Dictionary in stages:
			var parties := SR._get_parties(stage)
			var count: int = mini(sample_size, parties.size()) if sample_size > 0 else parties.size()
			var sims: int = SR.calculate_sims_for_party_count(count) if auto_sims else sims_per_combo
			var sample_note: String = " (sampled from %d)" % parties.size() \
				if sample_size > 0 and count < parties.size() else ""
			print("  %s: %d combos%s x %d sims = %d battles" % [
				stage.name, count, sample_note, sims, count * sims])
		print()

	var results := []
	var sw := Time.get_ticks_msec()

	for stage: Dictionary in stages:
		if not quiet:
			print("\n" + "=".repeat(60))
			print("  SIMULATING: %s" % stage.name)
			print("=".repeat(60))

		var sims: int
		if auto_sims:
			var parties := SR._get_parties(stage)
			var count: int = mini(sample_size, parties.size()) if sample_size > 0 else parties.size()
			sims = SR.calculate_sims_for_party_count(count)
		else:
			sims = sims_per_combo

		var result := SR.simulate_stage(stage, sims, sample_size)
		results.append(result)
		_all_results.append(result)
		_all_stages.append(stage)
		if not quiet:
			SR.print_stage_result(result)

	var elapsed := (Time.get_ticks_msec() - sw) / 1000.0
	if not quiet:
		SR.print_summary(results)

		for r: Dictionary in results:
			print("\n  --- %s ---" % r.stage_name)
			SR.print_combo_extremes(r)
			SR.print_class_breakdown(r)

		print("\n  Total time: %.1fs" % elapsed)


func _write_json_report() -> void:
	var report := []
	for idx in _all_results.size():
		report.append(SRep.build_entry(_all_results[idx], _all_stages[idx]))
	SRep.write_json(_json_path, report)


func _print_stage_list(stages: Array) -> void:
	print("  %-25s %6s %6s %8s" % ["Battle", "Story", "Stage", "Target"])
	print("  " + "-".repeat(49))
	for s: Dictionary in stages:
		print("  %-25s %6d %6d %7d%%" % [
			s.name, s.get("story", 1), s.progression_stage,
			int(s.target_win_rate * 100)])


func _print_help() -> void:
	print("Usage: godot --path EchoesOfChoiceGame --headless \\")
	print("       --script res://tools/battle_simulator.gd -- [options] [stage-name]\n")
	print("Options:")
	print("  --sims <n>           Simulations per combo (default: 1000)")
	print("  --auto               Auto-calculate sims to hit 200k+ total battles")
	print("  --sample <n>         Use stratified sample of n party combos")
	print("  --progression <n>    Run all battles in a progression stage")
	print("  --story <n>          Filter to story 1, 2, or 3")
	print("  --tier <t>           Filter to tier (base, tier1, tier2)")
	print("  --all                Run all battles")
	print("  --json <path>        Write structured JSON report to file")
	print("  --worker <N/M>       Worker mode: run stage slice N of M (used by parallel coordinator)")
	print("  --list               List available battle stages")
	print("  --help               Show this help\n")
	print("Auto mode sims by tier (capped at 500/combo):")
	print("  Base (56 combos)      ->   500 sims/combo =  28k battles")
	print("  Tier 1 (~816 combos)  ->   246 sims/combo = 200k battles")
	print("  Tier 2 (~8436 combos) ->    40 sims/combo = 337k battles\n")
	print("Examples:")
	print("  ... -- CityStreetBattle")
	print("  ... -- --sims 500 WolfForestBattle")
	print("  ... -- --auto --progression 0")
	print("  ... -- --auto --all")
	print("  ... -- --story 1 --auto --all")
	print("  ... -- --story 2 --sims 50 --progression 0")
	print("  ... -- --sample 500 --sims 50 --progression 4")
