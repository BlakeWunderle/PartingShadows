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
	# Merge with existing JSON: keep old stages, replace matching stage_names
	var new_names := {}
	for e in entries:
		new_names[e.get("stage_name", "")] = true
	var existing := FileAccess.open(path, FileAccess.READ)
	if existing:
		var parser := JSON.new()
		if parser.parse(existing.get_as_text()) == OK and parser.data is Dictionary:
			var old: Array = parser.data.get("stages", [])
			for o in old:
				if o is Dictionary and not new_names.has(o.get("stage_name", "")):
					entries.append(o)
		existing.close()
	entries.sort_custom(func(a: Dictionary, b: Dictionary) -> bool:
		return a.get("stage_name", "") < b.get("stage_name", ""))
	var json_str := JSON.stringify({"stages": entries}, "\t")
	var file := FileAccess.open(path, FileAccess.WRITE)
	if file:
		file.store_string(json_str)
		file.close()
		print("\n  JSON report written to: %s" % path)
	else:
		print("\n  ERROR: Could not write JSON report to: %s" % path)


## Write a human-readable text report with full verbose output for all stages.
## Used by --compact mode to store details in a file instead of stdout.
static func write_text_report(path: String, results: Array,
		stages: Array) -> void:
	var lines := PackedStringArray()
	lines.append("=== Detailed Simulation Report ===")
	lines.append("Generated: %s" % Time.get_datetime_string_from_system())
	lines.append("")

	for idx in results.size():
		var r: Dictionary = results[idx]
		lines.append("=" .repeat(60))
		lines.append("  %s" % r.stage_name)
		lines.append("=" .repeat(60))
		lines.append_array(SR.format_stage_verbose(r))

		# Add diagnostics for non-PASS stages.
		if SR.get_status(r) != "PASS" and idx < stages.size():
			var diags := SD.analyze(r, stages[idx])
			if not diags.is_empty():
				lines.append("")
				lines.append("  WEAK CLASS DIAGNOSTICS:")
				for d: Dictionary in diags:
					lines.append("")
					lines.append("    %s (win_rate: %.1f%%, category: %s)" % [
						d["class"], d.win_rate * 100, d.category])
					lines.append("      Offense: avg damage %.0f (stage avg %.0f, %.2fx)" % [
						d.avg_dmg_dealt, d.stage_avg_dealt, d.offense_ratio])
					lines.append("      Defense: avg taken %.0f (stage avg %.0f, %.2fx)" % [
						d.avg_dmg_taken, d.stage_avg_taken, d.defense_ratio])
					lines.append("      Heals: avg %.0f | Death rate: %.0f%%" % [
						d.avg_heals, d.death_rate * 100])
					if not d.enemy_profile.is_empty():
						var ep: Dictionary = d.enemy_profile
						lines.append("      Enemies: %d units, avg p_def=%d m_def=%d p_atk=%d m_atk=%d" % [
							ep.count, ep.avg_phys_def, ep.avg_mag_def,
							ep.avg_phys_atk, ep.avg_mag_atk])
		lines.append("")

	# Summary table.
	lines.append("=" .repeat(60))
	lines.append("  SUMMARY")
	lines.append("=" .repeat(60))
	lines.append("  %-25s %10s %10s %12s" % [
		"Battle", "Win Rate", "Target", "Status"])
	lines.append("  " + "-".repeat(57))
	var pass_count := 0
	for r: Dictionary in results:
		lines.append("  %-25s %9.1f%% %9d%% %12s" % [
			r.stage_name, r.overall_win_rate * 100,
			int(r.target_win_rate * 100), SR.get_status(r)])
		if SR.get_status(r) == "PASS":
			pass_count += 1
	lines.append("")
	lines.append("  Passed: %d/%d" % [pass_count, results.size()])

	var file := FileAccess.open(path, FileAccess.WRITE)
	if file:
		file.store_string("\n".join(lines))
		file.close()
		var abs_path := ProjectSettings.globalize_path(path)
		print("  Full report: %s" % abs_path)
	else:
		print("  ERROR: Could not write report to: %s" % path)
