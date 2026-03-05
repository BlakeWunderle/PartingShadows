class_name EnemyDBS2

## Story 2 enemy factory. Separate from EnemyDB to avoid touching Story 1 balance.

const FighterData := preload("res://scripts/data/fighter_data.gd")
const EAB := preload("res://scripts/data/enemy_ability_db_s2.gd")


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


static func create_vein_leech(n: String, lvl: int = 3) -> FighterData:
	var f := _base(n, "Vein Leech", lvl)
	f.health = _es(55, 65, 3, 5, lvl, 3); f.max_health = f.health
	f.mana = _es(6, 10, 1, 3, lvl, 3); f.max_mana = f.mana
	f.physical_attack = _es(20, 24, 2, 3, lvl, 3)
	f.physical_defense = _es(8, 11, 1, 2, lvl, 3)
	f.magic_attack = _es(5, 8, 0, 2, lvl, 3)
	f.magic_defense = _es(7, 10, 1, 2, lvl, 3)
	f.speed = _es(22, 28, 1, 3, lvl, 3)
	f.crit_chance = 12; f.crit_damage = 2; f.dodge_chance = 10
	f.abilities = [EAB.latch(), EAB.siphon_glow()]
	return f


static func create_stone_moth(n: String, lvl: int = 3) -> FighterData:
	var f := _base(n, "Stone Moth", lvl)
	f.health = _es(42, 50, 2, 4, lvl, 3); f.max_health = f.health
	f.mana = _es(10, 14, 1, 3, lvl, 3); f.max_mana = f.mana
	f.physical_attack = _es(8, 11, 0, 2, lvl, 3)
	f.physical_defense = _es(6, 9, 0, 1, lvl, 3)
	f.magic_attack = _es(18, 22, 1, 3, lvl, 3)
	f.magic_defense = _es(12, 16, 1, 2, lvl, 3)
	f.speed = _es(26, 32, 2, 3, lvl, 3)
	f.crit_chance = 10; f.crit_damage = 1; f.dodge_chance = 20
	f.abilities = [EAB.petrify_pulse(), EAB.wing_dust()]
	return f


# =============================================================================
# Fungal Hollow creatures (Progression 1, alt branch)
# =============================================================================

