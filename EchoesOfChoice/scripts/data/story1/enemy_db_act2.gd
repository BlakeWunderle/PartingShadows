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
# HP buffed +10-14% to compensate for CD 2 minimum / 3rd base ability changes.
# =============================================================================

static func create_raider(n: String, lvl: int = 4) -> FighterData:
	var f := _base(n, "Raider", lvl)
	f.health = _es(111, 128, 4, 7, lvl, 4); f.max_health = f.health
	f.mana = _es(10, 14, 1, 3, lvl, 4); f.max_mana = f.mana
	f.physical_attack = _es(21, 26, 2, 3, lvl, 4)
	f.physical_defense = _es(11, 15, 1, 2, lvl, 4)
	f.magic_attack = _es(4, 8, 0, 2, lvl, 4)
	f.magic_defense = _es(12, 16, 1, 2, lvl, 4)
	f.speed = _es(24, 30, 1, 3, lvl, 4)
	f.crit_chance = 12; f.crit_damage = 2; f.dodge_chance = 8
	f.abilities = [EAB.cleave(), EAB.war_cry()]
	return f

static func create_orc(n: String, lvl: int = 4) -> FighterData:
	var f := _base(n, "Orc", lvl)
	f.health = _es(139, 162, 5, 8, lvl, 4); f.max_health = f.health
	f.mana = _es(8, 12, 1, 3, lvl, 4); f.max_mana = f.mana
	f.physical_attack = _es(25, 29, 2, 4, lvl, 4)
	f.physical_defense = _es(14, 18, 1, 3, lvl, 4)
	f.magic_attack = _es(4, 7, 0, 1, lvl, 4)
	f.magic_defense = _es(13, 17, 1, 2, lvl, 4)
	f.speed = _es(19, 25, 1, 2, lvl, 4)
	f.crit_chance = 12; f.crit_damage = 3; f.dodge_chance = 3
	f.abilities = [EAB.crush(), EAB.thick_skin()]
	return f

static func create_troll(n: String, lvl: int = 5) -> FighterData:
	var f := _base(n, "Troll", lvl)
	f.health = _es(188, 213, 6, 10, lvl, 5); f.max_health = f.health
	f.mana = _es(13, 17, 1, 3, lvl, 5); f.max_mana = f.mana
	f.physical_attack = _es(26, 31, 2, 4, lvl, 5)
	f.physical_defense = _es(18, 22, 1, 3, lvl, 5)
	f.magic_attack = _es(5, 9, 0, 1, lvl, 5)
	f.magic_defense = _es(15, 19, 1, 2, lvl, 5)
	f.speed = _es(17, 23, 1, 2, lvl, 5)
	f.crit_chance = 8; f.crit_damage = 3; f.dodge_chance = 3
	f.abilities = [EAB.boulder_fist(), EAB.regenerate(), EAB.stomp()]
	return f

static func create_harpy(n: String, lvl: int = 5) -> FighterData:
	var f := _base(n, "Harpy", lvl)
	f.health = _es(121, 139, 4, 7, lvl, 5); f.max_health = f.health
	f.mana = _es(11, 15, 1, 3, lvl, 5); f.max_mana = f.mana
	f.physical_attack = _es(26, 31, 2, 4, lvl, 5)
	f.physical_defense = _es(11, 15, 1, 2, lvl, 5)
	f.magic_attack = _es(9, 13, 0, 2, lvl, 5)
	f.magic_defense = _es(14, 18, 1, 2, lvl, 5)
	f.speed = _es(29, 35, 2, 3, lvl, 5)
	f.crit_chance = 13; f.crit_damage = 2; f.dodge_chance = 16
	f.abilities = [EAB.talon_rake(), EAB.shriek()]
	return f

