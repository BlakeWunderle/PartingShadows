class_name SimDiagnostics

## Analyzes WEAK classes from simulation results to explain *why* they
## underperform. Compares per-class combat stats against stage averages
## and enemy stat profiles.

const SR := preload("res://scripts/tools/simulation_runner.gd")
const BSDB := preload("res://scripts/tools/battle_stage_db.gd")
const FighterDBRoles := preload("res://scripts/data/fighter_db_roles.gd")


## Analyze WEAK classes in a stage result. Returns an array of diagnostic
## entries, one per WEAK class.
static func analyze(result: Dictionary, stage: Dictionary) -> Array:
	var diag: Dictionary = result.get("class_diag", {})
	if diag.is_empty():
		return []

	var breakdown := SR.get_class_breakdown(result)
	var weak_threshold: float = result.target_win_rate * 0.60

	# Compute stage-wide averages.
	var avg := _compute_averages(diag)
	var enemy_profile := compute_enemy_profile(stage)

	var entries := []
	for cname: String in breakdown:
		if breakdown[cname].win_rate >= weak_threshold:
			continue
		if not diag.has(cname):
			continue

		var cd: Dictionary = diag[cname]
		var battles: int = cd.battles
		if battles == 0:
			continue

		var avg_dealt: float = float(cd.dmg_dealt) / battles
		var avg_taken: float = float(cd.dmg_taken) / battles
		var avg_heals: float = float(cd.heals) / battles
		var avg_mitigated: float = float(cd.get("dmg_mitigated", 0)) / battles
		var death_rate: float = float(cd.deaths) / battles

		var offense_ratio: float = avg_dealt / avg.dmg_dealt if avg.dmg_dealt > 0 else 1.0
		var defense_ratio: float = avg_taken / avg.dmg_taken if avg.dmg_taken > 0 else 1.0

		var category: String
		if offense_ratio < 0.70 and defense_ratio > 1.30:
			category = "LOW_OFFENSE + HIGH_DAMAGE_TAKEN"
		elif offense_ratio < 0.70:
			category = "LOW_OFFENSE"
		elif defense_ratio > 1.30:
			category = "HIGH_DAMAGE_TAKEN"
		else:
			category = "MARGINAL"

		# Adjust category when weakness is expected from the class's role.
		var class_id := FighterDBRoles.get_class_id_from_display_name(cname)
		var role_label := FighterDBRoles.get_label(class_id) if class_id != "" else ""
		if class_id != "":
			var low_off := FighterDBRoles.is_low_offense_expected(class_id)
			var high_taken := FighterDBRoles.is_high_damage_taken_expected(class_id)
			if low_off and "LOW_OFFENSE" in category:
				category = category.replace("LOW_OFFENSE", "ROLE_EXPECTED_LOW_OFFENSE")
			if high_taken and "HIGH_DAMAGE_TAKEN" in category:
				category = category.replace("HIGH_DAMAGE_TAKEN", "ROLE_EXPECTED_HIGH_TAKEN")

		entries.append({
			"class": cname,
			"win_rate": breakdown[cname].win_rate,
			"category": category,
			"role_label": role_label,
			"avg_dmg_dealt": avg_dealt,
			"avg_dmg_taken": avg_taken,
			"avg_heals": avg_heals,
			"avg_mitigated": avg_mitigated,
			"death_rate": death_rate,
			"stage_avg_dealt": avg.dmg_dealt,
			"stage_avg_taken": avg.dmg_taken,
			"stage_avg_mitigated": avg.dmg_mitigated,
			"offense_ratio": offense_ratio,
			"defense_ratio": defense_ratio,
			"enemy_profile": enemy_profile,
		})

	entries.sort_custom(func(a: Dictionary, b: Dictionary) -> bool:
		return a.win_rate < b.win_rate)
	return entries


## Compute stage-wide average combat stats across all classes.
static func _compute_averages(diag: Dictionary) -> Dictionary:
	var total_dealt := 0
	var total_taken := 0
	var total_heals := 0
	var total_deaths := 0
	var total_battles := 0
	var total_mitigated := 0
	for cd: Dictionary in diag.values():
		total_dealt += cd.dmg_dealt
		total_taken += cd.dmg_taken
		total_heals += cd.heals
		total_deaths += cd.deaths
		total_battles += cd.battles
		total_mitigated += cd.get("dmg_mitigated", 0)
	if total_battles == 0:
		return {dmg_dealt = 0.0, dmg_taken = 0.0, heals = 0.0, death_rate = 0.0, dmg_mitigated = 0.0}
	return {
		dmg_dealt = float(total_dealt) / total_battles,
		dmg_taken = float(total_taken) / total_battles,
		heals = float(total_heals) / total_battles,
		death_rate = float(total_deaths) / total_battles,
		dmg_mitigated = float(total_mitigated) / total_battles,
	}


## Compute average enemy stat profile for a stage.
static func compute_enemy_profile(stage: Dictionary) -> Dictionary:
	var enemies: Array = BSDB.create_enemies(stage.name)
	if enemies.is_empty():
		return {}
	var total_hp := 0
	var total_patk := 0
	var total_matk := 0
	var total_pdef := 0
	var total_mdef := 0
	for e in enemies:
		total_hp += e.max_health
		total_patk += e.physical_attack
		total_matk += e.magic_attack
		total_pdef += e.physical_defense
		total_mdef += e.magic_defense
	var n: float = enemies.size()
	return {
		count = enemies.size(),
		avg_hp = int(total_hp / n),
		avg_phys_atk = int(total_patk / n),
		avg_mag_atk = int(total_matk / n),
		avg_phys_def = int(total_pdef / n),
		avg_mag_def = int(total_mdef / n),
	}


## Print diagnostics to console.
static func print_diagnostics(diagnostics: Array, stage_name: String) -> void:
	if diagnostics.is_empty():
		return
	print("\n  WEAK CLASS DIAGNOSTICS for %s:" % stage_name)

	for d: Dictionary in diagnostics:
		var role_suffix := "  [%s]" % d.role_label if d.get("role_label", "") != "" else ""
		print("\n    %s (win_rate: %.1f%%, category: %s)%s" % [
			d["class"], d.win_rate * 100, d.category, role_suffix])
		print("      Offense: avg damage %.0f (stage avg %.0f, %.2fx)" % [
			d.avg_dmg_dealt, d.stage_avg_dealt, d.offense_ratio])
		print("      Defense: avg taken %.0f (stage avg %.0f, %.2fx)" % [
			d.avg_dmg_taken, d.stage_avg_taken, d.defense_ratio])
		print("      Heals: avg %.0f | Death rate: %.0f%%" % [
			d.avg_heals, d.death_rate * 100])
		print("      Mitigated: avg %.0f (stage avg %.0f)" % [
			d.get("avg_mitigated", 0.0), d.get("stage_avg_mitigated", 0.0)])
		if not d.enemy_profile.is_empty():
			var ep: Dictionary = d.enemy_profile
			print("      Enemies: %d units, avg p_def=%d m_def=%d p_atk=%d m_atk=%d" % [
				ep.count, ep.avg_phys_def, ep.avg_mag_def,
				ep.avg_phys_atk, ep.avg_mag_atk])


## Convert diagnostics to JSON-serializable array.
static func to_json(diagnostics: Array) -> Array:
	var result := []
	for d: Dictionary in diagnostics:
		var entry := d.duplicate()
		# Enemy profile is already serializable.
		result.append(entry)
	return result
