class_name EnemyDBS3Act3

## Story 3 Act III enemy factory. Cult dream guardians.

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
# Act III: Cult dream guardians (Progression 11-13)
# Per-enemy calibration from R4/R5 interpolation.
# Shared enemies constrained; non-shared tuned per-battle.
# =============================================================================

# Shared Prog 11 & 12 (+39%)
static func create_lucid_phantom(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Lucid Phantom", lvl)
	f.health = _es(614, 704, 6, 10, lvl, 12); f.max_health = f.health
	f.mana = _es(16, 20, 1, 3, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(23, 28, 1, 3, lvl, 12)
	f.physical_defense = _es(25, 30, 1, 3, lvl, 12)
	f.magic_attack = _es(39, 44, 3, 4, lvl, 12)
	f.magic_defense = _es(28, 33, 1, 4, lvl, 12)
	f.speed = _es(41, 47, 1, 4, lvl, 12)
	f.crit_chance = 12; f.crit_damage = 1; f.dodge_chance = 16
	f.abilities = [EAB.mind_spike(), EAB.phase_shift()]
	return f


# Shared Prog 11 & 12 (+39%)
static func create_thread_spinner(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Thread Spinner", lvl)
	f.health = _es(627, 722, 6, 10, lvl, 12); f.max_health = f.health
	f.mana = _es(18, 23, 2, 3, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(20, 25, 1, 3, lvl, 12)
	f.physical_defense = _es(28, 33, 1, 4, lvl, 12)
	f.magic_attack = _es(31, 37, 1, 4, lvl, 12)
	f.magic_defense = _es(30, 36, 1, 4, lvl, 12)
	f.speed = _es(36, 42, 1, 3, lvl, 12)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 8
	f.abilities = [EAB.woven_mend(), EAB.thread_snare()]
	return f


# Prog 12 DreamTemple only (+25%)
static func create_loom_sentinel(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "Loom Sentinel", lvl)
	f.health = _es(566, 648, 8, 13, lvl, 13); f.max_health = f.health
	f.mana = _es(13, 18, 1, 2, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(38, 44, 3, 4, lvl, 13)
	f.physical_defense = _es(33, 38, 3, 4, lvl, 13)
	f.magic_attack = _es(19, 24, 1, 2, lvl, 13)
	f.magic_defense = _es(30, 35, 1, 4, lvl, 13)
	f.speed = _es(33, 39, 1, 3, lvl, 13)
	f.crit_chance = 10; f.crit_damage = 1; f.dodge_chance = 4
	f.abilities = [EAB.loom_strike(), EAB.woven_armor()]
	return f


# Shared Prog 11 & 13 (+33%)
static func create_cult_shade(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Cult Shade", lvl)
	f.health = _es(507, 590, 5, 9, lvl, 12); f.max_health = f.health
	f.mana = _es(18, 23, 2, 3, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(18, 23, 1, 3, lvl, 12)
	f.physical_defense = _es(23, 28, 1, 3, lvl, 12)
	f.magic_attack = _es(43, 48, 3, 4, lvl, 12)
	f.magic_defense = _es(25, 30, 1, 3, lvl, 12)
	f.speed = _es(38, 44, 1, 4, lvl, 12)
	f.crit_chance = 12; f.crit_damage = 1; f.dodge_chance = 10
	f.abilities = [EAB.dark_thread(), EAB.unravel_mind()]
	return f


# Shared Prog 12 & 13 (+12%)
static func create_dream_warden(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "Dream Warden", lvl)
	f.health = _es(477, 540, 6, 10, lvl, 13); f.max_health = f.health
	f.mana = _es(15, 20, 1, 3, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(30, 35, 1, 4, lvl, 13)
	f.physical_defense = _es(29, 34, 2, 4, lvl, 13)
	f.magic_attack = _es(35, 40, 1, 4, lvl, 13)
	f.magic_defense = _es(27, 32, 1, 4, lvl, 13)
	f.speed = _es(37, 43, 1, 3, lvl, 13)
	f.crit_chance = 10; f.crit_damage = 1; f.dodge_chance = 8
	f.abilities = [EAB.ward_pulse(), EAB.binding_light()]
	return f


# Prog 12 DreamTemple only (+25%)
static func create_thought_leech(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "Thought Leech", lvl)
	f.health = _es(477, 549, 5, 9, lvl, 13); f.max_health = f.health
	f.mana = _es(20, 25, 2, 3, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(19, 24, 1, 2, lvl, 13)
	f.physical_defense = _es(23, 28, 1, 2, lvl, 13)
	f.magic_attack = _es(39, 44, 2, 4, lvl, 13)
	f.magic_defense = _es(28, 33, 1, 4, lvl, 13)
	f.speed = _es(34, 41, 1, 3, lvl, 13)
	f.crit_chance = 10; f.crit_damage = 1; f.dodge_chance = 10
	f.abilities = [EAB.psychic_siphon(), EAB.mind_fog()]
	return f


# Prog 12 DreamVoid only (+32%)
static func create_void_spinner(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "Void Spinner", lvl)
	f.health = _es(525, 600, 7, 9, lvl, 13); f.max_health = f.health
	f.mana = _es(21, 25, 2, 4, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(17, 23, 0, 3, lvl, 13)
	f.physical_defense = _es(27, 33, 1, 3, lvl, 13)
	f.magic_attack = _es(46, 52, 3, 4, lvl, 13)
	f.magic_defense = _es(33, 38, 1, 4, lvl, 13)
	f.speed = _es(41, 48, 1, 4, lvl, 13)
	f.crit_chance = 11; f.crit_damage = 1; f.dodge_chance = 8
	f.abilities = [EAB.void_thread(), EAB.nullify()]
	return f


# Prog 13 boss (−4%)
static func create_sanctum_guardian(n: String, lvl: int = 14) -> FighterData:
	var f := _base(n, "Sanctum Guardian", lvl)
	f.health = _es(553, 638, 10, 15, lvl, 14); f.max_health = f.health
	f.mana = _es(25, 30, 2, 5, lvl, 14); f.max_mana = f.mana
	f.physical_attack = _es(43, 48, 2, 4, lvl, 14)
	f.physical_defense = _es(32, 37, 3, 4, lvl, 14)
	f.magic_attack = _es(43, 48, 2, 4, lvl, 14)
	f.magic_defense = _es(32, 37, 3, 4, lvl, 14)
	f.speed = _es(42, 48, 2, 4, lvl, 14)
	f.crit_chance = 12; f.crit_damage = 2; f.dodge_chance = 11
	f.abilities = [EAB.loom_slam(), EAB.thread_storm(), EAB.guardians_veil()]
	return f