static func create_witch(n: String, lvl: int = 4) -> FighterData:
	var f := _base(n, "Witch", lvl)
	f.health = _es(103, 129, 4, 8, lvl, 4); f.max_health = f.health
	f.mana = _es(31, 47, 3, 6, lvl, 4); f.max_mana = f.mana
	f.physical_attack = _es(16, 21, 1, 2, lvl, 4)
	f.physical_defense = _es(10, 14, 1, 2, lvl, 4)
	f.magic_attack = _es(30, 41, 3, 6, lvl, 4)
	f.magic_defense = _es(16, 24, 2, 4, lvl, 4)
	f.speed = _es(21, 29, 1, 2, lvl, 4)
	f.crit_chance = 7; f.crit_damage = 2; f.dodge_chance = 8
	f.abilities = [EAB.enemy_hex(), EAB.bramble(), EAB.dark_blessing()]
	return f

static func create_wisp(n: String, lvl: int = 4) -> FighterData:
	var f := _base(n, "Wisp", lvl)
	f.health = _es(71, 94, 4, 8, lvl, 4); f.max_health = f.health
	f.mana = _es(25, 41, 2, 5, lvl, 4); f.max_mana = f.mana
	f.physical_attack = _es(13, 18, 1, 2, lvl, 4)
	f.physical_defense = _es(8, 12, 1, 2, lvl, 4)
	f.magic_attack = _es(25, 34, 3, 5, lvl, 4)
	f.magic_defense = _es(12, 18, 1, 3, lvl, 4)
	f.speed = _es(29, 39, 2, 3, lvl, 4)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 19
	f.abilities = [EAB.lure(), EAB.bewitch()]
	return f

static func create_sprite(n: String, lvl: int = 4) -> FighterData:
	var f := _base(n, "Sprite", lvl)
	f.health = _es(81, 107, 3, 8, lvl, 4); f.max_health = f.health
	f.mana = _es(23, 38, 2, 5, lvl, 4); f.max_mana = f.mana
	f.physical_attack = _es(22, 29, 2, 4, lvl, 4)
	f.physical_defense = _es(10, 15, 1, 2, lvl, 4)
	f.magic_attack = _es(13, 19, 1, 2, lvl, 4)
	f.magic_defense = _es(12, 18, 1, 2, lvl, 4)
	f.speed = _es(25, 36, 1, 3, lvl, 4)
	f.crit_chance = 17; f.crit_damage = 1; f.dodge_chance = 19
	f.abilities = [EAB.thorn(), EAB.pollen()]
	return f

static func create_siren(n: String, lvl: int = 4) -> FighterData:
	var f := _base(n, "Siren", lvl)
	f.health = _es(97, 118, 5, 10, lvl, 4); f.max_health = f.health
	f.mana = _es(20, 35, 2, 5, lvl, 3); f.max_mana = f.mana
	f.physical_attack = _es(15, 22, 1, 3, lvl, 4)
	f.physical_defense = _es(11, 18, 1, 3, lvl, 4)
	f.magic_attack = _es(27, 37, 3, 6, lvl, 4)
	f.magic_defense = _es(16, 25, 2, 4, lvl, 4)
	f.speed = _es(23, 31, 1, 2, lvl, 3)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 16
	f.abilities = [EAB.siren_song(), EAB.drowning_wave()]
	return f

static func create_merfolk(n: String, lvl: int = 4) -> FighterData:
	var f := _base(n, "Merfolk", lvl)
	f.health = _es(100, 120, 4, 7, lvl, 4); f.max_health = f.health
	f.mana = _es(12, 16, 1, 3, lvl, 4); f.max_mana = f.mana
	f.physical_attack = _es(23, 27, 2, 3, lvl, 4)
	f.physical_defense = _es(11, 16, 1, 2, lvl, 4)
	f.magic_attack = _es(17, 22, 1, 3, lvl, 4)
	f.magic_defense = _es(13, 17, 1, 2, lvl, 4)
	f.speed = _es(22, 28, 1, 3, lvl, 4)
	f.crit_chance = 7; f.crit_damage = 2; f.dodge_chance = 13
	f.abilities = [EAB.trident_thrust(), EAB.tidal_splash()]
	return f

