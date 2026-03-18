class_name SimulationRunner

## Runs automated battles and reports win rates for balance testing.
## Port of C# EchoesOfChoice/BattleSimulator/SimulationRunner.cs.

const BattleEngine := preload("res://scripts/battle/battle_engine.gd")
const FighterData := preload("res://scripts/data/fighter_data.gd")
const PC := preload("res://scripts/tools/party_composer.gd")
const BSDB := preload("res://scripts/tools/battle_stage_db.gd")

const MIN_TOTAL_BATTLES := 200_000
const MIN_SIMS_PER_COMBO := 40
const MAX_SIMS_PER_COMBO := 500
const TOLERANCE := 0.03
const MAX_TICKS := 500

static var _sim_engine: BattleEngine = null


static func _get_sim_engine() -> BattleEngine:
	if _sim_engine == null:
		_sim_engine = BattleEngine.new()
		_sim_engine.sim_mode = true
	return _sim_engine


static func calculate_sims_for_party_count(party_count: int) -> int:
	if party_count <= 0:
		return MIN_SIMS_PER_COMBO
	var sims := ceili(float(MIN_TOTAL_BATTLES) / party_count)
	return clampi(sims, MIN_SIMS_PER_COMBO, MAX_SIMS_PER_COMBO)


# =============================================================================
# Core battle loop
# =============================================================================

static func run_single_battle(party: Array, enemies: Array,
		engine: BattleEngine = null) -> bool:
	if engine == null:
		engine = BattleEngine.new()
	if engine.sim_mode:
		engine.start_battle_sim(party, enemies)
	else:
		engine.start_battle(party, enemies)
	var ticks := 0
	while not engine.is_battle_over() and ticks < MAX_TICKS:
		ticks += 1
		engine.tick_atb_fast()
		for actor: FighterData in engine.get_acting_units():
			if engine.is_battle_over():
				break
			engine.reset_modified_stat(actor)
			engine.tick_cooldowns(actor)
			var is_player := engine.units.has(actor)
			var targets: Array = engine.enemies if is_player else engine.units
			var allies: Array = engine.units if is_player else engine.enemies
			if targets.is_empty():
				break
			engine.execute_ai_turn(actor, targets, allies)
			engine.check_for_death()
		engine.reset_turns()
	return engine.did_player_win()


# =============================================================================
# Stage simulation
# =============================================================================

static func _get_parties(stage: Dictionary) -> Array:
	match stage.tier:
		"base": return PC.get_base_parties()
		"tier1": return PC.get_tier1_parties()
		"tier2": return PC.get_tier2_parties()
		_: return PC.get_base_parties()


static func _clone_fighters(template: Array) -> Array:
	var result := []
	for f: FighterData in template:
		result.append(f.clone())
	return result


static func simulate_stage(stage: Dictionary, sims_per_combo: int,
		sample_size: int = 0) -> Dictionary:
	var parties := _get_parties(stage)
	if sample_size > 0:
		parties = PC.sample_parties(parties, sample_size)

	var combo_results := []
	var start_ms := Time.get_ticks_msec()
	var is_mirror: bool = stage.name == "MirrorBattle"
	var engine := _get_sim_engine()

	for pi in parties.size():
		var party_def: Dictionary = parties[pi]
		var wins := 0
		# Create enemy template once per combo; clone per sim to avoid
		# the full factory dispatch on every iteration.
		var enemy_template: Array = []
		if not is_mirror:
			enemy_template = BSDB.create_enemies(stage.name)
		for si in sims_per_combo:
			var party_fighters := PC.create_party(party_def, stage.level_ups)
			var enemies: Array
			if is_mirror:
				enemies = BSDB.create_enemies(stage.name, party_fighters)
			else:
				enemies = _clone_fighters(enemy_template)
			if run_single_battle(party_fighters, enemies, engine):
				wins += 1

		combo_results.append({
			"description": PC.get_party_description(party_def),
			"wins": wins,
			"losses": sims_per_combo - wins,
			"total": sims_per_combo,
			"win_rate": float(wins) / sims_per_combo,
		})

		if (pi + 1) % 100 == 0:
			print("  ... %d / %d combos" % [pi + 1, parties.size()])

	combo_results.sort_custom(func(a: Dictionary, b: Dictionary) -> bool:
		return a.win_rate < b.win_rate)

	var total_wr := 0.0
	for c: Dictionary in combo_results:
		total_wr += c.win_rate
	var overall_wr: float = total_wr / combo_results.size() if not combo_results.is_empty() else 0.0

	return {
		"stage_name": stage.name,
		"target_win_rate": stage.target_win_rate,
		"progression_stage": stage.progression_stage,
		"combo_results": combo_results,
		"overall_win_rate": overall_wr,
		"elapsed_ms": Time.get_ticks_msec() - start_ms,
	}


# =============================================================================
# Output formatting
# =============================================================================

static func get_status(result: Dictionary) -> String:
	var low: float = result.target_win_rate - TOLERANCE
	var high: float = result.target_win_rate + TOLERANCE
	if result.overall_win_rate >= low and result.overall_win_rate <= high:
		return "PASS"
	if result.overall_win_rate < low:
		return "TOO HARD"
	return "TOO EASY"


static func print_stage_result(result: Dictionary) -> void:
	var combos: Array = result.combo_results
	print("  Combos tested: %d" % combos.size())
	print("  Time: %dms" % result.elapsed_ms)
	print("  Overall win rate: %.1f%%" % [result.overall_win_rate * 100])
	print("  Target: %d%% (+/- %d%%)" % [
		int(result.target_win_rate * 100), int(TOLERANCE * 100)])
	print_combo_extremes(result)
	print_class_breakdown(result)
	print("\n  STATUS: %s" % get_status(result))


