class_name EnemyDBS3PathB

## Story 3 Path B enemy factory. All unique types for the investigation path.

const FighterData := preload("res://scripts/data/fighter_data.gd")
const EAB := preload("res://scripts/data/story3/enemy_ability_db_s3_pathb.gd")


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
# Prog 11: Bound dream creatures guarding the inn cellar (S3_B_InnSearch)
# =============================================================================

static func create_cellar_sentinel(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Cellar Sentinel", lvl)
	f.health = _es(220, 255, 6, 10, lvl, 12); f.max_health = f.health
	f.mana = _es(12, 16, 1, 2, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(30, 35, 1, 3, lvl, 12)
	f.physical_defense = _es(25, 30, 1, 3, lvl, 12)
	f.magic_attack = _es(15, 20, 1, 2, lvl, 12)
	f.magic_defense = _es(23, 28, 1, 3, lvl, 12)
	f.speed = _es(32, 38, 1, 3, lvl, 12)
	f.crit_chance = 10; f.crit_damage = 1; f.dodge_chance = 8
	f.abilities = [EAB.petrified_slam(), EAB.stagnant_chill()]
	return f


static func create_bound_stalker(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Bound Stalker", lvl)
	f.health = _es(195, 225, 5, 8, lvl, 12); f.max_health = f.health
	f.mana = _es(9, 13, 1, 2, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(32, 37, 2, 3, lvl, 12)
	f.physical_defense = _es(20, 25, 1, 2, lvl, 12)
	f.magic_attack = _es(13, 17, 1, 2, lvl, 12)
	f.magic_defense = _es(18, 23, 1, 2, lvl, 12)
	f.speed = _es(38, 44, 2, 3, lvl, 12)
	f.crit_chance = 14; f.crit_damage = 1; f.dodge_chance = 12
	f.abilities = [EAB.tethered_lunge(), EAB.fraying_bite()]
	return f


# =============================================================================
# Prog 12: Cult members at early strength (S3_B_CultConfrontation)
# =============================================================================

static func create_thread_disciple(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "Thread Disciple", lvl)
	f.health = _es(230, 265, 5, 9, lvl, 13); f.max_health = f.health
	f.mana = _es(13, 17, 1, 2, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(18, 23, 1, 2, lvl, 13)
	f.physical_defense = _es(23, 28, 1, 3, lvl, 13)
	f.magic_attack = _es(35, 40, 2, 3, lvl, 13)
	f.magic_defense = _es(24, 29, 1, 3, lvl, 13)
	f.speed = _es(34, 40, 1, 3, lvl, 13)
	f.crit_chance = 12; f.crit_damage = 1; f.dodge_chance = 9
	f.abilities = [EAB.unstable_channeling(), EAB.siphon_faith()]
	return f


static func create_thread_warden(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "Thread Warden", lvl)
	f.health = _es(270, 310, 7, 11, lvl, 13); f.max_health = f.health
	f.mana = _es(8, 12, 1, 2, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(36, 42, 2, 3, lvl, 13)
	f.physical_defense = _es(30, 35, 2, 3, lvl, 13)
	f.magic_attack = _es(13, 18, 0, 2, lvl, 13)
	f.magic_defense = _es(26, 31, 1, 3, lvl, 13)
	f.speed = _es(31, 37, 1, 2, lvl, 13)
	f.crit_chance = 12; f.crit_damage = 1; f.dodge_chance = 5
	f.abilities = [EAB.shielding_blow(), EAB.guardians_oath()]
	return f


# =============================================================================
# Prog 13: Tunnel breach outer guard (S3_B_TunnelBreach)
# =============================================================================

static func create_tunnel_sentinel(n: String, lvl: int = 14) -> FighterData:
	var f := _base(n, "Tunnel Sentinel", lvl)
	f.health = _es(295, 340, 7, 12, lvl, 14); f.max_health = f.health
	f.mana = _es(9, 13, 1, 2, lvl, 14); f.max_mana = f.mana
	f.physical_attack = _es(40, 46, 2, 4, lvl, 14)
	f.physical_defense = _es(34, 39, 2, 4, lvl, 14)
	f.magic_attack = _es(14, 20, 0, 2, lvl, 14)
	f.magic_defense = _es(26, 31, 1, 3, lvl, 14)
	f.speed = _es(32, 38, 1, 3, lvl, 14)
	f.crit_chance = 11; f.crit_damage = 1; f.dodge_chance = 5
	f.abilities = [EAB.chokepoint_crush(), EAB.passage_block()]
	return f


static func create_thread_sniper(n: String, lvl: int = 14) -> FighterData:
	var f := _base(n, "Thread Sniper", lvl)
	f.health = _es(240, 280, 5, 9, lvl, 14); f.max_health = f.health
	f.mana = _es(20, 25, 2, 3, lvl, 14); f.max_mana = f.mana
	f.physical_attack = _es(16, 22, 1, 2, lvl, 14)
	f.physical_defense = _es(22, 27, 1, 3, lvl, 14)
	f.magic_attack = _es(44, 50, 3, 4, lvl, 14)
	f.magic_defense = _es(30, 35, 1, 4, lvl, 14)
	f.speed = _es(40, 46, 1, 4, lvl, 14)
	f.crit_chance = 14; f.crit_damage = 1; f.dodge_chance = 12
	f.abilities = [EAB.piercing_thread(), EAB.expose_weakness()]
	return f


static func create_pale_devotee(n: String, lvl: int = 14) -> FighterData:
	var f := _base(n, "Pale Devotee", lvl)
	f.health = _es(260, 300, 6, 10, lvl, 14); f.max_health = f.health
	f.mana = _es(18, 22, 2, 3, lvl, 14); f.max_mana = f.mana
	f.physical_attack = _es(18, 24, 1, 2, lvl, 14)
	f.physical_defense = _es(28, 33, 1, 3, lvl, 14)
	f.magic_attack = _es(40, 46, 2, 4, lvl, 14)
	f.magic_defense = _es(32, 37, 2, 4, lvl, 14)
	f.speed = _es(36, 42, 1, 3, lvl, 14)
	f.crit_chance = 12; f.crit_damage = 1; f.dodge_chance = 8
	f.abilities = [EAB.burning_devotion(), EAB.martyrs_gift()]
	return f


# =============================================================================
# Prog 14: Thorne's ward in the passages (S3_B_ThornesWard)
# =============================================================================

static func create_thread_ritualist(n: String, lvl: int = 14) -> FighterData:
	var f := _base(n, "Thread Ritualist", lvl)
	f.health = _es(310, 355, 7, 12, lvl, 14); f.max_health = f.health
	f.mana = _es(20, 25, 2, 3, lvl, 14); f.max_mana = f.mana
	f.physical_attack = _es(22, 28, 1, 3, lvl, 14)
	f.physical_defense = _es(33, 38, 2, 4, lvl, 14)
	f.magic_attack = _es(46, 52, 3, 4, lvl, 14)
	f.magic_defense = _es(36, 41, 2, 4, lvl, 14)
	f.speed = _es(39, 46, 1, 3, lvl, 14)
	f.crit_chance = 14; f.crit_damage = 1; f.dodge_chance = 10
	f.abilities = [EAB.binding_rite(), EAB.enervation_chant()]
	return f


static func create_passage_guardian(n: String, lvl: int = 14) -> FighterData:
	var f := _base(n, "Passage Guardian", lvl)
	f.health = _es(280, 320, 7, 11, lvl, 14); f.max_health = f.health
	f.mana = _es(10, 14, 1, 2, lvl, 14); f.max_mana = f.mana
	f.physical_attack = _es(38, 44, 2, 4, lvl, 14)
	f.physical_defense = _es(32, 37, 2, 4, lvl, 14)
	f.magic_attack = _es(16, 22, 1, 2, lvl, 14)
	f.magic_defense = _es(28, 33, 1, 3, lvl, 14)
	f.speed = _es(34, 40, 1, 3, lvl, 14)
	f.crit_chance = 10; f.crit_damage = 1; f.dodge_chance = 6
	f.abilities = [EAB.champions_cleave(), EAB.loom_aegis()]
	return f


static func create_warding_shadow(n: String, lvl: int = 14) -> FighterData:
	var f := _base(n, "Warding Shadow", lvl)
	f.health = _es(245, 285, 5, 9, lvl, 14); f.max_health = f.health
	f.mana = _es(18, 23, 2, 3, lvl, 14); f.max_mana = f.mana
	f.physical_attack = _es(16, 22, 1, 2, lvl, 14)
	f.physical_defense = _es(24, 29, 1, 3, lvl, 14)
	f.magic_attack = _es(42, 48, 3, 4, lvl, 14)
	f.magic_defense = _es(28, 33, 1, 3, lvl, 14)
	f.speed = _es(38, 44, 1, 4, lvl, 14)
	f.crit_chance = 12; f.crit_damage = 1; f.dodge_chance = 12
	f.abilities = [EAB.flickering_grasp(), EAB.shadow_veil()]
	return f


# =============================================================================
# Prog 14: Shadow Innkeeper and Aldric projection (S3_B_LoomHeart)
# =============================================================================

static func create_shadow_innkeeper(n: String, lvl: int = 15) -> FighterData:
	var f := _base(n, "Shadow Innkeeper", lvl)
	f.health = _es(340, 390, 8, 13, lvl, 15); f.max_health = f.health
	f.mana = _es(18, 23, 2, 3, lvl, 15); f.max_mana = f.mana
	f.physical_attack = _es(30, 36, 1, 3, lvl, 15)
	f.physical_defense = _es(33, 39, 2, 4, lvl, 15)
	f.magic_attack = _es(42, 48, 3, 4, lvl, 15)
	f.magic_defense = _es(33, 39, 2, 4, lvl, 15)
	f.speed = _es(40, 47, 1, 3, lvl, 15)
	f.crit_chance = 15; f.crit_damage = 1; f.dodge_chance = 12
	f.abilities = [EAB.borrowed_face(), EAB.thread_drain()]
	return f


static func create_astral_weaver(n: String, lvl: int = 15) -> FighterData:
	var f := _base(n, "Astral Weaver", lvl)
	f.health = _es(320, 370, 7, 12, lvl, 15); f.max_health = f.health
	f.mana = _es(22, 27, 2, 4, lvl, 15); f.max_mana = f.mana
	f.physical_attack = _es(20, 26, 1, 2, lvl, 15)
	f.physical_defense = _es(30, 36, 1, 4, lvl, 15)
	f.magic_attack = _es(50, 56, 3, 4, lvl, 15)
	f.magic_defense = _es(36, 42, 2, 4, lvl, 15)
	f.speed = _es(42, 49, 1, 3, lvl, 15)
	f.crit_chance = 14; f.crit_damage = 1; f.dodge_chance = 12
	f.abilities = [EAB.astral_barrage(), EAB.cosmic_unraveling()]
	return f


static func create_loom_tendril(n: String, lvl: int = 15) -> FighterData:
	var f := _base(n, "Loom Tendril", lvl)
	f.health = _es(290, 335, 6, 10, lvl, 15); f.max_health = f.health
	f.mana = _es(16, 21, 2, 3, lvl, 15); f.max_mana = f.mana
	f.physical_attack = _es(18, 24, 1, 2, lvl, 15)
	f.physical_defense = _es(25, 31, 1, 3, lvl, 15)
	f.magic_attack = _es(44, 50, 3, 4, lvl, 15)
	f.magic_defense = _es(28, 34, 1, 3, lvl, 15)
	f.speed = _es(40, 46, 1, 3, lvl, 15)
	f.crit_chance = 14; f.crit_damage = 1; f.dodge_chance = 10
	f.abilities = [EAB.siphon_pulse(), EAB.constricting_weave()]
	return f


# =============================================================================
# Prog 15: Lira's dream cathedral guardians (S3_B_DreamInvasion)
# =============================================================================

static func create_cathedral_warden(n: String, lvl: int = 16) -> FighterData:
	var f := _base(n, "Cathedral Warden", lvl)
	f.health = _es(390, 450, 9, 14, lvl, 16); f.max_health = f.health
	f.mana = _es(20, 25, 2, 4, lvl, 16); f.max_mana = f.mana
	f.physical_attack = _es(42, 48, 2, 4, lvl, 16)
	f.physical_defense = _es(36, 42, 3, 4, lvl, 16)
	f.magic_attack = _es(42, 48, 2, 4, lvl, 16)
	f.magic_defense = _es(36, 42, 3, 4, lvl, 16)
	f.speed = _es(40, 47, 1, 3, lvl, 16)
	f.crit_chance = 12; f.crit_damage = 1; f.dodge_chance = 8
	f.abilities = [EAB.consecrated_strike(), EAB.cathedrals_blessing()]
	return f


static func create_dream_binder(n: String, lvl: int = 16) -> FighterData:
	var f := _base(n, "Dream Binder", lvl)
	f.health = _es(320, 370, 6, 10, lvl, 16); f.max_health = f.health
	f.mana = _es(18, 23, 2, 3, lvl, 16); f.max_mana = f.mana
	f.physical_attack = _es(22, 28, 1, 3, lvl, 16)
	f.physical_defense = _es(28, 34, 1, 3, lvl, 16)
	f.magic_attack = _es(46, 52, 3, 4, lvl, 16)
	f.magic_defense = _es(32, 38, 1, 4, lvl, 16)
	f.speed = _es(44, 51, 1, 4, lvl, 16)
	f.crit_chance = 14; f.crit_damage = 1; f.dodge_chance = 14
	f.abilities = [EAB.binding_chains(), EAB.dreamlock()]
	return f


static func create_thread_anchor(n: String, lvl: int = 16) -> FighterData:
	var f := _base(n, "Thread Anchor", lvl)
	f.health = _es(350, 400, 7, 12, lvl, 16); f.max_health = f.health
	f.mana = _es(20, 25, 2, 4, lvl, 16); f.max_mana = f.mana
	f.physical_attack = _es(20, 26, 1, 2, lvl, 16)
	f.physical_defense = _es(32, 38, 2, 4, lvl, 16)
	f.magic_attack = _es(36, 42, 2, 4, lvl, 16)
	f.magic_defense = _es(34, 40, 2, 4, lvl, 16)
	f.speed = _es(36, 42, 1, 3, lvl, 16)
	f.crit_chance = 8; f.crit_damage = 1; f.dodge_chance = 6
	f.abilities = [EAB.anchor_pulse(), EAB.fortifying_thread()]
	return f


# =============================================================================
# Prog 17: Lira boss and minions (S3_B_DreamNexus)
# =============================================================================

static func create_lira_threadmaster(n: String, lvl: int = 18) -> FighterData:
	var f := _base(n, "Lira, the Threadmaster", lvl)
	f.health = _es(541, 617, 15, 22, lvl, 18); f.max_health = f.health
	f.mana = _es(35, 40, 4, 6, lvl, 18); f.max_mana = f.mana
	f.physical_attack = _es(59, 66, 3, 6, lvl, 18)
	f.physical_defense = _es(44, 50, 3, 5, lvl, 18)
	f.magic_attack = _es(65, 71, 4, 6, lvl, 18)
	f.magic_defense = _es(44, 50, 3, 5, lvl, 18)
	f.speed = _es(53, 60, 3, 5, lvl, 18)
	f.crit_chance = 22; f.crit_damage = 2; f.dodge_chance = 15
	f.abilities = [EAB.thread_puppetry(), EAB.dreamers_harvest(), EAB.liras_loom()]
	return f


static func create_tattered_deception(n: String, lvl: int = 18) -> FighterData:
	var f := _base(n, "Tattered Deception", lvl)
	f.health = _es(300, 345, 7, 11, lvl, 18); f.max_health = f.health
	f.mana = _es(16, 21, 1, 3, lvl, 18); f.max_mana = f.mana
	f.physical_attack = _es(28, 34, 1, 3, lvl, 18)
	f.physical_defense = _es(30, 36, 1, 4, lvl, 18)
	f.magic_attack = _es(48, 54, 3, 5, lvl, 18)
	f.magic_defense = _es(34, 40, 1, 4, lvl, 18)
	f.speed = _es(50, 58, 3, 5, lvl, 18)
	f.crit_chance = 18; f.crit_damage = 1; f.dodge_chance = 18
	f.abilities = [EAB.mirrored_assault(), EAB.unraveling_touch()]
	return f


static func create_dream_bastion(n: String, lvl: int = 18) -> FighterData:
	var f := _base(n, "Dream Bastion", lvl)
	f.health = _es(310, 355, 8, 12, lvl, 18); f.max_health = f.health
	f.mana = _es(14, 19, 1, 3, lvl, 18); f.max_mana = f.mana
	f.physical_attack = _es(50, 56, 3, 5, lvl, 18)
	f.physical_defense = _es(42, 48, 3, 5, lvl, 18)
	f.magic_attack = _es(28, 34, 1, 4, lvl, 18)
	f.magic_defense = _es(38, 44, 2, 4, lvl, 18)
	f.speed = _es(42, 49, 2, 4, lvl, 18)
	f.crit_chance = 12; f.crit_damage = 1; f.dodge_chance = 6
	f.abilities = [EAB.bastion_slam(), EAB.nexus_shield()]
	return f
