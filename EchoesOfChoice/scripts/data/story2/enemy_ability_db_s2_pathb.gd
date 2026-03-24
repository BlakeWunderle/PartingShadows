class_name EnemyAbilityDBS2PathB

## Story 2 Path B enemy abilities (archive awakening through Unblinking Eye).

const AbilityData := preload("res://scripts/data/ability_data.gd")
const Enums := preload("res://scripts/data/enums.gd")
const AbilityDB := preload("res://scripts/data/ability_db.gd")


static func _make(p_name: String, flavor: String, stat: Enums.StatType, mod: int,
		turns: int, on_enemy: bool, cost: int, all: bool = false,
		dot: int = 0, steal: float = 0.0) -> AbilityData:
	return AbilityDB._make(p_name, flavor, stat, mod, turns, on_enemy, cost, all, dot, steal)


# =============================================================================
# Fractured Scholar (Sera variant)
# =============================================================================

static func scholar_strike() -> AbilityData:
	return _make("Scholar's Strike", "A precise blow guided by fractured instinct.", Enums.StatType.PHYSICAL_ATTACK, 11, 0, true, 4, false, 0, 0.0)

static func forgotten_knowledge() -> AbilityData:
	return _make("Forgotten Knowledge", "Fragments of lost expertise manifest as cutting insight.", Enums.StatType.MAGIC_ATTACK, 9, 0, true, 4, false, 0, 0.3)

static func archive_ward() -> AbilityData:
	return _make("Archive Ward", "Shelves of records form a protective barrier.", Enums.StatType.DEFENSE, 5, 2, false, 3, false, 0, 0.0)


# =============================================================================
# Archive Sentinel
# =============================================================================

static func tome_crush() -> AbilityData:
	return _make("Tome Crush", "A massive bound volume slams down with the weight of centuries.", Enums.StatType.PHYSICAL_ATTACK, 10, 0, true, 3, false, 0, 0.0)

static func index_lock() -> AbilityData:
	return _make("Index Lock", "The archive's cataloging system ensnares the target.", Enums.StatType.SPEED, 5, 2, true, 3, false, 0, 0.0)


# =============================================================================
# Pipeline Warden (phys tank)
# =============================================================================

static func pipe_smash() -> AbilityData:
	return _make("Pipe Smash", "A heavy conduit pipe swings with industrial force.", Enums.StatType.PHYSICAL_ATTACK, 11, 0, true, 4, false, 0, 0.0)

static func pressure_seal() -> AbilityData:
	return _make("Pressure Seal", "High-pressure steam vents harden into a shield.", Enums.StatType.DEFENSE, 6, 2, false, 4, false, 0, 0.0)

