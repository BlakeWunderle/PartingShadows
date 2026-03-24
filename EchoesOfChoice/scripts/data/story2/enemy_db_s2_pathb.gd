class_name EnemyDBS2PathB

## Story 2 Path B enemy factory: Save Sera route (archive through Unblinking Eye).

const FighterData := preload("res://scripts/data/fighter_data.gd")
const EAB := preload("res://scripts/data/story2/enemy_ability_db_s2_pathb.gd")
const EH := preload("res://scripts/data/enemy_helpers.gd")


# =============================================================================
# Archive Awakening (Prog 13B) -- Sera fight + archive defender
# =============================================================================

static func create_fractured_scholar(n: String, lvl: int = 13) -> FighterData:
	var f := EH.base(n, "Fractured Scholar", lvl)
	f.health = EH.es(610, 685, 5, 8, lvl, 13); f.max_health = f.health
	f.mana = EH.es(17, 20, 1, 2, lvl, 13); f.max_mana = f.mana
	f.physical_attack = EH.es(88, 101, 2, 4, lvl, 13)
	f.physical_defense = EH.es(36, 43, 2, 3, lvl, 13)
	f.magic_attack = EH.es(82, 95, 2, 4, lvl, 13)
	f.magic_defense = EH.es(39, 46, 2, 3, lvl, 13)
	f.speed = EH.es(33, 39, 2, 3, lvl, 13)
	f.crit_chance = 15; f.crit_damage = 3; f.dodge_chance = 14
	f.abilities = [EAB.scholar_strike(), EAB.forgotten_knowledge(), EAB.archive_ward()]
	f.flavor_text = "Sera, driven by instincts she cannot name. She guards the archive's deepest secrets with desperate ferocity, unaware of why they matter."
	return f


static func create_archive_sentinel(n: String, lvl: int = 13) -> FighterData:
	var f := EH.base(n, "Archive Sentinel", lvl)
	f.health = EH.es(530, 600, 5, 8, lvl, 13); f.max_health = f.health
	f.mana = EH.es(10, 13, 1, 2, lvl, 13); f.max_mana = f.mana
	f.physical_attack = EH.es(95, 109, 3, 5, lvl, 13)
	f.physical_defense = EH.es(44, 52, 2, 4, lvl, 13)
	f.magic_attack = EH.es(12, 16, 0, 2, lvl, 13)
	f.magic_defense = EH.es(38, 45, 2, 3, lvl, 13)
	f.speed = EH.es(26, 32, 1, 3, lvl, 13)
	f.crit_chance = 14; f.crit_damage = 3; f.dodge_chance = 11
	f.abilities = [EAB.tome_crush(), EAB.index_lock()]
	f.flavor_text = "A massive automaton built from bound volumes and filing cabinets. It enforces the archive's silence with mechanical precision."
	return f


# =============================================================================
# Lighthouse Core (Prog 14B) -- phys tank / mixed / magic
# =============================================================================

