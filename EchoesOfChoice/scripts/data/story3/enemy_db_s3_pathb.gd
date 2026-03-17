class_name EnemyDBS3PathB

## Story 3 Path B enemy factory. Scaled cult variants, Shadow Innkeeper, and Lira.

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
# Prog 6: Bound dream creatures guarding the inn cellar (S3_B_InnSearch)
# =============================================================================

static func create_bound_thread_guard(n: String, lvl: int = 7) -> FighterData:
	var f := _base(n, "Thread Guard", lvl)
	f.health = _es(220, 255, 6, 10, lvl, 7); f.max_health = f.health
	f.mana = _es(12, 16, 1, 2, lvl, 7); f.max_mana = f.mana
	f.physical_attack = _es(30, 35, 1, 3, lvl, 7)
	f.physical_defense = _es(25, 30, 1, 3, lvl, 7)
	f.magic_attack = _es(15, 20, 1, 2, lvl, 7)
	f.magic_defense = _es(23, 28, 1, 3, lvl, 7)
	f.speed = _es(32, 38, 1, 3, lvl, 7)
	f.crit_chance = 10; f.crit_damage = 1; f.dodge_chance = 8
	f.abilities = [EAB.threaded_blade(), EAB.woven_shield()]
	return f


static func create_bound_dream_hound(n: String, lvl: int = 7) -> FighterData:
	var f := _base(n, "Dream Hound", lvl)
	f.health = _es(195, 225, 5, 8, lvl, 7); f.max_health = f.health
	f.mana = _es(9, 13, 1, 2, lvl, 7); f.max_mana = f.mana
	f.physical_attack = _es(32, 37, 2, 3, lvl, 7)
	f.physical_defense = _es(20, 25, 1, 2, lvl, 7)
	f.magic_attack = _es(13, 17, 1, 2, lvl, 7)
	f.magic_defense = _es(18, 23, 1, 2, lvl, 7)
	f.speed = _es(38, 44, 2, 3, lvl, 7)
	f.crit_chance = 14; f.crit_damage = 1; f.dodge_chance = 12
	f.abilities = [EAB.feral_bite(), EAB.dream_howl()]
	return f


# =============================================================================
# Prog 7: Cult members at early strength (S3_B_CultConfrontation)
# =============================================================================

static func create_early_cult_acolyte(n: String, lvl: int = 8) -> FighterData:
	var f := _base(n, "Cult Acolyte", lvl)
	f.health = _es(230, 265, 5, 9, lvl, 8); f.max_health = f.health
	f.mana = _es(13, 17, 1, 2, lvl, 8); f.max_mana = f.mana
	f.physical_attack = _es(18, 23, 1, 2, lvl, 8)
	f.physical_defense = _es(23, 28, 1, 3, lvl, 8)
	f.magic_attack = _es(35, 40, 2, 3, lvl, 8)
	f.magic_defense = _es(24, 29, 1, 3, lvl, 8)
	f.speed = _es(34, 40, 1, 3, lvl, 8)
	f.crit_chance = 12; f.crit_damage = 1; f.dodge_chance = 9
	f.abilities = [EAB.dark_bolt(), EAB.minor_ward()]
	return f


static func create_early_cult_enforcer(n: String, lvl: int = 8) -> FighterData:
	var f := _base(n, "Cult Enforcer", lvl)
	f.health = _es(270, 310, 7, 11, lvl, 8); f.max_health = f.health
	f.mana = _es(8, 12, 1, 2, lvl, 8); f.max_mana = f.mana
	f.physical_attack = _es(36, 42, 2, 3, lvl, 8)
	f.physical_defense = _es(30, 35, 2, 3, lvl, 8)
	f.magic_attack = _es(13, 18, 0, 2, lvl, 8)
	f.magic_defense = _es(26, 31, 1, 3, lvl, 8)
	f.speed = _es(31, 37, 1, 2, lvl, 8)
	f.crit_chance = 12; f.crit_damage = 1; f.dodge_chance = 5
	f.abilities = [EAB.heavy_strike(), EAB.brace()]
	return f


# =============================================================================
# Prog 8: Thorne at reduced strength (S3_B_ThornesWard)
# =============================================================================