static func create_captain(n: String, lvl: int = 5) -> FighterData:
	var f := _base(n, "Captain", lvl)
	f.health = _es(131, 164, 5, 11, lvl, 5); f.max_health = f.health
	f.mana = _es(24, 50, 2, 7, lvl, 5); f.max_mana = f.mana
	f.physical_attack = _es(27, 34, 2, 5, lvl, 5)
	f.physical_defense = _es(19, 27, 2, 5, lvl, 5)
	f.magic_attack = _es(9, 17, 1, 3, lvl, 5)
	f.magic_defense = _es(11, 19, 1, 3, lvl, 5)
	f.speed = _es(20, 28, 1, 2, lvl, 5)
	f.crit_chance = 21; f.crit_damage = 2; f.dodge_chance = 8
	f.abilities = [EAB.flintlock(), EAB.cannon_barrage(), EAB.bravado()]
	return f

static func create_pirate(n: String, lvl: int = 4) -> FighterData:
	var f := _base(n, "Pirate", lvl)
	f.health = _es(110, 141, 5, 11, lvl, 4); f.max_health = f.health
	f.mana = _es(17, 39, 2, 7, lvl, 4); f.max_mana = f.mana
	f.physical_attack = _es(23, 29, 2, 5, lvl, 4)
	f.physical_defense = _es(14, 21, 2, 5, lvl, 4)
	f.magic_attack = _es(9, 17, 1, 3, lvl, 4)
	f.magic_defense = _es(11, 19, 1, 3, lvl, 4)
	f.speed = _es(20, 29, 1, 3, lvl, 4)
	f.crit_chance = 17; f.crit_damage = 3; f.dodge_chance = 13
	f.abilities = [EAB.flintlock(), EAB.dirty_trick()]
	return f

# --- Prog 5-6: Branch battles ---

static func create_fire_wyrmling(n: String) -> FighterData:
	var f := _base(n, "Fire Wyrmling", 6)
	f.health = _fixed(144, 159); f.max_health = f.health
	f.mana = _fixed(26, 30); f.max_mana = f.mana
	f.physical_attack = _fixed(15, 19); f.physical_defense = _fixed(15, 19)
	f.magic_attack = _fixed(27, 31); f.magic_defense = _fixed(20, 24)
	f.speed = _fixed(29, 34)
	f.crit_chance = 17; f.crit_damage = 2; f.dodge_chance = 8
	f.abilities = [EAB.dragon_breath(), EAB.tail_strike(), EAB.searing_hiss()]
	return f

static func create_frost_wyrmling(n: String) -> FighterData:
	var f := _base(n, "Frost Wyrmling", 6)
	f.health = _fixed(144, 159); f.max_health = f.health
	f.mana = _fixed(21, 25); f.max_mana = f.mana
	f.physical_attack = _fixed(25, 29); f.physical_defense = _fixed(19, 23)
	f.magic_attack = _fixed(15, 19); f.magic_defense = _fixed(16, 20)
	f.speed = _fixed(29, 34)
	f.crit_chance = 17; f.crit_damage = 2; f.dodge_chance = 8
	f.abilities = [EAB.claw(), EAB.tail_strike(), EAB.frost_chains()]
	return f

static func create_ringmaster(n: String) -> FighterData:
	var f := _base(n, "Ringmaster", 6)
	f.health = _fixed(129, 143); f.max_health = f.health
	f.mana = _fixed(29, 33); f.max_mana = f.mana
	f.physical_attack = _fixed(23, 27); f.physical_defense = _fixed(21, 25)
	f.magic_attack = _fixed(24, 28); f.magic_defense = _fixed(21, 25)
	f.speed = _fixed(32, 37)
	f.crit_chance = 18; f.crit_damage = 2; f.dodge_chance = 13
	f.abilities = [EAB.whip_crack(), EAB.showstopper(), EAB.center_ring()]
	return f

static func create_harlequin(n: String) -> FighterData:
	var f := _base(n, "Harlequin", 6)
	f.health = _fixed(141, 157); f.max_health = f.health
	f.mana = _fixed(34, 38); f.max_mana = f.mana
	f.physical_attack = _fixed(22, 26); f.physical_defense = _fixed(19, 23)
	f.magic_attack = _fixed(34, 38); f.magic_defense = _fixed(22, 26)
	f.speed = _fixed(31, 36)
	f.crit_chance = 17; f.crit_damage = 2; f.dodge_chance = 16
	f.abilities = [EAB.pantomime_wall(), EAB.prop_drop(), EAB.mime_trap()]
	return f

