class_name SimReport

## Builds structured JSON report entries from simulation results.
## Extracted from battle_simulator.gd to keep the CLI entry point lean.

const SR := preload("res://scripts/tools/simulation_runner.gd")
const SD := preload("res://scripts/tools/sim_diagnostics.gd")


## Build a JSON-ready report entry for one stage result.
static func build_entry(result: Dictionary, stage: Dictionary) -> Dictionary:
	var breakdown := SR.get_class_breakdown(result)
	var spread := SR.get_spread(result)
	var extremes := SR.get_combo_extremes(result)
	var worst_entries := []
	for c: Dictionary in extremes.worst:
		worst_entries.append({"description": c.description, "win_rate": c.win_rate})
	var best_entries := []
	for c: Dictionary in extremes.best:
		best_entries.append({"description": c.description, "win_rate": c.win_rate})
	return {
		"stage_name": result.stage_name,
		"story": stage.get("story", 1),
		"progression_stage": result.progression_stage,
		"tier": stage.get("tier", "base"),
		"target_win_rate": result.target_win_rate,
		"overall_win_rate": result.overall_win_rate,
		"combo_count": result.combo_results.size(),
		"elapsed_ms": result.elapsed_ms,
		"status": SR.get_status(result),
		"class_breakdown": breakdown,
		"spread": spread,
		"best_combos": best_entries,
		"worst_combos": worst_entries,
		"diagnostics": SD.to_json(SD.analyze(result, stage)),
	}


## Write an array of report entries to a JSON file.
static func write_json(path: String, entries: Array) -> void:
	var json_str := JSON.stringify({"stages": entries}, "\t")
	var file := FileAccess.open(path, FileAccess.WRITE)
	if file:
		file.store_string(json_str)
		file.close()
		print("\n  JSON report written to: %s" % path)
	else:
		print("\n  ERROR: Could not write JSON report to: %s" % path)