static func create_early_cult_ritualist(n: String, lvl: int = 9) -> FighterData:
	var f := _base(n, "Cult Ritualist", lvl)
	f.health = _es(310, 355, 7, 12, lvl, 9); f.max_health = f.health
	f.mana = _es(20, 25, 2, 3, lvl, 9); f.max_mana = f.mana
	f.physical_attack = _es(22, 28, 1, 3, lvl, 9)
	f.physical_defense = _es(33, 38, 2, 4, lvl, 9)
	f.magic_attack = _es(46, 52, 3, 4, lvl, 9)
	f.magic_defense = _es(36, 41, 2, 4, lvl, 9)
	f.speed = _es(39, 46, 1, 3, lvl, 9)
	f.crit_chance = 14; f.crit_damage = 1; f.dodge_chance = 10
	f.abilities = [EAB.thread_lash(), EAB.ritual_chant()]
	return f


# =============================================================================
# Prog 9: Shadow Innkeeper and Aldric projection (S3_B_LoomHeart)
# =============================================================================

static func create_shadow_innkeeper(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "Shadow Innkeeper", lvl)
	f.health = _es(340, 390, 8, 13, lvl, 10); f.max_health = f.health
	f.mana = _es(18, 23, 2, 3, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(30, 36, 1, 3, lvl, 10)
	f.physical_defense = _es(33, 39, 2, 4, lvl, 10)
	f.magic_attack = _es(42, 48, 3, 4, lvl, 10)
	f.magic_defense = _es(33, 39, 2, 4, lvl, 10)
	f.speed = _es(40, 47, 1, 3, lvl, 10)
	f.crit_chance = 15; f.crit_damage = 1; f.dodge_chance = 12
	f.abilities = [EAB.borrowed_face(), EAB.thread_drain()]
	return f


static func create_weaver_projection(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "High Weaver", lvl)
	f.health = _es(320, 370, 7, 12, lvl, 10); f.max_health = f.health
	f.mana = _es(22, 27, 2, 4, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(20, 26, 1, 2, lvl, 10)
	f.physical_defense = _es(30, 36, 1, 4, lvl, 10)
	f.magic_attack = _es(50, 56, 3, 4, lvl, 10)
	f.magic_defense = _es(36, 42, 2, 4, lvl, 10)
	f.speed = _es(42, 49, 1, 3, lvl, 10)
	f.crit_chance = 14; f.crit_damage = 1; f.dodge_chance = 12
	f.abilities = [EAB.loom_blast(), EAB.unweave()]
	return f


# =============================================================================
# Prog 12: Lira boss and upscaled minion (S3_B_DreamNexus)
# =============================================================================

static func create_lira_threadmaster(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "Lira, the Threadmaster", lvl)
	f.health = _es(541, 617, 15, 22, lvl, 13); f.max_health = f.health
	f.mana = _es(35, 40, 4, 6, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(59, 66, 3, 6, lvl, 13)
	f.physical_defense = _es(44, 50, 3, 5, lvl, 13)
	f.magic_attack = _es(65, 71, 4, 6, lvl, 13)
	f.magic_defense = _es(44, 50, 3, 5, lvl, 13)
	f.speed = _es(53, 60, 3, 5, lvl, 13)
	f.crit_chance = 22; f.crit_damage = 2; f.dodge_chance = 15
	f.abilities = [EAB.thread_puppetry(), EAB.dreamers_harvest(), EAB.liras_loom()]
	return f


static func create_final_loom_sentinel(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "Loom Sentinel", lvl)
	f.health = _es(310, 355, 8, 12, lvl, 13); f.max_health = f.health
	f.mana = _es(14, 19, 1, 3, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(50, 56, 3, 5, lvl, 13)
	f.physical_defense = _es(42, 48, 3, 5, lvl, 13)
	f.magic_attack = _es(28, 34, 1, 4, lvl, 13)
	f.magic_defense = _es(38, 44, 2, 4, lvl, 13)
	f.speed = _es(42, 49, 2, 4, lvl, 13)
	f.crit_chance = 12; f.crit_damage = 1; f.dodge_chance = 6
	f.abilities = [EAB.loom_strike(), EAB.woven_armor()]
	return f
