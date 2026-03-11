class_name EnemyDBS3Act3

## Story 3 Act III enemy factory. Cult dream guardians.

const FighterData := preload("res://scripts/data/fighter_data.gd")
const EAB := preload("res://scripts/data/story3/enemy_ability_db_s3.gd")


static func _es(base_min: int, base_max: int, gmin: int, gmax: int, level: int, base_level: int = 1) -> int:
	var lvl: int = level - base_level
	var lo: int = base_min + lvl * gmin
	var hi: int = base_max + lvl * (gmax - 1)
	if hi <= lo:
		return lo
	return randi_range(lo, hi - 1)


static func _base(name: String, type: String, lvl: int) -> FighterData:
	var f := FighterData.new()
	f.character_name = name
	f.character_type = type
	f.class_id = type
	f.is_user_controlled = false
	f.level = lvl
	return f


# =============================================================================
# Act III: Cult dream guardians (Progression 6-8)
# =============================================================================

static func create_lucid_phantom(n: String, lvl: int = 7) -> FighterData:
	var f := _base(n, "Lucid Phantom", lvl)
	f.health = _es(206, 238, 6, 9, lvl, 7); f.max_health = f.health
	f.mana = _es(17, 22, 1, 3, lvl, 7); f.max_mana = f.mana
	f.physical_attack = _es(23, 28, 1, 2, lvl, 7)
	f.physical_defense = _es(25, 30, 1, 2, lvl, 7)
	f.magic_attack = _es(38, 43, 2, 3, lvl, 7)
	f.magic_defense = _es(28, 33, 1, 3, lvl, 7)
	f.speed = _es(34, 39, 1, 3, lvl, 7)
	f.crit_chance = 14; f.crit_damage = 1; f.dodge_chance = 16
	f.abilities = [EAB.mind_spike(), EAB.phase_shift()]
	return f


static func create_thread_spinner(n: String, lvl: int = 7) -> FighterData:
	var f := _base(n, "Thread Spinner", lvl)
	f.health = _es(213, 244, 6, 9, lvl, 7); f.max_health = f.health
	f.mana = _es(20, 24, 2, 3, lvl, 7); f.max_mana = f.mana
	f.physical_attack = _es(20, 25, 1, 2, lvl, 7)
	f.physical_defense = _es(28, 33, 1, 3, lvl, 7)
	f.magic_attack = _es(30, 35, 1, 3, lvl, 7)
	f.magic_defense = _es(30, 35, 1, 3, lvl, 7)
	f.speed = _es(30, 35, 1, 2, lvl, 7)
	f.crit_chance = 10; f.crit_damage = 1; f.dodge_chance = 10
	f.abilities = [EAB.woven_mend(), EAB.thread_snare()]
	return f


static func create_loom_sentinel(n: String, lvl: int = 8) -> FighterData:
	var f := _base(n, "Loom Sentinel", lvl)
	f.health = _es(250, 288, 7, 11, lvl, 8); f.max_health = f.health
	f.mana = _es(12, 16, 1, 2, lvl, 8); f.max_mana = f.mana
	f.physical_attack = _es(38, 43, 2, 3, lvl, 8)
	f.physical_defense = _es(33, 38, 2, 3, lvl, 8)
	f.magic_attack = _es(18, 23, 1, 2, lvl, 8)
	f.magic_defense = _es(30, 35, 1, 3, lvl, 8)
	f.speed = _es(28, 33, 1, 2, lvl, 8)
	f.crit_chance = 12; f.crit_damage = 1; f.dodge_chance = 5
	f.abilities = [EAB.loom_strike(), EAB.woven_armor()]
	return f