static func steam_burst() -> AbilityData:
	return _make("Steam Burst", "Superheated steam erupts from ruptured pipes.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, true, 0, 0.0)


# =============================================================================
# Maintenance Drone (mixed)
# =============================================================================

static func calibration_beam() -> AbilityData:
	return _make("Calibration Beam", "A precise beam of resonance energy meant for machinery but lethal to flesh.", Enums.StatType.MIXED_ATTACK, 9, 0, true, 4, false, 0, 0.0)

static func repair_pulse() -> AbilityData:
	return _make("Repair Pulse", "A restorative pulse designed to mend extraction equipment.", Enums.StatType.HEAL, 12, 0, false, 3, false, 0, 0.0)


# =============================================================================
# Resonance Node (magic)
# =============================================================================

static func resonance_bolt() -> AbilityData:
	return _make("Resonance Bolt", "A focused pulse of harmonic energy.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 4, false, 0, 0.0)

static func harmonic_disrupt() -> AbilityData:
	return _make("Harmonic Disruption", "Dissonant frequencies weaken magical wards.", Enums.StatType.MAGIC_DEFENSE, 5, 2, true, 3, true, 0, 0.0)


# =============================================================================
# Eye's Fist (phys)
# =============================================================================

static func crushing_will() -> AbilityData:
	return _make("Crushing Will", "The Eye's concentrated attention given physical form.", Enums.StatType.PHYSICAL_ATTACK, 12, 0, true, 4, false, 0, 0.0)

static func attention_lock() -> AbilityData:
	return _make("Attention Lock", "The full weight of the Eye's focus pins the target.", Enums.StatType.TAUNT, 1, 2, false, 3, false, 0, 0.0)


# =============================================================================
# Null Sentinel (magic)
# =============================================================================

static func erasure_beam() -> AbilityData:
	return _make("Erasure Beam", "A beam that unmakes thought and memory alike.", Enums.StatType.MAGIC_ATTACK, 11, 0, true, 4, false, 0, 0.0)

static func void_shroud() -> AbilityData:
	return _make("Void Shroud", "A cloak of nonexistence absorbs incoming attacks.", Enums.StatType.DEFENSE, 6, 2, false, 4, false, 0, 0.0)


# =============================================================================
# Overload Spark (mixed debuffer)
# =============================================================================

static func feedback_arc() -> AbilityData:
	return _make("Feedback Arc", "Overloaded memory energy arcs between targets.", Enums.StatType.MIXED_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func system_shock() -> AbilityData:
	return _make("System Shock", "A cascade failure that weakens all enemies.", Enums.StatType.ATTACK, 5, 2, true, 4, true, 0, 0.0)


# =============================================================================
# Memory Torrent (magic AoE)
# =============================================================================

static func torrent_blast() -> AbilityData:
	return _make("Torrent Blast", "A flood of unprocessed memories strikes everything in its path.", Enums.StatType.MAGIC_ATTACK, 9, 0, true, 4, true, 0, 0.0)

static func overwhelming_recall() -> AbilityData:
	return _make("Overwhelming Recall", "Stolen memories cascade through the mind, drowning out thought.", Enums.StatType.MAGIC_ATTACK, 12, 0, true, 3, false, 0, 0.0)


# =============================================================================
# Unleashed Recollection (phys)
# =============================================================================

static func memory_fist() -> AbilityData:
	return _make("Memory Fist", "A solid mass of crystallized recollection strikes with terrible force.", Enums.StatType.PHYSICAL_ATTACK, 11, 0, true, 4, false, 0, 0.0)

static func shatter_recall() -> AbilityData:
	return _make("Shatter Recall", "The recollection explodes into fragments that tear through defenses.", Enums.StatType.DEFENSE, 5, 2, true, 3, false, 0, 0.0)


# =============================================================================
# Rage Fragment (mixed)
# =============================================================================

static func fury_spike() -> AbilityData:
	return _make("Fury Spike", "Concentrated rage crystallized into a piercing lance.", Enums.StatType.MIXED_ATTACK, 10, 0, true, 4, false, 0, 0.0)

static func frenzied_pulse() -> AbilityData:
	return _make("Frenzied Pulse", "An unstable burst of emotion damages all enemies.", Enums.StatType.MIXED_ATTACK, 7, 0, true, 3, true, 0, 0.0)


# =============================================================================
# The Unblinking Eye (solo boss -- stronger than Lidless Eye)
# =============================================================================

static func gaze_of_annihilation() -> AbilityData:
	return _make("Gaze of Annihilation", "The Eye turns its full, undiminished attention on one target.", Enums.StatType.MAGIC_ATTACK, 16, 0, true, 4, false, 0, 0.0)

static func memory_maelstrom() -> AbilityData:
	return _make("Memory Maelstrom", "A storm of regurgitated memories bludgeons all enemies.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 4, true, 0, 0.0)

static func will_of_ages() -> AbilityData:
	return _make("Will of Ages", "Centuries of accumulated power harden into impenetrable resolve.", Enums.StatType.DEFENSE, 7, 2, false, 4, false, 0, 0.0)

static func devour_identity() -> AbilityData:
	return _make("Devour Identity", "The Eye consumes what makes you you.", Enums.StatType.MAGIC_ATTACK, 13, 0, true, 3, false, 0, 0.4)

static func unblinking_focus() -> AbilityData:
	return _make("Unblinking Focus", "The Eye's gaze intensifies, stripping away all magical protection.", Enums.StatType.ATTACK, 6, 2, true, 3, true, 0, 0.0)
