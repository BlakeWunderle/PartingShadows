class_name EnemyDBAct2

## Act II enemy factory (Progression 3-7): wilderness, shore, branch battles, cemetery.

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
# Act II enemies (Progression 3-7)
# =============================================================================

static func create_raider(n: String, lvl: int = 4) -> FighterData:
	var f := _base(n, "Raider", lvl)
	f.health = _es(121, 140, 5, 8, lvl, 4); f.max_health = f.health
	f.mana = _es(12, 16, 1, 3, lvl, 4); f.max_mana = f.mana
	f.physical_attack = _es(24, 30, 2, 4, lvl, 4)
	f.physical_defense = _es(13, 17, 1, 3, lvl, 4)
	f.magic_attack = _es(5, 9, 0, 2, lvl, 4)
	f.magic_defense = _es(14, 18, 1, 3, lvl, 4)
	f.speed = _es(24, 30, 1, 3, lvl, 4)
	f.crit_chance = 12; f.crit_damage = 2; f.dodge_chance = 8
	f.abilities = [EAB.cleave(), EAB.war_cry()]
	return f

static func create_orc(n: String, lvl: int = 4) -> FighterData:
	var f := _base(n, "Orc", lvl)
	f.health = _es(152, 176, 6, 9, lvl, 4); f.max_health = f.health
	f.mana = _es(9, 14, 1, 3, lvl, 4); f.max_mana = f.mana
	f.physical_attack = _es(29, 33, 2, 4, lvl, 4)
	f.physical_defense = _es(16, 21, 1, 3, lvl, 4)
	f.magic_attack = _es(5, 8, 0, 1, lvl, 4)
	f.magic_defense = _es(15, 20, 1, 3, lvl, 4)
	f.speed = _es(19, 25, 1, 2, lvl, 4)
	f.crit_chance = 12; f.crit_damage = 3; f.dodge_chance = 3
	f.abilities = [EAB.crush(), EAB.thick_skin()]
	return f

static func create_troll(n: String, lvl: int = 5) -> FighterData:
	var f := _base(n, "Troll", lvl)
	f.health = _es(205, 232, 7, 12, lvl, 5); f.max_health = f.health
	f.mana = _es(15, 20, 1, 3, lvl, 5); f.max_mana = f.mana
	f.physical_attack = _es(30, 36, 2, 4, lvl, 5)
	f.physical_defense = _es(21, 25, 2, 3, lvl, 5)
	f.magic_attack = _es(6, 10, 0, 2, lvl, 5)
	f.magic_defense = _es(17, 22, 1, 3, lvl, 5)
	f.speed = _es(17, 23, 1, 2, lvl, 5)
	f.crit_chance = 8; f.crit_damage = 3; f.dodge_chance = 3
	f.abilities = [AbilityDB.smash(), EAB.regenerate(), EAB.stomp()]
	return f

static func create_harpy(n: String, lvl: int = 5) -> FighterData:
	var f := _base(n, "Harpy", lvl)
	f.health = _es(112, 129, 5, 8, lvl, 5); f.max_health = f.health
	f.mana = _es(13, 17, 1, 3, lvl, 5); f.max_mana = f.mana
	f.physical_attack = _es(30, 36, 2, 4, lvl, 5)
	f.physical_defense = _es(13, 17, 1, 2, lvl, 5)
	f.magic_attack = _es(10, 15, 0, 2, lvl, 5)
	f.magic_defense = _es(16, 21, 1, 3, lvl, 5)
	f.speed = _es(29, 35, 2, 3, lvl, 5)
	f.crit_chance = 13; f.crit_damage = 2; f.dodge_chance = 16
	f.abilities = [EAB.talon_rake(), EAB.shriek()]
	return f

