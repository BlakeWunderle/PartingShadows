class_name EnemyDBS3Act2

## Story 3 expanded Act II + waking investigation enemies.
## 9 dream entities (Progs 4-6) + 6 waking cult/cellar enemies (Progs 9-10).

const FighterData := preload("res://scripts/data/fighter_data.gd")
const EAB := preload("res://scripts/data/story3/enemy_ability_db_s3_act2.gd")


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
# Prog 4: Thread-visible dream entities (S3_DreamThreads)
# =============================================================================

static func create_thread_lurker(n: String, lvl: int = 5) -> FighterData:
	var f := _base(n, "Thread Lurker", lvl)
	f.health = _es(120, 140, 3, 6, lvl, 5); f.max_health = f.health
	f.mana = _es(8, 12, 1, 2, lvl, 5); f.max_mana = f.mana
	f.physical_attack = _es(24, 28, 1, 3, lvl, 5)
	f.physical_defense = _es(13, 16, 1, 2, lvl, 5)
	f.magic_attack = _es(10, 13, 0, 2, lvl, 5)
	f.magic_defense = _es(12, 15, 1, 2, lvl, 5)
	f.speed = _es(30, 35, 1, 3, lvl, 5)
	f.crit_chance = 12; f.crit_damage = 2; f.dodge_chance = 10
	f.abilities = [EAB.thread_ambush(), EAB.web_snare()]
	return f


static func create_dream_sentinel(n: String, lvl: int = 5) -> FighterData:
	var f := _base(n, "Dream Sentinel", lvl)
	f.health = _es(155, 180, 4, 7, lvl, 5); f.max_health = f.health
	f.mana = _es(9, 13, 1, 2, lvl, 5); f.max_mana = f.mana
	f.physical_attack = _es(19, 23, 1, 2, lvl, 5)
	f.physical_defense = _es(18, 22, 1, 3, lvl, 5)
	f.magic_attack = _es(11, 14, 0, 2, lvl, 5)
	f.magic_defense = _es(16, 19, 1, 2, lvl, 5)
	f.speed = _es(23, 28, 1, 2, lvl, 5)
	f.crit_chance = 5; f.crit_damage = 1; f.dodge_chance = 4
	f.abilities = [EAB.sentinel_strike(), EAB.woven_guard()]
	return f


static func create_gloom_spinner(n: String, lvl: int = 5) -> FighterData:
	var f := _base(n, "Gloom Spinner", lvl)
	f.health = _es(105, 125, 3, 5, lvl, 5); f.max_health = f.health
	f.mana = _es(14, 18, 1, 3, lvl, 5); f.max_mana = f.mana
	f.physical_attack = _es(10, 13, 0, 2, lvl, 5)
	f.physical_defense = _es(10, 13, 1, 2, lvl, 5)
	f.magic_attack = _es(22, 26, 1, 3, lvl, 5)
	f.magic_defense = _es(14, 17, 1, 2, lvl, 5)
	f.speed = _es(27, 32, 1, 2, lvl, 5)
	f.crit_chance = 6; f.crit_damage = 1; f.dodge_chance = 7
	f.abilities = [EAB.shadow_thread(), EAB.gloom_web()]
	return f


# =============================================================================
# Prog 5: Drowned Corridor enemies (S3_DreamDrownedCorridor)
# =============================================================================

static func create_drowned_reverie(n: String, lvl: int = 6) -> FighterData:
	var f := _base(n, "Drowned Reverie", lvl)
	f.health = _es(130, 150, 3, 6, lvl, 6); f.max_health = f.health
	f.mana = _es(15, 19, 1, 3, lvl, 6); f.max_mana = f.mana
	f.physical_attack = _es(11, 14, 0, 2, lvl, 6)
	f.physical_defense = _es(12, 15, 1, 2, lvl, 6)
	f.magic_attack = _es(24, 28, 1, 3, lvl, 6)
	f.magic_defense = _es(15, 18, 1, 2, lvl, 6)
	f.speed = _es(26, 31, 1, 2, lvl, 6)
	f.crit_chance = 6; f.crit_damage = 1; f.dodge_chance = 8
	f.abilities = [EAB.memory_surge(), EAB.deep_pulse()]
	return f


