class_name EnemyDBS3Act3

## Story 3 Act III enemy factory. Cult dream guardians.
## T2 rebalance: stats scaled to match T2 player power levels.

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
# Prog 11 (S3_LucidDream): target 54%, 12 level-ups
# Prog 12 (S3_DreamTemple/DreamVoid): target 52%, 13 level-ups
# Prog 13 (S3_DreamSanctum): target 50%, 14 level-ups (boss)
# =============================================================================

# Shared Prog 11 & 12 -- mage phantom (fast magic DPS)
# Reverted to exact 76ae97b baseline for reproducibility check
static func create_lucid_phantom(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Lucid Phantom", lvl)
	f.health = _es(405, 465, 5, 8, lvl, 12); f.max_health = f.health
	f.mana = _es(30, 36, 2, 4, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(10, 14, 0, 2, lvl, 12)
	f.physical_defense = _es(28, 35, 2, 3, lvl, 12)
	f.magic_attack = _es(74, 86, 3, 5, lvl, 12)
	f.magic_defense = _es(37, 44, 2, 3, lvl, 12)
	f.speed = _es(33, 39, 2, 3, lvl, 12)
	f.crit_chance = 14; f.crit_damage = 2; f.dodge_chance = 13
	f.abilities = [EAB.mind_spike(), EAB.phase_shift()]
	f.flavor_text = "A phantom born from a dreamer who achieved lucidity but lost themselves in it. It wields focused thought like a weapon, phasing through attacks with terrifying ease."
	return f


# Shared Prog 11 & 12 -- support healer (mage support)
# Reverted to exact 76ae97b baseline
static func create_thread_spinner(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Thread Spinner", lvl)
	f.health = _es(450, 518, 5, 8, lvl, 12); f.max_health = f.health
	f.mana = _es(32, 38, 2, 4, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(10, 14, 0, 2, lvl, 12)
	f.physical_defense = _es(34, 41, 2, 3, lvl, 12)
	f.magic_attack = _es(66, 77, 2, 4, lvl, 12)
	f.magic_defense = _es(41, 48, 2, 3, lvl, 12)
	f.speed = _es(30, 36, 2, 3, lvl, 12)
	f.crit_chance = 12; f.crit_damage = 2; f.dodge_chance = 9
	f.abilities = [EAB.woven_mend(), EAB.thread_snare()]
	f.flavor_text = "A cult artisan who repairs the dream's fabric even as intruders tear through it. Its threads can mend allies or bind foes with equal skill."
	return f


# Prog 12 DreamTemple only -- physical tank
# Interpolated f=0.838 between 91.7% and 44.3% data points
static func create_loom_sentinel(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "Loom Sentinel", lvl)
	f.health = _es(530, 608, 5, 8, lvl, 13); f.max_health = f.health
	f.mana = _es(14, 18, 1, 2, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(80, 93, 3, 5, lvl, 13)
	f.physical_defense = _es(45, 53, 2, 3, lvl, 13)
	f.magic_attack = _es(8, 12, 0, 1, lvl, 13)
	f.magic_defense = _es(37, 44, 2, 3, lvl, 13)
	f.speed = _es(24, 30, 1, 2, lvl, 13)
	f.crit_chance = 14; f.crit_damage = 2; f.dodge_chance = 5
	f.abilities = [EAB.loom_strike(), EAB.woven_armor()]
	f.flavor_text = "A towering automaton built around the skeleton of a great loom. Its strikes carry the weight of compacted dream-thread, and its woven armor turns aside all but the strongest blows."
	return f


# Shared Prog 11 & 13 -- magic DPS (glass cannon caster)
# Reverted to exact 76ae97b baseline
static func create_cult_shade(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Cult Shade", lvl)
	f.health = _es(375, 434, 4, 7, lvl, 12); f.max_health = f.health
	f.mana = _es(30, 36, 2, 4, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(10, 14, 0, 2, lvl, 12)
	f.physical_defense = _es(24, 30, 1, 3, lvl, 12)
	f.magic_attack = _es(78, 90, 3, 5, lvl, 12)
	f.magic_defense = _es(35, 42, 2, 3, lvl, 12)
	f.speed = _es(33, 39, 2, 3, lvl, 12)
	f.crit_chance = 14; f.crit_damage = 2; f.dodge_chance = 14
	f.abilities = [EAB.dark_thread(), EAB.unravel_mind()]
	f.flavor_text = "A hooded cultist who channels forbidden thread-magic through rituals of devotion. It unravels the minds of its enemies, leaving them confused and vulnerable."
	return f


# Shared Prog 12 & 13 -- hybrid fighter (balanced physical/magic)
# Interpolated f=0.838 between 91.7% and 44.3% data points
static func create_dream_warden(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "Dream Warden", lvl)
	f.health = _es(466, 537, 5, 8, lvl, 13); f.max_health = f.health
	f.mana = _es(28, 34, 2, 3, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(69, 80, 2, 4, lvl, 13)
	f.physical_defense = _es(36, 43, 2, 3, lvl, 13)
	f.magic_attack = _es(69, 80, 2, 4, lvl, 13)
	f.magic_defense = _es(36, 43, 2, 3, lvl, 13)
	f.speed = _es(31, 37, 2, 3, lvl, 13)
	f.crit_chance = 14; f.crit_damage = 2; f.dodge_chance = 11
	f.abilities = [EAB.ward_pulse(), EAB.binding_light()]
	f.flavor_text = "An imposing guardian who patrols the border between the waking world and the cult's dream domain. It fights with both blade and binding light to repel all trespassers."
	return f


# Prog 12 DreamTemple only -- magic DPS
# Interpolated f=0.838 between 91.7% and 44.3% data points
static func create_thought_leech(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "Thought Leech", lvl)
	f.health = _es(413, 476, 5, 8, lvl, 13); f.max_health = f.health
	f.mana = _es(30, 36, 2, 4, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(10, 14, 0, 2, lvl, 13)
	f.physical_defense = _es(29, 36, 1, 3, lvl, 13)
	f.magic_attack = _es(75, 87, 3, 5, lvl, 13)
	f.magic_defense = _es(39, 47, 2, 3, lvl, 13)
	f.speed = _es(31, 37, 2, 3, lvl, 13)
	f.crit_chance = 13; f.crit_damage = 2; f.dodge_chance = 10
	f.abilities = [EAB.psychic_siphon(), EAB.mind_fog()]
	f.flavor_text = "A parasitic entity that attaches to the psyche and drains thought and willpower. Its victims stumble in a fog of confusion, unable to think clearly or act decisively."
	return f


# Prog 12 DreamVoid only -- magic DPS (void caster)
# Interpolated: baseline 69.2% -> overbuffed 27.5%, f=0.588 for target 52%
static func create_void_spinner(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "Void Spinner", lvl)
	f.health = _es(468, 537, 5, 8, lvl, 13); f.max_health = f.health
	f.mana = _es(32, 38, 2, 4, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(10, 14, 0, 2, lvl, 13)
	f.physical_defense = _es(33, 40, 2, 3, lvl, 13)
	f.magic_attack = _es(81, 94, 3, 5, lvl, 13)
	f.magic_defense = _es(46, 54, 2, 3, lvl, 13)
	f.speed = _es(36, 42, 2, 3, lvl, 13)
	f.crit_chance = 15; f.crit_damage = 2; f.dodge_chance = 12
	f.abilities = [EAB.void_thread(), EAB.nullify()]
	f.flavor_text = "A caster that draws power from the void between dreams, where nothing exists and all things unravel. Its threads nullify magic and dissolve protections on contact."
	return f


# Prog 13 boss -- balanced boss (Sanctum Guardian)
# Buffed slightly: DreamSanctum 53.8% too easy, target 50%
static func create_sanctum_guardian(n: String, lvl: int = 14) -> FighterData:
	var f := _base(n, "Sanctum Guardian", lvl)
	f.health = _es(630, 712, 6, 9, lvl, 14); f.max_health = f.health
	f.mana = _es(32, 38, 2, 4, lvl, 14); f.max_mana = f.mana
	f.physical_attack = _es(78, 90, 3, 5, lvl, 14)
	f.physical_defense = _es(43, 51, 2, 3, lvl, 14)
	f.magic_attack = _es(78, 90, 3, 5, lvl, 14)
	f.magic_defense = _es(43, 51, 2, 3, lvl, 14)
	f.speed = _es(32, 38, 2, 3, lvl, 14)
	f.crit_chance = 16; f.crit_damage = 3; f.dodge_chance = 10
	f.abilities = [EAB.loom_slam(), EAB.thread_storm(), EAB.guardians_veil()]
	f.flavor_text = "The final ward of the dream sanctum, a colossal being of interwoven threads and crystallized will. It fights with the combined resolve of every cultist who has prayed at the loom."
	return f