static func create_chanteuse(n: String) -> FighterData:
	var f := _base(n, "Chanteuse", 6)
	f.health = _fixed(103, 115); f.max_health = f.health
	f.mana = _fixed(35, 39); f.max_mana = f.mana
	f.physical_attack = _fixed(22, 27); f.physical_defense = _fixed(21, 25)
	f.magic_attack = _fixed(33, 37); f.magic_defense = _fixed(19, 23)
	f.speed = _fixed(36, 41)
	f.crit_chance = 17; f.crit_damage = 2; f.dodge_chance = 16
	f.abilities = [EAB.aria(), EAB.crescendo(), EAB.cadence()]
	return f

static func create_android(n: String) -> FighterData:
	var f := _base(n, "Android", 6)
	f.health = _fixed(151, 168); f.max_health = f.health
	f.mana = _fixed(29, 34); f.max_mana = f.mana
	f.physical_attack = _fixed(23, 27); f.physical_defense = _fixed(21, 25)
	f.magic_attack = _fixed(24, 28); f.magic_defense = _fixed(23, 27)
	f.speed = _fixed(32, 37)
	f.crit_chance = 20; f.crit_damage = 2; f.dodge_chance = 10
	f.abilities = [EAB.circuit_burst(), EAB.firewall(), EAB.overdrive()]
	return f

static func create_machinist(n: String) -> FighterData:
	var f := _base(n, "Machinist", 6)
	f.health = _fixed(151, 168); f.max_health = f.health
	f.mana = _fixed(22, 27); f.max_mana = f.mana
	f.physical_attack = _fixed(24, 28); f.physical_defense = _fixed(25, 30)
	f.magic_attack = _fixed(22, 26); f.magic_defense = _fixed(23, 27)
	f.speed = _fixed(30, 35)
	f.crit_chance = 11; f.crit_damage = 1; f.dodge_chance = 10
	f.abilities = [EAB.seismic_charge(), EAB.reinforce(), EAB.dismantle()]
	return f

static func create_ironclad(n: String) -> FighterData:
	var f := _base(n, "Ironclad", 6)
	f.health = _fixed(149, 165); f.max_health = f.health
	f.mana = _fixed(22, 27); f.max_mana = f.mana
	f.physical_attack = _fixed(22, 25); f.physical_defense = _fixed(25, 29)
	f.magic_attack = _fixed(16, 20); f.magic_defense = _fixed(27, 31)
	f.speed = _fixed(24, 29)
	f.crit_chance = 10; f.crit_damage = 1; f.dodge_chance = 10
	f.abilities = [EAB.hammer_blow(), EAB.temper(), EAB.steel_plating()]
	return f

static func create_commander(n: String) -> FighterData:
	var f := _base(n, "Commander", 6)
	f.health = _fixed(150, 166); f.max_health = f.health
	f.mana = _fixed(23, 27); f.max_mana = f.mana
	f.physical_attack = _fixed(26, 31); f.physical_defense = _fixed(25, 29)
	f.magic_attack = _fixed(12, 16); f.magic_defense = _fixed(24, 29)
	f.speed = _fixed(28, 33)
	f.crit_chance = 18; f.crit_damage = 2; f.dodge_chance = 8
	f.abilities = [EAB.shield_wall(), EAB.rally_strike(), EAB.war_ward()]
	return f

static func create_draconian(n: String) -> FighterData:
	var f := _base(n, "Draconian", 6)
	f.health = _fixed(120, 132); f.max_health = f.health
	f.mana = _fixed(26, 30); f.max_mana = f.mana
	f.physical_attack = _fixed(28, 32); f.physical_defense = _fixed(19, 23)
	f.magic_attack = _fixed(30, 34); f.magic_defense = _fixed(22, 27)
	f.speed = _fixed(30, 35)
	f.crit_chance = 18; f.crit_damage = 2; f.dodge_chance = 14
	f.abilities = [EAB.skewer(), EAB.drake_strike(), EAB.scale_guard()]
	return f

