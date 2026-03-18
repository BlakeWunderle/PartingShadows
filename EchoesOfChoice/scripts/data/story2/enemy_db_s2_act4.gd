class_name EnemyDBS2Act4

## Story 2 Act IV enemy factory: the Eye's domain.

const FighterData := preload("res://scripts/data/fighter_data.gd")
const EAB := preload("res://scripts/data/story2/enemy_ability_db_s2.gd")


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
# The Eye's servants (level 14)
# =============================================================================

static func create_gaze_stalker(n: String, lvl: int = 14) -> FighterData:
	var f := _base(n, "Gaze Stalker", lvl)
	f.health = _es(410, 465, 5, 8, lvl, 14); f.max_health = f.health
	f.mana = _es(18, 23, 1, 3, lvl, 14); f.max_mana = f.mana
	f.physical_attack = _es(72, 84, 3, 5, lvl, 14)
	f.physical_defense = _es(35, 43, 2, 3, lvl, 14)
	f.magic_attack = _es(72, 84, 3, 5, lvl, 14)
	f.magic_defense = _es(31, 39, 2, 3, lvl, 14)
	f.speed = _es(36, 42, 2, 3, lvl, 14)
	f.crit_chance = 19; f.crit_damage = 3; f.dodge_chance = 15
	f.abilities = [EAB.piercing_gaze_strike(), EAB.focus_break()]
	return f


static func create_memory_harvester(n: String, lvl: int = 14) -> FighterData:
	var f := _base(n, "Memory Harvester", lvl)
	f.health = _es(452, 510, 5, 8, lvl, 14); f.max_health = f.health
	f.mana = _es(32, 38, 2, 4, lvl, 14); f.max_mana = f.mana
	f.physical_attack = _es(20, 28, 1, 2, lvl, 14)
	f.physical_defense = _es(29, 37, 2, 3, lvl, 14)
	f.magic_attack = _es(107, 123, 3, 5, lvl, 14)
	f.magic_defense = _es(46, 54, 2, 4, lvl, 14)
	f.speed = _es(31, 37, 2, 3, lvl, 14)
	f.crit_chance = 13; f.crit_damage = 3; f.dodge_chance = 11
	f.abilities = [EAB.harvest_thought(), EAB.mass_extraction()]
	return f


static func create_oblivion_shade(n: String, lvl: int = 14) -> FighterData:
	var f := _base(n, "Oblivion Shade", lvl)
	f.health = _es(312, 354, 4, 7, lvl, 14); f.max_health = f.health
	f.mana = _es(28, 34, 2, 4, lvl, 14); f.max_mana = f.mana
	f.physical_attack = _es(20, 28, 1, 2, lvl, 14)
	f.physical_defense = _es(20, 28, 1, 3, lvl, 14)
	f.magic_attack = _es(81, 94, 3, 4, lvl, 14)
	f.magic_defense = _es(42, 51, 2, 4, lvl, 14)
	f.speed = _es(39, 45, 2, 4, lvl, 14)
	f.crit_chance = 13; f.crit_damage = 3; f.dodge_chance = 18
	f.abilities = [EAB.wave_of_oblivion(), EAB.nihil_bolt()]
	return f


static func create_thoughtform_knight(n: String, lvl: int = 14) -> FighterData:
	var f := _base(n, "Thoughtform Knight", lvl)
	f.health = _es(645, 715, 7, 10, lvl, 14); f.max_health = f.health
	f.mana = _es(23, 29, 2, 3, lvl, 14); f.max_mana = f.mana
	f.physical_attack = _es(122, 141, 3, 5, lvl, 14)
	f.physical_defense = _es(60, 70, 3, 5, lvl, 14)
	f.magic_attack = _es(16, 23, 1, 2, lvl, 14)
	f.magic_defense = _es(48, 56, 2, 4, lvl, 14)
	f.speed = _es(24, 30, 1, 3, lvl, 14)
	f.crit_chance = 15; f.crit_damage = 3; f.dodge_chance = 7
	f.abilities = [EAB.memory_blade(), EAB.ironclad_will()]
	return f


# =============================================================================
# The Eye (level 15 bosses)
# =============================================================================

static func create_the_iris(n: String, lvl: int = 15) -> FighterData:
	var f := _base(n, "The Iris", lvl)
	f.health = _es(805, 897, 8, 11, lvl, 15); f.max_health = f.health
	f.mana = _es(44, 52, 3, 5, lvl, 15); f.max_mana = f.mana
	f.physical_attack = _es(27, 36, 1, 3, lvl, 15)
	f.physical_defense = _es(59, 70, 3, 5, lvl, 15)
	f.magic_attack = _es(140, 161, 4, 7, lvl, 15)
	f.magic_defense = _es(74, 84, 3, 5, lvl, 15)
	f.speed = _es(32, 38, 2, 3, lvl, 15)
	f.crit_chance = 17; f.crit_damage = 3; f.dodge_chance = 9
	f.abilities = [EAB.prismatic_blast(), EAB.refraction_beam(), EAB.crystalline_ward()]
	return f


static func create_the_lidless_eye(n: String, lvl: int = 15) -> FighterData:
	var f := _base(n, "The Lidless Eye", lvl)
	f.health = _es(1143, 1298, 9, 13, lvl, 15); f.max_health = f.health
	f.mana = _es(52, 60, 3, 5, lvl, 15); f.max_mana = f.mana
	f.physical_attack = _es(22, 30, 1, 3, lvl, 15)
	f.physical_defense = _es(62, 74, 3, 5, lvl, 15)
	f.magic_attack = _es(141, 160, 5, 8, lvl, 15)
	f.magic_defense = _es(81, 94, 4, 6, lvl, 15)
	f.speed = _es(33, 39, 2, 4, lvl, 15)
	f.crit_chance = 17; f.crit_damage = 3; f.dodge_chance = 10
	f.abilities = [EAB.gaze_of_forgetting(), EAB.memory_devour(), EAB.final_blink()]
	return f