static func create_witch(n: String, lvl: int = 4) -> FighterData:
	var f := _base(n, "Witch", lvl)
	f.health = _es(113, 141, 5, 9, lvl, 4); f.max_health = f.health
	f.mana = _es(36, 54, 3, 7, lvl, 4); f.max_mana = f.mana
	f.physical_attack = _es(18, 24, 1, 2, lvl, 4)
	f.physical_defense = _es(12, 16, 1, 2, lvl, 4)
	f.magic_attack = _es(35, 47, 3, 7, lvl, 4)
	f.magic_defense = _es(18, 28, 2, 5, lvl, 4)
	f.speed = _es(21, 29, 1, 2, lvl, 4)
	f.crit_chance = 7; f.crit_damage = 2; f.dodge_chance = 8
	f.abilities = [EAB.enemy_hex(), EAB.bramble(), EAB.dark_blessing()]
	return f

static func create_wisp(n: String, lvl: int = 4) -> FighterData:
	var f := _base(n, "Wisp", lvl)
	f.health = _es(77, 104, 5, 9, lvl, 4); f.max_health = f.health
	f.mana = _es(29, 47, 2, 6, lvl, 4); f.max_mana = f.mana
	f.physical_attack = _es(15, 21, 1, 2, lvl, 4)
	f.physical_defense = _es(9, 14, 1, 2, lvl, 4)
	f.magic_attack = _es(29, 39, 3, 6, lvl, 4)
	f.magic_defense = _es(14, 21, 1, 3, lvl, 4)
	f.speed = _es(29, 39, 2, 3, lvl, 4)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 19
	f.abilities = [EAB.lure(), EAB.bewitch()]
	return f

static func create_sprite(n: String, lvl: int = 4) -> FighterData:
	var f := _base(n, "Sprite", lvl)
	f.health = _es(89, 116, 3, 9, lvl, 4); f.max_health = f.health
	f.mana = _es(26, 44, 2, 6, lvl, 4); f.max_mana = f.mana
	f.physical_attack = _es(25, 33, 2, 5, lvl, 4)
	f.physical_defense = _es(12, 17, 1, 2, lvl, 4)
	f.magic_attack = _es(15, 22, 1, 2, lvl, 4)
	f.magic_defense = _es(14, 21, 1, 3, lvl, 4)
	f.speed = _es(25, 36, 1, 3, lvl, 4)
	f.crit_chance = 17; f.crit_damage = 1; f.dodge_chance = 19
	f.abilities = [EAB.thorn(), EAB.pollen()]
	return f

static func create_siren(n: String, lvl: int = 4) -> FighterData:
	var f := _base(n, "Siren", lvl)
	f.health = _es(109, 132, 6, 12, lvl, 4); f.max_health = f.health
	f.mana = _es(23, 40, 2, 6, lvl, 3); f.max_mana = f.mana
	f.physical_attack = _es(17, 25, 1, 3, lvl, 4)
	f.physical_defense = _es(13, 21, 1, 3, lvl, 4)
	f.magic_attack = _es(31, 43, 3, 7, lvl, 4)
	f.magic_defense = _es(18, 29, 2, 5, lvl, 4)
	f.speed = _es(23, 31, 1, 2, lvl, 3)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 16
	f.abilities = [EAB.siren_song(), AbilityDB.torrent()]
	return f

static func create_merfolk(n: String, lvl: int = 4) -> FighterData:
	var f := _base(n, "Merfolk", lvl)
	f.health = _es(111, 133, 5, 8, lvl, 4); f.max_health = f.health
	f.mana = _es(14, 18, 1, 3, lvl, 4); f.max_mana = f.mana
	f.physical_attack = _es(26, 31, 2, 4, lvl, 4)
	f.physical_defense = _es(13, 18, 1, 3, lvl, 4)
	f.magic_attack = _es(20, 25, 1, 3, lvl, 4)
	f.magic_defense = _es(15, 20, 1, 3, lvl, 4)
	f.speed = _es(22, 28, 1, 3, lvl, 4)
	f.crit_chance = 7; f.crit_damage = 2; f.dodge_chance = 13
	f.abilities = [EAB.trident_thrust(), EAB.tidal_splash()]
	return f

