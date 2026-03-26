class_name SimProgressive

## Runs battle stages progression-by-progression, stopping at the first
## progression where any stage fails. Used for iterative balance passes
## where later progressions depend on earlier ones being correct.

const SR := preload("res://scripts/tools/simulation_runner.gd")
const SC := preload("res://scripts/tools/sim_cache.gd")


## Run stages grouped by progression, lowest to highest.
## Returns true if all progressions passed.
static func run(stages: Array, sims_per_combo: int, auto_sims: bool,
		sample_size: int, from_prog: int, use_cache: bool,
		quiet: bool, all_results: Array, all_stages: Array) -> bool:
	# Group stages by progression_stage.
	var by_prog := {}
	for s: Dictionary in stages:
		var p: int = s.progression_stage
		if p < from_prog:
			continue
		if not by_prog.has(p):
			by_prog[p] = []
		by_prog[p].append(s)

	var prog_keys: Array = by_prog.keys()
	prog_keys.sort()

	if prog_keys.is_empty():
		if not quiet:
			print("  No progressions found (from=%d)." % from_prog)
		return true

	var grand_sw := Time.get_ticks_msec()

	for prog: int in prog_keys:
		var prog_stages: Array = by_prog[prog]
		if not quiet:
			print("\n" + "=".repeat(60))
			print("  PROGRESSION %d  (%d battle%s)" % [
				prog, prog_stages.size(),
				"s" if prog_stages.size() > 1 else ""])
			print("=".repeat(60))

		var results := []
		for stage: Dictionary in prog_stages:
			var sims := _calc_sims(stage, auto_sims, sims_per_combo, sample_size)

			# Check cache first.
			var cached := SC.get_cached(stage.name, stage.get("story", 1),
				sims, sample_size) if use_cache else {}

			var result: Dictionary
			if not cached.is_empty():
				result = cached
				if not quiet:
					print("  %s: cached (%.1f%%, %s)" % [stage.name,
						result.overall_win_rate * 100, SR.get_status(result)])
			else:
				if not quiet:
					print("  Simulating %s (%d sims/combo)..." % [stage.name, sims])
				result = SR.simulate_stage(stage, sims, sample_size)
				if use_cache:
					SC.store(stage.name, stage.get("story", 1),
						sims, sample_size, result, stage)
				if not quiet:
					print("  %s: %.1f%% (%s)" % [stage.name,
						result.overall_win_rate * 100, SR.get_status(result)])

			results.append(result)
			all_results.append(result)
			all_stages.append(stage)

		# Check if all stages in this progression passed.
		var all_pass := true
		var failed_names := []
		for r: Dictionary in results:
			if SR.get_status(r) != "PASS":
				all_pass = false
				failed_names.append("%s (%.1f%%, %s)" % [
					r.stage_name, r.overall_win_rate * 100, SR.get_status(r)])

		if not all_pass:
			if not quiet:
				print("\n  PROGRESSION %d FAILED:" % prog)
				for fname: String in failed_names:
					print("    %s" % fname)
				_print_summary(all_results)
			return false

		if not quiet:
			print("\n  PROGRESSION %d: ALL PASS" % prog)

	if not quiet:
		var elapsed := (Time.get_ticks_msec() - grand_sw) / 1000.0
		print("\n" + "=".repeat(60))
		print("  ALL PROGRESSIONS PASSED!")
		print("=".repeat(60))
		_print_summary(all_results)
		print("  Total time: %.1fs" % elapsed)

	return true


static func _calc_sims(stage: Dictionary, auto_sims: bool,
		sims_per_combo: int, sample_size: int) -> int:
	if auto_sims:
		var parties := SR._get_parties(stage)
		var count: int = mini(sample_size, parties.size()) \
			if sample_size > 0 else parties.size()
		return SR.calculate_sims_for_party_count(count)
	return sims_per_combo


static func _print_summary(results: Array) -> void:
	print("\n  %-25s %10s %10s %12s" % ["Battle", "Win Rate", "Target", "Status"])
	print("  " + "-".repeat(57))
	for r: Dictionary in results:
		print("  %-25s %9.1f%% %9d%% %12s" % [
			r.stage_name, r.overall_win_rate * 100,
			int(r.target_win_rate * 100), SR.get_status(r)])
