class_name EnemyAbilityDBS3PathB

## Story 3 Path B enemy abilities. Unique abilities for the investigation route.

const AbilityData := preload("res://scripts/data/ability_data.gd")
const Enums := preload("res://scripts/data/enums.gd")
const AbilityDB := preload("res://scripts/data/ability_db.gd")


static func _make(p_name: String, flavor: String, stat: Enums.StatType, mod: int,
		turns: int, on_enemy: bool, cost: int, all: bool = false,
		dot: int = 0, steal: float = 0.0) -> AbilityData:
	return AbilityDB._make(p_name, flavor, stat, mod, turns, on_enemy, cost, all, dot, steal)


# =============================================================================
# Prog 11: Inn Search -- Bound dream creatures in the cellar
# =============================================================================

# --- Cellar Sentinel (mixed attacker, tanky) ---

static func petrified_slam() -> AbilityData:
	return _make("Petrified Slam", "Stone fist meets dream energy in a grinding impact.", Enums.StatType.MIXED_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func stagnant_chill() -> AbilityData:
	return _make("Stagnant Chill", "Decades of cold stillness seep outward and slow everything.", Enums.StatType.SPEED, 6, 2, true, 4, true, 0, 0.0)

# --- Bound Stalker (physical DPS, DoT specialist) ---

static func tethered_lunge() -> AbilityData:
	return _make("Tethered Lunge", "It hurls itself forward to the full length of its chain.", Enums.StatType.PHYSICAL_ATTACK, 9, 0, true, 3, false, 0, 0.0)

static func fraying_bite() -> AbilityData:
	return _make("Fraying Bite", "Teeth find flesh and the wound keeps tearing.", Enums.StatType.HEALTH, 0, 3, true, 3, false, 3, 0.0)


# =============================================================================
# Prog 12: Cult Confrontation -- Brother Voss and Sister Maren
# =============================================================================

# --- Thread Disciple "Brother Voss" (mixed attacker, life steal) ---

static func unstable_channeling() -> AbilityData:
	return _make("Unstable Channeling", "Raw power pours out without focus or restraint.", Enums.StatType.MIXED_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func siphon_faith() -> AbilityData:
	return _make("Siphon Faith", "The disciple drains the target's essence to fuel their own.", Enums.StatType.MAGIC_ATTACK, 5, 0, true, 3, false, 0, 0.2)

# --- Thread Warden "Sister Maren" (physical tank, taunt) ---

static func shielding_blow() -> AbilityData:
	return _make("Shielding Blow", "A blow that drives enemies back from the one she guards.", Enums.StatType.PHYSICAL_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func guardians_oath() -> AbilityData:
	return _make("Guardian's Oath", "She steps forward and demands all eyes turn to her.", Enums.StatType.TAUNT, 0, 2, false, 3, false, 0, 0.0)


# =============================================================================
# Prog 13: Tunnel Breach -- Gate guards in narrow catacombs
# =============================================================================

# --- Tunnel Sentinel "Gate Guard" (physical tank, area denial) ---

static func chokepoint_crush() -> AbilityData:
	return _make("Chokepoint Crush", "In these tight quarters, there is nowhere to dodge.", Enums.StatType.PHYSICAL_ATTACK, 9, 0, true, 3, false, 0, 0.0)

static func passage_block() -> AbilityData:
	return _make("Passage Block", "The guard fills the corridor and nobody gets past.", Enums.StatType.SPEED, 8, 2, true, 4, true, 0, 0.0)

# --- Thread Sniper "Bolt Caster" (magic glass cannon, debuffer) ---

static func piercing_thread() -> AbilityData:
	return _make("Piercing Thread", "A needle-thin thread launched with lethal precision.", Enums.StatType.MAGIC_ATTACK, 9, 0, true, 3, false, 0, 0.0)

static func expose_weakness() -> AbilityData:
	return _make("Expose Weakness", "The sniper's eye finds every gap in the armor.", Enums.StatType.DEFENSE, 10, 2, true, 3, false, 0, 0.0)

# --- Pale Devotee "Brother Hale" (magic DoT, AoE defense debuffer) ---

static func burning_devotion() -> AbilityData:
	return _make("Burning Devotion", "Faith made manifest sears the skin and keeps smoldering.", Enums.StatType.HEALTH, 0, 3, true, 3, false, 3, 0.0)

static func martyrs_gift() -> AbilityData:
	return _make("Martyr's Gift", "His suffering strips the protection from every enemy, leaving them exposed.", Enums.StatType.DEFENSE, 10, 2, true, 4, true, 0, 0.0)


# =============================================================================
# Prog 14: Thorne's Ward -- Philosopher-warrior and his elite guard
# =============================================================================

# --- Thread Ritualist "High Ritualist Thorne" (mixed attacker, AoE debuffer) ---

static func binding_rite() -> AbilityData:
	return _make("Binding Rite", "The ritual strikes at body and will with equal conviction.", Enums.StatType.MIXED_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func enervation_chant() -> AbilityData:
	return _make("Enervation Chant", "A droning chant that saps the will to fight.", Enums.StatType.ATTACK, 11, 2, true, 4, true, 0, 0.0)

# --- Passage Guardian "Loom Champion" (physical DPS, magic defense debuffer) ---

static func champions_cleave() -> AbilityData:
	return _make("Champion's Cleave", "A measured, devastating arc from a master combatant.", Enums.StatType.PHYSICAL_ATTACK, 9, 0, true, 3, false, 0, 0.0)

static func loom_aegis() -> AbilityData:
	return _make("Loom Aegis", "The champion's gaze pierces through magical barriers.", Enums.StatType.MAGIC_DEFENSE, 13, 2, true, 3, false, 0, 0.0)

# --- Warding Shadow (magic DPS, speed debuffer) ---

static func flickering_grasp() -> AbilityData:
	return _make("Flickering Grasp", "A hand that shifts between real and shadow reaches through the guard.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func shadow_veil() -> AbilityData:
	return _make("Shadow Grasp", "The shadow reaches through the veil and drags at the limbs.", Enums.StatType.SPEED, 8, 2, true, 3, false, 0, 0.0)


# =============================================================================
# Prog 14: Loom Heart -- Ritual chamber with the physical Loom
# =============================================================================

# --- Shadow Innkeeper (mixed DPS, life-steal) ---

static func borrowed_face() -> AbilityData:
	return _make("Borrowed Face", "The friendly smile cracks and something wrong looks through.", Enums.StatType.MIXED_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func thread_drain() -> AbilityData:
	return _make("Thread Drain", "She feeds on the connection between waking and dreaming.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 3, false, 0, 0.2)

# --- Astral Weaver "Weaver Aldric" (magic AoE specialist) ---

static func astral_barrage() -> AbilityData:
	return _make("Astral Barrage", "Points of starlight descend like burning rain.", Enums.StatType.MAGIC_ATTACK, 5, 0, true, 4, true, 0, 0.0)

static func cosmic_unraveling() -> AbilityData:
	return _make("Cosmic Unraveling", "The weaver pulls apart every magical defense at once.", Enums.StatType.MAGIC_DEFENSE, 13, 2, true, 4, true, 0, 0.0)

# --- Loom Tendril (magic life-steal, constriction DoT) ---

static func siphon_pulse() -> AbilityData:
	return _make("Siphon Pulse", "The tendril latches on and drinks deep.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, false, 0, 0.2)

static func constricting_weave() -> AbilityData:
	return _make("Constricting Weave", "Thread wraps tight and squeezes, turn after turn.", Enums.StatType.SPEED, 6, 3, true, 3, false, 2, 0.0)


# =============================================================================
# Prog 15: Dream Invasion -- Lira's dream cathedral
# =============================================================================

# --- Cathedral Warden "Loom Warden" (mixed attacker, AoE mixed DPS) ---

static func consecrated_strike() -> AbilityData:
	return _make("Consecrated Strike", "A blow that carries the weight of centuries of worship.", Enums.StatType.MIXED_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func cathedrals_blessing() -> AbilityData:
	return _make("Consecrated Blast", "The cathedral itself punishes all who defile this ground.", Enums.StatType.MIXED_ATTACK, 6, 0, true, 4, true, 0, 0.0)

# --- Dream Binder "Thread Binder" (magic DoT, AoE attack debuffer) ---

static func binding_chains() -> AbilityData:
	return _make("Binding Chains", "Chains of dream-stuff lock on and keep burning.", Enums.StatType.HEALTH, 0, 3, true, 3, false, 3, 0.0)

static func dreamlock() -> AbilityData:
	return _make("Dreamlock", "The binder freezes every muscle and thought.", Enums.StatType.ATTACK, 11, 2, true, 4, true, 0, 0.0)

# --- Thread Anchor "Dream Anchor" (mixed attacker, AoE magic defense debuffer) ---

static func anchor_pulse() -> AbilityData:
	return _make("Anchor Pulse", "A wave of grounded energy disrupts body and mind.", Enums.StatType.MIXED_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func fortifying_thread() -> AbilityData:
	return _make("Fortifying Thread", "The anchor's threads strip away every ward they touch.", Enums.StatType.MAGIC_DEFENSE, 13, 2, true, 4, true, 0, 0.0)


# =============================================================================
# Prog 17: Dream Nexus -- Final battle
# =============================================================================

# --- Lira, the Threadmaster (boss) ---

static func inn_keepers_embrace() -> AbilityData:
	return _make("Innkeeper's Embrace", "She offers comfort, then takes everything. Warm hands, cold intent.", Enums.StatType.MIXED_ATTACK, 11, 0, true, 3, false, 0, 0.2)

static func veil_of_lies() -> AbilityData:
	return _make("Veil of Lies", "Centuries of deception coalesce into a single strike of pure malice.", Enums.StatType.MAGIC_ATTACK, 15, 0, true, 4, false, 0, 0.0)

static func shattered_trust() -> AbilityData:
	return _make("Shattered Trust", "Every kindness she ever showed was a weapon. Now the mask drops.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 3, true, 0, 0.0)

static func charm_of_ages() -> AbilityData:
	return _make("Charm of Ages", "Her voice drips with false warmth, sapping the will to fight.", Enums.StatType.ATTACK, 13, 2, true, 4, true, 0, 0.0)

static func stolen_warmth() -> AbilityData:
	return _make("Stolen Warmth", "She draws life as easily as she once poured tea. Old habits.", Enums.StatType.MAGIC_ATTACK, 11, 0, true, 4, false, 0, 0.3)

# --- Tattered Deception (mixed glass cannon, magic defense shredder) ---

static func mirrored_assault() -> AbilityData:
	return _make("Mirrored Assault", "Your own movements, twisted and thrown back at you.", Enums.StatType.MIXED_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func unraveling_touch() -> AbilityData:
	return _make("Unraveling Touch", "Fingers of frayed thread peel back every ward and protection.", Enums.StatType.MAGIC_DEFENSE, 13, 2, true, 3, false, 0, 0.0)

# --- Dream Bastion (physical tank, AoE mixed DPS) ---

static func bastion_slam() -> AbilityData:
	return _make("Bastion Slam", "The fortress itself strikes with a wall of solidified dream.", Enums.StatType.PHYSICAL_ATTACK, 10, 0, true, 3, false, 0, 0.0)

static func nexus_shield() -> AbilityData:
	return _make("Nexus Blast", "The bastion projects the nexus's remaining power outward as a devastating wave.", Enums.StatType.MIXED_ATTACK, 6, 0, true, 3, true, 0, 0.0)


# =============================================================================
# Prog 16 physical attacker addition: WeftStalker (T2 rework pass)
# =============================================================================

# --- WeftStalker (hunting predator woven from loom weft threads) ---

static func weft_lash() -> AbilityData:
	return _make("Weft Lash", "Threads of weft snap outward like whips, catching everyone in the arc.", Enums.StatType.MIXED_ATTACK, 5, 0, true, 4, true, 0, 0.0)

static func stalk() -> AbilityData:
	return _make("Stalk", "The creature circles its prey, hampering every move and slowing the quarry.", Enums.StatType.SPEED, 6, 2, true, 3, false, 0, 0.0)


# --- Loom Parasite (physical DoT + life steal creature) ---

static func parasitic_bite() -> AbilityData:
	return _make("Parasitic Bite", "The parasite latches on and drinks deep from the wound.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.2)

static func infesting_spores() -> AbilityData:
	return _make("Infesting Spores", "Spores burrow under the skin and feed on living tissue.", Enums.StatType.HEALTH, 0, 3, true, 3, false, 3, 0.0)