static func create_cult_shade(n: String, lvl: int = 7) -> FighterData:
	var f := _base(n, "Cult Shade", lvl)
	f.health = _es(200, 231, 5, 8, lvl, 7); f.max_health = f.health
	f.mana = _es(20, 24, 2, 3, lvl, 7); f.max_mana = f.mana
	f.physical_attack = _es(18, 23, 1, 2, lvl, 7)
	f.physical_defense = _es(23, 28, 1, 2, lvl, 7)
	f.magic_attack = _es(40, 45, 2, 3, lvl, 7)
	f.magic_defense = _es(25, 30, 1, 2, lvl, 7)
	f.speed = _es(32, 37, 1, 3, lvl, 7)
	f.crit_chance = 14; f.crit_damage = 1; f.dodge_chance = 12
	f.abilities = [EAB.dark_thread(), EAB.unravel_mind()]
	return f


static func create_dream_warden(n: String, lvl: int = 8) -> FighterData:
	var f := _base(n, "Dream Warden", lvl)
	f.health = _es(231, 263, 6, 9, lvl, 8); f.max_health = f.health
	f.mana = _es(14, 18, 1, 3, lvl, 8); f.max_mana = f.mana
	f.physical_attack = _es(30, 35, 1, 3, lvl, 8)
	f.physical_defense = _es(30, 35, 2, 3, lvl, 8)
	f.magic_attack = _es(35, 40, 1, 3, lvl, 8)
	f.magic_defense = _es(28, 33, 1, 3, lvl, 8)
	f.speed = _es(32, 37, 1, 3, lvl, 8)
	f.crit_chance = 12; f.crit_damage = 1; f.dodge_chance = 10
	f.abilities = [EAB.ward_pulse(), EAB.binding_light()]
	return f


static func create_thought_leech(n: String, lvl: int = 8) -> FighterData:
	var f := _base(n, "Thought Leech", lvl)
	f.health = _es(213, 244, 5, 8, lvl, 8); f.max_health = f.health
	f.mana = _es(20, 24, 2, 3, lvl, 8); f.max_mana = f.mana
	f.physical_attack = _es(18, 23, 1, 2, lvl, 8)
	f.physical_defense = _es(23, 28, 1, 2, lvl, 8)
	f.magic_attack = _es(38, 43, 2, 3, lvl, 8)
	f.magic_defense = _es(28, 33, 1, 3, lvl, 8)
	f.speed = _es(30, 35, 1, 2, lvl, 8)
	f.crit_chance = 12; f.crit_damage = 1; f.dodge_chance = 12
	f.abilities = [EAB.psychic_siphon(), EAB.mind_fog()]
	return f


static func create_void_spinner(n: String, lvl: int = 8) -> FighterData:
	var f := _base(n, "Void Spinner", lvl)
	f.health = _es(219, 250, 6, 8, lvl, 8); f.max_health = f.health
	f.mana = _es(22, 26, 2, 3, lvl, 8); f.max_mana = f.mana
	f.physical_attack = _es(15, 20, 0, 2, lvl, 8)
	f.physical_defense = _es(25, 30, 1, 2, lvl, 8)
	f.magic_attack = _es(40, 45, 2, 3, lvl, 8)
	f.magic_defense = _es(30, 35, 1, 3, lvl, 8)
	f.speed = _es(32, 37, 1, 3, lvl, 8)
	f.crit_chance = 12; f.crit_damage = 1; f.dodge_chance = 10
	f.abilities = [EAB.void_thread(), EAB.nullify()]
	return f


static func create_sanctum_guardian(n: String, lvl: int = 9) -> FighterData:
	var f := _base(n, "Sanctum Guardian", lvl)
	f.health = _es(325, 375, 9, 13, lvl, 9); f.max_health = f.health
	f.mana = _es(24, 28, 2, 4, lvl, 9); f.max_mana = f.mana
	f.physical_attack = _es(43, 48, 2, 3, lvl, 9)
	f.physical_defense = _es(33, 38, 2, 3, lvl, 9)
	f.magic_attack = _es(43, 48, 2, 3, lvl, 9)
	f.magic_defense = _es(33, 38, 2, 3, lvl, 9)
	f.speed = _es(36, 41, 2, 3, lvl, 9)
	f.crit_chance = 14; f.crit_damage = 2; f.dodge_chance = 12
	f.abilities = [EAB.loom_slam(), EAB.thread_storm(), EAB.guardians_veil()]
	return f
