class_name EnemyAbilityDBS3

## Story 3 enemy abilities (dreams + cult).

const AbilityData := preload("res://scripts/data/ability_data.gd")
const Enums := preload("res://scripts/data/enums.gd")
const AbilityDB := preload("res://scripts/data/ability_db.gd")


static func _make(p_name: String, flavor: String, stat: Enums.StatType, mod: int,
		turns: int, on_enemy: bool, cost: int, all: bool = false,
		dot: int = 0, steal: float = 0.0) -> AbilityData:
	return AbilityDB._make(p_name, flavor, stat, mod, turns, on_enemy, cost, all, dot, steal)


# =============================================================================
# Act I: Dream fauna abilities
# =============================================================================

# --- Dream Wisp ---

static func shimmer_bolt() -> AbilityData:
	return _make("Shimmer Bolt", "A flickering mote of light that stings on contact.", Enums.StatType.MAGIC_ATTACK, 3, 0, true, 2, false, 0, 0.0)

static func daze() -> AbilityData:
	return _make("Daze", "The light pulses, leaving the mind sluggish.", Enums.StatType.SPEED, 5, 2, true, 2, false, 0, 0.0)

# --- Phantasm ---

static func phase_strike() -> AbilityData:
	return _make("Phase Strike", "A translucent fist passes through armor and flesh alike.", Enums.StatType.MIXED_ATTACK, 4, 0, true, 3, false, 0, 0.0)

static func unnerve() -> AbilityData:
	return _make("Unnerve", "The air grows cold and confidence falters.", Enums.StatType.DEFENSE, 7, 2, true, 2, false, 0, 0.0)

# --- Shade Moth ---

static func dust_wing() -> AbilityData:
	return _make("Dust Wing", "Scales of shadow scrape across exposed skin.", Enums.StatType.PHYSICAL_ATTACK, 3, 0, true, 2, false, 0, 0.0)

static func flit() -> AbilityData:
	return _make("Flit", "The moth darts erratically, impossible to track.", Enums.StatType.SPEED, 8, 2, false, 2, false, 0, 0.0)

# --- Slumber Beast ---

