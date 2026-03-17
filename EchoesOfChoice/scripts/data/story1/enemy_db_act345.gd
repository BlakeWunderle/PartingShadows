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
	f.health = _es(318, 362, 12, 18, lvl, 12); f.max_health = f.health
	f.mana = _es(20, 28, 3, 5, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(55, 65, 4, 7, lvl, 12)
	f.physical_defense = _es(39, 46, 4, 5, lvl, 12)
	f.magic_attack = _es(7, 12, 0, 2, lvl, 12)
	f.magic_defense = _es(38, 46, 3, 4, lvl, 12)
	f.speed = _es(28, 34, 2, 3, lvl, 12)
	f.crit_chance = 20; f.crit_damage = 3; f.dodge_chance = 15
	f.abilities = [AbilityDB.shield_slam(), EAB.sword_strike(), EAB.defensive_formation()]
	return f

static func create_guard_sergeant(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Guard Sergeant", lvl)
	f.health = _es(329, 375, 12, 18, lvl, 12); f.max_health = f.health
	f.mana = _es(23, 30, 3, 5, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(59, 70, 4, 7, lvl, 12)
	f.physical_defense = _es(29, 36, 3, 4, lvl, 12)
	f.magic_attack = _es(9, 15, 0, 3, lvl, 12)
	f.magic_defense = _es(33, 38, 2, 3, lvl, 12)
	f.speed = _es(30, 36, 2, 3, lvl, 12)
	f.crit_chance = 24; f.crit_damage = 4; f.dodge_chance = 12
	f.abilities = [EAB.sword_strike(), AbilityDB.rally(), EAB.decisive_blow()]
	return f

static func create_guard_archer(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Guard Archer", lvl)
	f.health = _es(276, 320, 9, 15, lvl, 12); f.max_health = f.health
	f.mana = _es(23, 30, 3, 5, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(57, 66, 4, 7, lvl, 12)
	f.physical_defense = _es(21, 29, 1, 4, lvl, 12)
	f.magic_attack = _es(7, 12, 0, 3, lvl, 12)
	f.magic_defense = _es(30, 38, 2, 4, lvl, 12)
	f.speed = _es(34, 40, 3, 4, lvl, 12)
	f.crit_chance = 27; f.crit_damage = 4; f.dodge_chance = 20
	f.abilities = [EAB.arrow_shot(), EAB.volley(), EAB.pin_down()]
	return f

static func create_stranger(n: String, lvl: int = 16) -> FighterData:
	var f := _base(n, "Stranger", lvl)
	f.health = _es(808, 897, 22, 31, lvl, 16); f.max_health = f.health
	f.mana = _es(65, 75, 4, 7, lvl, 16); f.max_mana = f.mana
	f.physical_attack = _es(77, 88, 5, 8, lvl, 16)
	f.physical_defense = _es(44, 52, 3, 5, lvl, 16)
	f.magic_attack = _es(83, 95, 5, 9, lvl, 16)
	f.magic_defense = _es(48, 57, 3, 5, lvl, 16)
	f.speed = _es(43, 49, 2, 4, lvl, 16)
	f.crit_chance = 28; f.crit_damage = 4; f.dodge_chance = 18
	f.abilities = [EAB.shadow_strike(), EAB.dark_pulse(), EAB.void_shield(), EAB.drain()]
	return f


# =============================================================================
# Act IV-V enemies (Progression 10-13)
# =============================================================================

static func create_lich(n: String, lvl: int = 16) -> FighterData:
	var f := _base(n, "Lich", lvl)
	f.health = _es(375, 423, 11, 16, lvl, 16); f.max_health = f.health
	f.mana = _es(57, 68, 4, 7, lvl, 16); f.max_mana = f.mana
	f.physical_attack = _es(18, 24, 0, 3, lvl, 16)
	f.physical_defense = _es(30, 38, 3, 4, lvl, 16)
	f.magic_attack = _es(73, 83, 5, 8, lvl, 16)
	f.magic_defense = _es(51, 61, 4, 7, lvl, 16)
	f.speed = _es(36, 42, 2, 4, lvl, 16)
	f.crit_chance = 25; f.crit_damage = 5; f.dodge_chance = 22
	f.abilities = [EAB.death_bolt(), EAB.raise_dead(), EAB.soul_cage()]
	return f

static func create_ghast(n: String, lvl: int = 16) -> FighterData:
	var f := _base(n, "Ghast", lvl)
	f.health = _es(328, 373, 9, 14, lvl, 16); f.max_health = f.health
	f.mana = _es(29, 36, 3, 5, lvl, 16); f.max_mana = f.mana
	f.physical_attack = _es(66, 75, 4, 7, lvl, 16)
	f.physical_defense = _es(42, 48, 3, 5, lvl, 16)
	f.magic_attack = _es(23, 31, 1, 3, lvl, 16)
	f.magic_defense = _es(31, 39, 2, 4, lvl, 16)
	f.speed = _es(32, 38, 2, 3, lvl, 16)
	f.crit_chance = 19; f.crit_damage = 4; f.dodge_chance = 12
	f.abilities = [EAB.slam(), EAB.poison_cloud(), EAB.rend()]
	return f

static func create_demon(n: String, lvl: int = 16) -> FighterData:
	var f := _base(n, "Demon", lvl)
	f.health = _es(447, 497, 11, 17, lvl, 16); f.max_health = f.health
	f.mana = _es(62, 73, 4, 7, lvl, 16); f.max_mana = f.mana
	f.physical_attack = _es(31, 39, 1, 4, lvl, 16)
	f.physical_defense = _es(39, 47, 3, 5, lvl, 16)
	f.magic_attack = _es(79, 90, 5, 8, lvl, 16)
	f.magic_defense = _es(49, 57, 3, 5, lvl, 16)
	f.speed = _es(36, 42, 2, 4, lvl, 16)
	f.crit_chance = 24; f.crit_damage = 4; f.dodge_chance = 22
	f.abilities = [EAB.brimstone(), EAB.infernal_strike(), EAB.dread()]
	return f

static func create_corrupted_treant(n: String, lvl: int = 16) -> FighterData:
	var f := _base(n, "Corrupted Treant", lvl)
	f.health = _es(419, 468, 11, 17, lvl, 16); f.max_health = f.health
	f.mana = _es(31, 39, 3, 5, lvl, 16); f.max_mana = f.mana
	f.physical_attack = _es(62, 72, 4, 7, lvl, 16)
	f.physical_defense = _es(51, 59, 4, 7, lvl, 16)
	f.magic_attack = _es(21, 29, 1, 3, lvl, 16)
	f.magic_defense = _es(46, 52, 3, 5, lvl, 16)
	f.speed = _es(28, 34, 1, 3, lvl, 16)
	f.crit_chance = 18; f.crit_damage = 4; f.dodge_chance = 11
	f.abilities = [EAB.vine_whip(), EAB.root_slam(), EAB.bark_shield()]
	return f

static func create_hellion(n: String, lvl: int = 17) -> FighterData:
	var f := _base(n, "Hellion", lvl)
	f.health = _fixed(206, 235); f.max_health = f.health
	f.mana = _fixed(44, 52); f.max_mana = f.mana
	f.physical_attack = _fixed(52, 57); f.physical_defense = _fixed(27, 33)
	f.magic_attack = _fixed(44, 51); f.magic_defense = _fixed(25, 30)
	f.speed = _fixed(37, 43)
	f.crit_chance = 29; f.crit_damage = 4; f.dodge_chance = 18
	f.abilities = [EAB.infernal_strike(), EAB.shadow_strike(), EAB.enemy_hex()]
	return f

static func create_fiendling(n: String, lvl: int = 17) -> FighterData:
	var f := _base(n, "Fiendling", lvl)
	f.health = _fixed(186, 217); f.max_health = f.health
	f.mana = _fixed(52, 62); f.max_mana = f.mana
	f.physical_attack = _fixed(18, 23); f.physical_defense = _fixed(21, 27)
	f.magic_attack = _fixed(56, 65); f.magic_defense = _fixed(29, 34)
	f.speed = _fixed(39, 45)
	f.crit_chance = 27; f.crit_damage = 4; f.dodge_chance = 18
	f.abilities = [EAB.brimstone(), EAB.dread(), EAB.enemy_hex()]
	return f

static func create_dragon(n: String, lvl: int = 17) -> FighterData:
	var f := _base(n, "Dragon", lvl)
	f.health = _fixed(307, 336); f.max_health = f.health
	f.mana = _fixed(55, 65); f.max_mana = f.mana
	f.physical_attack = _fixed(34, 39); f.physical_defense = _fixed(33, 38)
	f.magic_attack = _fixed(52, 57); f.magic_defense = _fixed(29, 34)
	f.speed = _fixed(35, 41)
	f.crit_chance = 30; f.crit_damage = 4; f.dodge_chance = 16
	f.abilities = [EAB.dragon_breath(), EAB.tail_strike(), AbilityDB.roar()]
	return f

static func create_blighted_stag(n: String, lvl: int = 17) -> FighterData:
	var f := _base(n, "Blighted Stag", lvl)
	f.health = _fixed(207, 237); f.max_health = f.health
	f.mana = _fixed(36, 44); f.max_mana = f.mana
	f.physical_attack = _fixed(47, 53); f.physical_defense = _fixed(23, 29)
	f.magic_attack = _fixed(23, 29); f.magic_defense = _fixed(21, 27)
	f.speed = _fixed(39, 45)
	f.crit_chance = 21; f.crit_damage = 4; f.dodge_chance = 17
	f.abilities = [EAB.antler_charge(), EAB.rot_aura(), EAB.enemy_blight()]
	return f

static func create_dark_knight(n: String, lvl: int = 18) -> FighterData:
	var f := _base(n, "Dark Knight", lvl)
	f.health = _es(502, 555, 12, 17, lvl, 18); f.max_health = f.health
	f.mana = _es(39, 49, 4, 7, lvl, 18); f.max_mana = f.mana
	f.physical_attack = _es(83, 92, 5, 8, lvl, 18)
	f.physical_defense = _es(48, 59, 4, 7, lvl, 18)
	f.magic_attack = _es(46, 56, 3, 5, lvl, 18)
	f.magic_defense = _es(47, 56, 3, 5, lvl, 18)
	f.speed = _es(37, 43, 2, 4, lvl, 18)
	f.crit_chance = 27; f.crit_damage = 5; f.dodge_chance = 18
	f.abilities = [EAB.dark_blade(), EAB.shadow_guard(), EAB.cleave()]
	return f

static func create_fell_hound(n: String, lvl: int = 18) -> FighterData:
	var f := _base(n, "Fell Hound", lvl)
	f.health = _es(419, 470, 10, 15, lvl, 18); f.max_health = f.health
	f.mana = _es(39, 49, 4, 7, lvl, 18); f.max_mana = f.mana
	f.physical_attack = _es(30, 36, 1, 4, lvl, 18)
	f.physical_defense = _es(34, 40, 3, 4, lvl, 18)
	f.magic_attack = _es(73, 82, 4, 7, lvl, 18)
	f.magic_defense = _es(44, 51, 3, 5, lvl, 18)
	f.speed = _es(43, 49, 3, 5, lvl, 18)
	f.crit_chance = 23; f.crit_damage = 4; f.dodge_chance = 21
	f.abilities = [EAB.shadow_bite(), EAB.howl_of_dread(), EAB.enemy_blight()]
	return f

static func create_sigil_wretch(n: String, lvl: int = 18) -> FighterData:
	var f := _base(n, "Sigil Wretch", lvl)
	f.health = _es(425, 476, 10, 15, lvl, 18); f.max_health = f.health
	f.mana = _es(52, 62, 4, 7, lvl, 18); f.max_mana = f.mana
	f.physical_attack = _es(17, 21, 0, 3, lvl, 18)
	f.physical_defense = _es(31, 39, 2, 4, lvl, 18)
	f.magic_attack = _es(81, 94, 7, 9, lvl, 18)
	f.magic_defense = _es(47, 55, 3, 5, lvl, 18)
	f.speed = _es(42, 48, 3, 5, lvl, 18)
	f.crit_chance = 26; f.crit_damage = 4; f.dodge_chance = 23
	f.abilities = [EAB.spark(), AbilityDB.ember(), EAB.enemy_hex()]
	return f

static func create_tunnel_lurker(n: String, lvl: int = 18) -> FighterData:
	var f := _base(n, "Tunnel Lurker", lvl)
	f.health = _es(542, 596, 14, 20, lvl, 18); f.max_health = f.health
	f.mana = _es(34, 42, 3, 5, lvl, 18); f.max_mana = f.mana
	f.physical_attack = _es(86, 98, 7, 9, lvl, 18)
	f.physical_defense = _es(43, 51, 3, 5, lvl, 18)
	f.magic_attack = _es(18, 26, 1, 3, lvl, 18)
	f.magic_defense = _es(46, 53, 3, 4, lvl, 18)
	f.speed = _es(39, 45, 3, 5, lvl, 18)
	f.crit_chance = 27; f.crit_damage = 4; f.dodge_chance = 20
	f.abilities = [EAB.venomous_bite(), EAB.web(), EAB.poison_cloud()]
	return f

static func create_stranger_final(n: String, lvl: int = 20) -> FighterData:
	var f := _base(n, "Stranger", lvl)
	f.class_id = "StrangerFinal"
	f.health = _es(1199, 1314, 23, 31, lvl, 20); f.max_health = f.health
	f.mana = _es(91, 104, 7, 9, lvl, 20); f.max_mana = f.mana
	f.physical_attack = _es(93, 104, 5, 8, lvl, 20)
	f.physical_defense = _es(66, 74, 4, 7, lvl, 20)
	f.magic_attack = _es(104, 115, 7, 9, lvl, 20)
	f.magic_defense = _es(70, 78, 4, 7, lvl, 20)
	f.speed = _es(54, 61, 3, 5, lvl, 20)
	f.crit_chance = 31; f.crit_damage = 5; f.dodge_chance = 19
	f.abilities = [EAB.shadow_blast(), EAB.siphon(), EAB.dark_veil(), EAB.unmake(), AbilityDB.corruption()]
	return f
