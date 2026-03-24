class_name AbilityDBPlayerB

## Player T1 and T2 class abilities: Tinker, Wildling, Wanderer trees.

const AbilityData := preload("res://scripts/data/ability_data.gd")
const Enums := preload("res://scripts/data/enums.gd")
const AbilityDB := preload("res://scripts/data/ability_db.gd")


static func _make(p_name: String, flavor: String, stat: Enums.StatType, mod: int,
		turns: int, on_enemy: bool, cost: int, all: bool = false,
		dot: int = 0, steal: float = 0.0) -> AbilityData:
	return AbilityDB._make(p_name, flavor, stat, mod, turns, on_enemy, cost, all, dot, steal)


# =============================================================================
# Tinker tree:T1
# =============================================================================

# Artificer
static func magical_tinkering() -> AbilityData:
	return _make("Magical Tinkering", "Enhance an ally's magical potency.",
		Enums.StatType.MAGIC_ATTACK, 5, 2, false, 2, false, 0, 0.0)

static func volatile_flask() -> AbilityData:
	return _make("Volatile Flask", "A bubbling concoction hurled at the enemy.",
		Enums.StatType.MAGIC_ATTACK, 6, 0, true, 3, false, 0, 0.0)


static func healing_draught() -> AbilityData:
	return _make("Healing Draught", "A carefully brewed potion that mends wounds.",
		Enums.StatType.HEALTH, 4, 0, false, 4, false, 0, 0.0)

# Cosmologist (Philosopher)
static func time_warp() -> AbilityData:
	return _make("Time Warp", "Bend time to hasten an ally.",
		Enums.StatType.SPEED, 5, 2, false, 2, false, 0, 0.0)

static func black_hole() -> AbilityData:
	return _make("Black Hole", "Crush the enemy with gravity.",
		Enums.StatType.MAGIC_ATTACK, 7, 0, true, 4, false, 0, 0.0)

static func gravity() -> AbilityData:
	return _make("Gravity", "Slow the enemy with crushing force.",
		Enums.StatType.SPEED, 4, 2, true, 2, false, 0, 0.0)

# Arithmancer
static func theorem() -> AbilityData:
	return _make("Theorem", "A mathematical proof made manifest.",
		Enums.StatType.MAGIC_ATTACK, 9, 0, true, 4, false, 0, 0.0)

static func calculate() -> AbilityData:
	return _make("Calculate", "Exploit mathematical weakness.",
		Enums.StatType.DEFENSE, 4, 2, true, 2, false, 0, 0.0)

static func probability() -> AbilityData:
	return _make("Probability", "Shift the odds in an ally's favor.",
		Enums.StatType.SPEED, 4, 2, false, 2, false, 0, 0.0)

# =============================================================================
# Tinker tree:T2
# =============================================================================

# Alchemist
static func transmute() -> AbilityData:
	return _make("Transmute", "Transform matter into pure energy.",
		Enums.StatType.MIXED_ATTACK, 10, 0, true, 4, false, 0, 0.0)

static func corrosive_acid() -> AbilityData:
	return _make("Corrosive Acid", "Acid that burns over time.",
		Enums.StatType.HEALTH, 0, 3, true, 4, false, 4, 0.0)

static func elixir() -> AbilityData:
	return _make("Elixir", "A carefully brewed healing potion.",
		Enums.StatType.HEALTH, 12, 0, false, 4, false, 0, 0.0)

