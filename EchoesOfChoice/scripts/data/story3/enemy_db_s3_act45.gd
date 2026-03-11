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
# =============================================================================

static func create_cult_acolyte(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "Cult Acolyte", lvl)
	f.health = _es(310, 356, 7, 10, lvl, 10); f.max_health = f.health
	f.mana = _es(18, 22, 2, 3, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(26, 32, 1, 3, lvl, 10)
	f.physical_defense = _es(32, 38, 2, 3, lvl, 10)
	f.magic_attack = _es(48, 54, 2, 4, lvl, 10)
	f.magic_defense = _es(32, 38, 2, 3, lvl, 10)
	f.speed = _es(32, 37, 1, 3, lvl, 10)
	f.crit_chance = 12; f.crit_damage = 1; f.dodge_chance = 10
	f.abilities = [EAB.dark_bolt(), EAB.minor_ward()]
	return f


static func create_cult_enforcer(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "Cult Enforcer", lvl)
	f.health = _es(370, 418, 8, 12, lvl, 10); f.max_health = f.health
	f.mana = _es(10, 14, 1, 2, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(52, 58, 2, 4, lvl, 10)
	f.physical_defense = _es(42, 48, 2, 3, lvl, 10)
	f.magic_attack = _es(18, 22, 1, 2, lvl, 10)
	f.magic_defense = _es(34, 40, 2, 3, lvl, 10)
	f.speed = _es(30, 35, 1, 3, lvl, 10)
	f.crit_chance = 12; f.crit_damage = 1; f.dodge_chance = 5
	f.abilities = [EAB.heavy_strike(), EAB.brace()]
	return f


static func create_cult_hexer(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "Cult Hexer", lvl)
	f.health = _es(300, 345, 6, 9, lvl, 10); f.max_health = f.health
	f.mana = _es(22, 26, 2, 4, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(24, 30, 1, 2, lvl, 10)
	f.physical_defense = _es(28, 34, 1, 3, lvl, 10)
	f.magic_attack = _es(52, 58, 2, 4, lvl, 10)
	f.magic_defense = _es(34, 40, 2, 3, lvl, 10)
	f.speed = _es(32, 37, 2, 3, lvl, 10)
	f.crit_chance = 14; f.crit_damage = 1; f.dodge_chance = 12
	f.abilities = [EAB.hex_bolt(), EAB.curse()]
	return f


static func create_thread_guard(n: String, lvl: int = 11) -> FighterData:
	var f := _base(n, "Thread Guard", lvl)
	f.health = _es(385, 438, 8, 12, lvl, 11); f.max_health = f.health
	f.mana = _es(14, 18, 1, 2, lvl, 11); f.max_mana = f.mana
	f.physical_attack = _es(54, 60, 2, 4, lvl, 11)
	f.physical_defense = _es(42, 48, 2, 4, lvl, 11)
	f.magic_attack = _es(24, 30, 1, 2, lvl, 11)
	f.magic_defense = _es(38, 44, 2, 3, lvl, 11)
	f.speed = _es(32, 37, 2, 3, lvl, 11)
	f.crit_chance = 12; f.crit_damage = 1; f.dodge_chance = 10
	f.abilities = [EAB.threaded_blade(), EAB.woven_shield()]
	return f


static func create_dream_hound(n: String, lvl: int = 11) -> FighterData:
	var f := _base(n, "Dream Hound", lvl)
	f.health = _es(340, 388, 7, 10, lvl, 11); f.max_health = f.health
	f.mana = _es(12, 16, 1, 2, lvl, 11); f.max_mana = f.mana
	f.physical_attack = _es(52, 58, 2, 4, lvl, 11)
	f.physical_defense = _es(32, 38, 2, 3, lvl, 11)
	f.magic_attack = _es(20, 26, 1, 2, lvl, 11)
	f.magic_defense = _es(28, 34, 1, 3, lvl, 11)
	f.speed = _es(36, 41, 2, 3, lvl, 11)
	f.crit_chance = 16; f.crit_damage = 1; f.dodge_chance = 14
	f.abilities = [EAB.feral_bite(), EAB.dream_howl()]
	return f


static func create_cult_ritualist(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Cult Ritualist", lvl)
	f.health = _es(380, 432, 7, 10, lvl, 12); f.max_health = f.health
	f.mana = _es(24, 28, 2, 4, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(26, 32, 1, 2, lvl, 12)
	f.physical_defense = _es(38, 44, 2, 3, lvl, 12)
	f.magic_attack = _es(54, 60, 2, 4, lvl, 12)
	f.magic_defense = _es(42, 48, 2, 3, lvl, 12)
	f.speed = _es(32, 37, 2, 3, lvl, 12)
	f.crit_chance = 12; f.crit_damage = 1; f.dodge_chance = 10
	f.abilities = [EAB.thread_lash(), EAB.ritual_chant()]
	return f


static func create_high_weaver(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "High Weaver", lvl)
	f.health = _es(400, 452, 8, 11, lvl, 12); f.max_health = f.health
	f.mana = _es(26, 30, 2, 4, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(24, 30, 1, 2, lvl, 12)
	f.physical_defense = _es(36, 42, 2, 3, lvl, 12)
	f.magic_attack = _es(60, 66, 3, 4, lvl, 12)
	f.magic_defense = _es(42, 48, 2, 3, lvl, 12)
	f.speed = _es(34, 39, 2, 3, lvl, 12)
	f.crit_chance = 14; f.crit_damage = 1; f.dodge_chance = 12
	f.abilities = [EAB.loom_blast(), EAB.unweave()]
	return f


static func create_the_threadmaster(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "The Threadmaster", lvl)
	f.health = _es(540, 620, 12, 18, lvl, 13); f.max_health = f.health
	f.mana = _es(32, 36, 3, 5, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(58, 66, 3, 4, lvl, 13)
	f.physical_defense = _es(44, 50, 2, 4, lvl, 13)
	f.magic_attack = _es(66, 74, 3, 5, lvl, 13)
	f.magic_defense = _es(44, 50, 2, 4, lvl, 13)
	f.speed = _es(38, 43, 2, 3, lvl, 13)
	f.crit_chance = 16; f.crit_damage = 2; f.dodge_chance = 12
	f.abilities = [EAB.dream_shatter(), EAB.loom_collapse(), EAB.thread_of_oblivion()]
	return f