static func create_captain(n: String, lvl: int = 5) -> FighterData:
	var f := _base(n, "Captain", lvl)
	f.health = _es(123, 154, 6, 13, lvl, 5); f.max_health = f.health
	f.mana = _es(28, 58, 2, 8, lvl, 5); f.max_mana = f.mana
	f.physical_attack = _es(31, 39, 2, 6, lvl, 5)
	f.physical_defense = _es(22, 31, 2, 6, lvl, 5)
	f.magic_attack = _es(10, 20, 1, 3, lvl, 5)
	f.magic_defense = _es(13, 22, 1, 3, lvl, 5)
	f.speed = _es(20, 28, 1, 2, lvl, 5)
	f.crit_chance = 21; f.crit_damage = 2; f.dodge_chance = 8
	f.abilities = [EAB.flintlock(), EAB.cannon_barrage(), EAB.bravado()]
	return f

static func create_pirate(n: String, lvl: int = 4) -> FighterData:
	var f := _base(n, "Pirate", lvl)
	f.health = _es(104, 132, 6, 13, lvl, 4); f.max_health = f.health
	f.mana = _es(20, 45, 2, 8, lvl, 4); f.max_mana = f.mana
	f.physical_attack = _es(26, 33, 2, 6, lvl, 4)
	f.physical_defense = _es(16, 24, 2, 6, lvl, 4)
	f.magic_attack = _es(10, 20, 1, 3, lvl, 4)
	f.magic_defense = _es(13, 22, 1, 3, lvl, 4)
	f.speed = _es(20, 29, 1, 3, lvl, 4)
	f.crit_chance = 17; f.crit_damage = 3; f.dodge_chance = 13
	f.abilities = [EAB.flintlock(), EAB.dirty_trick()]
	return f

# --- Prog 5-6: Branch battles ---

static func create_fire_wyrmling(n: String) -> FighterData:
	var f := _base(n, "Fire Wyrmling", 6)
	f.health = _fixed(157, 173); f.max_health = f.health
	f.mana = _fixed(30, 35); f.max_mana = f.mana
	f.physical_attack = _fixed(20, 26); f.physical_defense = _fixed(20, 26)
	f.magic_attack = _fixed(36, 42); f.magic_defense = _fixed(27, 32)
	f.speed = _fixed(29, 34)
	f.crit_chance = 17; f.crit_damage = 2; f.dodge_chance = 8
	f.abilities = [EAB.dragon_breath(), EAB.tail_strike(), AbilityDB.roar()]
	return f

static func create_frost_wyrmling(n: String) -> FighterData:
	var f := _base(n, "Frost Wyrmling", 6)
	f.health = _fixed(157, 173); f.max_health = f.health
	f.mana = _fixed(24, 29); f.max_mana = f.mana
	f.physical_attack = _fixed(34, 39); f.physical_defense = _fixed(26, 31)
	f.magic_attack = _fixed(20, 26); f.magic_defense = _fixed(22, 27)
	f.speed = _fixed(29, 34)
	f.crit_chance = 17; f.crit_damage = 2; f.dodge_chance = 8
	f.abilities = [EAB.claw(), EAB.tail_strike(), EAB.riptide()]
	return f

static func create_ringmaster(n: String) -> FighterData:
	var f := _base(n, "Ringmaster", 6)
	f.health = _fixed(131, 146); f.max_health = f.health
	f.mana = _fixed(38, 43); f.max_mana = f.mana
	f.physical_attack = _fixed(29, 34); f.physical_defense = _fixed(27, 33)
	f.magic_attack = _fixed(30, 35); f.magic_defense = _fixed(27, 33)
	f.speed = _fixed(32, 37)
	f.crit_chance = 18; f.crit_damage = 2; f.dodge_chance = 13
	f.abilities = [EAB.whip_crack(), EAB.showstopper(), EAB.center_ring()]
	return f

static func create_harlequin(n: String) -> FighterData:
	var f := _base(n, "Harlequin", 6)
	f.health = _fixed(143, 160); f.max_health = f.health
	f.mana = _fixed(44, 49); f.max_mana = f.mana
	f.physical_attack = _fixed(28, 33); f.physical_defense = _fixed(25, 30)
	f.magic_attack = _fixed(43, 48); f.magic_defense = _fixed(29, 34)
	f.speed = _fixed(31, 36)
	f.crit_chance = 17; f.crit_damage = 2; f.dodge_chance = 16
	f.abilities = [EAB.pantomime_wall(), EAB.prop_drop(), EAB.mime_trap()]
	return f