static func create_chaplain(n: String) -> FighterData:
	var f := _base(n, "Chaplain", 6)
	f.health = _fixed(122, 136); f.max_health = f.health
	f.mana = _fixed(33, 37); f.max_mana = f.mana
	f.physical_attack = _fixed(17, 21); f.physical_defense = _fixed(24, 28)
	f.magic_attack = _fixed(27, 31); f.magic_defense = _fixed(26, 30)
	f.speed = _fixed(27, 32)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 8
	f.abilities = [EAB.blessing(), EAB.mace_strike(), EAB.enemy_consecrate()]
	return f

static func create_zombie(n: String, lvl: int = 6) -> FighterData:
	var f := _base(n, "Zombie", lvl)
	f.health = _es(121, 149, 6, 11, lvl, 6); f.max_health = f.health
	f.mana = _es(23, 36, 2, 5, lvl, 6); f.max_mana = f.mana
	f.physical_attack = _es(25, 32, 3, 5, lvl, 6)
	f.physical_defense = _es(22, 32, 2, 4, lvl, 6)
	f.magic_attack = _es(24, 31, 3, 5, lvl, 6)
	f.magic_defense = _es(22, 32, 2, 4, lvl, 6)
	f.speed = _es(24, 34, 1, 2, lvl, 6)
	f.crit_chance = 25; f.crit_damage = 3; f.dodge_chance = 8
	f.abilities = [EAB.rend(), EAB.putrid_touch(), EAB.devour()]
	return f

static func create_ghoul(n: String, lvl: int = 6) -> FighterData:
	var f := _base(n, "Ghoul", lvl)
	f.health = _es(118, 135, 3, 6, lvl, 6); f.max_health = f.health
	f.mana = _es(13, 17, 1, 3, lvl, 6); f.max_mana = f.mana
	f.physical_attack = _es(20, 25, 2, 3, lvl, 6)
	f.physical_defense = _es(16, 21, 1, 2, lvl, 6)
	f.magic_attack = _es(12, 17, 1, 2, lvl, 6)
	f.magic_defense = _es(15, 19, 1, 2, lvl, 6)
	f.speed = _es(26, 32, 2, 3, lvl, 6)
	f.crit_chance = 19; f.crit_damage = 2; f.dodge_chance = 13
	f.abilities = [EAB.claw(), EAB.paralyze(), EAB.devour()]
	return f

static func create_shade(n: String, lvl: int = 7) -> FighterData:
	var f := _base(n, "Shade", lvl)
	f.health = _es(139, 167, 5, 9, lvl, 7); f.max_health = f.health
	f.mana = _es(23, 32, 2, 5, lvl, 7); f.max_mana = f.mana
	f.physical_attack = _es(21, 27, 1, 3, lvl, 7)
	f.physical_defense = _es(14, 18, 1, 2, lvl, 7)
	f.magic_attack = _es(33, 40, 3, 5, lvl, 7)
	f.magic_defense = _es(16, 22, 2, 4, lvl, 7)
	f.speed = _es(32, 38, 2, 4, lvl, 7)
	f.crit_chance = 20; f.crit_damage = 2; f.dodge_chance = 25
	f.abilities = [EAB.umbral_lash(), EAB.shadow_rot(), EAB.dread_whisper()]
	return f

static func create_wraith(n: String, lvl: int = 7) -> FighterData:
	var f := _base(n, "Wraith", lvl)
	f.health = _es(158, 188, 5, 9, lvl, 7); f.max_health = f.health
	f.mana = _es(18, 22, 2, 4, lvl, 7); f.max_mana = f.mana
	f.physical_attack = _es(21, 26, 0, 2, lvl, 7)
	f.physical_defense = _es(11, 15, 1, 2, lvl, 7)
	f.magic_attack = _es(32, 41, 3, 5, lvl, 7)
	f.magic_defense = _es(16, 22, 2, 3, lvl, 7)
	f.speed = _es(30, 36, 2, 4, lvl, 7)
	f.crit_chance = 20; f.crit_damage = 3; f.dodge_chance = 20
	f.abilities = [EAB.soul_drain(), EAB.death_wither(), EAB.terrify()]
	return f