static func create_riptide_beast(n: String, lvl: int = 6) -> FighterData:
	var f := _base(n, "Riptide Beast", lvl)
	f.health = _es(125, 145, 3, 5, lvl, 6); f.max_health = f.health
	f.mana = _es(8, 12, 1, 2, lvl, 6); f.max_mana = f.mana
	f.physical_attack = _es(26, 30, 1, 3, lvl, 6)
	f.physical_defense = _es(14, 17, 1, 2, lvl, 6)
	f.magic_attack = _es(10, 13, 0, 2, lvl, 6)
	f.magic_defense = _es(12, 15, 1, 2, lvl, 6)
	f.speed = _es(31, 36, 1, 3, lvl, 6)
	f.crit_chance = 14; f.crit_damage = 2; f.dodge_chance = 12
	f.abilities = [EAB.riptide_slash(), EAB.swift_current()]
	return f


static func create_depth_crawler(n: String, lvl: int = 6) -> FighterData:
	var f := _base(n, "Depth Crawler", lvl)
	f.health = _es(140, 160, 3, 6, lvl, 6); f.max_health = f.health
	f.mana = _es(10, 14, 1, 2, lvl, 6); f.max_mana = f.mana
	f.physical_attack = _es(20, 24, 1, 3, lvl, 6)
	f.physical_defense = _es(15, 18, 1, 2, lvl, 6)
	f.magic_attack = _es(18, 22, 1, 2, lvl, 6)
	f.magic_defense = _es(13, 16, 1, 2, lvl, 6)
	f.speed = _es(25, 30, 1, 2, lvl, 6)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 5
	f.abilities = [EAB.thread_burn(), EAB.latch()]
	return f


# =============================================================================
# Prog 5: Shattered Gallery enemies (S3_DreamShatteredGallery)
# =============================================================================

static func create_fragment_golem(n: String, lvl: int = 6) -> FighterData:
	var f := _base(n, "Fragment Golem", lvl)
	f.health = _es(175, 200, 4, 7, lvl, 6); f.max_health = f.health
	f.mana = _es(6, 10, 1, 2, lvl, 6); f.max_mana = f.mana
	f.physical_attack = _es(25, 29, 1, 3, lvl, 6)
	f.physical_defense = _es(20, 24, 1, 3, lvl, 6)
	f.magic_attack = _es(8, 11, 0, 1, lvl, 6)
	f.magic_defense = _es(16, 19, 1, 2, lvl, 6)
	f.speed = _es(21, 26, 1, 2, lvl, 6)
	f.crit_chance = 5; f.crit_damage = 1; f.dodge_chance = 3
	f.abilities = [EAB.dream_crush(), EAB.fragment_shield()]
	return f


static func create_memory_wisp(n: String, lvl: int = 6) -> FighterData:
	var f := _base(n, "Memory Wisp", lvl)
	f.health = _es(100, 120, 2, 5, lvl, 6); f.max_health = f.health
	f.mana = _es(13, 17, 1, 3, lvl, 6); f.max_mana = f.mana
	f.physical_attack = _es(10, 13, 0, 2, lvl, 6)
	f.physical_defense = _es(9, 12, 0, 1, lvl, 6)
	f.magic_attack = _es(19, 23, 1, 3, lvl, 6)
	f.magic_defense = _es(12, 15, 1, 2, lvl, 6)
	f.speed = _es(32, 37, 1, 3, lvl, 6)
	f.crit_chance = 8; f.crit_damage = 1; f.dodge_chance = 15
	f.abilities = [EAB.stolen_thought(), EAB.blur()]
	return f


static func create_gallery_shade(n: String, lvl: int = 6) -> FighterData:
	var f := _base(n, "Gallery Shade", lvl)
	f.health = _es(120, 140, 3, 5, lvl, 6); f.max_health = f.health
	f.mana = _es(14, 18, 1, 3, lvl, 6); f.max_mana = f.mana
	f.physical_attack = _es(11, 14, 0, 2, lvl, 6)
	f.physical_defense = _es(11, 14, 1, 2, lvl, 6)
	f.magic_attack = _es(25, 29, 1, 3, lvl, 6)
	f.magic_defense = _es(14, 17, 1, 2, lvl, 6)
	f.speed = _es(28, 33, 1, 3, lvl, 6)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 9
	f.abilities = [EAB.gallery_bolt(), EAB.shatter_ward()]
	return f


