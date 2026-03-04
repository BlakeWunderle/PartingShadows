class_name EnemyDBS2

## Story 2 enemy factory. Separate from EnemyDB to avoid touching Story 1 balance.

const FighterData := preload("res://scripts/data/fighter_data.gd")
const EAB := preload("res://scripts/data/enemy_ability_db.gd")


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
# Cave creatures (Progression 0-2)
# =============================================================================

static func create_glow_worm(n: String, lvl: int = 1) -> FighterData:
	var f := _base(n, "Glow Worm", lvl)
	f.health = _es(30, 38, 2, 4, lvl, 1); f.max_health = f.health
	f.mana = _es(8, 12, 1, 3, lvl, 1); f.max_mana = f.mana
	f.physical_attack = _es(8, 11, 0, 2, lvl, 1)
	f.physical_defense = _es(4, 7, 0, 1, lvl, 1)
	f.magic_attack = _es(14, 17, 1, 3, lvl, 1)
	f.magic_defense = _es(8, 11, 1, 2, lvl, 1)
	f.speed = _es(22, 28, 1, 3, lvl, 1)
	f.crit_chance = 10; f.crit_damage = 1; f.dodge_chance = 12
	f.abilities = [EAB.luminous_pulse(), EAB.glare()]
	return f


static func create_crystal_spider(n: String, lvl: int = 1) -> FighterData:
	var f := _base(n, "Crystal Spider", lvl)
	f.health = _es(48, 56, 3, 6, lvl, 1); f.max_health = f.health
	f.mana = _es(4, 8, 1, 2, lvl, 1); f.max_mana = f.mana
	f.physical_attack = _es(16, 19, 1, 3, lvl, 1)
	f.physical_defense = _es(9, 12, 1, 2, lvl, 1)
	f.magic_attack = _es(3, 6, 0, 1, lvl, 1)
	f.magic_defense = _es(7, 10, 1, 2, lvl, 1)
	f.speed = _es(20, 26, 1, 2, lvl, 1)
	f.crit_chance = 12; f.crit_damage = 1; f.dodge_chance = 8
	f.abilities = [EAB.crystal_fang(), EAB.refract()]
	return f


static func create_shade_crawler(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Shade Crawler", lvl)
	f.health = _es(52, 62, 3, 5, lvl, 2); f.max_health = f.health
	f.mana = _es(6, 10, 1, 3, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(14, 18, 1, 3, lvl, 2)
	f.physical_defense = _es(8, 11, 1, 2, lvl, 2)
	f.magic_attack = _es(12, 16, 1, 2, lvl, 2)
	f.magic_defense = _es(8, 11, 1, 2, lvl, 2)
	f.speed = _es(24, 30, 2, 3, lvl, 2)
	f.crit_chance = 10; f.crit_damage = 1; f.dodge_chance = 15
	f.abilities = [EAB.shadow_lash(), EAB.dissolve()]
	return f


static func create_echo_wisp(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Echo Wisp", lvl)
	f.health = _es(36, 44, 2, 4, lvl, 2); f.max_health = f.health
	f.mana = _es(10, 14, 1, 3, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(6, 9, 0, 1, lvl, 2)
	f.physical_defense = _es(5, 8, 0, 1, lvl, 2)
	f.magic_attack = _es(16, 20, 1, 3, lvl, 2)
	f.magic_defense = _es(10, 14, 1, 2, lvl, 2)
	f.speed = _es(26, 32, 2, 3, lvl, 2)
	f.crit_chance = 10; f.crit_damage = 1; f.dodge_chance = 18
	f.abilities = [EAB.resonance(), EAB.distortion()]
	return f


static func create_cave_maw(n: String, lvl: int = 3) -> FighterData:
	var f := _base(n, "Cave Maw", lvl)
	f.health = _es(78, 90, 4, 7, lvl, 3); f.max_health = f.health
	f.mana = _es(8, 12, 1, 3, lvl, 3); f.max_mana = f.mana
	f.physical_attack = _es(22, 26, 2, 3, lvl, 3)
	f.physical_defense = _es(14, 18, 1, 3, lvl, 3)
	f.magic_attack = _es(4, 7, 0, 1, lvl, 3)
	f.magic_defense = _es(10, 14, 1, 2, lvl, 3)
	f.speed = _es(16, 22, 1, 2, lvl, 3)
	f.crit_chance = 10; f.crit_damage = 2; f.dodge_chance = 5
	f.abilities = [EAB.gnash(), EAB.swallow(), EAB.tremor()]
	return f
