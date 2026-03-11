class_name EnemyDBS2Act3

## Story 2 Act III enemy factory: memory sanctum constructs.

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
# Sanctum guardians (levels 10-11) -- used by P10, P11
# =============================================================================

static func create_memory_wisp(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "Memory Wisp", lvl)
	f.health = _es(246, 287, 4, 7, lvl, 10); f.max_health = f.health
	f.mana = _es(26, 32, 2, 3, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(10, 14, 0, 2, lvl, 10)
	f.physical_defense = _es(20, 26, 1, 3, lvl, 10)
	f.magic_attack = _es(67, 78, 2, 4, lvl, 10)
	f.magic_defense = _es(30, 37, 2, 3, lvl, 10)
	f.speed = _es(31, 37, 2, 3, lvl, 10)
	f.crit_chance = 9; f.crit_damage = 2; f.dodge_chance = 16
	f.abilities = [EAB.recall_bolt(), EAB.memory_drain()]
	return f


static func create_echo_sentinel(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "Echo Sentinel", lvl)
	f.health = _es(360, 410, 5, 8, lvl, 10); f.max_health = f.health
	f.mana = _es(12, 16, 1, 2, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(54, 64, 2, 4, lvl, 10)
	f.physical_defense = _es(39, 46, 2, 3, lvl, 10)
	f.magic_attack = _es(8, 12, 0, 1, lvl, 10)
	f.magic_defense = _es(33, 40, 1, 3, lvl, 10)
	f.speed = _es(23, 29, 1, 2, lvl, 10)
	f.crit_chance = 11; f.crit_damage = 2; f.dodge_chance = 5
	f.abilities = [EAB.crystal_strike(), EAB.ward_of_echoes()]
	return f


static func create_thought_eater(n: String, lvl: int = 11) -> FighterData:
	var f := _base(n, "Thought Eater", lvl)
	f.health = _es(318, 366, 4, 7, lvl, 11); f.max_health = f.health
	f.mana = _es(28, 34, 2, 4, lvl, 11); f.max_mana = f.mana
	f.physical_attack = _es(10, 14, 0, 2, lvl, 11)
	f.physical_defense = _es(24, 30, 1, 3, lvl, 11)
	f.magic_attack = _es(77, 89, 2, 5, lvl, 11)
	f.magic_defense = _es(37, 44, 2, 3, lvl, 11)
	f.speed = _es(29, 35, 2, 3, lvl, 11)
	f.crit_chance = 11; f.crit_damage = 2; f.dodge_chance = 12
	f.abilities = [EAB.mind_rend(), EAB.psychic_leech()]
	return f


static func create_grief_shade(n: String, lvl: int = 11) -> FighterData:
	var f := _base(n, "Grief Shade", lvl)
	f.health = _es(273, 314, 4, 6, lvl, 11); f.max_health = f.health
	f.mana = _es(26, 32, 2, 3, lvl, 11); f.max_mana = f.mana
	f.physical_attack = _es(12, 16, 0, 2, lvl, 11)
	f.physical_defense = _es(20, 27, 1, 2, lvl, 11)
	f.magic_attack = _es(66, 76, 2, 4, lvl, 11)
	f.magic_defense = _es(33, 40, 2, 3, lvl, 11)
	f.speed = _es(31, 37, 2, 3, lvl, 11)
	f.crit_chance = 9; f.crit_damage = 2; f.dodge_chance = 18
	f.abilities = [EAB.sorrows_touch(), EAB.wail_of_loss()]
	return f


static func create_hollow_watcher(n: String, lvl: int = 11) -> FighterData:
	var f := _base(n, "Hollow Watcher", lvl)
	f.health = _es(352, 401, 5, 8, lvl, 11); f.max_health = f.health
	f.mana = _es(14, 18, 1, 3, lvl, 11); f.max_mana = f.mana
	f.physical_attack = _es(73, 85, 2, 4, lvl, 11)
	f.physical_defense = _es(34, 41, 2, 3, lvl, 11)
	f.magic_attack = _es(12, 16, 0, 2, lvl, 11)
	f.magic_defense = _es(27, 34, 1, 3, lvl, 11)
	f.speed = _es(27, 33, 1, 3, lvl, 11)
	f.crit_chance = 14; f.crit_damage = 2; f.dodge_chance = 8
	f.abilities = [EAB.blind_strike(), EAB.sense_intent()]
	return f


# =============================================================================
# Deep sanctum enemies (levels 12-13) -- used by P11
# =============================================================================

static func create_mirror_self(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Mirror Self", lvl)
	f.health = _es(361, 412, 5, 8, lvl, 12); f.max_health = f.health
	f.mana = _es(26, 32, 2, 3, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(67, 77, 2, 4, lvl, 12)
	f.physical_defense = _es(33, 41, 2, 3, lvl, 12)
	f.magic_attack = _es(67, 77, 2, 4, lvl, 12)
	f.magic_defense = _es(33, 41, 2, 3, lvl, 12)
	f.speed = _es(31, 37, 2, 3, lvl, 12)
	f.crit_chance = 14; f.crit_damage = 3; f.dodge_chance = 14
	f.abilities = [EAB.mirrored_slash(), EAB.reflected_spell()]
	return f


static func create_void_weaver(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Void Weaver", lvl)
	f.health = _es(323, 367, 4, 7, lvl, 12); f.max_health = f.health
	f.mana = _es(32, 38, 2, 4, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(10, 14, 0, 2, lvl, 12)
	f.physical_defense = _es(26, 33, 1, 3, lvl, 12)
	f.magic_attack = _es(71, 82, 3, 5, lvl, 12)
	f.magic_defense = _es(48, 56, 2, 4, lvl, 12)
	f.speed = _es(29, 35, 2, 3, lvl, 12)
	f.crit_chance = 11; f.crit_damage = 2; f.dodge_chance = 10
	f.abilities = [EAB.void_bolt(), EAB.unravel()]
	return f


static func create_mnemonic_golem(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Mnemonic Golem", lvl)
	f.health = _es(464, 530, 6, 9, lvl, 12); f.max_health = f.health
	f.mana = _es(12, 16, 1, 2, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(97, 112, 3, 5, lvl, 12)
	f.physical_defense = _es(53, 62, 2, 4, lvl, 12)
	f.magic_attack = _es(8, 12, 0, 1, lvl, 12)
	f.magic_defense = _es(42, 49, 2, 3, lvl, 12)
	f.speed = _es(19, 25, 1, 2, lvl, 12)
	f.crit_chance = 13; f.crit_damage = 3; f.dodge_chance = 4
	f.abilities = [EAB.memory_slam(), EAB.crystallize()]
	return f


# =============================================================================
# Act III boss enemies (level 13)
# =============================================================================

static func create_the_warden(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "The Warden", lvl)
	f.health = _es(579, 646, 6, 9, lvl, 13); f.max_health = f.health
	f.mana = _es(30, 36, 2, 4, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(12, 16, 0, 2, lvl, 13)
	f.physical_defense = _es(42, 49, 2, 3, lvl, 13)
	f.magic_attack = _es(101, 116, 3, 5, lvl, 13)
	f.magic_defense = _es(52, 59, 2, 4, lvl, 13)
	f.speed = _es(28, 34, 2, 3, lvl, 13)
	f.crit_chance = 12; f.crit_damage = 3; f.dodge_chance = 10
	f.abilities = [EAB.sanctum_judgment(), EAB.barrier_of_ages(), EAB.purge_thought()]
	return f


static func create_fractured_protector(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "Fractured Protector", lvl)
	f.health = _es(538, 605, 5, 8, lvl, 13); f.max_health = f.health
	f.mana = _es(28, 34, 2, 4, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(88, 102, 2, 4, lvl, 13)
	f.physical_defense = _es(35, 42, 2, 3, lvl, 13)
	f.magic_attack = _es(83, 97, 2, 4, lvl, 13)
	f.magic_defense = _es(38, 45, 2, 3, lvl, 13)
	f.speed = _es(32, 38, 2, 3, lvl, 13)
	f.crit_chance = 14; f.crit_damage = 3; f.dodge_chance = 12
	f.abilities = [EAB.desperate_strike(), EAB.memory_seal(), EAB.forgetting_touch()]
	return f


# =============================================================================
# P9: Beneath the Lighthouse (unique enemies)
# =============================================================================

static func create_fading_wisp(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "Fading Wisp", lvl)
	f.health = _es(215, 250, 4, 7, lvl, 10); f.max_health = f.health  # -6 to -8 HP
	f.mana = _es(26, 32, 2, 3, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(10, 14, 0, 2, lvl, 10)
	f.physical_defense = _es(20, 26, 1, 3, lvl, 10)
	f.magic_attack = _es(66, 76, 2, 4, lvl, 10)  # -1 to -2 Mag ATK
	f.magic_defense = _es(30, 37, 2, 3, lvl, 10)
	f.speed = _es(31, 37, 2, 3, lvl, 10)
	f.crit_chance = 9; f.crit_damage = 2; f.dodge_chance = 16
	f.abilities = [EAB.recall_bolt(), EAB.hallucinate()]  # Replaced debuff with pure damage
	return f


static func create_dim_guardian(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "Dim Guardian", lvl)
	f.health = _es(312, 355, 5, 8, lvl, 10); f.max_health = f.health  # -12 to -14 HP
	f.mana = _es(12, 16, 1, 2, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(53, 63, 2, 4, lvl, 10)  # -1 Phys ATK
	f.physical_defense = _es(39, 46, 2, 3, lvl, 10)
	f.magic_attack = _es(8, 12, 0, 1, lvl, 10)
	f.magic_defense = _es(33, 40, 1, 3, lvl, 10)
	f.speed = _es(23, 29, 1, 2, lvl, 10)
	f.crit_chance = 11; f.crit_damage = 2; f.dodge_chance = 5
	f.abilities = [EAB.crystal_strike(), EAB.gnash()]  # Replaced defense buff with pure damage
	return f


# =============================================================================
# P12 GT: Guardian's Threshold (unique enemies)
# All stats match base Golem/VW/MS exactly, HP -2% only
# =============================================================================

static func create_ward_construct(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Ward Construct", lvl)
	f.health = _es(487, 555, 6, 9, lvl, 12); f.max_health = f.health
	f.mana = _es(12, 16, 1, 2, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(102, 118, 3, 5, lvl, 12)
	f.physical_defense = _es(53, 62, 2, 4, lvl, 12)
	f.magic_attack = _es(8, 12, 0, 1, lvl, 12)
	f.magic_defense = _es(42, 49, 2, 3, lvl, 12)
	f.speed = _es(19, 25, 1, 2, lvl, 12)
	f.crit_chance = 13; f.crit_damage = 3; f.dodge_chance = 4
	f.abilities = [EAB.memory_slam(), EAB.crystallize()]
	return f


static func create_null_phantom(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Null Phantom", lvl)
	f.health = _es(339, 385, 4, 7, lvl, 12); f.max_health = f.health
	f.mana = _es(32, 38, 2, 4, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(10, 14, 0, 2, lvl, 12)
	f.physical_defense = _es(26, 33, 1, 3, lvl, 12)
	f.magic_attack = _es(75, 86, 3, 5, lvl, 12)
	f.magic_defense = _es(48, 56, 2, 4, lvl, 12)
	f.speed = _es(29, 35, 2, 3, lvl, 12)
	f.crit_chance = 11; f.crit_damage = 2; f.dodge_chance = 10
	f.abilities = [EAB.void_bolt(), EAB.unravel()]
	return f


static func create_threshold_echo(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Threshold Echo", lvl)
	f.health = _es(379, 432, 5, 8, lvl, 12); f.max_health = f.health
	f.mana = _es(26, 32, 2, 3, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(70, 81, 2, 4, lvl, 12)
	f.physical_defense = _es(33, 41, 2, 3, lvl, 12)
	f.magic_attack = _es(70, 81, 2, 4, lvl, 12)
	f.magic_defense = _es(33, 41, 2, 3, lvl, 12)
	f.speed = _es(31, 37, 2, 3, lvl, 12)
	f.crit_chance = 14; f.crit_damage = 3; f.dodge_chance = 14
	f.abilities = [EAB.mirrored_slash(), EAB.reflected_spell()]
	return f


# =============================================================================
# P12 FA: Forgotten Archive (unique enemies)
# All stats match base Golem/HW/MW/ES exactly, HP -4% only
# =============================================================================

static func create_archive_keeper(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Archive Keeper", lvl)
	f.health = _es(490, 560, 6, 9, lvl, 12); f.max_health = f.health
	f.mana = _es(12, 16, 1, 2, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(104, 120, 3, 5, lvl, 12)
	f.physical_defense = _es(53, 62, 2, 4, lvl, 12)
	f.magic_attack = _es(8, 12, 0, 1, lvl, 12)
	f.magic_defense = _es(42, 49, 2, 3, lvl, 12)
	f.speed = _es(19, 25, 1, 2, lvl, 12)
	f.crit_chance = 13; f.crit_damage = 3; f.dodge_chance = 4
	f.abilities = [EAB.memory_slam(), EAB.crystallize()]
	return f


static func create_silent_archivist(n: String, lvl: int = 11) -> FighterData:
	var f := _base(n, "Silent Archivist", lvl)
	f.health = _es(372, 424, 5, 8, lvl, 11); f.max_health = f.health
	f.mana = _es(14, 18, 1, 3, lvl, 11); f.max_mana = f.mana
	f.physical_attack = _es(78, 91, 2, 4, lvl, 11)
	f.physical_defense = _es(34, 41, 2, 3, lvl, 11)
	f.magic_attack = _es(12, 16, 0, 2, lvl, 11)
	f.magic_defense = _es(27, 34, 1, 3, lvl, 11)
	f.speed = _es(27, 33, 1, 3, lvl, 11)
	f.crit_chance = 14; f.crit_damage = 2; f.dodge_chance = 8
	f.abilities = [EAB.blind_strike(), EAB.sense_intent()]
	return f


static func create_lost_record(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "Lost Record", lvl)
	f.health = _es(260, 304, 4, 7, lvl, 10); f.max_health = f.health
	f.mana = _es(26, 32, 2, 3, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(10, 14, 0, 2, lvl, 10)
	f.physical_defense = _es(20, 26, 1, 3, lvl, 10)
	f.magic_attack = _es(72, 83, 2, 4, lvl, 10)
	f.magic_defense = _es(30, 37, 2, 3, lvl, 10)
	f.speed = _es(31, 37, 2, 3, lvl, 10)
	f.crit_chance = 9; f.crit_damage = 2; f.dodge_chance = 16
	f.abilities = [EAB.recall_bolt(), EAB.memory_drain()]
	return f


static func create_faded_page(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "Faded Page", lvl)
	f.health = _es(381, 433, 5, 8, lvl, 10); f.max_health = f.health
	f.mana = _es(12, 16, 1, 2, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(58, 68, 2, 4, lvl, 10)
	f.physical_defense = _es(39, 46, 2, 3, lvl, 10)
	f.magic_attack = _es(8, 12, 0, 1, lvl, 10)
	f.magic_defense = _es(33, 40, 1, 3, lvl, 10)
	f.speed = _es(23, 29, 1, 2, lvl, 10)
	f.crit_chance = 11; f.crit_damage = 2; f.dodge_chance = 5
	f.abilities = [EAB.crystal_strike(), EAB.ward_of_echoes()]
	return f
