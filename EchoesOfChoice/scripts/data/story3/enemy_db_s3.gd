class_name EnemyDBS3

## Story 3 Acts I-II enemy factory. Dream fauna and nightmare entities.

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
# Act I: Dream fauna (Progression 0-2)
# =============================================================================

# Prog 0 (+14%) -- LOCKED (PASS at 77.6%)
static func create_dream_wisp(n: String, lvl: int = 1) -> FighterData:
	var f := _base(n, "Dream Wisp", lvl)
	f.health = _es(32, 41, 2, 5, lvl, 1); f.max_health = f.health
	f.mana = _es(11, 16, 1, 3, lvl, 1); f.max_mana = f.mana
	f.physical_attack = _es(9, 13, 0, 2, lvl, 1)
	f.physical_defense = _es(6, 9, 0, 1, lvl, 1)
	f.magic_attack = _es(16, 19, 1, 3, lvl, 1)
	f.magic_defense = _es(10, 14, 1, 2, lvl, 1)
	f.speed = _es(27, 32, 1, 3, lvl, 1)
	f.crit_chance = 6; f.crit_damage = 1; f.dodge_chance = 9
	f.abilities = [EAB.shimmer_bolt(), EAB.daze()]
	return f


static func create_phantasm(n: String, lvl: int = 1) -> FighterData:
	var f := _base(n, "Phantasm", lvl)
	f.health = _es(38, 47, 2, 5, lvl, 1); f.max_health = f.health
	f.mana = _es(9, 14, 1, 2, lvl, 1); f.max_mana = f.mana
	f.physical_attack = _es(14, 17, 1, 2, lvl, 1)
	f.physical_defense = _es(7, 10, 0, 1, lvl, 1)
	f.magic_attack = _es(13, 16, 1, 2, lvl, 1)
	f.magic_defense = _es(9, 13, 1, 2, lvl, 1)
	f.speed = _es(25, 31, 1, 3, lvl, 1)
	f.crit_chance = 8; f.crit_damage = 1; f.dodge_chance = 15
	f.abilities = [EAB.phase_strike(), EAB.unnerve()]
	return f


# Prog 1 MirrorHall enemies (+10%)
static func create_shade_moth(n: String, lvl: int = 1) -> FighterData:
	var f := _base(n, "Shade Moth", lvl)
	f.health = _es(28, 35, 2, 3, lvl, 1); f.max_health = f.health
	f.mana = _es(7, 11, 1, 2, lvl, 1); f.max_mana = f.mana
	f.physical_attack = _es(11, 14, 1, 2, lvl, 1)
	f.physical_defense = _es(4, 8, 0, 1, lvl, 1)
	f.magic_attack = _es(9, 12, 0, 2, lvl, 1)
	f.magic_defense = _es(7, 10, 0, 1, lvl, 1)
	f.speed = _es(29, 35, 1, 3, lvl, 1)
	f.crit_chance = 10; f.crit_damage = 1; f.dodge_chance = 18
	f.abilities = [EAB.dust_wing(), EAB.flit()]
	return f