static func create_chanteuse(n: String) -> FighterData:
	var f := _base(n, "Chanteuse", 6)
	f.health = _fixed(105, 117); f.max_health = f.health
	f.mana = _fixed(46, 51); f.max_mana = f.mana
	f.physical_attack = _fixed(28, 34); f.physical_defense = _fixed(27, 33)
	f.magic_attack = _fixed(41, 46); f.magic_defense = _fixed(25, 30)
	f.speed = _fixed(36, 41)
	f.crit_chance = 17; f.crit_damage = 2; f.dodge_chance = 16
	f.abilities = [EAB.aria(), EAB.crescendo(), EAB.cadence()]
	return f

static func create_android(n: String) -> FighterData:
	var f := _base(n, "Android", 6)
	f.health = _fixed(134, 148); f.max_health = f.health
	f.mana = _fixed(38, 44); f.max_mana = f.mana
	f.physical_attack = _fixed(29, 34); f.physical_defense = _fixed(27, 33)
	f.magic_attack = _fixed(30, 35); f.magic_defense = _fixed(30, 35)
	f.speed = _fixed(32, 37)
	f.crit_chance = 20; f.crit_damage = 2; f.dodge_chance = 10
	f.abilities = [EAB.circuit_burst(), EAB.firewall(), EAB.overdrive()]
	return f

static func create_machinist(n: String) -> FighterData:
	var f := _base(n, "Machinist", 6)
	f.health = _fixed(134, 148); f.max_health = f.health
	f.mana = _fixed(29, 35); f.max_mana = f.mana
	f.physical_attack = _fixed(30, 35); f.physical_defense = _fixed(33, 39)
	f.magic_attack = _fixed(28, 33); f.magic_defense = _fixed(30, 35)
	f.speed = _fixed(30, 35)
	f.crit_chance = 11; f.crit_damage = 1; f.dodge_chance = 10
	f.abilities = [EAB.seismic_charge(), EAB.reinforce(), EAB.dismantle()]
	return f

static func create_ironclad(n: String) -> FighterData:
	var f := _base(n, "Ironclad", 6)
	f.health = _fixed(131, 146); f.max_health = f.health
	f.mana = _fixed(29, 35); f.max_mana = f.mana
	f.physical_attack = _fixed(28, 31); f.physical_defense = _fixed(33, 38)
	f.magic_attack = _fixed(20, 25); f.magic_defense = _fixed(35, 40)
	f.speed = _fixed(24, 29)
	f.crit_chance = 10; f.crit_damage = 1; f.dodge_chance = 10
	f.abilities = [EAB.hammer_blow(), EAB.temper(), EAB.steel_plating()]
	return f

static func create_commander(n: String) -> FighterData:
	var f := _base(n, "Commander", 6)
	f.health = _fixed(142, 156); f.max_health = f.health
	f.mana = _fixed(30, 35); f.max_mana = f.mana
	f.physical_attack = _fixed(33, 39); f.physical_defense = _fixed(33, 38)
	f.magic_attack = _fixed(15, 20); f.magic_defense = _fixed(31, 38)
	f.speed = _fixed(28, 33)
	f.crit_chance = 18; f.crit_damage = 2; f.dodge_chance = 8
	f.abilities = [EAB.shield_wall(), EAB.rally_strike(), EAB.war_ward()]
	return f

static func create_draconian(n: String) -> FighterData:
	var f := _base(n, "Draconian", 6)
	f.health = _fixed(112, 124); f.max_health = f.health
	f.mana = _fixed(34, 39); f.max_mana = f.mana
	f.physical_attack = _fixed(35, 40); f.physical_defense = _fixed(25, 30)
	f.magic_attack = _fixed(38, 43); f.magic_defense = _fixed(29, 35)
	f.speed = _fixed(30, 35)
	f.crit_chance = 18; f.crit_damage = 2; f.dodge_chance = 14
	f.abilities = [EAB.skewer(), EAB.drake_strike(), EAB.scale_guard()]
	return f

