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
	return _make("Dissonant Echo", "Overlapping reflections of the target's own movements scramble their timing.", Enums.StatType.SPEED, 4, 2, true, 3, false, 0, 0.0)

# --- Sorrow Shade ---

static func grief_surge() -> AbilityData:
	return _make("Grief Surge", "Crystallized sorrow launches itself at the target with shattering force.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func shattered_trust() -> AbilityData:
	return _make("Shattered Trust", "The memory of betrayal crumbles all defensive conviction.", Enums.StatType.DEFENSE, 4, 2, true, 4, true, 0, 0.0)

# --- Memory Reaper ---

static func harvesting_scythe() -> AbilityData:
	return _make("Harvesting Scythe", "The scythe sweeps through memories and flesh at once.", Enums.StatType.MIXED_ATTACK, 11, 0, true, 4, false, 0, 0.0)

static func accumulated_toll() -> AbilityData:
	return _make("Accumulated Toll", "Each memory claimed leaves a festering wound. The toll spreads.", Enums.StatType.HEALTH, 6, 3, true, 4, true, 3, 0.0)

# --- Void Iris ---

static func void_gaze() -> AbilityData:
	return _make("Void Gaze", "The void at the Iris's center opens fully. To meet it is to lose yourself in darkness.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 4, false, 0, 0.0)

static func iris_flash() -> AbilityData:
	return _make("Iris Flash", "The Iris flares open, flooding the chamber with blinding light that scrambles all reaction.", Enums.StatType.SPEED, 5, 2, true, 3, true, 0, 0.0)

# --- Memory Wisp ---

static func recall_bolt() -> AbilityData:
	return _make("Recall Bolt", "A shard of stolen memory strikes like lightning.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func memory_drain() -> AbilityData:
	return _make("Memory Drain", "The wisp pulls at the edges of thought.", Enums.StatType.MAGIC_DEFENSE, 4, 2, true, 3, false, 0, 0.0)

# --- Echo Sentinel ---

static func crystal_strike() -> AbilityData:
	return _make("Crystal Strike", "A crystalline fist crashes down with resonant force.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func ward_of_echoes() -> AbilityData:
	return _make("Ward of Echoes", "Layered reverberations harden into a shield.", Enums.StatType.DEFENSE, 5, 2, false, 3, false, 0, 0.0)

# --- Thought Eater ---

static func mind_rend() -> AbilityData:
	return _make("Mind Rend", "Psychic jaws tear through mental defenses.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 4, false, 0, 0.0)

static func psychic_leech() -> AbilityData:
	return _make("Psychic Leech", "The eater feeds on consciousness itself.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 3, false, 0, 0.3)

# --- Grief Shade ---

static func sorrows_touch() -> AbilityData:
	return _make("Sorrow's Touch", "A caress of pure sadness numbs the body.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 3, false, 0, 0.0)

static func wail_of_loss() -> AbilityData:
	return _make("Wail of Loss", "A cry that drains the will to fight from all who hear it.", Enums.StatType.ATTACK, 4, 2, true, 4, true, 0, 0.0)

# --- Hollow Watcher ---

static func blind_strike() -> AbilityData:
	return _make("Blind Strike", "Eyeless, it strikes with unerring precision.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func sense_intent() -> AbilityData:
	return _make("Sense Intent", "It reads your movements before you make them.", Enums.StatType.DEFENSE, 4, 2, true, 3, false, 0, 0.0)

# --- Mirror Self ---

static func mirrored_slash() -> AbilityData:
	return _make("Mirrored Slash", "Your own fighting style turned against you.", Enums.StatType.PHYSICAL_ATTACK, 9, 0, true, 4, false, 0, 0.0)

static func reflected_spell() -> AbilityData:
	return _make("Reflected Spell", "A stolen incantation cast with hollow precision.", Enums.StatType.MAGIC_ATTACK, 9, 0, true, 4, false, 0, 0.0)

# --- Void Weaver ---

static func void_bolt() -> AbilityData:
	return _make("Void Bolt", "A lance of nothingness tears through everything.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 4, true, 0, 0.0)

static func unravel() -> AbilityData:
	return _make("Unravel", "Reality frays at the seams, weakening all defenses.", Enums.StatType.MAGIC_DEFENSE, 5, 2, true, 4, false, 0, 0.0)

# --- Mnemonic Golem ---

static func memory_slam() -> AbilityData:
	return _make("Memory Slam", "A fist of crystallized memories crashes down.", Enums.StatType.PHYSICAL_ATTACK, 10, 0, true, 4, false, 0, 0.0)

static func crystallize() -> AbilityData:
	return _make("Crystallize", "Memories harden into impenetrable armor.", Enums.StatType.DEFENSE, 6, 2, false, 4, false, 0, 0.0)

# --- The Warden (boss) ---

static func sanctum_judgment() -> AbilityData:
	return _make("Sanctum Judgment", "The sanctum itself passes sentence on intruders.", Enums.StatType.MAGIC_ATTACK, 12, 0, true, 3, true, 0, 0.0)

static func barrier_of_ages() -> AbilityData:
	return _make("Barrier of Ages", "Centuries of accumulated memory form an unbreakable wall.", Enums.StatType.MAGIC_DEFENSE, 6, 2, false, 4, false, 0, 0.0)

static func decree_of_exile() -> AbilityData:
	return _make("Decree of Exile", "The sanctum's supreme authority strips away all protection. Intruders deserve none.", Enums.StatType.DEFENSE, 6, 2, true, 3, false, 0, 0.0)

# --- Fractured Protector (boss) ---

static func desperate_strike() -> AbilityData:
	return _make("Desperate Strike", "A blow struck not in anger but in fear.", Enums.StatType.PHYSICAL_ATTACK, 11, 0, true, 4, false, 0, 0.0)

static func memory_seal() -> AbilityData:
	return _make("Memory Seal", "A pulse that clouds the mind and slows all thought.", Enums.StatType.SPEED, 5, 2, true, 3, true, 0, 0.0)

static func forgetting_touch() -> AbilityData:
	return _make("Forgetting Touch", "One touch and something important slips away.", Enums.StatType.MAGIC_ATTACK, 9, 0, true, 4, false, 0, 0.3)

# --- Fading Wisp (P9 variant) ---

static func flicker_bolt() -> AbilityData:
	return _make("Flicker Bolt", "A stuttering lance of dying light strikes with erratic force.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func dim_aura() -> AbilityData:
	return _make("Dim Aura", "The fading light seeps into magical wards and unravels them from within.", Enums.StatType.MAGIC_DEFENSE, 5, 2, true, 4, true, 0, 0.0)

# --- Dim Guardian (P9 variant) ---

static func fading_blow() -> AbilityData:
	return _make("Fading Blow", "A heavy fist strikes with diminished but still dangerous force.", Enums.StatType.PHYSICAL_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func waning_ward() -> AbilityData:
	return _make("Waning Ward", "A protective barrier flickers to life, weaker than it once was but still standing.", Enums.StatType.DEFENSE, 4, 2, false, 4, true, 0, 0.0)

# --- Ward Construct (P12 GT variant) ---

static func reinforced_strike() -> AbilityData:
	return _make("Reinforced Strike", "Stone fists reinforced with crystallized wards crash down.", Enums.StatType.PHYSICAL_ATTACK, 11, 0, true, 4, false, 0, 0.0)

static func warding_presence() -> AbilityData:
	return _make("Warding Presence", "The construct projects an immovable aura. All hostility redirects toward its bulk.", Enums.StatType.TAUNT, 1, 2, false, 3, false, 0, 0.0)

# --- Null Phantom (P12 GT variant) ---

static func null_lance() -> AbilityData:
	return _make("Null Lance", "A beam of absolute nothing punches through matter and memory alike.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 4, false, 0, 0.0)

static func nullification() -> AbilityData:
	return _make("Nullification", "Everything the target knows about fighting simply ceases to exist.", Enums.StatType.ATTACK, 6, 2, true, 4, false, 0, 0.0)

# --- Threshold Echo (P12 GT variant) ---

static func liminal_strike() -> AbilityData:
	return _make("Liminal Strike", "The blow lands in two worlds at once, physical and ethereal.", Enums.StatType.MIXED_ATTACK, 11, 0, true, 4, false, 0, 0.0)

static func threshold_bind() -> AbilityData:
	return _make("Threshold Bind", "Crossing the boundary leaves the body sluggish, caught between here and there.", Enums.StatType.SPEED, 6, 2, true, 4, false, 0, 0.0)

# --- Archive Keeper (P12 FA variant) ---

static func archive_slam() -> AbilityData:
	return _make("Archive Slam", "Stone shelves topple forward, driven by the keeper's immense weight.", Enums.StatType.PHYSICAL_ATTACK, 11, 0, true, 4, false, 0, 0.0)

static func guardian_oath() -> AbilityData:
	return _make("Guardian Oath", "The keeper steps forward, its bulk filling the passage. Nothing gets past.", Enums.StatType.TAUNT, 1, 2, false, 3, false, 0, 0.0)

# --- Silent Archivist (P12 FA variant) ---

static func archived_spell() -> AbilityData:
	return _make("Archived Spell", "Pages riffle open and words of power leap from the text in cold, precise order.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 4, false, 0, 0.0)

static func silence() -> AbilityData:
	return _make("Silence", "A finger to stone lips. The target's strength drains into quiet obedience.", Enums.StatType.ATTACK, 6, 2, true, 4, false, 0, 0.0)

# --- Lost Record (P12 FA variant) ---

static func fragmented_blast() -> AbilityData:
	return _make("Fragmented Blast", "Broken words and half-formed spells hurl outward in a jagged spray.", Enums.StatType.MAGIC_ATTACK, 9, 0, true, 3, false, 0, 0.0)

static func corrupted_text() -> AbilityData:
	return _make("Corrupted Text", "Garbled information burrows into the mind, festering and wrong.", Enums.StatType.HEALTH, 8, 3, true, 4, false, 4, 0.0)

# --- Faded Page (P12 FA variant) ---

static func binding_press() -> AbilityData:
	return _make("Binding Press", "Pages snap shut with crushing force, edges sharp enough to draw blood.", Enums.StatType.PHYSICAL_ATTACK, 9, 0, true, 3, false, 0, 0.0)

static func eroding_script() -> AbilityData:
	return _make("Eroding Script", "Faded words crawl across the target's skin, dissolving wards and armor alike.", Enums.StatType.DEFENSE, 5, 2, true, 3, false, 0, 0.0)


# =============================================================================
# Act IV: The Eye's domain abilities
# =============================================================================

# --- Gaze Stalker ---

static func piercing_gaze_strike() -> AbilityData:
	return _make("Piercing Gaze", "Eyes that cut deeper than any blade.", Enums.StatType.MIXED_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func focus_break() -> AbilityData:
	return _make("Focus Break", "A psychic jab that shatters concentration.", Enums.StatType.MAGIC_DEFENSE, 5, 2, true, 3, false, 0, 0.0)

# --- Memory Harvester ---

static func harvest_thought() -> AbilityData:
	return _make("Harvest Thought", "It plucks a memory and feeds.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 4, false, 0, 0.35)

static func mass_extraction() -> AbilityData:
	return _make("Mass Extraction", "A wave of hunger tears at every mind at once.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, true, 0, 0.0)

# --- Oblivion Shade ---

static func wave_of_oblivion() -> AbilityData:
	return _make("Wave of Oblivion", "A tide of nothing that drains the will to fight.", Enums.StatType.ATTACK, 5, 2, true, 3, true, 0, 0.0)

static func nihil_bolt() -> AbilityData:
	return _make("Nihil Bolt", "A bolt of pure emptiness.", Enums.StatType.MAGIC_ATTACK, 9, 0, true, 4, false, 0, 0.0)

# --- Thoughtform Knight ---

static func memory_blade() -> AbilityData:
	return _make("Memory Blade", "A sword forged from ten thousand stolen recollections.", Enums.StatType.PHYSICAL_ATTACK, 10, 0, true, 3, false, 0, 0.0)

static func ironclad_will() -> AbilityData:
	return _make("Ironclad Will", "Thought hardens into unbreakable armor.", Enums.StatType.DEFENSE, 6, 2, false, 3, false, 0, 0.0)

# --- The Iris (Phase 1 boss) ---

static func prismatic_blast() -> AbilityData:
	return _make("Prismatic Blast", "The Iris fractures light into a storm of burning color.", Enums.StatType.MAGIC_ATTACK, 12, 0, true, 4, true, 0, 0.0)

static func refraction_beam() -> AbilityData:
	return _make("Refraction Beam", "A focused beam that burns through all defenses.", Enums.StatType.MAGIC_ATTACK, 14, 0, true, 3, false, 0, 0.0)

static func crystalline_ward() -> AbilityData:
	return _make("Crystalline Ward", "The Iris wraps itself in layers of stolen light.", Enums.StatType.MAGIC_DEFENSE, 7, 2, false, 4, false, 0, 0.0)

# --- The Lidless Eye (Phase 2 final boss) ---

static func gaze_of_forgetting() -> AbilityData:
	return _make("Gaze of Forgetting", "Its stare peels away everything you are.", Enums.StatType.ATTACK, 6, 2, true, 4, true, 0, 0.0)

static func memory_devour() -> AbilityData:
	return _make("Memory Devour", "It eats what makes you whole.", Enums.StatType.MAGIC_ATTACK, 12, 0, true, 3, false, 0, 0.35)

static func final_blink() -> AbilityData:
	return _make("Final Blink", "The last thing it sees, it destroys.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 3, true, 0, 0.0)