static func create_sleep_stalker(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Sleep Stalker", lvl)
	f.health = _es(45, 53, 3, 6, lvl, 2); f.max_health = f.health
	f.mana = _es(7, 11, 1, 2, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(20, 24, 1, 3, lvl, 2)
	f.physical_defense = _es(8, 11, 1, 2, lvl, 2)
	f.magic_attack = _es(7, 10, 0, 1, lvl, 2)
	f.magic_defense = _es(8, 11, 0, 1, lvl, 2)
	f.speed = _es(26, 32, 1, 3, lvl, 2)
	f.crit_chance = 14; f.crit_damage = 2; f.dodge_chance = 11
	f.abilities = [EAB.dream_fang(), EAB.shadow_lunge()]
	return f


static func create_mirror_shade(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Mirror Shade", lvl)
	f.health = _es(42, 50, 2, 4, lvl, 2); f.max_health = f.health
	f.mana = _es(9, 13, 1, 2, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(14, 18, 1, 2, lvl, 2)
	f.physical_defense = _es(10, 13, 1, 2, lvl, 2)
	f.magic_attack = _es(14, 18, 1, 2, lvl, 2)
	f.magic_defense = _es(10, 13, 1, 2, lvl, 2)
	f.speed = _es(24, 30, 1, 2, lvl, 2)
	f.crit_chance = 8; f.crit_damage = 1; f.dodge_chance = 9
	f.abilities = [EAB.reflected_strike(), EAB.mimic_stance()]
	return f


# Prog 1 FogGarden enemies (+4% stats, reduced crit/dodge)
static func create_slumber_beast(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Slumber Beast", lvl)
	f.health = _es(54, 65, 3, 6, lvl, 2); f.max_health = f.health
	f.mana = _es(6, 10, 1, 2, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(17, 21, 1, 3, lvl, 2)
	f.physical_defense = _es(11, 15, 1, 2, lvl, 2)
	f.magic_attack = _es(6, 9, 0, 1, lvl, 2)
	f.magic_defense = _es(8, 11, 1, 2, lvl, 2)
	f.speed = _es(19, 24, 1, 2, lvl, 2)
	f.crit_chance = 5; f.crit_damage = 1; f.dodge_chance = 3
	f.abilities = [EAB.heavy_paw(), EAB.drowsy_roar()]
	return f


static func create_fog_wraith(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Fog Wraith", lvl)
	f.health = _es(38, 46, 2, 4, lvl, 2); f.max_health = f.health
	f.mana = _es(12, 17, 1, 3, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(8, 11, 0, 2, lvl, 2)
	f.physical_defense = _es(6, 9, 0, 1, lvl, 2)
	f.magic_attack = _es(17, 21, 1, 3, lvl, 2)
	f.magic_defense = _es(9, 14, 1, 2, lvl, 2)
	f.speed = _es(23, 28, 1, 3, lvl, 2)
	f.crit_chance = 5; f.crit_damage = 1; f.dodge_chance = 8
	f.abilities = [EAB.mist_tendril(), EAB.chill_fog()]
	return f


static func create_thorn_dreamer(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Thorn Dreamer", lvl)
	f.health = _es(48, 56, 3, 5, lvl, 2); f.max_health = f.health
	f.mana = _es(10, 15, 1, 3, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(15, 18, 1, 2, lvl, 2)
	f.physical_defense = _es(8, 11, 1, 2, lvl, 2)
	f.magic_attack = _es(10, 14, 1, 2, lvl, 2)
	f.magic_defense = _es(9, 12, 1, 2, lvl, 2)
	f.speed = _es(21, 26, 1, 2, lvl, 2)
	f.crit_chance = 5; f.crit_damage = 1; f.dodge_chance = 4
	f.abilities = [EAB.briar_lash(), EAB.spore_cloud()]
	return f


# =============================================================================
# Act II: Nightmare entities (Progression 3-5)
# =============================================================================

# Prog 3 enemies (+2% stats, reduced crit/dodge), also used at Prog 5 as support
static func create_nightmare_hound(n: String, lvl: int = 4) -> FighterData:
	var f := _base(n, "Nightmare Hound", lvl)
	f.health = _es(87, 102, 4, 7, lvl, 4); f.max_health = f.health
	f.mana = _es(8, 12, 1, 2, lvl, 4); f.max_mana = f.mana
	f.physical_attack = _es(22, 27, 1, 3, lvl, 4)
	f.physical_defense = _es(13, 16, 1, 2, lvl, 4)
	f.magic_attack = _es(10, 13, 0, 2, lvl, 4)
	f.magic_defense = _es(12, 15, 1, 2, lvl, 4)
	f.speed = _es(29, 34, 1, 3, lvl, 4)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 6
	f.abilities = [EAB.savage_bite(), EAB.howl()]
	return f


static func create_dream_weaver(n: String, lvl: int = 4) -> FighterData:
	var f := _base(n, "Dream Weaver", lvl)
	f.health = _es(78, 92, 3, 6, lvl, 4); f.max_health = f.health
	f.mana = _es(14, 18, 1, 3, lvl, 4); f.max_mana = f.mana
	f.physical_attack = _es(10, 13, 0, 2, lvl, 4)
	f.physical_defense = _es(12, 15, 1, 2, lvl, 4)
	f.magic_attack = _es(21, 26, 1, 3, lvl, 4)
	f.magic_defense = _es(14, 17, 1, 2, lvl, 4)
	f.speed = _es(26, 31, 1, 2, lvl, 4)
	f.crit_chance = 5; f.crit_damage = 1; f.dodge_chance = 4
	f.abilities = [EAB.thread_bolt(), EAB.woven_ward()]
	return f


static func create_hollow_echo(n: String, lvl: int = 4) -> FighterData:
	var f := _base(n, "Hollow Echo", lvl)
	f.health = _es(83, 97, 3, 5, lvl, 4); f.max_health = f.health
	f.mana = _es(12, 16, 1, 3, lvl, 4); f.max_mana = f.mana
	f.physical_attack = _es(10, 13, 0, 2, lvl, 4)
	f.physical_defense = _es(11, 14, 1, 2, lvl, 4)
	f.magic_attack = _es(20, 24, 1, 3, lvl, 4)
	f.magic_defense = _es(13, 16, 1, 2, lvl, 4)
	f.speed = _es(26, 31, 1, 2, lvl, 4)
	f.crit_chance = 5; f.crit_damage = 1; f.dodge_chance = 6
	f.abilities = [EAB.echo_drain(), EAB.dissonance()]
	return f


# Prog 4 Labyrinth enemies (+6%)
static func create_somnolent_serpent(n: String, lvl: int = 5) -> FighterData:
	var f := _base(n, "Somnolent Serpent", lvl)
	f.health = _es(101, 116, 4, 6, lvl, 5); f.max_health = f.health
	f.mana = _es(10, 14, 1, 3, lvl, 5); f.max_mana = f.mana
	f.physical_attack = _es(22, 25, 1, 3, lvl, 5)
	f.physical_defense = _es(15, 18, 1, 2, lvl, 5)
	f.magic_attack = _es(13, 16, 1, 2, lvl, 5)
	f.magic_defense = _es(14, 17, 1, 2, lvl, 5)
	f.speed = _es(28, 33, 1, 2, lvl, 5)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 8
	f.abilities = [EAB.venom_coil(), EAB.sleep_fang()]
	return f


static func create_twilight_stalker(n: String, lvl: int = 5) -> FighterData:
	var f := _base(n, "Twilight Stalker", lvl)
	f.health = _es(96, 111, 3, 6, lvl, 5); f.max_health = f.health
	f.mana = _es(8, 12, 1, 2, lvl, 5); f.max_mana = f.mana
	f.physical_attack = _es(25, 30, 1, 3, lvl, 5)
	f.physical_defense = _es(13, 16, 1, 2, lvl, 5)
	f.magic_attack = _es(11, 14, 0, 2, lvl, 5)
	f.magic_defense = _es(12, 15, 1, 2, lvl, 5)
	f.speed = _es(30, 35, 1, 3, lvl, 5)
	f.crit_chance = 15; f.crit_damage = 2; f.dodge_chance = 13
	f.abilities = [EAB.dusk_blade(), EAB.vanish_strike()]
	return f


static func create_waking_terror(n: String, lvl: int = 5) -> FighterData:
	var f := _base(n, "Waking Terror", lvl)
	f.health = _es(105, 121, 4, 6, lvl, 5); f.max_health = f.health
	f.mana = _es(14, 18, 2, 3, lvl, 5); f.max_mana = f.mana
	f.physical_attack = _es(13, 16, 0, 2, lvl, 5)
	f.physical_defense = _es(14, 17, 1, 2, lvl, 5)
	f.magic_attack = _es(23, 28, 1, 3, lvl, 5)
	f.magic_defense = _es(16, 19, 1, 2, lvl, 5)
	f.speed = _es(25, 31, 1, 2, lvl, 5)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 6
	f.abilities = [EAB.scream_blast(), EAB.terror_wave()]
	return f


# Prog 4 ClockTower enemies (+12%)
static func create_dusk_sentinel(n: String, lvl: int = 5) -> FighterData:
	var f := _base(n, "Dusk Sentinel", lvl)
	f.health = _es(127, 149, 6, 9, lvl, 5); f.max_health = f.health
	f.mana = _es(9, 13, 1, 2, lvl, 5); f.max_mana = f.mana
	f.physical_attack = _es(23, 27, 1, 3, lvl, 5)
	f.physical_defense = _es(20, 25, 1, 3, lvl, 5)
	f.magic_attack = _es(9, 12, 0, 1, lvl, 5)
	f.magic_defense = _es(18, 22, 1, 2, lvl, 5)
	f.speed = _es(25, 30, 1, 2, lvl, 5)
	f.crit_chance = 6; f.crit_damage = 1; f.dodge_chance = 4
	f.abilities = [EAB.shield_bash(), EAB.iron_stance()]
	return f


static func create_clock_specter(n: String, lvl: int = 5) -> FighterData:
	var f := _base(n, "Clock Specter", lvl)
	f.health = _es(102, 118, 3, 7, lvl, 5); f.max_health = f.health
	f.mana = _es(11, 16, 1, 3, lvl, 5); f.max_mana = f.mana
	f.physical_attack = _es(18, 23, 1, 2, lvl, 5)
	f.physical_defense = _es(14, 17, 1, 2, lvl, 5)
	f.magic_attack = _es(20, 25, 1, 3, lvl, 5)
	f.magic_defense = _es(15, 18, 1, 2, lvl, 5)
	f.speed = _es(29, 35, 1, 3, lvl, 5)
	f.crit_chance = 10; f.crit_damage = 1; f.dodge_chance = 11
	f.abilities = [EAB.time_rend(), EAB.stasis_touch()]
	return f


# Prog 5 boss (+2%), support enemies are nightmare_hound + hollow_echo from Prog 3
static func create_the_nightmare(n: String, lvl: int = 6) -> FighterData:
	var f := _base(n, "The Nightmare", lvl)
	f.health = _es(175, 203, 6, 10, lvl, 6); f.max_health = f.health
	f.mana = _es(18, 22, 2, 4, lvl, 6); f.max_mana = f.mana
	f.physical_attack = _es(29, 33, 2, 3, lvl, 6)
	f.physical_defense = _es(18, 22, 1, 3, lvl, 6)
	f.magic_attack = _es(27, 31, 2, 3, lvl, 6)
	f.magic_defense = _es(18, 22, 1, 3, lvl, 6)
	f.speed = _es(31, 36, 2, 3, lvl, 6)
	f.crit_chance = 9; f.crit_damage = 2; f.dodge_chance = 8
	f.abilities = [EAB.nightmare_crush(), EAB.dream_rend(), EAB.dread_aura()]
	return f
