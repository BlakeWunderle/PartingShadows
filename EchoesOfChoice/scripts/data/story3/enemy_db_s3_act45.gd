class_name EnemyDBS3Act45

## Story 3 Acts IV-V enemy factory. Cult members and the Threadmaster.

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
# Acts IV-V: Cult members (Progression 9-12)
# Per-enemy calibration from R4/R5 interpolation.
# =============================================================================

# Prog 9 (+41%)
static func create_cult_acolyte(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "Cult Acolyte", lvl)
	f.health = _es(459, 527, 7, 11, lvl, 10); f.max_health = f.health
	f.mana = _es(16, 21, 1, 3, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(29, 36, 1, 3, lvl, 10)
	f.physical_defense = _es(31, 37, 1, 3, lvl, 10)
	f.magic_attack = _es(52, 59, 3, 4, lvl, 10)
	f.magic_defense = _es(31, 37, 1, 3, lvl, 10)
	f.speed = _es(42, 49, 1, 3, lvl, 10)
	f.crit_chance = 16; f.crit_damage = 1; f.dodge_chance = 11
	f.abilities = [EAB.dark_bolt(), EAB.minor_ward()]
	return f


# Prog 9 (+41%)
static func create_cult_enforcer(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "Cult Enforcer", lvl)
	f.health = _es(550, 620, 9, 14, lvl, 10); f.max_health = f.health
	f.mana = _es(10, 15, 1, 2, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(55, 62, 3, 4, lvl, 10)
	f.physical_defense = _es(39, 45, 3, 4, lvl, 10)
	f.magic_attack = _es(20, 26, 0, 3, lvl, 10)
	f.magic_defense = _es(34, 39, 1, 3, lvl, 10)
	f.speed = _es(39, 47, 1, 3, lvl, 10)
	f.crit_chance = 16; f.crit_damage = 1; f.dodge_chance = 7
	f.abilities = [EAB.heavy_strike(), EAB.brace()]
	return f


# Prog 9 (+41%)
static func create_cult_hexer(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "Cult Hexer", lvl)
	f.health = _es(446, 515, 6, 10, lvl, 10); f.max_health = f.health
	f.mana = _es(21, 26, 2, 4, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(26, 32, 1, 3, lvl, 10)
	f.physical_defense = _es(28, 34, 1, 3, lvl, 10)
	f.magic_attack = _es(55, 62, 3, 4, lvl, 10)
	f.magic_defense = _es(34, 39, 1, 4, lvl, 10)
	f.speed = _es(42, 49, 1, 3, lvl, 10)
	f.crit_chance = 19; f.crit_damage = 1; f.dodge_chance = 14
	f.abilities = [EAB.hex_bolt(), EAB.curse()]
	return f


# Shared Prog 10 & 11 (+38%, unchanged)
static func create_thread_guard(n: String, lvl: int = 11) -> FighterData:
	var f := _base(n, "Thread Guard", lvl)
	f.health = _es(527, 600, 8, 14, lvl, 11); f.max_health = f.health
	f.mana = _es(15, 20, 1, 2, lvl, 11); f.max_mana = f.mana
	f.physical_attack = _es(58, 63, 3, 4, lvl, 11)
	f.physical_defense = _es(39, 44, 3, 4, lvl, 11)
	f.magic_attack = _es(25, 32, 1, 3, lvl, 11)
	f.magic_defense = _es(36, 41, 1, 4, lvl, 11)
	f.speed = _es(41, 48, 1, 3, lvl, 11)
	f.crit_chance = 14; f.crit_damage = 1; f.dodge_chance = 11
	f.abilities = [EAB.threaded_blade(), EAB.woven_shield()]
	return f


# Prog 10 (+40%)
static func create_dream_hound(n: String, lvl: int = 11) -> FighterData:
	var f := _base(n, "Dream Hound", lvl)
	f.health = _es(465, 529, 7, 11, lvl, 11); f.max_health = f.health
	f.mana = _es(12, 17, 1, 2, lvl, 11); f.max_mana = f.mana
	f.physical_attack = _es(58, 62, 3, 4, lvl, 11)
	f.physical_defense = _es(31, 36, 1, 3, lvl, 11)
	f.magic_attack = _es(23, 29, 1, 3, lvl, 11)
	f.magic_defense = _es(28, 34, 1, 3, lvl, 11)
	f.speed = _es(48, 55, 3, 4, lvl, 11)
	f.crit_chance = 18; f.crit_damage = 1; f.dodge_chance = 15
	f.abilities = [EAB.feral_bite(), EAB.dream_howl()]
	return f


# Prog 11 (+63%)
static func create_cult_ritualist(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Cult Ritualist", lvl)
	f.health = _es(618, 707, 8, 13, lvl, 12); f.max_health = f.health
	f.mana = _es(26, 31, 3, 4, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(33, 41, 1, 3, lvl, 12)
	f.physical_defense = _es(42, 49, 1, 5, lvl, 12)
	f.magic_attack = _es(68, 75, 3, 5, lvl, 12)
	f.magic_defense = _es(46, 52, 3, 5, lvl, 12)
	f.speed = _es(49, 57, 1, 3, lvl, 12)
	f.crit_chance = 16; f.crit_damage = 1; f.dodge_chance = 12
	f.abilities = [EAB.thread_lash(), EAB.ritual_chant()]
	return f


# Prog 11 (+63%)
static func create_high_weaver(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "High Weaver", lvl)
	f.health = _es(657, 746, 8, 15, lvl, 12); f.max_health = f.health
	f.mana = _es(28, 33, 3, 5, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(30, 38, 1, 3, lvl, 12)
	f.physical_defense = _es(39, 46, 1, 5, lvl, 12)
	f.magic_attack = _es(75, 83, 3, 6, lvl, 12)
	f.magic_defense = _es(46, 52, 3, 5, lvl, 12)
	f.speed = _es(52, 60, 1, 5, lvl, 12)
	f.crit_chance = 18; f.crit_damage = 1; f.dodge_chance = 15
	f.abilities = [EAB.loom_blast(), EAB.unweave()]
	return f


# Prog 12 boss minion (+45%)
static func create_shadow_fragment(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "Shadow Fragment", lvl)
	f.health = _es(473, 544, 8, 12, lvl, 13); f.max_health = f.health
	f.mana = _es(17, 22, 1, 4, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(33, 40, 1, 4, lvl, 13)
	f.physical_defense = _es(32, 38, 1, 5, lvl, 13)
	f.magic_attack = _es(56, 63, 3, 5, lvl, 13)
	f.magic_defense = _es(35, 41, 1, 4, lvl, 13)
	f.speed = _es(49, 57, 3, 5, lvl, 13)
	f.crit_chance = 18; f.crit_damage = 1; f.dodge_chance = 18
	f.abilities = [EAB.shadow_lash(), EAB.consume_light()]
	return f


# Prog 12 boss (+47%)
static func create_the_threadmaster(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "The Threadmaster", lvl)
	f.health = _es(839, 956, 15, 22, lvl, 13); f.max_health = f.health
	f.mana = _es(35, 40, 4, 6, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(68, 76, 3, 6, lvl, 13)
	f.physical_defense = _es(44, 50, 3, 5, lvl, 13)
	f.magic_attack = _es(75, 82, 4, 6, lvl, 13)
	f.magic_defense = _es(44, 50, 3, 5, lvl, 13)
	f.speed = _es(53, 60, 3, 5, lvl, 13)
	f.crit_chance = 22; f.crit_damage = 2; f.dodge_chance = 15
	f.abilities = [EAB.dream_shatter(), EAB.loom_collapse(), EAB.thread_of_oblivion()]
	return f