# =============================================================================
# Prog 6: Shadow Chase convergence (S3_DreamShadowChase)
# =============================================================================

static func create_shadow_pursuer(n: String, lvl: int = 7) -> FighterData:
	var f := _base(n, "Shadow Pursuer", lvl)
	f.health = _es(140, 165, 3, 6, lvl, 7); f.max_health = f.health
	f.mana = _es(8, 12, 1, 2, lvl, 7); f.max_mana = f.mana
	f.physical_attack = _es(28, 33, 1, 3, lvl, 7)
	f.physical_defense = _es(14, 17, 1, 2, lvl, 7)
	f.magic_attack = _es(12, 15, 0, 2, lvl, 7)
	f.magic_defense = _es(13, 16, 1, 2, lvl, 7)
	f.speed = _es(33, 38, 1, 3, lvl, 7)
	f.crit_chance = 16; f.crit_damage = 2; f.dodge_chance = 13
	f.abilities = [EAB.shadow_strike(), EAB.relentless_hound()]
	return f


static func create_dread_tendril(n: String, lvl: int = 7) -> FighterData:
	var f := _base(n, "Dread Tendril", lvl)
	f.health = _es(130, 155, 3, 5, lvl, 7); f.max_health = f.health
	f.mana = _es(16, 20, 1, 3, lvl, 7); f.max_mana = f.mana
	f.physical_attack = _es(11, 14, 0, 2, lvl, 7)
	f.physical_defense = _es(13, 16, 1, 2, lvl, 7)
	f.magic_attack = _es(26, 31, 1, 3, lvl, 7)
	f.magic_defense = _es(15, 18, 1, 2, lvl, 7)
	f.speed = _es(27, 32, 1, 2, lvl, 7)
	f.crit_chance = 6; f.crit_damage = 1; f.dodge_chance = 7
	f.abilities = [EAB.dread_lash(), EAB.terror_grip()]
	return f


static func create_faded_voice(n: String, lvl: int = 7) -> FighterData:
	var f := _base(n, "Faded Voice", lvl)
	f.health = _es(120, 140, 3, 5, lvl, 7); f.max_health = f.health
	f.mana = _es(14, 18, 1, 3, lvl, 7); f.max_mana = f.mana
	f.physical_attack = _es(12, 15, 0, 2, lvl, 7)
	f.physical_defense = _es(12, 15, 1, 2, lvl, 7)
	f.magic_attack = _es(22, 26, 1, 3, lvl, 7)
	f.magic_defense = _es(14, 17, 1, 2, lvl, 7)
	f.speed = _es(28, 33, 1, 2, lvl, 7)
	f.crit_chance = 6; f.crit_damage = 1; f.dodge_chance = 9
	f.abilities = [EAB.echoed_cry(), EAB.fade()]
	return f


# =============================================================================
# Prog 9: Waking market confrontation (S3_MarketConfrontation)
# =============================================================================