static func create_chaplain(n: String) -> FighterData:
	var f := _base(n, "Chaplain", 6)
	f.health = _fixed(114, 126); f.max_health = f.health
	f.mana = _fixed(43, 48); f.max_mana = f.mana
	f.physical_attack = _fixed(21, 26); f.physical_defense = _fixed(31, 36)
	f.magic_attack = _fixed(34, 39); f.magic_defense = _fixed(34, 39)
	f.speed = _fixed(27, 32)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 8
	f.abilities = [EAB.blessing(), EAB.mace_strike(), EAB.enemy_consecrate()]
	return f

static func create_zombie(n: String, lvl: int = 6) -> FighterData:
	var f := _base(n, "Zombie", lvl)
	f.health = _es(126, 156, 8, 14, lvl, 6); f.max_health = f.health
	f.mana = _es(30, 47, 3, 7, lvl, 6); f.max_mana = f.mana
	f.physical_attack = _es(31, 40, 4, 6, lvl, 6)
	f.physical_defense = _es(29, 42, 3, 5, lvl, 6)
	f.magic_attack = _es(30, 39, 4, 6, lvl, 6)
	f.magic_defense = _es(29, 42, 3, 5, lvl, 6)
	f.speed = _es(24, 34, 1, 2, lvl, 6)
	f.crit_chance = 25; f.crit_damage = 3; f.dodge_chance = 8
	f.abilities = [EAB.rend(), EAB.enemy_blight(), EAB.devour()]
	return f

static func create_ghoul(n: String, lvl: int = 6) -> FighterData:
	var f := _base(n, "Ghoul", lvl)
	f.health = _es(124, 142, 4, 8, lvl, 6); f.max_health = f.health
	f.mana = _es(17, 22, 1, 3, lvl, 6); f.max_mana = f.mana
	f.physical_attack = _es(25, 31, 3, 4, lvl, 6)
	f.physical_defense = _es(21, 27, 1, 3, lvl, 6)
	f.magic_attack = _es(15, 21, 1, 3, lvl, 6)
	f.magic_defense = _es(19, 25, 1, 3, lvl, 6)
	f.speed = _es(26, 32, 2, 3, lvl, 6)
	f.crit_chance = 19; f.crit_damage = 2; f.dodge_chance = 13
	f.abilities = [EAB.claw(), EAB.paralyze(), EAB.devour()]
	return f

static func create_shade(n: String, lvl: int = 7) -> FighterData:
	var f := _base(n, "Shade", lvl)
	f.health = _es(138, 165, 7, 12, lvl, 7); f.max_health = f.health
	f.mana = _es(30, 42, 3, 7, lvl, 7); f.max_mana = f.mana
	f.physical_attack = _es(26, 34, 1, 3, lvl, 7)
	f.physical_defense = _es(18, 23, 1, 3, lvl, 7)
	f.magic_attack = _es(41, 50, 4, 6, lvl, 7)
	f.magic_defense = _es(21, 29, 2, 5, lvl, 7)
	f.speed = _es(32, 38, 2, 4, lvl, 7)
	f.crit_chance = 20; f.crit_damage = 2; f.dodge_chance = 20
	f.abilities = [AbilityDB.shadow_attack(), EAB.enemy_blight(), AbilityDB.frustrate()]
	return f

static func create_wraith(n: String, lvl: int = 7) -> FighterData:
	var f := _base(n, "Wraith", lvl)
	f.health = _es(156, 186, 7, 12, lvl, 7); f.max_health = f.health
	f.mana = _es(23, 29, 3, 5, lvl, 7); f.max_mana = f.mana
	f.physical_attack = _es(26, 33, 0, 3, lvl, 7)
	f.physical_defense = _es(14, 19, 1, 3, lvl, 7)
	f.magic_attack = _es(40, 51, 4, 6, lvl, 7)
	f.magic_defense = _es(21, 29, 2, 4, lvl, 7)
	f.speed = _es(30, 36, 2, 4, lvl, 7)
	f.crit_chance = 20; f.crit_damage = 3; f.dodge_chance = 16
	f.abilities = [EAB.soul_drain(), EAB.enemy_blight(), EAB.terrify()]
	return f