static func create_pipeline_warden(n: String, lvl: int = 14) -> FighterData:
	var f := EH.base(n, "Pipeline Warden", lvl)
	f.health = EH.es(520, 590, 6, 9, lvl, 14); f.max_health = f.health
	f.mana = EH.es(12, 15, 1, 2, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(100, 115, 3, 5, lvl, 14)
	f.physical_defense = EH.es(52, 61, 3, 4, lvl, 14)
	f.magic_attack = EH.es(14, 19, 0, 2, lvl, 14)
	f.magic_defense = EH.es(40, 48, 2, 3, lvl, 14)
	f.speed = EH.es(24, 30, 1, 3, lvl, 14)
	f.crit_chance = 14; f.crit_damage = 3; f.dodge_chance = 10
	f.abilities = [EAB.pipe_smash(), EAB.pressure_seal(), EAB.steam_burst()]
	f.flavor_text = "A hulking construct of iron pipes and crystalline conduits. It patrols the lighthouse's deep machinery with tireless vigilance."
	return f


static func create_maintenance_drone(n: String, lvl: int = 14) -> FighterData:
	var f := EH.base(n, "Maintenance Drone", lvl)
	f.health = EH.es(380, 435, 5, 7, lvl, 14); f.max_health = f.health
	f.mana = EH.es(18, 22, 1, 2, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(55, 64, 2, 4, lvl, 14)
	f.physical_defense = EH.es(30, 37, 2, 3, lvl, 14)
	f.magic_attack = EH.es(58, 67, 2, 4, lvl, 14)
	f.magic_defense = EH.es(35, 42, 2, 3, lvl, 14)
	f.speed = EH.es(34, 40, 2, 3, lvl, 14)
	f.crit_chance = 15; f.crit_damage = 3; f.dodge_chance = 18
	f.abilities = [EAB.calibration_beam(), EAB.repair_pulse()]
	f.flavor_text = "A floating construct designed to maintain the Eye's extraction machinery. Its repair beams are equally effective as weapons."
	return f


static func create_resonance_node(n: String, lvl: int = 14) -> FighterData:
	var f := EH.base(n, "Resonance Node", lvl)
	f.health = EH.es(360, 410, 4, 7, lvl, 14); f.max_health = f.health
	f.mana = EH.es(22, 26, 2, 3, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(14, 19, 0, 2, lvl, 14)
	f.physical_defense = EH.es(28, 35, 2, 3, lvl, 14)
	f.magic_attack = EH.es(90, 104, 3, 5, lvl, 14)
	f.magic_defense = EH.es(45, 53, 2, 4, lvl, 14)
	f.speed = EH.es(30, 36, 2, 3, lvl, 14)
	f.crit_chance = 13; f.crit_damage = 3; f.dodge_chance = 15
	f.abilities = [EAB.resonance_bolt(), EAB.harmonic_disrupt()]
	f.flavor_text = "A crystal amplifier that channels the lighthouse's resonance frequencies. It hums with barely contained power."
	return f


# =============================================================================
# Resonance Chamber (Prog 15B) -- phys / magic / mixed debuffer
# =============================================================================

static func create_eyes_fist(n: String, lvl: int = 14) -> FighterData:
	var f := EH.base(n, "Eye's Fist", lvl)
	f.health = EH.es(545, 620, 6, 9, lvl, 14); f.max_health = f.health
	f.mana = EH.es(11, 14, 1, 2, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(112, 128, 3, 5, lvl, 14)
	f.physical_defense = EH.es(54, 63, 3, 5, lvl, 14)
	f.magic_attack = EH.es(16, 22, 1, 2, lvl, 14)
	f.magic_defense = EH.es(43, 51, 2, 4, lvl, 14)
	f.speed = EH.es(25, 31, 1, 3, lvl, 14)
	f.crit_chance = 15; f.crit_damage = 3; f.dodge_chance = 12
	f.abilities = [EAB.crushing_will(), EAB.attention_lock()]
	f.flavor_text = "The Eye's physical enforcement, a construct of compressed perception given crushing weight. It draws all aggression toward itself."
	return f


static func create_null_sentinel(n: String, lvl: int = 14) -> FighterData:
	var f := EH.base(n, "Null Sentinel", lvl)
	f.health = EH.es(400, 455, 5, 7, lvl, 14); f.max_health = f.health
	f.mana = EH.es(21, 25, 2, 3, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(16, 22, 1, 2, lvl, 14)
	f.physical_defense = EH.es(30, 37, 2, 3, lvl, 14)
	f.magic_attack = EH.es(95, 109, 3, 5, lvl, 14)
	f.magic_defense = EH.es(50, 58, 3, 4, lvl, 14)
	f.speed = EH.es(32, 38, 2, 3, lvl, 14)
	f.crit_chance = 13; f.crit_damage = 3; f.dodge_chance = 17
	f.abilities = [EAB.erasure_beam(), EAB.void_shroud()]
	f.flavor_text = "A sentinel woven from pure negation. It erases incoming attacks with the same ease it erases minds."
	return f


static func create_overload_spark(n: String, lvl: int = 14) -> FighterData:
	var f := EH.base(n, "Overload Spark", lvl)
	f.health = EH.es(370, 420, 4, 7, lvl, 14); f.max_health = f.health
	f.mana = EH.es(18, 22, 1, 2, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(52, 60, 2, 4, lvl, 14)
	f.physical_defense = EH.es(27, 34, 2, 3, lvl, 14)
	f.magic_attack = EH.es(54, 62, 2, 4, lvl, 14)
	f.magic_defense = EH.es(33, 40, 2, 3, lvl, 14)
	f.speed = EH.es(38, 44, 2, 4, lvl, 14)
	f.crit_chance = 16; f.crit_damage = 3; f.dodge_chance = 20
	f.abilities = [EAB.feedback_arc(), EAB.system_shock()]
	f.flavor_text = "A crackling entity born from the resonance overload. It arcs between targets, leaving weakened defenses in its wake."
	return f


# =============================================================================
# Memory Flood (Prog 16B) -- magic AoE / phys / mixed
# =============================================================================

static func create_memory_torrent(n: String, lvl: int = 15) -> FighterData:
	var f := EH.base(n, "Memory Torrent", lvl)
	f.health = EH.es(420, 480, 5, 8, lvl, 15); f.max_health = f.health
	f.mana = EH.es(24, 28, 2, 3, lvl, 15); f.max_mana = f.mana
	f.physical_attack = EH.es(16, 22, 1, 2, lvl, 15)
	f.physical_defense = EH.es(30, 37, 2, 3, lvl, 15)
	f.magic_attack = EH.es(120, 138, 4, 6, lvl, 15)
	f.magic_defense = EH.es(50, 58, 3, 4, lvl, 15)
	f.speed = EH.es(33, 39, 2, 3, lvl, 15)
	f.crit_chance = 14; f.crit_damage = 3; f.dodge_chance = 16
	f.abilities = [EAB.torrent_blast(), EAB.overwhelming_recall()]
	f.flavor_text = "A raging current of unleashed memories, each one a stolen life surging with anguish and confusion."
	return f


static func create_unleashed_recollection(n: String, lvl: int = 15) -> FighterData:
	var f := EH.base(n, "Unleashed Recollection", lvl)
	f.health = EH.es(470, 535, 5, 8, lvl, 15); f.max_health = f.health
	f.mana = EH.es(12, 15, 1, 2, lvl, 15); f.max_mana = f.mana
	f.physical_attack = EH.es(108, 124, 3, 5, lvl, 15)
	f.physical_defense = EH.es(42, 50, 2, 4, lvl, 15)
	f.magic_attack = EH.es(16, 22, 1, 2, lvl, 15)
	f.magic_defense = EH.es(36, 43, 2, 3, lvl, 15)
	f.speed = EH.es(30, 36, 2, 3, lvl, 15)
	f.crit_chance = 16; f.crit_damage = 3; f.dodge_chance = 13
	f.abilities = [EAB.memory_fist(), EAB.shatter_recall()]
	f.flavor_text = "A solid mass of crystallized memory broken free from storage. It crashes through anything in its path with mindless fury."
	return f


static func create_rage_fragment(n: String, lvl: int = 15) -> FighterData:
	var f := EH.base(n, "Rage Fragment", lvl)
	f.health = EH.es(390, 445, 5, 7, lvl, 15); f.max_health = f.health
	f.mana = EH.es(17, 20, 1, 2, lvl, 15); f.max_mana = f.mana
	f.physical_attack = EH.es(72, 83, 3, 5, lvl, 15)
	f.physical_defense = EH.es(28, 35, 2, 3, lvl, 15)
	f.magic_attack = EH.es(74, 85, 3, 5, lvl, 15)
	f.magic_defense = EH.es(32, 39, 2, 3, lvl, 15)
	f.speed = EH.es(40, 46, 3, 4, lvl, 15)
	f.crit_chance = 18; f.crit_damage = 3; f.dodge_chance = 21
	f.abilities = [EAB.fury_spike(), EAB.frenzied_pulse()]
	f.flavor_text = "A shard of pure anger torn from the Eye's psyche. It lashes out at everything, unable to distinguish friend from foe."
	return f


# =============================================================================
# The Unblinking Eye (Prog 17B, solo boss -- stronger than Lidless Eye)
# =============================================================================

static func create_the_unblinking_eye(n: String, lvl: int = 15) -> FighterData:
	var f := EH.base(n, "The Unblinking Eye", lvl)
	f.health = EH.es(1380, 1540, 10, 14, lvl, 15); f.max_health = f.health
	f.mana = EH.es(36, 42, 2, 3, lvl, 15); f.max_mana = f.mana
	f.physical_attack = EH.es(26, 34, 1, 3, lvl, 15)
	f.physical_defense = EH.es(68, 80, 3, 5, lvl, 15)
	f.magic_attack = EH.es(155, 176, 5, 8, lvl, 15)
	f.magic_defense = EH.es(88, 100, 4, 6, lvl, 15)
	f.speed = EH.es(38, 44, 2, 4, lvl, 15)
	f.crit_chance = 18; f.crit_damage = 4; f.dodge_chance = 19
	f.abilities = [EAB.gaze_of_annihilation(), EAB.memory_maelstrom(), EAB.will_of_ages(), EAB.devour_identity(), EAB.unblinking_focus()]
	f.flavor_text = "The Eye of Oblivion at full, terrible power. Not weakened by sacrifice, not diminished by poison. It sees everything and forgets nothing."
	return f