static func create_spore_stalker(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Spore Stalker", lvl)
	f.health = _es(40, 48, 2, 4, lvl, 2); f.max_health = f.health
	f.mana = _es(8, 12, 1, 3, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(14, 18, 1, 3, lvl, 2)
	f.physical_defense = _es(6, 9, 0, 1, lvl, 2)
	f.magic_attack = _es(10, 14, 1, 2, lvl, 2)
	f.magic_defense = _es(6, 9, 0, 1, lvl, 2)
	f.speed = _es(26, 32, 2, 3, lvl, 2)
	f.crit_chance = 12; f.crit_damage = 1; f.dodge_chance = 18
	f.abilities = [EAB.toxic_dart(), EAB.spore_burst()]
	return f


static func create_fungal_hulk(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Fungal Hulk", lvl)
	f.health = _es(62, 72, 4, 6, lvl, 2); f.max_health = f.health
	f.mana = _es(6, 10, 1, 2, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(16, 20, 1, 3, lvl, 2)
	f.physical_defense = _es(10, 14, 1, 2, lvl, 2)
	f.magic_attack = _es(4, 7, 0, 1, lvl, 2)
	f.magic_defense = _es(8, 11, 1, 2, lvl, 2)
	f.speed = _es(14, 18, 1, 2, lvl, 2)
	f.crit_chance = 8; f.crit_damage = 1; f.dodge_chance = 5
	f.abilities = [EAB.fungal_slam(), EAB.mycelium_shield()]
	return f


static func create_cap_wisp(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Cap Wisp", lvl)
	f.health = _es(34, 42, 2, 4, lvl, 2); f.max_health = f.health
	f.mana = _es(12, 16, 1, 3, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(6, 9, 0, 1, lvl, 2)
	f.physical_defense = _es(5, 8, 0, 1, lvl, 2)
	f.magic_attack = _es(16, 20, 1, 3, lvl, 2)
	f.magic_defense = _es(10, 14, 1, 2, lvl, 2)
	f.speed = _es(24, 30, 2, 3, lvl, 2)
	f.crit_chance = 10; f.crit_damage = 1; f.dodge_chance = 16
	f.abilities = [EAB.hallucinate(), EAB.befuddle()]
	return f


# =============================================================================
# Tranquil Pool creatures (Progression 2, alt branch)
# =============================================================================

static func create_cave_eel(n: String, lvl: int = 3) -> FighterData:
	var f := _base(n, "Cave Eel", lvl)
	f.health = _es(44, 52, 2, 4, lvl, 3); f.max_health = f.health
	f.mana = _es(10, 14, 1, 3, lvl, 3); f.max_mana = f.mana
	f.physical_attack = _es(18, 22, 1, 3, lvl, 3)
	f.physical_defense = _es(6, 9, 0, 1, lvl, 3)
	f.magic_attack = _es(14, 18, 1, 2, lvl, 3)
	f.magic_defense = _es(8, 11, 1, 2, lvl, 3)
	f.speed = _es(28, 34, 2, 3, lvl, 3)
	f.crit_chance = 14; f.crit_damage = 2; f.dodge_chance = 15
	f.abilities = [EAB.jolt(), EAB.arc_flash()]
	return f


static func create_blind_angler(n: String, lvl: int = 3) -> FighterData:
	var f := _base(n, "Blind Angler", lvl)
	f.health = _es(50, 60, 3, 5, lvl, 3); f.max_health = f.health
	f.mana = _es(10, 14, 1, 3, lvl, 3); f.max_mana = f.mana
	f.physical_attack = _es(8, 11, 0, 2, lvl, 3)
	f.physical_defense = _es(8, 11, 1, 2, lvl, 3)
	f.magic_attack = _es(16, 20, 1, 3, lvl, 3)
	f.magic_defense = _es(10, 14, 1, 2, lvl, 3)
	f.speed = _es(20, 26, 1, 2, lvl, 3)
	f.crit_chance = 10; f.crit_damage = 1; f.dodge_chance = 10
	f.abilities = [EAB.lure_light(), EAB.abyssal_gaze()]
	return f


static func create_pale_crayfish(n: String, lvl: int = 3) -> FighterData:
	var f := _base(n, "Pale Crayfish", lvl)
	f.health = _es(68, 78, 4, 6, lvl, 3); f.max_health = f.health
	f.mana = _es(6, 10, 1, 2, lvl, 3); f.max_mana = f.mana
	f.physical_attack = _es(20, 24, 2, 3, lvl, 3)
	f.physical_defense = _es(14, 18, 1, 3, lvl, 3)
	f.magic_attack = _es(4, 7, 0, 1, lvl, 3)
	f.magic_defense = _es(10, 14, 1, 2, lvl, 3)
	f.speed = _es(14, 20, 1, 2, lvl, 3)
	f.crit_chance = 8; f.crit_damage = 2; f.dodge_chance = 5
	f.abilities = [EAB.pincer_crush(), EAB.shell_up()]
	return f


# =============================================================================
# Torch Chamber dwellers (Progression 2, alt branch)
# =============================================================================

static func create_cave_dweller(n: String, lvl: int = 3) -> FighterData:
	var f := _base(n, "Cave Dweller", lvl)
	f.health = _es(58, 68, 3, 5, lvl, 3); f.max_health = f.health
	f.mana = _es(6, 10, 1, 2, lvl, 3); f.max_mana = f.mana
	f.physical_attack = _es(20, 24, 2, 3, lvl, 3)
	f.physical_defense = _es(12, 16, 1, 2, lvl, 3)
	f.magic_attack = _es(6, 9, 0, 1, lvl, 3)
	f.magic_defense = _es(8, 11, 1, 2, lvl, 3)
	f.speed = _es(20, 26, 1, 2, lvl, 3)
	f.crit_chance = 10; f.crit_damage = 2; f.dodge_chance = 8
	f.abilities = [EAB.crude_axe(), EAB.rock_toss()]
	return f


static func create_tunnel_shaman(n: String, lvl: int = 3) -> FighterData:
	var f := _base(n, "Tunnel Shaman", lvl)
	f.health = _es(46, 54, 2, 4, lvl, 3); f.max_health = f.health
	f.mana = _es(14, 18, 1, 3, lvl, 3); f.max_mana = f.mana
	f.physical_attack = _es(6, 9, 0, 1, lvl, 3)
	f.physical_defense = _es(7, 10, 0, 2, lvl, 3)
	f.magic_attack = _es(18, 22, 1, 3, lvl, 3)
	f.magic_defense = _es(12, 16, 1, 2, lvl, 3)
	f.speed = _es(22, 28, 1, 2, lvl, 3)
	f.crit_chance = 10; f.crit_damage = 1; f.dodge_chance = 10
	f.abilities = [EAB.hex_flame(), EAB.ward_bones()]
	return f


static func create_burrow_scout(n: String, lvl: int = 3) -> FighterData:
	var f := _base(n, "Burrow Scout", lvl)
	f.health = _es(40, 48, 2, 4, lvl, 3); f.max_health = f.health
	f.mana = _es(8, 12, 1, 2, lvl, 3); f.max_mana = f.mana
	f.physical_attack = _es(16, 20, 1, 3, lvl, 3)
	f.physical_defense = _es(6, 9, 0, 1, lvl, 3)
	f.magic_attack = _es(4, 7, 0, 1, lvl, 3)
	f.magic_defense = _es(6, 9, 0, 1, lvl, 3)
	f.speed = _es(28, 34, 2, 3, lvl, 3)
	f.crit_chance = 14; f.crit_damage = 2; f.dodge_chance = 20
	f.abilities = [EAB.dart_strike(), EAB.smoke_bomb()]
	return f
