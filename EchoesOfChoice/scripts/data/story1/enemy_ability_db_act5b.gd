class_name EnemyAbilityDBAct5B

## Story 1 Act V Path B enemy abilities (ritual anchor, sanctum collapse, stranger undone).

const AbilityData := preload("res://scripts/data/ability_data.gd")
const Enums := preload("res://scripts/data/enums.gd")
const AbilityDB := preload("res://scripts/data/ability_db.gd")


static func _make(p_name: String, flavor: String, stat: Enums.StatType, mod: int,
		turns: int, on_enemy: bool, cost: int, all: bool = false,
		dot: int = 0, steal: float = 0.0) -> AbilityData:
	return AbilityDB._make(p_name, flavor, stat, mod, turns, on_enemy, cost, all, dot, steal)


# =============================================================================
# Sigil Colossus (physical tank)
# =============================================================================

static func sigil_crush() -> AbilityData:
	return _make("Sigil Crush", "A rune-covered fist smashes downward.", Enums.StatType.PHYSICAL_ATTACK, 11, 0, true, 4, false, 0, 0.0)

static func anchor_pulse() -> AbilityData:
	return _make("Anchor Pulse", "The ritual pillar releases a shockwave.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, true, 0, 0.0)

static func sigil_ward() -> AbilityData:
	return _make("Sigil Ward", "Glowing wards harden around the construct.", Enums.StatType.DEFENSE, 6, 2, false, 4, false, 0, 0.0)


# =============================================================================
# Ritual Conduit (magic healer)
# =============================================================================

static func conduit_beam() -> AbilityData:
	return _make("Conduit Beam", "A focused beam of ritual energy.", Enums.StatType.MAGIC_ATTACK, 9, 0, true, 3, false, 0, 0.0)

static func mending_sigil() -> AbilityData:
	return _make("Mending Sigil", "A restorative glyph knits wounds closed.", Enums.StatType.HEALTH, 14, 0, false, 4, false, 0, 0.0)

static func ritual_shield() -> AbilityData:
	return _make("Ritual Shield", "A barrier of ritual light protects allies.", Enums.StatType.DEFENSE, 5, 2, false, 3, true, 0, 0.0)


# =============================================================================
# Void Sentinel (mixed DPS)
# =============================================================================

static func void_slash() -> AbilityData:
	return _make("Void Slash", "A blade of compressed nothing cuts through armor and ward alike.", Enums.StatType.MIXED_ATTACK, 10, 0, true, 4, false, 0, 0.0)

static func nullfield() -> AbilityData:
	return _make("Nullfield", "A field of void energy suppresses all defenses.", Enums.StatType.DEFENSE, 5, 2, true, 3, true, 0, 0.0)


# =============================================================================
# Void Horror (magic burst)
# =============================================================================

static func void_eruption() -> AbilityData:
	return _make("Void Eruption", "Raw void energy explodes outward.", Enums.StatType.MAGIC_ATTACK, 12, 0, true, 4, true, 0, 0.0)

static func terror_gaze() -> AbilityData:
	return _make("Terror Gaze", "Eyes of the void sap the will to fight.", Enums.StatType.ATTACK, 6, 2, true, 3, false, 0, 0.0)


# =============================================================================
# Fractured Shadow (fast physical)
# =============================================================================

static func shadow_rend() -> AbilityData:
	return _make("Shadow Rend", "Claws of fragmenting shadow tear through flesh.", Enums.StatType.PHYSICAL_ATTACK, 10, 0, true, 3, false, 0, 0.0)

static func flickerstrike() -> AbilityData:
	return _make("Flickerstrike", "A blink-fast assault from shifting darkness.", Enums.StatType.PHYSICAL_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func speed_siphon() -> AbilityData:
	return _make("Speed Siphon", "Drains the target's reflexes.", Enums.StatType.SPEED, 5, 2, true, 3, false, 0, 0.0)


# =============================================================================
# Shadow Remnant (debuffer)
# =============================================================================

static func fading_curse() -> AbilityData:
	return _make("Fading Curse", "A decaying hex gnaws at strength.", Enums.StatType.ATTACK, 5, 2, true, 3, true, 0, 0.0)

static func remnant_bolt() -> AbilityData:
	return _make("Remnant Bolt", "A shard of dying shadow strikes the mind.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func dissolution() -> AbilityData:
	return _make("Dissolution", "The target's armor softens and crumbles.", Enums.StatType.DEFENSE, 6, 2, true, 3, false, 0, 0.0)


# =============================================================================
# Stranger Undone (solo boss -- faster, crittier, weaker)
# =============================================================================

static func desperate_strike() -> AbilityData:
	return _make("Desperate Strike", "A wild, uncontrolled swing of raw power.", Enums.StatType.MIXED_ATTACK, 12, 0, true, 3, false, 0, 0.0)

static func unraveling() -> AbilityData:
	return _make("Unraveling", "The Stranger's fading power lashes out at all enemies.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 4, true, 0, 0.0)

static func last_refuge() -> AbilityData:
	return _make("Last Refuge", "A thin barrier of shadow, barely holding.", Enums.StatType.DEFENSE, 5, 2, false, 3, false, 0, 0.0)

static func entropy_spike() -> AbilityData:
	return _make("Entropy Spike", "A concentrated lance of entropy pierces through.", Enums.StatType.MAGIC_ATTACK, 14, 0, true, 4, false, 0, 0.0)

# --- Stranger Undone boss kit (5-ability redesign) ---

static func shadow_remnant_strike() -> AbilityData:
	return _make("Shadow Remnant", "A weakened slash of the void, still carrying the Stranger's spite.", Enums.StatType.MIXED_ATTACK, 14, 0, true, 3, false, 0, 0.0)

static func void_drain() -> AbilityData:
	return _make("Void Drain", "He feeds on what little void power remains, desperately sustaining himself.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 3, false, 0, 0.4)

static func crumbling_shield() -> AbilityData:
	return _make("Crumbling Shield", "A thin wall of shadow rises around him, barely holding together.", Enums.StatType.DEFENSE, 5, 2, false, 3, false, 0, 0.0)

static func final_echo() -> AbilityData:
	return _make("Final Echo", "A last desperate pulse of dark energy lashes out at everything.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 4, true, 0, 0.0)

static func desperation() -> AbilityData:
	return _make("Desperation", "Cornered and undone, he accelerates beyond reason.", Enums.StatType.SPEED, 6, 2, false, 3, false, 0, 0.0)