static func create_market_watcher(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "Market Watcher", lvl)
	f.health = _es(175, 200, 4, 7, lvl, 10); f.max_health = f.health
	f.mana = _es(10, 14, 1, 2, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(28, 33, 1, 3, lvl, 10)
	f.physical_defense = _es(18, 22, 1, 3, lvl, 10)
	f.magic_attack = _es(12, 15, 0, 2, lvl, 10)
	f.magic_defense = _es(15, 18, 1, 2, lvl, 10)
	f.speed = _es(27, 32, 1, 2, lvl, 10)
	f.crit_chance = 8; f.crit_damage = 1; f.dodge_chance = 6
	f.abilities = [EAB.hidden_blade(), EAB.merchant_guard()]
	return f


static func create_thread_smith(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "Thread Smith", lvl)
	f.health = _es(200, 230, 5, 8, lvl, 10); f.max_health = f.health
	f.mana = _es(7, 11, 1, 2, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(31, 36, 2, 3, lvl, 10)
	f.physical_defense = _es(22, 26, 1, 3, lvl, 10)
	f.magic_attack = _es(9, 12, 0, 1, lvl, 10)
	f.magic_defense = _es(17, 20, 1, 2, lvl, 10)
	f.speed = _es(24, 29, 1, 2, lvl, 10)
	f.crit_chance = 7; f.crit_damage = 2; f.dodge_chance = 4
	f.abilities = [EAB.hammer_blow(), EAB.forge_hardened()]
	return f


static func create_hex_herbalist(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "Hex Herbalist", lvl)
	f.health = _es(155, 180, 3, 6, lvl, 10); f.max_health = f.health
	f.mana = _es(16, 20, 1, 3, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(12, 15, 0, 2, lvl, 10)
	f.physical_defense = _es(14, 17, 1, 2, lvl, 10)
	f.magic_attack = _es(27, 32, 1, 3, lvl, 10)
	f.magic_defense = _es(16, 19, 1, 2, lvl, 10)
	f.speed = _es(28, 33, 1, 3, lvl, 10)
	f.crit_chance = 6; f.crit_damage = 1; f.dodge_chance = 8
	f.abilities = [EAB.tainted_salve(), EAB.numbing_dust()]
	return f


# =============================================================================
# Prog 10: Cellar discovery (S3_CellarDiscovery)
# =============================================================================

static func create_cellar_watcher(n: String, lvl: int = 11) -> FighterData:
	var f := _base(n, "Cellar Watcher", lvl)
	f.health = _es(180, 210, 4, 7, lvl, 11); f.max_health = f.health
	f.mana = _es(12, 16, 1, 3, lvl, 11); f.max_mana = f.mana
	f.physical_attack = _es(26, 31, 1, 3, lvl, 11)
	f.physical_defense = _es(17, 21, 1, 2, lvl, 11)
	f.magic_attack = _es(24, 29, 1, 3, lvl, 11)
	f.magic_defense = _es(16, 19, 1, 2, lvl, 11)
	f.speed = _es(28, 33, 1, 2, lvl, 11)
	f.crit_chance = 8; f.crit_damage = 1; f.dodge_chance = 7
	f.abilities = [EAB.bound_strike(), EAB.tether_pull()]
	return f


static func create_thread_construct(n: String, lvl: int = 11) -> FighterData:
	var f := _base(n, "Thread Construct", lvl)
	f.health = _es(215, 245, 5, 8, lvl, 11); f.max_health = f.health
	f.mana = _es(6, 10, 1, 2, lvl, 11); f.max_mana = f.mana
	f.physical_attack = _es(30, 35, 2, 3, lvl, 11)
	f.physical_defense = _es(23, 27, 1, 3, lvl, 11)
	f.magic_attack = _es(10, 13, 0, 1, lvl, 11)
	f.magic_defense = _es(18, 21, 1, 2, lvl, 11)
	f.speed = _es(23, 28, 1, 2, lvl, 11)
	f.crit_chance = 5; f.crit_damage = 1; f.dodge_chance = 3
	f.abilities = [EAB.woven_fist(), EAB.reinforced_threads()]
	return f


static func create_ink_shade(n: String, lvl: int = 11) -> FighterData:
	var f := _base(n, "Ink Shade", lvl)
	f.health = _es(160, 185, 3, 6, lvl, 11); f.max_health = f.health
	f.mana = _es(15, 19, 1, 3, lvl, 11); f.max_mana = f.mana
	f.physical_attack = _es(13, 16, 0, 2, lvl, 11)
	f.physical_defense = _es(14, 17, 1, 2, lvl, 11)
	f.magic_attack = _es(29, 34, 1, 3, lvl, 11)
	f.magic_defense = _es(17, 20, 1, 2, lvl, 11)
	f.speed = _es(32, 37, 1, 3, lvl, 11)
	f.crit_chance = 9; f.crit_damage = 1; f.dodge_chance = 12
	f.abilities = [EAB.ink_bolt(), EAB.ink_pool()]
	return f
