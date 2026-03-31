class_name EnemyAbilityDBS2Late

## Story 2 Acts III-IV enemy abilities (memory sanctum + Eye's domain).

const AbilityData := preload("res://scripts/data/ability_data.gd")
const Enums := preload("res://scripts/data/enums.gd")
const AbilityDB := preload("res://scripts/data/ability_db.gd")


static func _make(p_name: String, flavor: String, stat: Enums.StatType, mod: int,
		turns: int, on_enemy: bool, cost: int, all: bool = false,
		dot: int = 0, steal: float = 0.0) -> AbilityData:
	return AbilityDB._make(p_name, flavor, stat, mod, turns, on_enemy, cost, all, dot, steal)


# =============================================================================
# Act III: Memory sanctum abilities
# =============================================================================

# --- Shattered Frame ---

static func mirror_shard() -> AbilityData:
	return _make("Mirror Shard", "A razor-edged shard of enchanted glass tears free and hurls itself at the target.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func dissonant_echo() -> AbilityData:
	return _make("Dissonant Echo", "Overlapping reflections of the target's own movements scramble their timing.", Enums.StatType.SPEED, 6, 2, true, 3, false, 0, 0.0)

# --- Sorrow Shade ---

static func grief_surge() -> AbilityData:
	return _make("Grief Surge", "Crystallized sorrow launches itself at the target with shattering force.", Enums.StatType.MAGIC_ATTACK, 9, 0, true, 3, false, 0, 0.0)

static func shattered_trust() -> AbilityData:
	return _make("Despair Wave", "A wave of crystallized grief crashes over the target.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 4, false, 0, 0.0)

# --- Memory Reaper ---

static func harvesting_scythe() -> AbilityData:
	return _make("Harvesting Scythe", "The scythe sweeps through memories and flesh at once.", Enums.StatType.MIXED_ATTACK, 11, 0, true, 4, false, 0, 0.0)

static func accumulated_toll() -> AbilityData:
	return _make("Accumulated Toll", "Each memory claimed leaves a festering wound. The toll spreads.", Enums.StatType.HEALTH, 0, 3, true, 4, true, 3, 0.0)

# --- Memory Wisp ---

static func recall_bolt() -> AbilityData:
	return _make("Recall Bolt", "A shard of stolen memory strikes like lightning.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func memory_drain() -> AbilityData:
	return _make("Memory Drain", "The wisp pulls at the edges of thought.", Enums.StatType.MAGIC_DEFENSE, 10, 2, true, 3, false, 0, 0.0)

# --- Echo Sentinel ---

static func crystal_strike() -> AbilityData:
	return _make("Crystal Strike", "A crystalline fist crashes down with resonant force.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func ward_of_echoes() -> AbilityData:
	return _make("Ward of Echoes", "Layered reverberations harden into a shield.", Enums.StatType.DEFENSE, 10, 2, false, 3, false, 0, 0.0)

# --- Thought Eater ---

static func mind_rend() -> AbilityData:
	return _make("Mind Rend", "Psychic jaws tear through mental defenses.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 4, false, 0, 0.0)

static func psychic_leech() -> AbilityData:
	return _make("Psychic Leech", "The eater feeds on consciousness itself.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 3, false, 0, 0.2)

# --- Grief Shade ---

static func sorrows_touch() -> AbilityData:
	return _make("Sorrow's Touch", "A caress of pure sadness numbs the body.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 3, false, 0, 0.0)

static func wail_of_loss() -> AbilityData:
	return _make("Echo Wail", "A resonant cry of pure anguish tears through all who hear it.", Enums.StatType.MAGIC_ATTACK, 5, 0, true, 4, true, 0, 0.0)

# --- Hollow Watcher ---

static func blind_strike() -> AbilityData:
	return _make("Blind Strike", "Eyeless, it strikes with unerring precision.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func sense_intent() -> AbilityData:
	return _make("Sense Intent", "It reads your movements before you make them.", Enums.StatType.DEFENSE, 10, 2, true, 3, false, 0, 0.0)

# --- Mirror Self ---

static func mirrored_slash() -> AbilityData:
	return _make("Mirrored Slash", "Your own fighting style turned against you.", Enums.StatType.PHYSICAL_ATTACK, 11, 0, true, 4, false, 0, 0.0)

static func reflected_spell() -> AbilityData:
	return _make("Reflected Spell", "A stolen incantation cast with hollow precision.", Enums.StatType.MAGIC_ATTACK, 11, 0, true, 4, false, 0, 0.0)

# --- Void Weaver ---

static func void_bolt() -> AbilityData:
	return _make("Void Bolt", "A lance of nothingness tears through everything.", Enums.StatType.MAGIC_ATTACK, 11, 0, true, 4, true, 0, 0.0)

static func unravel() -> AbilityData:
	return _make("Unravel", "Reality frays at the seams, weakening all defenses.", Enums.StatType.MAGIC_DEFENSE, 13, 2, true, 4, false, 0, 0.0)

# --- Mnemonic Golem ---

static func memory_slam() -> AbilityData:
	return _make("Memory Slam", "A fist of crystallized memories crashes down.", Enums.StatType.PHYSICAL_ATTACK, 10, 0, true, 4, false, 0, 0.0)

static func crystallize() -> AbilityData:
	return _make("Crystallize", "Memories harden into impenetrable armor.", Enums.StatType.DEFENSE, 12, 2, false, 4, false, 0, 0.0)

# --- The Warden (boss) ---

static func sanctum_judgment() -> AbilityData:
	return _make("Sanctum Judgment", "The sanctum itself passes sentence on intruders.", Enums.StatType.MAGIC_ATTACK, 12, 0, true, 3, true, 0, 0.0)

static func barrier_of_ages() -> AbilityData:
	return _make("Barrier of Ages", "Centuries of accumulated memory form an unbreakable wall.", Enums.StatType.MAGIC_DEFENSE, 15, 2, false, 4, false, 0, 0.0)

static func decree_of_exile() -> AbilityData:
	return _make("Decree of Exile", "The sanctum's supreme authority strips away all protection. Intruders deserve none.", Enums.StatType.DEFENSE, 12, 2, true, 3, false, 0, 0.0)

# --- Fractured Protector (boss) ---

# --- Fading Wisp (P9 variant) ---

static func corrosive_flicker() -> AbilityData:
	return _make("Corrosive Flicker", "A sputtering burst of corrupted light that strikes with physical and magical force.", Enums.StatType.MIXED_ATTACK, 10, 0, true, 3, false, 0, 0.0)

static func flickering_decay() -> AbilityData:
	return _make("Flickering Decay", "The wisp's dying light clings to flesh and slowly burns from within.", Enums.StatType.HEALTH, 0, 3, true, 4, false, 4, 0.0)

# --- Dim Guardian (P9 variant) ---

static func fading_blow() -> AbilityData:
	return _make("Fading Blow", "A heavy fist strikes with diminished but still dangerous force.", Enums.StatType.PHYSICAL_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func last_surge() -> AbilityData:
	return _make("Last Surge", "The guardian channels its remaining existence into one devastating strike.", Enums.StatType.PHYSICAL_ATTACK, 15, 0, true, 5, false, 0, 0.0)

# --- Ward Construct (P12 GT variant) ---

static func reinforced_strike() -> AbilityData:
	return _make("Reinforced Strike", "Stone fists reinforced with crystallized wards crash down.", Enums.StatType.PHYSICAL_ATTACK, 11, 0, true, 4, false, 0, 0.0)

static func warding_presence() -> AbilityData:
	return _make("Warding Presence", "The construct projects an immovable aura. All hostility redirects toward its bulk.", Enums.StatType.TAUNT, 1, 2, false, 3, false, 0, 0.0)

# --- Null Phantom (P12 GT variant) ---

static func null_lance() -> AbilityData:
	return _make("Null Lance", "A beam of absolute nothing punches through matter and memory alike.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 4, false, 0, 0.0)

static func nullification() -> AbilityData:
	return _make("Nullification", "Everything the target knows about fighting simply ceases to exist.", Enums.StatType.ATTACK, 13, 2, true, 4, false, 0, 0.0)

# --- Threshold Echo (P12 GT variant) ---

static func liminal_strike() -> AbilityData:
	return _make("Liminal Strike", "The blow lands in two worlds at once, physical and ethereal.", Enums.StatType.MIXED_ATTACK, 11, 0, true, 4, false, 0, 0.0)

static func threshold_bind() -> AbilityData:
	return _make("Threshold Bind", "Crossing the boundary leaves the body sluggish, caught between here and there.", Enums.StatType.SPEED, 9, 2, true, 4, false, 0, 0.0)

# --- Ink Devourer (P12 FA variant) ---

static func ink_lash() -> AbilityData:
	return _make("Ink Lash", "A tendril of living ink whips forward, burning with absorbed knowledge.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 4, false, 0, 0.0)

static func devour_script() -> AbilityData:
	return _make("Devour Script", "The ink drinks deep from living memory, replenishing itself.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, false, 0, 0.25)

# --- Silent Archivist (P12 FA variant) ---

static func archived_spell() -> AbilityData:
	return _make("Archived Spell", "Pages riffle open and words of power leap from the text in cold, precise order.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 4, false, 0, 0.0)

static func silence() -> AbilityData:
	return _make("Silence", "A finger to stone lips. The target's strength drains into quiet obedience.", Enums.StatType.ATTACK, 13, 2, true, 4, false, 0, 0.0)

# --- Lost Record (P12 FA variant) ---

static func fragmented_blast() -> AbilityData:
	return _make("Fragmented Blast", "Broken words and half-formed spells hurl outward in a jagged spray.", Enums.StatType.MAGIC_ATTACK, 9, 0, true, 3, false, 0, 0.0)

static func corrupted_text() -> AbilityData:
	return _make("Corrupted Text", "Garbled information burrows into the mind, festering and wrong.", Enums.StatType.HEALTH, 0, 3, true, 4, false, 5, 0.0)

# --- Maw Codex (P12 FA variant) ---

static func tome_bite() -> AbilityData:
	return _make("Tome Bite", "The grimoire snaps open, revealing rows of teeth that clamp down on flesh.", Enums.StatType.PHYSICAL_ATTACK, 10, 0, true, 4, false, 0, 0.0)

static func knowledge_storm() -> AbilityData:
	return _make("Knowledge Storm", "Loose pages erupt outward in a razor-edged cyclone.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 4, true, 0, 0.0)


# =============================================================================
# Act IV: The Eye's domain abilities
# =============================================================================

# --- Pupil Leech ---

static func memory_siphon() -> AbilityData:
	return _make("Memory Siphon", "The leech latches onto thought itself, drinking deep.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 4, false, 0, 0.2)

static func festering_gaze() -> AbilityData:
	return _make("Festering Gaze", "The parasite's stolen eye leaves a wound that won't close.", Enums.StatType.HEALTH, 0, 3, true, 4, false, 3, 0.0)

# --- Gaze Stalker ---

static func piercing_gaze_strike() -> AbilityData:
	return _make("Piercing Gaze", "Eyes that cut deeper than any blade.", Enums.StatType.MIXED_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func focus_break() -> AbilityData:
	return _make("Focus Break", "A psychic jab that shatters concentration.", Enums.StatType.MAGIC_DEFENSE, 13, 2, true, 3, false, 0, 0.0)

# --- Memory Harvester ---

static func harvest_thought() -> AbilityData:
	return _make("Harvest Thought", "It plucks a memory and feeds.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 4, false, 0, 0.2)

static func mass_extraction() -> AbilityData:
	return _make("Mass Extraction", "A wave of hunger tears at every mind at once.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, true, 0, 0.0)

# --- Oblivion Shade ---

static func wave_of_oblivion() -> AbilityData:
	return _make("Wave of Oblivion", "A tide of nothing that drains the will to fight.", Enums.StatType.ATTACK, 11, 2, true, 3, true, 0, 0.0)

static func nihil_bolt() -> AbilityData:
	return _make("Nihil Bolt", "A bolt of pure emptiness.", Enums.StatType.MAGIC_ATTACK, 9, 0, true, 4, false, 0, 0.0)

# --- Thoughtform Knight ---

static func memory_blade() -> AbilityData:
	return _make("Memory Blade", "A sword forged from ten thousand stolen recollections.", Enums.StatType.PHYSICAL_ATTACK, 10, 0, true, 3, false, 0, 0.0)

static func ironclad_will() -> AbilityData:
	return _make("Ironclad Will", "Thought hardens into unbreakable armor.", Enums.StatType.DEFENSE, 12, 2, false, 3, false, 0, 0.0)

# --- The Iris (Phase 1 boss) ---

static func prismatic_blast() -> AbilityData:
	return _make("Prismatic Blast", "The Iris fractures light into a storm of burning color.", Enums.StatType.MAGIC_ATTACK, 13, 0, true, 4, true, 0, 0.0)

static func refraction_beam() -> AbilityData:
	return _make("Refraction Beam", "A focused beam that burns through all defenses.", Enums.StatType.MAGIC_ATTACK, 14, 0, true, 3, false, 0, 0.0)

static func crystalline_ward() -> AbilityData:
	return _make("Crystalline Ward", "The Iris wraps itself in layers of stolen light.", Enums.StatType.MAGIC_DEFENSE, 20, 2, false, 4, false, 0, 0.0)

# --- The Lidless Eye (Phase 2 final boss) ---


# =============================================================================
# Boss kit expansions
# =============================================================================

# --- The Warden (2 new abilities) ---

static func memory_verdict() -> AbilityData:
	return _make("Memory Verdict", "The Warden channels its full authority into a single devastating judgment.", Enums.StatType.MAGIC_ATTACK, 14, 0, true, 3, false, 0, 0.0)

# --- Fractured Protector / Sera (redesign -- healer using healing as weapon) ---

static func corrupted_mending() -> AbilityData:
	return _make("Corrupted Mending", "She heals herself with life-force stolen from those she was meant to protect.", Enums.StatType.HEALTH, 18, 0, false, 4, false, 0, 0.0)

static func eye_infused_strike() -> AbilityData:
	return _make("Eye-Infused Strike", "The Eye's power courses through her healing touch, burning instead of mending.", Enums.StatType.MAGIC_ATTACK, 14, 0, true, 4, false, 0, 0.0)

static func drowned_light() -> AbilityData:
	return _make("Drowned Light", "A wave of corrupted healing crashes outward, scalding every target it reaches.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 4, true, 0, 0.0)

static func memory_fracture() -> AbilityData:
	return _make("Memory Fracture", "Her touch scatters thought and reflex, leaving all movement sluggish.", Enums.StatType.SPEED, 8, 2, true, 3, true, 0, 0.0)

static func fractured_blessing() -> AbilityData:
	return _make("Fractured Blessing", "She blesses her enemies with inverted mercy, drawing their vitality into herself.", Enums.StatType.MAGIC_ATTACK, 11, 0, true, 3, false, 0, 0.2)

# --- The Iris (2 new abilities) ---

static func eye_lance() -> AbilityData:
	return _make("Eye Lance", "A focused beam that destroys what it sees, leaving only void where memory was.", Enums.StatType.MAGIC_ATTACK, 13, 0, true, 4, false, 0, 0.0)

static func memory_erosion() -> AbilityData:
	return _make("Memory Erosion", "The Iris dissolves the magical protection from a single target, preparing the killing blow.", Enums.StatType.MAGIC_DEFENSE, 18, 2, true, 3, false, 0, 0.0)

# --- Void Iris (boss support redesign) ---

static func void_pulse() -> AbilityData:
	return _make("Void Pulse", "A scattered burst of the Eye's light scours every target.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, true, 0, 0.0)

static func refraction_link() -> AbilityData:
	return _make("Refraction Link", "The Void Iris amplifies its master's destructive potential through prismatic resonance.", Enums.StatType.ATTACK, 13, 2, false, 3, false, 0, 0.0)

static func dispel_will() -> AbilityData:
	return _make("Dispel Will", "A splinter of void cuts the resolve from a single target.", Enums.StatType.ATTACK, 11, 2, true, 3, false, 0, 0.0)

static func null_mending() -> AbilityData:
	return _make("Null Mending", "The Void Iris channels refracted void light into its allies, reversing wounds with stolen radiance.", Enums.StatType.HEALTH, 9, 0, false, 3, true, 0, 0.0)

# --- Eye of Oblivion / Lidless Eye (dying monster kit -- all offense) ---

static func crushing_gaze() -> AbilityData:
	return _make("Crushing Gaze", "One last focused stare. The weight of its dying perception breaks bone and will alike.", Enums.StatType.PHYSICAL_ATTACK, 18, 0, true, 4, false, 0, 0.0)

static func desperate_lunge() -> AbilityData:
	return _make("Desperate Lunge", "It throws its massive form forward, all pretense of control abandoned.", Enums.StatType.PHYSICAL_ATTACK, 15, 0, true, 4, false, 0, 0.0)

static func death_throes() -> AbilityData:
	return _make("Death Throes", "Everything left, physical and arcane, scattered in one convulsive blast.", Enums.StatType.MIXED_ATTACK, 14, 0, true, 4, true, 0, 0.0)

static func collapse() -> AbilityData:
	return _make("Collapse", "The Eye burns from within. The light goes out in pieces.", Enums.StatType.HEALTH, 0, 3, true, 4, true, 3, 0.0)

static func last_tremor() -> AbilityData:
	return _make("Last Tremor", "The final shudder before extinction. Faint, but still crushing.", Enums.StatType.PHYSICAL_ATTACK, 11, 0, true, 3, true, 0, 0.0)