# Bombardier
static func shrapnel() -> AbilityData:
	return _make("Shrapnel", "Razor-sharp metal fragments.",
		Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func explosion() -> AbilityData:
	return _make("Explosion", "A massive detonation.",
		Enums.StatType.MIXED_ATTACK, 10, 0, true, 4, false, 0, 0.0)

static func field_repair() -> AbilityData:
	return _make("Field Repair", "Patch wounds with salvaged materials.",
		Enums.StatType.HEALTH, 8, 0, false, 4, false, 0, 0.0)

# Chronomancer
static func warp_speed() -> AbilityData:
	return _make("Warp Speed", "Accelerate an ally through time.",
		Enums.StatType.SPEED, 10, 2, false, 4, false, 0, 0.0)

static func time_bomb() -> AbilityData:
	return _make("Time Bomb", "A delayed temporal explosion.",
		Enums.StatType.MAGIC_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func time_freeze() -> AbilityData:
	return _make("Time Freeze", "Stop the enemy in their tracks.",
		Enums.StatType.SPEED, 7, 2, true, 4, false, 0, 0.0)

# Astronomer
static func starfall() -> AbilityData:
	return _make("Starfall", "Call down celestial fire.",
		Enums.StatType.MAGIC_ATTACK, 8, 0, true, 4, false, 0, 0.0)

static func meteor_shower() -> AbilityData:
	return _make("Meteor Shower", "A rain of cosmic debris.",
		Enums.StatType.MAGIC_ATTACK, 4, 0, true, 5, true, 0, 0.0)

static func eclipse() -> AbilityData:
	return _make("Eclipse", "Blot out the enemy's magical senses.",
		Enums.StatType.MAGIC_DEFENSE, 5, 2, true, 3, false, 0, 0.0)

# Automaton
static func servo_strike() -> AbilityData:
	return _make("Servo Strike", "A pneumatic piston blow from mechanical limbs.",
		Enums.StatType.MAGIC_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func discharge() -> AbilityData:
	return _make("Discharge", "Release a burst of stored energy that arcs through all enemies.",
		Enums.StatType.MAGIC_ATTACK, 5, 0, true, 5, true, 0, 0.0)

static func overclock() -> AbilityData:
	return _make("Overclock", "Push systems beyond safe limits.",
		Enums.StatType.SPEED, 7, 2, false, 3, false, 0, 0.0)

# Technomancer
static func circuit_blast() -> AbilityData:
	return _make("Circuit Blast", "Channel magic through overcharged circuits.",
		Enums.StatType.MAGIC_ATTACK, 7, 0, true, 4, false, 0, 0.0)

static func circuit_shield() -> AbilityData:
	return _make("Circuit Shield", "A humming barrier of overcharged circuitry.",
		Enums.StatType.DEFENSE, 4, 2, false, 3, false, 0, 0.0)

static func emp_pulse() -> AbilityData:
	return _make("EMP Pulse", "An electromagnetic burst disrupts all enemies' reactions.",
		Enums.StatType.SPEED, 5, 2, true, 3, true, 0, 0.0)


# =============================================================================
# Wildling tree:T1
# =============================================================================

# Herbalist
static func mending_herbs() -> AbilityData:
	return _make("Mending Herbs", "Apply healing herbs to an ally.",
		Enums.StatType.HEALTH, 4, 0, false, 4, false, 0, 0.0)

static func sapping_vine() -> AbilityData:
	return _make("Sapping Vine", "Lash out with life-draining vines.",
		Enums.StatType.MAGIC_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func thorn_spray() -> AbilityData:
	return _make("Thorn Spray", "A spray of enchanted thorns that disrupts magical defenses.",
		Enums.StatType.MAGIC_DEFENSE, 3, 2, true, 2, false, 0, 0.0)

# Shaman
static func spectral_lance() -> AbilityData:
	return _make("Spectral Lance", "A ghostly spear of spirit energy.",
		Enums.StatType.MAGIC_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func player_hex() -> AbilityData:
	return _make("Hex", "A curse that saps the enemy's power.",
		Enums.StatType.ATTACK, 5, 2, true, 3, false, 0, 0.0)

static func spirit_bolt() -> AbilityData:
	return _make("Spirit Bolt", "A crackling bolt of ancestral energy.",
		Enums.StatType.MAGIC_ATTACK, 6, 0, true, 3, false, 0, 0.0)


static func ancestral_curse() -> AbilityData:
	return _make("Ancestral Curse", "Invoke the wrath of forgotten spirits upon all foes.",
		Enums.StatType.ATTACK, 5, 2, true, 3, true, 0, 0.0)


static func spirit_veil() -> AbilityData:
	return _make("Spirit Veil", "Spirits weave a protective ward against magic.",
		Enums.StatType.MAGIC_DEFENSE, 4, 2, false, 2, false, 0, 0.0)

# Beastcaller
static func feral_strike() -> AbilityData:
	return _make("Feral Strike", "Call a beast to strike the enemy.",
		Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func pack_howl() -> AbilityData:
	return _make("Pack Howl", "Rally the pack for greater power.",
		Enums.StatType.ATTACK, 4, 2, false, 3, true, 0, 0.0)

static func stampede() -> AbilityData:
	return _make("Stampede", "A rampaging beast crashes through the enemy lines.",
		Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 4, true, 0, 0.0)

# =============================================================================
# Wildling tree:T2
# =============================================================================

# Blighter
static func blight() -> AbilityData:
	return _make("Blight", "Dark natural magic that corrupts.",
		Enums.StatType.MAGIC_ATTACK, 9, 0, true, 5, false, 0, 0.0)

static func life_siphon() -> AbilityData:
	return _make("Life Siphon", "Drain the enemy's essence.",
		Enums.StatType.MAGIC_ATTACK, 8, 0, true, 5, false, 0, 0.5)

static func poison_sting() -> AbilityData:
	return _make("Poison Sting", "A venomous barb that festers.",
		Enums.StatType.HEALTH, 0, 3, true, 3, false, 4, 0.0)

# Grove Keeper
static func root_trap() -> AbilityData:
	return _make("Root Trap", "Roots that entangle all enemies.",
		Enums.StatType.SPEED, 4, 2, true, 5, true, 0, 0.0)

static func thorn_burst() -> AbilityData:
	return _make("Thorn Burst", "A violent eruption of razor-sharp thorns.",
		Enums.StatType.MAGIC_ATTACK, 9, 0, true, 5, false, 0, 0.0)

static func draining_vines() -> AbilityData:
	return _make("Draining Vines", "Thorned vines that drain the life from a foe.",
		Enums.StatType.MAGIC_ATTACK, 8, 0, true, 5, false, 0, 0.5)

# Witch Doctor
static func voodoo_bolt() -> AbilityData:
	return _make("Voodoo Bolt", "Dark spiritual energy strikes the enemy.",
		Enums.StatType.MAGIC_ATTACK, 7, 0, true, 5, false, 0, 0.4)

static func dark_hex() -> AbilityData:
	return _make("Dark Hex", "A potent curse that weakens magic resistance.",
		Enums.StatType.MAGIC_DEFENSE, 5, 3, true, 4, false, 0, 0.0)

static func creeping_rot() -> AbilityData:
	return _make("Creeping Rot", "A slow decay that saps strength.",
		Enums.StatType.ATTACK, 3, 3, true, 3, false, 4, 0.0)

# Spiritwalker
static func spirit_shield() -> AbilityData:
	return _make("Spirit Shield", "Ancestral spirits protect an ally.",
		Enums.StatType.DEFENSE, 5, 2, false, 3, false, 0, 0.0)

static func ancestral_blessing() -> AbilityData:
	return _make("Ancestral Blessing", "The ancestors empower all allies.",
		Enums.StatType.ATTACK, 4, 2, false, 4, true, 0, 0.0)

static func spirit_mend() -> AbilityData:
	return _make("Spirit Mend", "Healing energy from the spirit world.",
		Enums.StatType.HEALTH, 7, 0, false, 5, false, 0, 0.0)

# Falconer
static func falcon_strike() -> AbilityData:
	return _make("Falcon Strike", "A raptor dives from above.",
		Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 4, false, 0, 0.0)

static func talon_rend() -> AbilityData:
	return _make("Talon Rend", "The falcon shreds the enemy's armor with razor talons.",
		Enums.StatType.DEFENSE, 4, 2, true, 3, false, 0, 0.0)

static func raptors_gift() -> AbilityData:
	return _make("Raptor's Gift", "The falcon's keen bond channels restorative energy.",
		Enums.StatType.MIXED_ATTACK, 6, 0, false, 4, false, 0, 0.0)

# Shapeshifter
static func savage_maul() -> AbilityData:
	return _make("Savage Maul", "Transform and maul the enemy.",
		Enums.StatType.PHYSICAL_ATTACK, 8, 0, true, 4, false, 0, 0.0)

static func frenzy() -> AbilityData:
	return _make("Frenzy", "Enter a bestial rage.",
		Enums.StatType.ATTACK, 5, 2, false, 2, false, 0, 0.0)

static func primal_roar() -> AbilityData:
	return _make("Primal Roar", "A roar that shakes all enemies.",
		Enums.StatType.DEFENSE, 4, 2, true, 5, true, 0, 0.0)


# =============================================================================
# Wanderer tree:T1
# =============================================================================

# Sentinel
static func shield_bash() -> AbilityData:
	return _make("Shield Bash", "Drive your shield into the foe with crushing force.",
		Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func barrier() -> AbilityData:
	return _make("Barrier", "Raise a shimmering ward to protect an ally from magic.",
		Enums.StatType.MAGIC_DEFENSE, 4, 2, false, 2, false, 0, 0.0)

static func fortify() -> AbilityData:
	return _make("Fortify", "Strengthen the whole team's resolve against harm.",
		Enums.StatType.DEFENSE, 2, 2, false, 4, true, 0, 0.0)

# Pathfinder
static func keen_strike() -> AbilityData:
	return _make("Keen Strike", "Strike with precision at an exposed weakness.",
		Enums.StatType.MIXED_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func exploit_weakness() -> AbilityData:
	return _make("Exploit Weakness", "Study the enemy to find their flaw.",
		Enums.StatType.DEFENSE, 4, 2, true, 2, false, 0, 0.0)

static func adaptable_strike() -> AbilityData:
	return _make("Adaptable Strike", "A versatile blow that siphons the enemy's vitality.",
		Enums.StatType.MIXED_ATTACK, 5, 0, true, 2, false, 0, 0.25)

# =============================================================================
# Wanderer tree:T2
# =============================================================================

# Bulwark - balanced attacker/defender
static func fortress_strike() -> AbilityData:
	return _make("Fortress Strike", "Strike with the weight of an immovable fortress.",
		Enums.StatType.PHYSICAL_ATTACK, 6, 0, true, 4, false, 0, 0.0)

static func iron_fist() -> AbilityData:
	return _make("Iron Fist", "A devastating blow that shatters defenses.",
		Enums.StatType.MIXED_ATTACK, 9, 0, true, 4, false, 0, 0.0)

static func ironclad_challenge() -> AbilityData:
	return _make("Ironclad Challenge", "Issue a thunderous challenge that forces enemies to attack you.",
		Enums.StatType.TAUNT, 0, 2, false, 4, false, 0, 0.0)

# Aegis - support tank with party buffs and healing
static func guardians_blessing() -> AbilityData:
	return _make("Guardian's Blessing", "Channel protective energy to mend all allies.",
		Enums.StatType.HEALTH, 6, 0, false, 5, true, 0, 0.0)

static func protective_ward() -> AbilityData:
	return _make("Protective Ward", "Extend a shield of protection to all nearby allies.",
		Enums.StatType.DEFENSE, 3, 2, false, 5, true, 0, 0.0)

static func aegis_barrier() -> AbilityData:
	return _make("Aegis Barrier", "Raise a barrier of pure defensive magic.",
		Enums.StatType.MAGIC_DEFENSE, 4, 2, false, 4, false, 0, 0.0)

# Trailblazer
static func blaze_trail() -> AbilityData:
	return _make("Blaze Trail", "Charge forward with reckless, blazing speed.",
		Enums.StatType.MIXED_ATTACK, 8, 0, true, 5, false, 0, 0.3)

static func ambush() -> AbilityData:
	return _make("Ambush", "Strike from an unexpected angle, hitting all foes.",
		Enums.StatType.PHYSICAL_ATTACK, 6, 0, true, 5, true, 0, 0.0)

static func expose() -> AbilityData:
	return _make("Expose", "Reveal the enemy's vulnerabilities for all to exploit.",
		Enums.StatType.DEFENSE, 4, 2, true, 3, false, 0, 0.0)

# Survivalist
static func endure() -> AbilityData:
	return _make("Endure", "Dig deep and restore your body through sheer willpower.",
		Enums.StatType.HEALTH, 15, 0, false, 5, false, 0, 0.0)

static func resourceful_strike() -> AbilityData:
	return _make("Resourceful Strike",
		"Strike with practiced efficiency, draining the foe's vitality.",
		Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 4, false, 0, 0.3)

static func adapt() -> AbilityData:
	return _make("Adapt", "Heighten your senses and reflexes to the battlefield.",
		Enums.StatType.SPEED, 4, 3, false, 3, false, 0, 0.0)