static func get_combo_extremes(result: Dictionary, count: int = 5) -> Dictionary:
	var sorted: Array = result.combo_results
	if sorted.is_empty():
		return {"worst": [], "best": []}
	var worst := sorted.slice(0, mini(count, sorted.size()))
	var best := sorted.slice(maxi(0, sorted.size() - count), sorted.size())
	return {"worst": worst, "best": best}


static func get_spread(result: Dictionary) -> Dictionary:
	var sorted: Array = result.combo_results
	if sorted.is_empty():
		return {"full_spread": 0.0, "core_spread": 0.0, "p10": 0.0, "p90": 0.0, "verdict": "N/A"}
	var worst_wr: float = sorted[0].win_rate
	var best_wr: float = sorted[-1].win_rate
	var full_spread: float = best_wr - worst_wr
	var p10_idx := mini(int(sorted.size() * 0.10), sorted.size() - 1)
	var p90_idx := mini(int(sorted.size() * 0.90), sorted.size() - 1)
	var p10: float = sorted[p10_idx].win_rate
	var p90: float = sorted[p90_idx].win_rate
	var core_spread: float = p90 - p10
	var verdict: String
	if core_spread < 0.15:
		verdict = "EXCELLENT"
	elif core_spread < 0.25:
		verdict = "ACCEPTABLE"
	elif core_spread < 0.40:
		verdict = "CONCERNING"
	else:
		verdict = "CRITICAL"
	return {"full_spread": full_spread, "core_spread": core_spread, "p10": p10, "p90": p90, "verdict": verdict}


static func get_class_breakdown(result: Dictionary) -> Dictionary:
	var class_stats := {}
	for combo: Dictionary in result.combo_results:
		for cname: String in combo.description.split(" / "):
			if not class_stats.has(cname):
				class_stats[cname] = {"wins": 0, "total": 0, "count": 0}
			class_stats[cname].wins += combo.wins
			class_stats[cname].total += combo.total
			class_stats[cname].count += 1
	var breakdown := {}
	for cname: String in class_stats:
		var s: Dictionary = class_stats[cname]
		breakdown[cname] = {
			"wins": s.wins,
			"total": s.total,
			"win_rate": float(s.wins) / s.total if s.total > 0 else 0.0,
			"combo_count": s.count,
		}
	return breakdown


static func print_combo_extremes(result: Dictionary, count: int = 5) -> void:
	var extremes := get_combo_extremes(result, count)
	if extremes.worst.is_empty():
		return
	var spread := get_spread(result)

	print("\n  WEAKEST COMBOS:")
	for c: Dictionary in extremes.worst:
		print("    %.1f%%  %s" % [c.win_rate * 100, c.description])

	print("\n  STRONGEST COMBOS:")
	for c: Dictionary in extremes.best:
		print("    %.1f%%  %s" % [c.win_rate * 100, c.description])

	print("\n  FULL SPREAD (min-max): %.1f%%" % [spread.full_spread * 100])
	print("  CORE SPREAD (p10-p90): %.1f%% (%s)  [p10=%.1f%%, p90=%.1f%%]" % [
		spread.core_spread * 100, spread.verdict, spread.p10 * 100, spread.p90 * 100])


static func print_class_breakdown(result: Dictionary) -> void:
	var breakdown := get_class_breakdown(result)
	var entries := []
	for cname: String in breakdown:
		entries.append({
			"class": cname,
			"win_rate": breakdown[cname].win_rate,
			"count": breakdown[cname].combo_count,
		})
	entries.sort_custom(func(a: Dictionary, b: Dictionary) -> bool:
		return a.win_rate > b.win_rate)

	print("\n  CLASS BREAKDOWN:")
	print("    %-22s %10s %8s  %s" % ["Class", "Win Rate", "Combos", "Note"])
	print("    " + "-".repeat(54))

	var warn_threshold: float = result.target_win_rate * 0.60
	for e: Dictionary in entries:
		var note: String = "** WEAK **" if e.win_rate < warn_threshold else ""
		print("    %-22s %9.1f%% %8d  %s" % [
			e["class"], e.win_rate * 100, e.count, note])


static func print_summary(results: Array) -> void:
	print("\n" + "=".repeat(80))
	print("  SIMULATION SUMMARY")
	print("=".repeat(80))
	print("  %-25s %10s %10s %14s %12s" % [
		"Battle", "Win Rate", "Target", "Range", "Status"])
	print("  " + "-".repeat(71))

	for r: Dictionary in results:
		var low: float = r.target_win_rate - TOLERANCE
		var high: float = r.target_win_rate + TOLERANCE
		var range_str := "%d%% - %d%%" % [int(low * 100), int(high * 100)]
		print("  %-25s %9.1f%% %9d%% %14s %12s" % [
			r.stage_name, r.overall_win_rate * 100,
			int(r.target_win_rate * 100), range_str, get_status(r)])

	var total_wr := 0.0
	var pass_count := 0
	for r: Dictionary in results:
		total_wr += r.overall_win_rate
		if get_status(r) == "PASS":
			pass_count += 1

	print("\n  Passed: %d/%d" % [pass_count, results.size()])
	print("  Average win rate: %.1f%%" % [total_wr / results.size() * 100])
	print("  Tolerance: +/- %d%%" % int(TOLERANCE * 100))
