class_name EnemyAbilityDBS3

## Story 3 enemy abilities (dreams + cult).

const AbilityData := preload("res://scripts/data/ability_data.gd")
const Enums := preload("res://scripts/data/enums.gd")
const AbilityDB := preload("res://scripts/data/ability_db.gd")


static func _make(p_name: String, flavor: String, stat: Enums.StatType, mod: int,
		turns: int, on_enemy: bool, cost: int, all: bool = false,
		dot: int = 0, steal: float = 0.0, cd: int = 0) -> AbilityData:
	return AbilityDB._make(p_name, flavor, stat, mod, turns, on_enemy, cost, all, dot, steal, cd)


# =============================================================================
# Act I: Dream fauna abilities
# =============================================================================

# --- Dream Wisp ---

static func shimmer_bolt() -> AbilityData:
	return _make("Shimmer Bolt", "A flickering mote of light that stings on contact.", Enums.StatType.MAGIC_ATTACK, 3, 0, true, 2, false, 0, 0.0, 2)

static func daze() -> AbilityData:
	return _make("Daze", "The light pulses, leaving the mind sluggish.", Enums.StatType.SPEED, 3, 2, true, 2, false, 0, 0.0, 2)

# --- Phantasm ---

static func phase_strike() -> AbilityData:
	return _make("Phase Strike", "A translucent fist passes through armor and flesh alike.", Enums.StatType.MIXED_ATTACK, 4, 0, true, 3, false, 0, 0.0, 2)

static func unnerve() -> AbilityData:
	return _make("Unnerve", "The air grows cold and confidence falters.", Enums.StatType.DEFENSE, 3, 2, true, 2, false, 0, 0.0, 2)

# --- Shade Moth ---

static func dust_wing() -> AbilityData:
	return _make("Dust Wing", "Scales of shadow scrape across exposed skin.", Enums.StatType.PHYSICAL_ATTACK, 3, 0, true, 2, false, 0, 0.0, 2)

static func flit() -> AbilityData:
	return _make("Flit", "The moth darts erratically, impossible to track.", Enums.StatType.SPEED, 5, 2, false, 2, false, 0, 0.0, 2)

# --- Slumber Beast ---