static func heavy_paw() -> AbilityData:
	return _make("Heavy Paw", "A massive paw crashes down with dreamlike weight.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 2, false, 0, 0.0)

static func drowsy_roar() -> AbilityData:
	return _make("Drowsy Roar", "A deep rumble that makes eyelids heavy.", Enums.StatType.SPEED, 5, 2, true, 4, true, 0, 0.0)

# --- Fog Wraith ---

static func mist_tendril() -> AbilityData:
	return _make("Mist Tendril", "A tendril of fog wraps tight and squeezes.", Enums.StatType.MAGIC_ATTACK, 4, 0, true, 3, false, 0, 0.0)

static func chill_fog() -> AbilityData:
	return _make("Chill Fog", "Cold mist settles over everyone.", Enums.StatType.MAGIC_ATTACK, 3, 0, true, 4, true, 0, 0.0)

# --- Sleep Stalker ---

static func dream_fang() -> AbilityData:
	return _make("Dream Fang", "Teeth that feel real enough to draw blood.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 2, false, 0, 0.0)

static func shadow_lunge() -> AbilityData:
	return _make("Shadow Lunge", "A blur of darkness closes the distance in an instant.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.0)

# --- Mirror Shade ---

static func reflected_strike() -> AbilityData:
	return _make("Reflected Strike", "Your own movements turned against you.", Enums.StatType.MIXED_ATTACK, 4, 0, true, 3, false, 0, 0.0)

static func mimic_stance() -> AbilityData:
	return _make("Mimic Stance", "The shade copies a defensive posture it observed.", Enums.StatType.DEFENSE, 7, 2, false, 2, false, 0, 0.0)

# --- Thorn Dreamer ---

static func briar_lash() -> AbilityData:
	return _make("Briar Lash", "Thorny vines lash out and keep cutting.", Enums.StatType.HEALTH, 0, 3, true, 3, false, 3, 0.0)

static func spore_cloud() -> AbilityData:
	return _make("Spore Cloud", "A cloud of numbing spores drifts over the field.", Enums.StatType.DEFENSE, 7, 2, true, 4, true, 0, 0.0)


# =============================================================================
# Act II: Nightmare entity abilities
# =============================================================================

# --- Nightmare Hound ---

static func savage_bite() -> AbilityData:
	return _make("Savage Bite", "Jaws snap with force that shouldn't exist in a dream.", Enums.StatType.PHYSICAL_ATTACK, 6, 0, true, 3, false, 0, 0.0)

static func howl() -> AbilityData:
	return _make("Howl", "The pack surges forward at the sound.", Enums.StatType.SPEED, 5, 2, false, 3, true, 0, 0.0)

# --- Dream Weaver ---

static func thread_bolt() -> AbilityData:
	return _make("Thread Bolt", "A needle of woven light pierces through.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 3, false, 0, 0.0)

static func woven_ward() -> AbilityData:
	return _make("Woven Ward", "Threads of dream-stuff harden into a barrier.", Enums.StatType.DEFENSE, 10, 2, false, 3, true, 0, 0.0)

# --- Somnolent Serpent ---

static func venom_coil() -> AbilityData:
	return _make("Venom Coil", "Fangs sink in and the poison keeps working.", Enums.StatType.HEALTH, 0, 3, true, 3, false, 3, 0.0)

static func sleep_fang() -> AbilityData:
	return _make("Sleep Fang", "A bite that numbs the limbs.", Enums.StatType.SPEED, 6, 2, true, 3, false, 0, 0.0)

# --- Twilight Stalker ---

static func dusk_blade() -> AbilityData:
	return _make("Dusk Blade", "A blade forged from the edge of waking.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func vanish_strike() -> AbilityData:
	return _make("Vanish Strike", "It disappears and reappears behind you.", Enums.StatType.PHYSICAL_ATTACK, 9, 0, true, 4, false, 0, 0.0)

# --- Dusk Sentinel ---

static func shield_bash() -> AbilityData:
	return _make("Shield Bash", "A wall of shadow slams forward.", Enums.StatType.PHYSICAL_ATTACK, 6, 0, true, 3, false, 0, 0.0)

static func dusk_toll() -> AbilityData:
	return _make("Dusk Toll", "The sentinel's wrath sweeps across all who dare the threshold.", Enums.StatType.PHYSICAL_ATTACK, 0, 0, true, 4, true, 0, 0.0)

static func sentinel_stasis() -> AbilityData:
	return _make("Sentinel Slam", "The sentinel crashes forward with the full force of dusk behind it.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.0)

# --- Shattered Hourglass ---

static func grain_siphon() -> AbilityData:
	return _make("Grain Siphon", "Suspended sand streams toward the target, pulling stolen seconds from their veins.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 3, false, 0, 0.2)

static func eroding_sand() -> AbilityData:
	return _make("Eroding Sand", "Fine grains work beneath armor and skin, grinding away vitality grain by grain.", Enums.StatType.HEALTH, 0, 3, true, 3, false, 3, 0.0)

# --- Hollow Echo ---

static func echo_drain() -> AbilityData:
	return _make("Echo Drain", "A shockwave of stolen sound slams into flesh and bone.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 3, false, 0, 0.2)

static func dissonance() -> AbilityData:
	return _make("Dissonance", "Conflicting sounds shatter concentration.", Enums.StatType.DEFENSE, 10, 2, true, 3, false, 0, 0.0)

# --- Waking Terror ---

static func scream_blast() -> AbilityData:
	return _make("Scream", "A sound that shouldn't be possible tears through the air.", Enums.StatType.MAGIC_ATTACK, 5, 0, true, 4, true, 0, 0.0)

static func terror_wave() -> AbilityData:
	return _make("Terror Strike", "The terror lunges, channeling raw panic into a single devastating blow.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 4, false, 0, 0.0)

# --- Clock Specter ---

static func time_rend() -> AbilityData:
	return _make("Time Rend", "The hands of the clock spin backward through flesh.", Enums.StatType.MIXED_ATTACK, 10, 0, true, 3, false, 0, 0.0)

static func temporal_rupture() -> AbilityData:
	return _make("Temporal Rupture", "Fractured time detonates across the battlefield, tearing at everyone at once.", Enums.StatType.MIXED_ATTACK, 0, 0, true, 4, true, 0, 0.0)

# --- The Nightmare (boss) ---

static func nightmare_crush() -> AbilityData:
	return _make("Nightmare Crush", "The full weight of dread made physical.", Enums.StatType.PHYSICAL_ATTACK, 10, 0, true, 4, false, 0, 0.0)

static func dream_rend() -> AbilityData:
	return _make("Dream Rend", "The dreamscape tears apart around you.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, true, 0, 0.0)

static func dread_aura() -> AbilityData:
	return _make("Dread Aura", "Courage withers in its presence.", Enums.StatType.DEFENSE, 10, 2, true, 4, true, 0, 0.0)

# --- Nightmare Guard ---

static func dread_fang() -> AbilityData:
	return _make("Dread Fang", "Corrupted jaws snap with the weight of stolen nightmares.", Enums.StatType.PHYSICAL_ATTACK, 9, 0, true, 3, false, 0, 0.0)

static func guardian_howl() -> AbilityData:
	return _make("Dread Howl", "A howl that carries the Nightmare's terror across the entire party.", Enums.StatType.MAGIC_ATTACK, 5, 0, true, 3, true, 0, 0.0)

# --- Void Echo ---

static func void_siphon() -> AbilityData:
	return _make("Void Siphon", "It drinks the warmth from thought itself.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 3, false, 0, 0.2)

static func void_echo_drain() -> AbilityData:
	return _make("Void Drain", "A hollow echo that tears at thought without sustaining the void.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 3, false, 0, 0.0)

static func hollow_wail() -> AbilityData:
	return _make("Void Shriek", "The echo tears itself apart in a wail that shreds everything nearby.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 4, true, 0, 0.0)


# =============================================================================
# Act III: Cult dream guardian abilities
# =============================================================================

# --- Lucid Phantom ---

static func mind_spike() -> AbilityData:
	return _make("Mind Spike", "A focused thought driven like a nail.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func phase_shift() -> AbilityData:
	return _make("Phase Shift", "The phantom flickers between states of being.", Enums.StatType.DODGE_CHANCE, 10, 2, false, 3, false, 0, 0.0)

# --- Thread Spinner ---

static func woven_mend() -> AbilityData:
	return _make("Woven Mend", "Threads stitch together what was broken.", Enums.StatType.DEFENSE, 10, 2, false, 4, true, 0, 0.0)

static func thread_snare() -> AbilityData:
	return _make("Thread Snare", "Invisible threads tangle around the ankles.", Enums.StatType.SPEED, 8, 2, true, 3, false, 0, 0.0)

# --- Loom Sentinel ---

static func loom_strike() -> AbilityData:
	return _make("Loom Strike", "A fist of woven energy crashes down.", Enums.StatType.PHYSICAL_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func woven_armor() -> AbilityData:
	return _make("Loom Bash", "The sentinel swings an armored limb like a battering ram.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3)

# --- Cult Shade ---

static func dark_thread() -> AbilityData:
	return _make("Dark Thread", "A strand of shadow cuts through the air.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func unravel_mind() -> AbilityData:
	return _make("Unravel", "The shade pulls at the threads of magical resistance.", Enums.StatType.MAGIC_DEFENSE, 13, 2, true, 3, false, 0, 0.0)

# --- Dream Warden ---

static func ward_pulse() -> AbilityData:
	return _make("Ward Pulse", "A pulse of protective energy lashes outward.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func binding_light() -> AbilityData:
	return _make("Binding Light", "Light coils around the limbs and holds fast.", Enums.StatType.SPEED, 8, 2, true, 3, false, 0, 0.0)

# --- Thought Leech ---

static func psychic_siphon() -> AbilityData:
	return _make("Psychic Siphon", "It drains thought and converts it to sustenance.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, false, 0, 0.2)

static func mind_fog() -> AbilityData:
	return _make("Mind Fog", "A haze settles over every mind on the field.", Enums.StatType.ATTACK, 9, 2, true, 4, true, 0, 0.0)

# --- Void Spinner ---

static func void_thread() -> AbilityData:
	return _make("Void Thread", "Threads of nothingness pierce through all targets.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 4, false, 0, 0.0)

static func nullify() -> AbilityData:
	return _make("Nullify", "All targets' magic defense dissolves like mist.", Enums.StatType.MAGIC_DEFENSE, 9, 2, true, 3, false, 0, 0.0)

# --- Sanctum Guardian (boss) ---

static func loom_slam() -> AbilityData:
	return _make("Loom Slam", "The guardian brings down a column of woven force.", Enums.StatType.PHYSICAL_ATTACK, 10, 0, true, 4, false, 0, 0.0)

static func thread_storm() -> AbilityData:
	return _make("Thread Storm", "A maelstrom of razor-sharp threads fills the air.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 3, true, 0, 0.0)

static func guardians_veil() -> AbilityData:
	return _make("Guardian's Veil", "The guardian's power strips away the veil of protection from all intruders.", Enums.StatType.DEFENSE, 10, 2, true, 4, true, 0, 0.0)


# =============================================================================
# Acts IV-V: Cult member and final boss abilities
# =============================================================================

# --- Cult Acolyte (zealous apprentice, raw unfocused energy) ---

static func thread_sear() -> AbilityData:
	return _make("Thread Sear", "Raw Loom energy burns through body and spirit alike.", Enums.StatType.MIXED_ATTACK, 6, 0, true, 3, false, 0, 0.0)

static func zealots_fervor() -> AbilityData:
	return _make("Zealot's Strike", "Fanatical devotion channels into a reckless, devastating blow.", Enums.StatType.MIXED_ATTACK, 7, 0, true, 3)

# --- Cult Enforcer (thread-augmented warrior, muscles laced with filament) ---

static func thread_laced_fist() -> AbilityData:
	return _make("Thread-Laced Fist", "Threads woven through the knuckles keep cutting after impact.", Enums.StatType.HEALTH, 0, 3, true, 3, false, 3, 0.0)

static func threaded_sinew() -> AbilityData:
	return _make("Threaded Sinew", "The enforcer's war-rhythm saps the fighting spirit of every opponent.", Enums.StatType.ATTACK, 9, 2, true, 4, true, 0, 0.0)

# --- Cult Hexer ---

static func hex_bolt() -> AbilityData:
	return _make("Hex Bolt", "A crackling sphere of cursed energy.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func curse() -> AbilityData:
	return _make("Curse", "Words that sap the strength from limbs.", Enums.StatType.ATTACK, 11, 2, true, 3, false, 0, 0.0)

# --- Thread Guard (P15 — slow BURST hitter) ---

static func threaded_blade() -> AbilityData:
	return _make("Threaded Blade", "A sword wrapped in strands of woven power.", Enums.StatType.PHYSICAL_ATTACK, 9, 0, true, 3, false, 0, 0.0)

static func rending_weave() -> AbilityData:
	return _make("Rending Weave", "Dream-threads coil around the blade and rip through armor in a single devastating arc.", Enums.StatType.PHYSICAL_ATTACK, 9, 0, true, 3, false, 0, 0.0)

static func thread_impale() -> AbilityData:
	return _make("Thread Impale", "A spear of compressed dream-thread driven clean through the chest.", Enums.StatType.PHYSICAL_ATTACK, 15, 0, true, 5, false, 0, 0.0)

# --- Dream Hound (P15 — MIXED drainer) ---

static func dream_siphon() -> AbilityData:
	return _make("Dream Siphon", "Jaws latch on and drink the warmth from flesh and spirit alike.", Enums.StatType.MIXED_ATTACK, 7, 0, true, 3, false, 0, 0.2)

static func spectral_lunge() -> AbilityData:
	return _make("Spectral Lunge", "The hound flickers between waking and dreaming mid-leap, striking body and mind at once.", Enums.StatType.MIXED_ATTACK, 10, 0, true, 4, false, 0, 0.0)

# --- Cult Ritualist ---

static func ritual_chant() -> AbilityData:
	return _make("Ritual Chant", "An incantation that weakens every defense within earshot.", Enums.StatType.DEFENSE, 10, 2, true, 4, true, 0, 0.0)

# --- High Weaver ---

static func loom_blast() -> AbilityData:
	return _make("Loom Blast", "A concentrated burst of the Loom's power.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 4, false, 0, 0.0)

static func unweave() -> AbilityData:
	return _make("Unweave", "Defensive wards come apart thread by thread.", Enums.StatType.DEFENSE, 10, 2, true, 3, false, 0, 0.0)

# --- Shadow Fragment (final boss minion) ---

static func shadow_lash() -> AbilityData:
	return _make("Shadow Lash", "A tendril of living darkness whips across the field.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func consume_light() -> AbilityData:
	return _make("Consume Light", "The shadow feeds on hope and warmth.", Enums.StatType.ATTACK, 11, 2, true, 4, true, 0, 0.0)

# --- The Threadmaster (final boss) ---

static func thread_lash() -> AbilityData:
	return _make("Thread Lash", "A whip of braided dreamstuff cracks across flesh and armor.", Enums.StatType.PHYSICAL_ATTACK, 15, 0, true, 4, false, 0, 0.0)

static func loom_crush() -> AbilityData:
	return _make("Loom Crush", "Pillars of woven reality crash down on all who stand beneath.", Enums.StatType.PHYSICAL_ATTACK, 10, 0, true, 3, true, 0, 0.0)

static func sever() -> AbilityData:
	return _make("Sever", "A single clean cut through the threads that hold body together.", Enums.StatType.PHYSICAL_ATTACK, 12, 0, true, 3, false, 0, 0.0)

static func thread_bind() -> AbilityData:
	return _make("Thread Bind", "Threads tighten around the party, sapping the will to fight.", Enums.StatType.ATTACK, 13, 2, true, 4, true, 0, 0.0)

static func puppets_drain() -> AbilityData:
	return _make("Puppet's Drain", "The construct feeds, sustaining its borrowed form with stolen vitality.", Enums.StatType.PHYSICAL_ATTACK, 11, 0, true, 4, false, 0, 0.3)

# --- Cult Ritualist (boss additions) ---

static func ancient_rite() -> AbilityData:
	return _make("Ancient Rite", "He calls upon the full destructive power of the Thread cult's oldest ceremonies.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 4, false, 0, 0.0)

static func blood_weaving() -> AbilityData:
	return _make("Blood Weaving", "A ritual feeding that sustains the High Ritualist through stolen vitality.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 3, false, 0, 0.0)


# =============================================================================
# Physical attacker additions: high-mDef cult/weaving enemies (T2 rework pass)
# =============================================================================

# --- DreadTailor (cult seamstress, dream-shears) ---

static func shear() -> AbilityData:
	return _make("Shear", "Dream-shears close with surgical precision. Magic glances off the blades.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func snip_away() -> AbilityData:
	return _make("Snip Away", "The seamstress pivots, raking both blades across the entire field.", Enums.StatType.PHYSICAL_ATTACK, 4, 0, true, 4, true, 0, 0.0)

# --- NeedleWraith (animated bone-needle construct) ---

static func pin_barrage() -> AbilityData:
	return _make("Pin Barrage", "Dozens of bone-needles scatter in every direction at once.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 4, true, 0, 0.0)

static func puncture() -> AbilityData:
	return _make("Puncture", "A single needle drives through the thickest armor like paper.", Enums.StatType.PHYSICAL_ATTACK, 6, 0, true, 3, false, 0, 0.0)

# --- LoomCrusher (compacted woven-thread construct) ---

static func thread_crush() -> AbilityData:
	return _make("Thread Crush", "A fist of compacted dream-thread slams down with crushing force.", Enums.StatType.PHYSICAL_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func weave_brace() -> AbilityData:
	return _make("Weave Brace", "The construct draws its threads inward, coiling for a devastating follow-up strike.", Enums.StatType.ATTACK, 11, 1, false, 2, false, 0, 0.0)


# --- Thread Stitcher (P15 — SUPPORT healer) ---

static func thread_mend() -> AbilityData:
	return _make("Thread Mend", "Dream-threads stitch torn flesh back together.", Enums.StatType.HEALTH, 18, 0, false, 4, false, 0, 0.0)

static func lacerating_thread() -> AbilityData:
	return _make("Lacerating Thread", "A whip-thin strand of hardened dream-stuff lashes out with surgical spite.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, false, 0, 0.0)

