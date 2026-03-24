class_name EnemyAbilityDBS3PathC

## Story 3 Path C enemy abilities (deep dream entities, dream-projected cult, Threadmaster).

const AbilityData := preload("res://scripts/data/ability_data.gd")
const Enums := preload("res://scripts/data/enums.gd")
const AbilityDB := preload("res://scripts/data/ability_db.gd")


static func _make(p_name: String, flavor: String, stat: Enums.StatType, mod: int,
		turns: int, on_enemy: bool, cost: int, all: bool = false,
		dot: int = 0, steal: float = 0.0) -> AbilityData:
	return AbilityDB._make(p_name, flavor, stat, mod, turns, on_enemy, cost, all, dot, steal)


# =============================================================================
# Deep dream entities (S3_C_DreamDescent)
# =============================================================================

# --- Abyssal Dreamer ---

static func void_pulse() -> AbilityData:
	return _make("Void Pulse", "A wave of emptiness rolls outward from the deep dream.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 4, true, 0, 0.0)

static func deep_slumber() -> AbilityData:
	return _make("Deep Slumber", "The abyss tugs at consciousness, dragging the mind down.", Enums.StatType.SPEED, 5, 2, true, 3, false, 0, 0.0)

# --- Thread Devourer ---

static func thread_bite() -> AbilityData:
	return _make("Thread Bite", "Jaws made of frayed dream-stuff tear and swallow.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.25)

static func unravel_ward() -> AbilityData:
	return _make("Unravel Ward", "Defenses come apart at the seams.", Enums.StatType.DEFENSE, 5, 2, true, 3, false, 0, 0.0)

# --- Slumbering Colossus ---

static func crushing_dream() -> AbilityData:
	return _make("Crushing Dream", "A fist the size of a house descends with the weight of sleep.", Enums.StatType.PHYSICAL_ATTACK, 9, 0, true, 4, false, 0, 0.0)

static func ancient_yawn() -> AbilityData:
	return _make("Ancient Yawn", "A yawn that spans centuries settles over the battlefield.", Enums.StatType.SPEED, 4, 2, true, 4, true, 0, 0.0)


# =============================================================================
# Dream-projected cult members (S3_C_CultInterception)
# =============================================================================

# --- Dream Priest (Thorne's dream form) ---

static func loom_prayer() -> AbilityData:
	return _make("Loom Prayer", "A chant that strips away the defenses of the faithless.", Enums.StatType.DEFENSE, 5, 2, true, 4, true, 0, 0.0)

static func sacred_thread() -> AbilityData:
	return _make("Sacred Thread", "A bolt of consecrated dream-stuff strikes with purpose.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 3, false, 0, 0.0)

# --- Astral Enforcer ---

static func dream_blade() -> AbilityData:
	return _make("Dream Blade", "A sword forged from pure intent cuts deeper than steel.", Enums.StatType.PHYSICAL_ATTACK, 9, 0, true, 3, false, 0, 0.0)

static func astral_brace() -> AbilityData:
	return _make("Astral Fist", "The enforcer channels astral force through a devastating punch.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.0)

# --- Oneiric Hexer ---

static func nightmare_hex() -> AbilityData:
	return _make("Nightmare Hex", "A curse woven from bad dreams saps the will to fight.", Enums.StatType.ATTACK, 5, 2, true, 4, true, 0, 0.0)

static func dream_bolt() -> AbilityData:
	return _make("Dream Bolt", "A concentrated shard of dreaming strikes like lightning.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, false, 0, 0.0)


# =============================================================================
# Threadmaster's personal guardians (S3_C_ThreadmasterLair)
# =============================================================================

# --- Memory Eater ---

static func devour_memory() -> AbilityData:
	return _make("Devour Memory", "It feeds on what you remember and grows stronger.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 3, false, 0, 0.3)

static func amnesia_fog() -> AbilityData:
	return _make("Amnesia Fog", "A haze that strips away the knowledge of how to defend.", Enums.StatType.MAGIC_DEFENSE, 5, 2, true, 4, true, 0, 0.0)

# --- Nightmare Sentinel ---

static func nightmare_blade() -> AbilityData:
	return _make("Nightmare Blade", "A blade forged in the deepest fears of a thousand sleepers.", Enums.StatType.PHYSICAL_ATTACK, 9, 0, true, 3, false, 0, 0.0)

static func terror_ward() -> AbilityData:
	return _make("Terror Aura", "Fear radiates outward, sapping the will to fight from every enemy.", Enums.StatType.ATTACK, 5, 2, true, 4, true, 0, 0.0)

# --- Anchor Chain ---

static func binding_pull() -> AbilityData:
	return _make("Binding Pull", "The chain tightens and the blood slows.", Enums.StatType.SPEED, 4, 3, true, 3, false, 2, 0.0)

static func iron_link() -> AbilityData:
	return _make("Chain Strike", "The chain whips outward and crashes into the nearest target.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.0)


# =============================================================================
# The Ancient Threadmaster and its servants (S3_C_DreamNexus)
# =============================================================================

# --- The Ancient Threadmaster ---

static func primordial_dream() -> AbilityData:
	return _make("Primordial Dream", "The first dream ever dreamed crashes down like a wave.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 3, true, 0, 0.0)

static func loom_dominion() -> AbilityData:
	return _make("Loom Dominion", "The Loom itself lashes out at the Threadmaster's command.", Enums.StatType.PHYSICAL_ATTACK, 12, 0, true, 3, false, 0, 0.0)

static func chain_of_ages() -> AbilityData:
	return _make("Chain of Ages", "Centuries of stolen power weigh down every limb.", Enums.StatType.ATTACK, 6, 2, true, 4, true, 0, 0.0)

# --- Dream Shackle ---

static func binding_lash() -> AbilityData:
	return _make("Binding Lash", "A length of chain whips outward, seeking to reclaim.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func reclaim() -> AbilityData:
	return _make("Reclaim", "The shackle drags everything toward the Threadmaster.", Enums.StatType.SPEED, 5, 2, true, 4, true, 0, 0.0)

# --- Loom Heart ---

static func pulse_of_the_loom() -> AbilityData:
	return _make("Pulse of the Loom", "The Loom's heartbeat reverberates through everything, rattling armor and resolve.", Enums.StatType.DEFENSE, 5, 2, true, 3, true, 0, 0.0)

static func loom_storm() -> AbilityData:
	return _make("Loom Storm", "Threads of raw energy lash outward in every direction.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, true, 0, 0.0)
