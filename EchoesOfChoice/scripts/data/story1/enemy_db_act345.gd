class_name EnemyDBAct345

## Acts III-V enemy factory (Progression 8-13): city guards, stranger, corruption, final.

const FighterData := preload("res://scripts/data/fighter_data.gd")
const AbilityDB := preload("res://scripts/data/ability_db.gd")
const EAB := preload("res://scripts/data/story1/enemy_ability_db.gd")


static func _es(base_min: int, base_max: int, gmin: int, gmax: int, level: int, base_level: int = 1) -> int:
	var lvl: int = level - base_level
	var lo: int = base_min + lvl * gmin
	var hi: int = base_max + lvl * (gmax - 1)
	if hi <= lo:
		return lo
	return randi_range(lo, hi - 1)

static func _fixed(base_min: int, base_max: int) -> int:
	return randi_range(base_min, base_max - 1)


static func _base(name: String, type: String, lvl: int) -> FighterData:
	var f := FighterData.new()
	f.character_name = name
	f.character_type = type
	f.class_id = type
	f.is_user_controlled = false
	f.level = lvl
	return f


# =============================================================================
# Act III enemies (Progression 8-9)
# =============================================================================

static func create_royal_guard(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Royal Guard", lvl)
	f.health = _es(206, 234, 8, 12, lvl, 12); f.max_health = f.health
	f.mana = _es(16, 22, 2, 4, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(41, 48, 3, 5, lvl, 12)
	f.physical_defense = _es(30, 35, 3, 4, lvl, 12)
	f.magic_attack = _es(5, 9, 0, 2, lvl, 12)
	f.magic_defense = _es(29, 35, 2, 3, lvl, 12)
	f.speed = _es(28, 34, 2, 3, lvl, 12)
	f.crit_chance = 18; f.crit_damage = 3; f.dodge_chance = 15
	f.abilities = [AbilityDB.shield_slam(), EAB.sword_strike(), EAB.defensive_formation()]
	return f

static func create_guard_sergeant(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Guard Sergeant", lvl)
	f.health = _es(213, 243, 8, 12, lvl, 12); f.max_health = f.health
	f.mana = _es(18, 24, 2, 4, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(44, 52, 3, 5, lvl, 12)
	f.physical_defense = _es(22, 28, 2, 3, lvl, 12)
	f.magic_attack = _es(7, 11, 0, 2, lvl, 12)
	f.magic_defense = _es(25, 29, 1, 2, lvl, 12)
	f.speed = _es(30, 36, 2, 3, lvl, 12)
	f.crit_chance = 22; f.crit_damage = 4; f.dodge_chance = 12
	f.abilities = [EAB.sword_strike(), AbilityDB.rally(), EAB.decisive_blow()]
	return f

static func create_guard_archer(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Guard Archer", lvl)
	f.health = _es(179, 207, 6, 10, lvl, 12); f.max_health = f.health
	f.mana = _es(18, 24, 2, 4, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(42, 49, 3, 5, lvl, 12)
	f.physical_defense = _es(16, 22, 1, 3, lvl, 12)
	f.magic_attack = _es(5, 9, 0, 2, lvl, 12)
	f.magic_defense = _es(23, 29, 1, 3, lvl, 12)
	f.speed = _es(34, 40, 3, 4, lvl, 12)
	f.crit_chance = 25; f.crit_damage = 4; f.dodge_chance = 20
	f.abilities = [EAB.arrow_shot(), EAB.volley(), EAB.pin_down()]
	return f

static func create_stranger(n: String, lvl: int = 16) -> FighterData:
	var f := _base(n, "Stranger", lvl)
	f.health = _es(552, 613, 16, 22, lvl, 16); f.max_health = f.health
	f.mana = _es(50, 58, 3, 5, lvl, 16); f.max_mana = f.mana
	f.physical_attack = _es(59, 68, 4, 6, lvl, 16)
	f.physical_defense = _es(34, 40, 2, 4, lvl, 16)
	f.magic_attack = _es(64, 73, 4, 7, lvl, 16)
	f.magic_defense = _es(37, 44, 2, 4, lvl, 16)
	f.speed = _es(43, 49, 2, 4, lvl, 16)
	f.crit_chance = 26; f.crit_damage = 4; f.dodge_chance = 18
	f.abilities = [EAB.shadow_strike(), EAB.dark_pulse(), EAB.void_shield(), EAB.drain()]
	return f


# =============================================================================
# Act IV-V enemies (Progression 10-13)
# =============================================================================

static func create_lich(n: String, lvl: int = 16) -> FighterData:
	var f := _base(n, "Lich", lvl)
	f.health = _es(270, 304, 8, 12, lvl, 16); f.max_health = f.health
	f.mana = _es(44, 52, 3, 5, lvl, 16); f.max_mana = f.mana
	f.physical_attack = _es(14, 18, 0, 2, lvl, 16)
	f.physical_defense = _es(23, 29, 2, 3, lvl, 16)
	f.magic_attack = _es(56, 64, 4, 6, lvl, 16)
	f.magic_defense = _es(39, 47, 3, 5, lvl, 16)
	f.speed = _es(36, 42, 2, 4, lvl, 16)
	f.crit_chance = 23; f.crit_damage = 5; f.dodge_chance = 22
	f.abilities = [EAB.death_bolt(), EAB.raise_dead(), EAB.soul_cage()]
	return f

static func create_ghast(n: String, lvl: int = 16) -> FighterData:
	var f := _base(n, "Ghast", lvl)
	f.health = _es(236, 268, 7, 10, lvl, 16); f.max_health = f.health
	f.mana = _es(22, 28, 2, 4, lvl, 16); f.max_mana = f.mana
	f.physical_attack = _es(51, 58, 3, 5, lvl, 16)
	f.physical_defense = _es(32, 37, 2, 4, lvl, 16)
	f.magic_attack = _es(18, 24, 1, 2, lvl, 16)
	f.magic_defense = _es(24, 30, 1, 3, lvl, 16)
	f.speed = _es(32, 38, 2, 3, lvl, 16)
	f.crit_chance = 17; f.crit_damage = 4; f.dodge_chance = 12
	f.abilities = [EAB.slam(), EAB.poison_cloud(), EAB.rend()]
	return f

static func create_demon(n: String, lvl: int = 16) -> FighterData:
	var f := _base(n, "Demon", lvl)
	f.health = _es(310, 345, 8, 12, lvl, 16); f.max_health = f.health
	f.mana = _es(48, 56, 3, 5, lvl, 16); f.max_mana = f.mana
	f.physical_attack = _es(24, 30, 1, 3, lvl, 16)
	f.physical_defense = _es(30, 36, 2, 4, lvl, 16)
	f.magic_attack = _es(61, 69, 4, 6, lvl, 16)
	f.magic_defense = _es(38, 44, 2, 4, lvl, 16)
	f.speed = _es(36, 42, 2, 4, lvl, 16)
	f.crit_chance = 22; f.crit_damage = 4; f.dodge_chance = 22
	f.abilities = [EAB.brimstone(), EAB.infernal_strike(), EAB.dread()]
	return f

static func create_corrupted_treant(n: String, lvl: int = 16) -> FighterData:
	var f := _base(n, "Corrupted Treant", lvl)
	f.health = _es(290, 324, 8, 12, lvl, 16); f.max_health = f.health
	f.mana = _es(24, 30, 2, 4, lvl, 16); f.max_mana = f.mana
	f.physical_attack = _es(48, 55, 3, 5, lvl, 16)
	f.physical_defense = _es(39, 45, 3, 5, lvl, 16)
	f.magic_attack = _es(16, 22, 1, 2, lvl, 16)
	f.magic_defense = _es(35, 40, 2, 4, lvl, 16)
	f.speed = _es(28, 34, 1, 3, lvl, 16)
	f.crit_chance = 16; f.crit_damage = 4; f.dodge_chance = 11
	f.abilities = [EAB.vine_whip(), EAB.root_slam(), EAB.bark_shield()]
	return f

static func create_hellion(n: String, lvl: int = 17) -> FighterData:
	var f := _base(n, "Hellion", lvl)
	f.health = _fixed(143, 163); f.max_health = f.health
	f.mana = _fixed(34, 40); f.max_mana = f.mana
	f.physical_attack = _fixed(40, 44); f.physical_defense = _fixed(21, 25)
	f.magic_attack = _fixed(34, 39); f.magic_defense = _fixed(19, 23)
	f.speed = _fixed(37, 43)
	f.crit_chance = 27; f.crit_damage = 4; f.dodge_chance = 18
	f.abilities = [EAB.infernal_strike(), EAB.shadow_strike(), EAB.enemy_hex()]
	return f

static func create_fiendling(n: String, lvl: int = 17) -> FighterData:
	var f := _base(n, "Fiendling", lvl)
	f.health = _fixed(129, 150); f.max_health = f.health
	f.mana = _fixed(40, 48); f.max_mana = f.mana
	f.physical_attack = _fixed(14, 18); f.physical_defense = _fixed(16, 21)
	f.magic_attack = _fixed(43, 50); f.magic_defense = _fixed(22, 26)
	f.speed = _fixed(39, 45)
	f.crit_chance = 25; f.crit_damage = 4; f.dodge_chance = 18
	f.abilities = [EAB.brimstone(), EAB.dread(), EAB.enemy_hex()]
	return f

static func create_dragon(n: String, lvl: int = 17) -> FighterData:
	var f := _base(n, "Dragon", lvl)
	f.health = _fixed(213, 233); f.max_health = f.health
	f.mana = _fixed(42, 50); f.max_mana = f.mana
	f.physical_attack = _fixed(26, 30); f.physical_defense = _fixed(25, 29)
	f.magic_attack = _fixed(40, 44); f.magic_defense = _fixed(22, 26)
	f.speed = _fixed(35, 41)
	f.crit_chance = 28; f.crit_damage = 4; f.dodge_chance = 16
	f.abilities = [EAB.dragon_breath(), EAB.tail_strike(), AbilityDB.roar()]
	return f

static func create_blighted_stag(n: String, lvl: int = 17) -> FighterData:
	var f := _base(n, "Blighted Stag", lvl)
	f.health = _fixed(144, 164); f.max_health = f.health
	f.mana = _fixed(28, 34); f.max_mana = f.mana
	f.physical_attack = _fixed(36, 41); f.physical_defense = _fixed(18, 22)
	f.magic_attack = _fixed(18, 22); f.magic_defense = _fixed(16, 21)
	f.speed = _fixed(39, 45)
	f.crit_chance = 19; f.crit_damage = 4; f.dodge_chance = 17
	f.abilities = [EAB.antler_charge(), EAB.rot_aura(), EAB.enemy_blight()]
	return f

static func create_dark_knight(n: String, lvl: int = 18) -> FighterData:
	var f := _base(n, "Dark Knight", lvl)
	f.health = _es(348, 384, 8, 12, lvl, 18); f.max_health = f.health
	f.mana = _es(30, 38, 3, 5, lvl, 18); f.max_mana = f.mana
	f.physical_attack = _es(64, 71, 4, 6, lvl, 18)
	f.physical_defense = _es(37, 45, 3, 5, lvl, 18)
	f.magic_attack = _es(35, 43, 2, 4, lvl, 18)
	f.magic_defense = _es(36, 43, 2, 4, lvl, 18)
	f.speed = _es(37, 43, 2, 4, lvl, 18)
	f.crit_chance = 26; f.crit_damage = 5; f.dodge_chance = 19
	f.abilities = [EAB.dark_blade(), EAB.shadow_guard(), EAB.cleave()]
	return f

static func create_fell_hound(n: String, lvl: int = 18) -> FighterData:
	var f := _base(n, "Fell Hound", lvl)
	f.health = _es(290, 325, 7, 10, lvl, 18); f.max_health = f.health
	f.mana = _es(30, 38, 3, 5, lvl, 18); f.max_mana = f.mana
	f.physical_attack = _es(23, 28, 1, 3, lvl, 18)
	f.physical_defense = _es(26, 31, 2, 3, lvl, 18)
	f.magic_attack = _es(56, 63, 3, 5, lvl, 18)
	f.magic_defense = _es(34, 39, 2, 4, lvl, 18)
	f.speed = _es(43, 49, 3, 5, lvl, 18)
	f.crit_chance = 22; f.crit_damage = 4; f.dodge_chance = 22
	f.abilities = [EAB.shadow_bite(), EAB.howl_of_dread(), EAB.enemy_blight()]
	return f

static func create_sigil_wretch(n: String, lvl: int = 18) -> FighterData:
	var f := _base(n, "Sigil Wretch", lvl)
	f.health = _es(284, 318, 7, 10, lvl, 18); f.max_health = f.health
	f.mana = _es(40, 48, 3, 5, lvl, 18); f.max_mana = f.mana
	f.physical_attack = _es(13, 16, 0, 2, lvl, 18)
	f.physical_defense = _es(24, 30, 1, 3, lvl, 18)
	f.magic_attack = _es(62, 72, 5, 7, lvl, 18)
	f.magic_defense = _es(36, 42, 2, 4, lvl, 18)
	f.speed = _es(42, 48, 3, 5, lvl, 18)
	f.crit_chance = 24; f.crit_damage = 4; f.dodge_chance = 23
	f.abilities = [EAB.spark(), AbilityDB.ember(), EAB.enemy_hex()]
	return f

static func create_tunnel_lurker(n: String, lvl: int = 18) -> FighterData:
	var f := _base(n, "Tunnel Lurker", lvl)
	f.health = _es(363, 399, 10, 14, lvl, 18); f.max_health = f.health
	f.mana = _es(26, 32, 2, 4, lvl, 18); f.max_mana = f.mana
	f.physical_attack = _es(66, 75, 5, 7, lvl, 18)
	f.physical_defense = _es(33, 39, 2, 4, lvl, 18)
	f.magic_attack = _es(14, 20, 1, 2, lvl, 18)
	f.magic_defense = _es(35, 41, 2, 3, lvl, 18)
	f.speed = _es(39, 45, 3, 5, lvl, 18)
	f.crit_chance = 25; f.crit_damage = 4; f.dodge_chance = 20
	f.abilities = [EAB.venomous_bite(), EAB.web(), EAB.poison_cloud()]
	return f

static func create_stranger_final(n: String, lvl: int = 20) -> FighterData:
	var f := _base(n, "Stranger", lvl)
	f.class_id = "StrangerFinal"
	f.health = _es(862, 945, 17, 23, lvl, 20); f.max_health = f.health
	f.mana = _es(70, 80, 5, 7, lvl, 20); f.max_mana = f.mana
	f.physical_attack = _es(74, 83, 4, 6, lvl, 20)
	f.physical_defense = _es(51, 57, 3, 5, lvl, 20)
	f.magic_attack = _es(83, 92, 5, 7, lvl, 20)
	f.magic_defense = _es(54, 60, 3, 5, lvl, 20)
	f.speed = _es(54, 61, 3, 5, lvl, 20)
	f.crit_chance = 29; f.crit_damage = 5; f.dodge_chance = 19
	f.abilities = [EAB.shadow_blast(), EAB.siphon(), EAB.dark_veil(), EAB.unmake(), AbilityDB.corruption()]
	return f