static func heavy_paw() -> AbilityData:
	return _make("Heavy Paw", "A massive paw crashes down with dreamlike weight.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 2, false, 0, 0.0, 2)

static func drowsy_roar() -> AbilityData:
	return _make("Drowsy Roar", "A deep rumble that makes eyelids heavy.", Enums.StatType.SPEED, 3, 2, true, 4, true, 0, 0.0, 3)

# --- Fog Wraith ---

static func mist_tendril() -> AbilityData:
	return _make("Mist Tendril", "A tendril of fog wraps tight and squeezes.", Enums.StatType.MAGIC_ATTACK, 4, 0, true, 3, false, 0, 0.0, 2)

static func chill_fog() -> AbilityData:
	return _make("Chill Fog", "Cold mist settles over everyone.", Enums.StatType.MAGIC_ATTACK, 3, 0, true, 4, true, 0, 0.0, 3)

# --- Sleep Stalker ---

static func dream_fang() -> AbilityData:
	return _make("Dream Fang", "Teeth that feel real enough to draw blood.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 2, false, 0, 0.0, 2)

static func shadow_lunge() -> AbilityData:
	return _make("Shadow Lunge", "A blur of darkness closes the distance in an instant.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.0, 2)

# --- Mirror Shade ---

static func reflected_strike() -> AbilityData:
	return _make("Reflected Strike", "Your own movements turned against you.", Enums.StatType.MIXED_ATTACK, 4, 0, true, 3, false, 0, 0.0, 2)

static func mimic_stance() -> AbilityData:
	return _make("Mimic Stance", "The shade copies a defensive posture it observed.", Enums.StatType.DEFENSE, 3, 2, false, 2, false, 0, 0.0, 2)

# --- Thorn Dreamer ---

static func briar_lash() -> AbilityData:
	return _make("Briar Lash", "Thorny vines lash out and keep cutting.", Enums.StatType.PHYSICAL_ATTACK, 3, 3, true, 3, false, 2, 0.0, 2)

static func spore_cloud() -> AbilityData:
	return _make("Spore Cloud", "A cloud of numbing spores drifts over the field.", Enums.StatType.DEFENSE, 3, 2, true, 4, true, 0, 0.0, 3)


# =============================================================================
# Act II: Nightmare entity abilities
# =============================================================================

# --- Nightmare Hound ---

static func savage_bite() -> AbilityData:
	return _make("Savage Bite", "Jaws snap with force that shouldn't exist in a dream.", Enums.StatType.PHYSICAL_ATTACK, 6, 0, true, 3, false, 0, 0.0, 2)

static func howl() -> AbilityData:
	return _make("Howl", "The pack surges forward at the sound.", Enums.StatType.SPEED, 3, 2, false, 3, true, 0, 0.0, 3)

# --- Dream Weaver ---

static func thread_bolt() -> AbilityData:
	return _make("Thread Bolt", "A needle of woven light pierces through.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 3, false, 0, 0.0, 2)

static func woven_ward() -> AbilityData:
	return _make("Woven Ward", "Threads of dream-stuff harden into a barrier.", Enums.StatType.DEFENSE, 4, 2, false, 3, true, 0, 0.0, 3)

# --- Somnolent Serpent ---

static func venom_coil() -> AbilityData:
	return _make("Venom Coil", "Fangs sink in and the poison keeps working.", Enums.StatType.PHYSICAL_ATTACK, 5, 3, true, 3, false, 3, 0.0, 2)

static func sleep_fang() -> AbilityData:
	return _make("Sleep Fang", "A bite that numbs the limbs.", Enums.StatType.SPEED, 4, 2, true, 3, false, 0, 0.0, 2)

# --- Twilight Stalker ---

static func dusk_blade() -> AbilityData:
	return _make("Dusk Blade", "A blade forged from the edge of waking.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.0, 2)

static func vanish_strike() -> AbilityData:
	return _make("Vanish Strike", "It disappears and reappears behind you.", Enums.StatType.PHYSICAL_ATTACK, 9, 0, true, 4, false, 0, 0.0, 2)

# --- Dusk Sentinel ---

static func iron_stance() -> AbilityData:
	return _make("Iron Stance", "An immovable silhouette braces against all harm.", Enums.StatType.DEFENSE, 5, 2, false, 3, false, 0, 0.0, 2)

static func shield_bash() -> AbilityData:
	return _make("Shield Bash", "A wall of shadow slams forward.", Enums.StatType.PHYSICAL_ATTACK, 6, 0, true, 3, false, 0, 0.0, 2)

# --- Hollow Echo ---

static func echo_drain() -> AbilityData:
	return _make("Echo Drain", "It feeds on the reverberations of your voice.", Enums.StatType.MAGIC_ATTACK, 5, 0, true, 3, false, 0, 0.3, 2)

static func dissonance() -> AbilityData:
	return _make("Dissonance", "Conflicting sounds shatter concentration.", Enums.StatType.DEFENSE, 4, 2, true, 3, false, 0, 0.0, 2)

# --- Waking Terror ---

static func scream_blast() -> AbilityData:
	return _make("Scream", "A sound that shouldn't be possible tears through the air.", Enums.StatType.MAGIC_ATTACK, 5, 0, true, 4, true, 0, 0.0, 3)

static func terror_wave() -> AbilityData:
	return _make("Terror Wave", "A pulse of raw fear washes over everyone.", Enums.StatType.SPEED, 4, 2, true, 4, true, 0, 0.0, 3)

# --- Clock Specter ---

static func time_rend() -> AbilityData:
	return _make("Time Rend", "The hands of the clock spin backward through flesh.", Enums.StatType.MIXED_ATTACK, 6, 0, true, 3, false, 0, 0.0, 2)

static func stasis_touch() -> AbilityData:
	return _make("Stasis Touch", "Time stops for just a heartbeat too long.", Enums.StatType.SPEED, 5, 2, true, 3, false, 0, 0.0, 2)

# --- The Nightmare (boss) ---

static func nightmare_crush() -> AbilityData:
	return _make("Nightmare Crush", "The full weight of dread made physical.", Enums.StatType.PHYSICAL_ATTACK, 8, 0, true, 4, false, 0, 0.0, 2)

static func dream_rend() -> AbilityData:
	return _make("Dream Rend", "The dreamscape tears apart around you.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 5, true, 0, 0.0, 3)

static func dread_aura() -> AbilityData:
	return _make("Dread Aura", "Courage withers in its presence.", Enums.StatType.DEFENSE, 4, 2, true, 4, true, 0, 0.0, 3)


# =============================================================================
# Act III: Cult dream guardian abilities
# =============================================================================

# --- Lucid Phantom ---

static func mind_spike() -> AbilityData:
	return _make("Mind Spike", "A focused thought driven like a nail.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, false, 0, 0.0, 2)

static func phase_shift() -> AbilityData:
	return _make("Phase Shift", "The phantom flickers between states of being.", Enums.StatType.DODGE_CHANCE, 10, 2, false, 3, false, 0, 0.0, 2)

# --- Thread Spinner ---

static func woven_mend() -> AbilityData:
	return _make("Woven Mend", "Threads stitch together what was broken.", Enums.StatType.DEFENSE, 5, 2, false, 4, true, 0, 0.0, 3)

static func thread_snare() -> AbilityData:
	return _make("Thread Snare", "Invisible threads tangle around the ankles.", Enums.StatType.SPEED, 5, 2, true, 3, false, 0, 0.0, 2)

# --- Loom Sentinel ---

static func loom_strike() -> AbilityData:
	return _make("Loom Strike", "A fist of woven energy crashes down.", Enums.StatType.PHYSICAL_ATTACK, 8, 0, true, 3, false, 0, 0.0, 2)

static func woven_armor() -> AbilityData:
	return _make("Woven Armor", "Layers of thread harden into plating.", Enums.StatType.DEFENSE, 6, 2, false, 3, false, 0, 0.0, 2)

# --- Cult Shade ---

static func dark_thread() -> AbilityData:
	return _make("Dark Thread", "A strand of shadow cuts through the air.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 3, false, 0, 0.0, 2)

static func unravel_mind() -> AbilityData:
	return _make("Unravel", "The shade pulls at the threads of magical resistance.", Enums.StatType.MAGIC_DEFENSE, 5, 2, true, 3, false, 0, 0.0, 2)

# --- Dream Warden ---

static func ward_pulse() -> AbilityData:
	return _make("Ward Pulse", "A pulse of protective energy lashes outward.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, false, 0, 0.0, 2)

static func binding_light() -> AbilityData:
	return _make("Binding Light", "Light coils around the limbs and holds fast.", Enums.StatType.SPEED, 5, 2, true, 3, false, 0, 0.0, 2)

# --- Thought Leech ---

static func psychic_siphon() -> AbilityData:
	return _make("Psychic Siphon", "It drains thought and converts it to sustenance.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, false, 0, 0.3, 2)

static func mind_fog() -> AbilityData:
	return _make("Mind Fog", "A haze settles over every mind on the field.", Enums.StatType.ATTACK, 4, 2, true, 4, true, 0, 0.0, 3)

# --- Void Spinner ---

static func void_thread() -> AbilityData:
	return _make("Void Thread", "Threads of nothingness cut through everything.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 4, true, 0, 0.0, 3)

static func nullify() -> AbilityData:
	return _make("Nullify", "Magic defenses dissolve like mist.", Enums.StatType.MAGIC_DEFENSE, 4, 2, true, 4, true, 0, 0.0, 3)

# --- Sanctum Guardian (boss) ---

static func loom_slam() -> AbilityData:
	return _make("Loom Slam", "The guardian brings down a column of woven force.", Enums.StatType.PHYSICAL_ATTACK, 10, 0, true, 4, false, 0, 0.0, 2)

static func thread_storm() -> AbilityData:
	return _make("Thread Storm", "A maelstrom of razor-sharp threads fills the air.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 5, true, 0, 0.0, 3)

static func guardians_veil() -> AbilityData:
	return _make("Guardian's Veil", "The guardian wraps itself in the Loom's protection.", Enums.StatType.DEFENSE, 6, 2, false, 4, false, 0, 0.0, 2)


# =============================================================================
# Acts IV-V: Cult member and final boss abilities
# =============================================================================

# --- Cult Acolyte ---

static func dark_bolt() -> AbilityData:
	return _make("Dark Bolt", "A bolt of shadow flung with practiced ease.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 3, false, 0, 0.0, 2)

static func minor_ward() -> AbilityData:
	return _make("Minor Ward", "A basic protective incantation.", Enums.StatType.DEFENSE, 3, 2, false, 2, false, 0, 0.0, 2)

# --- Cult Enforcer ---

static func heavy_strike() -> AbilityData:
	return _make("Heavy Strike", "A deliberate blow backed by trained muscle.", Enums.StatType.PHYSICAL_ATTACK, 8, 0, true, 3, false, 0, 0.0, 2)

static func brace() -> AbilityData:
	return _make("Brace", "The enforcer sets their stance and hardens.", Enums.StatType.DEFENSE, 5, 2, false, 3, false, 0, 0.0, 2)

# --- Cult Hexer ---

static func hex_bolt() -> AbilityData:
	return _make("Hex Bolt", "A crackling sphere of cursed energy.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, false, 0, 0.0, 2)

static func curse() -> AbilityData:
	return _make("Curse", "Words that sap the strength from limbs.", Enums.StatType.ATTACK, 5, 2, true, 3, false, 0, 0.0, 2)

# --- Thread Guard ---

static func threaded_blade() -> AbilityData:
	return _make("Threaded Blade", "A sword wrapped in strands of woven power.", Enums.StatType.PHYSICAL_ATTACK, 9, 0, true, 3, false, 0, 0.0, 2)

static func woven_shield() -> AbilityData:
	return _make("Woven Shield", "Dream-threads form a barrier around allies.", Enums.StatType.DEFENSE, 5, 2, false, 4, true, 0, 0.0, 3)

# --- Dream Hound ---

static func feral_bite() -> AbilityData:
	return _make("Feral Bite", "Teeth close with wild, desperate force.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.0, 2)

static func dream_howl() -> AbilityData:
	return _make("Dream Howl", "A howl that reverberates through waking and dreaming.", Enums.StatType.SPEED, 4, 2, true, 4, true, 0, 0.0, 3)

# --- Cult Ritualist ---

static func ritual_chant() -> AbilityData:
	return _make("Ritual Chant", "An incantation that strengthens all who hear it.", Enums.StatType.DEFENSE, 5, 2, false, 4, true, 0, 0.0, 3)

static func thread_lash() -> AbilityData:
	return _make("Thread Lash", "A whip of woven dream-stuff cracks through the air.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, false, 0, 0.0, 2)

# --- High Weaver ---

static func loom_blast() -> AbilityData:
	return _make("Loom Blast", "A concentrated burst of the Loom's power.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 4, false, 0, 0.0, 2)

static func unweave() -> AbilityData:
	return _make("Unweave", "Defensive wards come apart thread by thread.", Enums.StatType.DEFENSE, 5, 2, true, 3, false, 0, 0.0, 2)

# --- Shadow Fragment (final boss minion) ---

static func shadow_lash() -> AbilityData:
	return _make("Shadow Lash", "A tendril of living darkness whips across the field.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 3, false, 0, 0.0, 2)

static func consume_light() -> AbilityData:
	return _make("Consume Light", "The shadow feeds on hope and warmth.", Enums.StatType.ATTACK, 5, 2, true, 4, true, 0, 0.0, 3)

# --- The Threadmaster (final boss) ---

static func dream_shatter() -> AbilityData:
	return _make("Dream Shatter", "The Loom convulses and everything breaks.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 5, true, 0, 0.0, 3)

static func loom_collapse() -> AbilityData:
	return _make("Loom Collapse", "Pillars of woven reality crash down.", Enums.StatType.PHYSICAL_ATTACK, 12, 0, true, 5, false, 0, 0.0, 2)

static func thread_of_oblivion() -> AbilityData:
	return _make("Thread of Oblivion", "A single thread that unravels the will to fight.", Enums.StatType.ATTACK, 6, 2, true, 6, true, 0, 0.0, 3)
