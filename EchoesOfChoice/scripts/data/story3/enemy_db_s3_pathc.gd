class_name EnemyDBS3PathC

## Story 3 Path C enemy factory. Deep dream entities, dream-projected cult,
## and the Ancient Threadmaster.

const FighterData := preload("res://scripts/data/fighter_data.gd")
const EAB := preload("res://scripts/data/story3/enemy_ability_db_s3_pathc.gd")


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
# Prog 9: Deep dream entities (S3_C_DreamDescent)
# =============================================================================

static func create_abyssal_dreamer(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "Abyssal Dreamer", lvl)
	f.health = _es(275, 318, 6, 10, lvl, 10); f.max_health = f.health
	f.mana = _es(20, 25, 2, 3, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(18, 23, 1, 2, lvl, 10)
	f.physical_defense = _es(24, 29, 1, 3, lvl, 10)
	f.magic_attack = _es(48, 54, 3, 4, lvl, 10)
	f.magic_defense = _es(30, 36, 1, 4, lvl, 10)
	f.speed = _es(44, 51, 2, 3, lvl, 10)
	f.crit_chance = 14; f.crit_damage = 1; f.dodge_chance = 14
	f.abilities = [EAB.void_pulse(), EAB.deep_slumber()]
	return f


static func create_thread_devourer(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "Thread Devourer", lvl)
	f.health = _es(290, 335, 7, 11, lvl, 10); f.max_health = f.health
	f.mana = _es(12, 16, 1, 2, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(44, 50, 3, 4, lvl, 10)
	f.physical_defense = _es(28, 33, 1, 3, lvl, 10)
	f.magic_attack = _es(20, 25, 1, 2, lvl, 10)
	f.magic_defense = _es(25, 30, 1, 3, lvl, 10)
	f.speed = _es(46, 53, 2, 4, lvl, 10)
	f.crit_chance = 18; f.crit_damage = 1; f.dodge_chance = 14
	f.abilities = [EAB.thread_bite(), EAB.unravel_ward()]
	return f


static func create_slumbering_colossus(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "Slumbering Colossus", lvl)
	f.health = _es(380, 435, 10, 14, lvl, 10); f.max_health = f.health
	f.mana = _es(10, 14, 1, 2, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(46, 52, 3, 4, lvl, 10)
	f.physical_defense = _es(38, 44, 3, 4, lvl, 10)
	f.magic_attack = _es(15, 20, 0, 2, lvl, 10)
	f.magic_defense = _es(32, 37, 1, 4, lvl, 10)
	f.speed = _es(28, 34, 1, 2, lvl, 10)
	f.crit_chance = 10; f.crit_damage = 1; f.dodge_chance = 3
	f.abilities = [EAB.crushing_dream(), EAB.ancient_yawn()]
	return f


# =============================================================================
# Prog 10: Dream-projected cult members (S3_C_CultInterception)
# =============================================================================

static func create_dream_priest(n: String, lvl: int = 11) -> FighterData:
	var f := _base(n, "Dream Priest", lvl)
	f.health = _es(360, 410, 8, 13, lvl, 11); f.max_health = f.health
	f.mana = _es(24, 29, 2, 4, lvl, 11); f.max_mana = f.mana
	f.physical_attack = _es(28, 34, 1, 3, lvl, 11)
	f.physical_defense = _es(36, 42, 2, 4, lvl, 11)
	f.magic_attack = _es(50, 56, 3, 4, lvl, 11)
	f.magic_defense = _es(40, 46, 2, 4, lvl, 11)
	f.speed = _es(42, 49, 1, 3, lvl, 11)
	f.crit_chance = 14; f.crit_damage = 1; f.dodge_chance = 10
	f.abilities = [EAB.sacred_thread(), EAB.loom_prayer()]
	return f


static func create_astral_enforcer(n: String, lvl: int = 11) -> FighterData:
	var f := _base(n, "Astral Enforcer", lvl)
	f.health = _es(375, 425, 9, 14, lvl, 11); f.max_health = f.health
	f.mana = _es(12, 16, 1, 2, lvl, 11); f.max_mana = f.mana
	f.physical_attack = _es(54, 60, 3, 5, lvl, 11)
	f.physical_defense = _es(40, 46, 3, 4, lvl, 11)
	f.magic_attack = _es(18, 24, 0, 3, lvl, 11)
	f.magic_defense = _es(34, 39, 1, 3, lvl, 11)
	f.speed = _es(40, 47, 1, 3, lvl, 11)
	f.crit_chance = 16; f.crit_damage = 1; f.dodge_chance = 8
	f.abilities = [EAB.dream_blade(), EAB.astral_brace()]
	return f


static func create_oneiric_hexer(n: String, lvl: int = 11) -> FighterData:
	var f := _base(n, "Oneiric Hexer", lvl)
	f.health = _es(320, 368, 7, 11, lvl, 11); f.max_health = f.health
	f.mana = _es(22, 27, 2, 4, lvl, 11); f.max_mana = f.mana
	f.physical_attack = _es(22, 28, 1, 2, lvl, 11)
	f.physical_defense = _es(30, 36, 1, 3, lvl, 11)
	f.magic_attack = _es(52, 58, 3, 4, lvl, 11)
	f.magic_defense = _es(36, 42, 2, 4, lvl, 11)
	f.speed = _es(44, 51, 1, 4, lvl, 11)
	f.crit_chance = 16; f.crit_damage = 1; f.dodge_chance = 13
	f.abilities = [EAB.dream_bolt(), EAB.nightmare_hex()]
	return f


# =============================================================================
# Prog 11: Threadmaster's personal guardians (S3_C_ThreadmasterLair)
# =============================================================================

static func create_memory_eater(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Memory Eater", lvl)
	f.health = _es(380, 435, 8, 13, lvl, 12); f.max_health = f.health
	f.mana = _es(26, 31, 3, 4, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(24, 30, 1, 3, lvl, 12)
	f.physical_defense = _es(34, 40, 1, 4, lvl, 12)
	f.magic_attack = _es(58, 64, 3, 5, lvl, 12)
	f.magic_defense = _es(40, 46, 2, 4, lvl, 12)
	f.speed = _es(46, 53, 1, 4, lvl, 12)
	f.crit_chance = 16; f.crit_damage = 1; f.dodge_chance = 12
	f.abilities = [EAB.devour_memory(), EAB.amnesia_fog()]
	return f


static func create_nightmare_sentinel(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Nightmare Sentinel", lvl)
	f.health = _es(430, 490, 10, 15, lvl, 12); f.max_health = f.health
	f.mana = _es(18, 23, 1, 3, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(52, 58, 3, 5, lvl, 12)
	f.physical_defense = _es(44, 50, 3, 5, lvl, 12)
	f.magic_attack = _es(38, 44, 2, 4, lvl, 12)
	f.magic_defense = _es(42, 48, 3, 5, lvl, 12)
	f.speed = _es(44, 51, 1, 3, lvl, 12)
	f.crit_chance = 14; f.crit_damage = 1; f.dodge_chance = 8
	f.abilities = [EAB.nightmare_blade(), EAB.terror_ward()]
	return f


static func create_anchor_chain(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Anchor Chain", lvl)
	f.health = _es(400, 456, 9, 14, lvl, 12); f.max_health = f.health
	f.mana = _es(14, 19, 1, 2, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(30, 36, 1, 3, lvl, 12)
	f.physical_defense = _es(48, 54, 3, 5, lvl, 12)
	f.magic_attack = _es(26, 32, 1, 3, lvl, 12)
	f.magic_defense = _es(46, 52, 3, 5, lvl, 12)
	f.speed = _es(36, 42, 1, 2, lvl, 12)
	f.crit_chance = 8; f.crit_damage = 1; f.dodge_chance = 4
	f.abilities = [EAB.binding_pull(), EAB.iron_link()]
	return f


# =============================================================================
# Prog 12: The Ancient Threadmaster and its servants (S3_C_DreamNexus)
# =============================================================================

static func create_ancient_threadmaster(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "The Ancient Threadmaster", lvl)
	f.health = _es(541, 617, 15, 22, lvl, 13); f.max_health = f.health
	f.mana = _es(35, 40, 4, 6, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(59, 66, 3, 6, lvl, 13)
	f.physical_defense = _es(44, 50, 3, 5, lvl, 13)
	f.magic_attack = _es(65, 71, 4, 6, lvl, 13)
	f.magic_defense = _es(44, 50, 3, 5, lvl, 13)
	f.speed = _es(53, 60, 3, 5, lvl, 13)
	f.crit_chance = 22; f.crit_damage = 2; f.dodge_chance = 15
	f.abilities = [EAB.primordial_dream(), EAB.loom_dominion(), EAB.chain_of_ages()]
	return f


static func create_dream_shackle(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "Dream Shackle", lvl)
	f.health = _es(300, 346, 7, 11, lvl, 13); f.max_health = f.health
	f.mana = _es(18, 23, 2, 4, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(28, 34, 1, 3, lvl, 13)
	f.physical_defense = _es(30, 36, 1, 4, lvl, 13)
	f.magic_attack = _es(52, 58, 3, 5, lvl, 13)
	f.magic_defense = _es(34, 40, 1, 4, lvl, 13)
	f.speed = _es(50, 58, 3, 5, lvl, 13)
	f.crit_chance = 16; f.crit_damage = 1; f.dodge_chance = 16
	f.abilities = [EAB.binding_lash(), EAB.reclaim()]
	return f


static func create_loom_heart(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "Loom Heart", lvl)
	f.health = _es(340, 390, 8, 13, lvl, 13); f.max_health = f.health
	f.mana = _es(30, 35, 3, 5, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(20, 26, 1, 2, lvl, 13)
	f.physical_defense = _es(40, 46, 3, 5, lvl, 13)
	f.magic_attack = _es(44, 50, 2, 4, lvl, 13)
	f.magic_defense = _es(44, 50, 3, 5, lvl, 13)
	f.speed = _es(38, 44, 1, 3, lvl, 13)
	f.crit_chance = 10; f.crit_damage = 1; f.dodge_chance = 6
	f.abilities = [EAB.pulse_of_the_loom(), EAB.loom_storm()]
	return f
