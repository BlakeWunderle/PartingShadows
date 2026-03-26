class_name EnemyDBS2Act3

## Story 2 Act III enemy factory: memory sanctum constructs.

const FighterData := preload("res://scripts/data/fighter_data.gd")
const EABL := preload("res://scripts/data/story2/enemy_ability_db_s2_late.gd")
const EH := preload("res://scripts/data/enemy_helpers.gd")


# =============================================================================
# Sanctum guardians (levels 10-11) -- used by P10, P11
# =============================================================================

static func create_memory_wisp(n: String, lvl: int = 10) -> FighterData:
	var f := EH.base(n, "Memory Wisp", lvl)
	f.health = EH.es(392, 461, 4, 7, lvl, 10); f.max_health = f.health
	f.mana = EH.es(16, 19, 1, 2, lvl, 10); f.max_mana = f.mana
	f.physical_attack = EH.es(10, 14, 0, 2, lvl, 10)
	f.physical_defense = EH.es(21, 28, 1, 3, lvl, 10)
	f.magic_attack = EH.es(70, 82, 2, 4, lvl, 10)
	f.magic_defense = EH.es(32, 39, 2, 3, lvl, 10)
	f.speed = EH.es(33, 39, 2, 3, lvl, 10)
	f.crit_chance = 11; f.crit_damage = 2; f.dodge_chance = 21
	f.abilities = [EABL.recall_bolt(), EABL.memory_drain()]
	f.flavor_text = "A shimmering fragment of someone's forgotten recollection, given form and hunger. It feeds on the memories of the living."
	return f


static func create_shattered_frame(n: String, lvl: int = 10) -> FighterData:
	var f := EH.base(n, "Shattered Frame", lvl)
	f.health = EH.es(418, 491, 4, 7, lvl, 10); f.max_health = f.health
	f.mana = EH.es(16, 19, 1, 2, lvl, 10); f.max_mana = f.mana
	f.physical_attack = EH.es(10, 14, 0, 2, lvl, 10)
	f.physical_defense = EH.es(21, 28, 1, 3, lvl, 10)
	f.magic_attack = EH.es(69, 81, 2, 4, lvl, 10)
	f.magic_defense = EH.es(32, 39, 2, 3, lvl, 10)
	f.speed = EH.es(33, 39, 2, 3, lvl, 10)
	f.crit_chance = 9; f.crit_damage = 2; f.dodge_chance = 7
	f.abilities = [EABL.mirror_shard(), EABL.dissonant_echo()]
	f.flavor_text = "An ornate mirror frame that has torn itself from the echo gallery's walls and learned to hunt. Its cracked glass shows scenes that never happened, or perhaps already did."
	return f


static func create_echo_sentinel(n: String, lvl: int = 10) -> FighterData:
	var f := EH.base(n, "Echo Sentinel", lvl)
	f.health = EH.es(528, 601, 5, 8, lvl, 10); f.max_health = f.health
	f.mana = EH.es(7, 10, 1, 1, lvl, 10); f.max_mana = f.mana
	f.physical_attack = EH.es(58, 68, 2, 4, lvl, 10)
	f.physical_defense = EH.es(42, 49, 2, 3, lvl, 10)
	f.magic_attack = EH.es(8, 12, 0, 1, lvl, 10)
	f.magic_defense = EH.es(35, 43, 1, 3, lvl, 10)
	f.speed = EH.es(25, 31, 1, 2, lvl, 10)
	f.crit_chance = 12; f.crit_damage = 2; f.dodge_chance = 13
	f.abilities = [EABL.crystal_strike(), EABL.ward_of_echoes()]
	f.flavor_text = "A towering construct of solidified memory, shaped like an armored knight. It guards the sanctum's corridors with relentless vigilance."
	return f


static func create_thought_eater(n: String, lvl: int = 11) -> FighterData:
	var f := EH.base(n, "Thought Eater", lvl)
	f.health = EH.es(467, 538, 4, 7, lvl, 11); f.max_health = f.health
	f.mana = EH.es(17, 20, 1, 2, lvl, 11); f.max_mana = f.mana
	f.physical_attack = EH.es(10, 14, 0, 2, lvl, 11)
	f.physical_defense = EH.es(26, 32, 1, 3, lvl, 11)
	f.magic_attack = EH.es(83, 96, 2, 5, lvl, 11)
	f.magic_defense = EH.es(40, 47, 2, 3, lvl, 11)
	f.speed = EH.es(31, 37, 2, 3, lvl, 11)
	f.crit_chance = 12; f.crit_damage = 2; f.dodge_chance = 19
	f.abilities = [EABL.mind_rend(), EABL.psychic_leech()]
	f.flavor_text = "A formless psychic predator that burrows into the mind to consume thoughts whole. Victims feel their knowledge dissolving like mist."
	return f


static func create_grief_shade(n: String, lvl: int = 11) -> FighterData:
	var f := EH.base(n, "Grief Shade", lvl)
	f.health = EH.es(451, 518, 4, 6, lvl, 11); f.max_health = f.health
	f.mana = EH.es(16, 19, 1, 2, lvl, 11); f.max_mana = f.mana
	f.physical_attack = EH.es(12, 16, 0, 2, lvl, 11)
	f.physical_defense = EH.es(21, 28, 1, 2, lvl, 11)
	f.magic_attack = EH.es(70, 81, 2, 4, lvl, 11)
	f.magic_defense = EH.es(34, 41, 2, 3, lvl, 11)
	f.speed = EH.es(31, 37, 2, 3, lvl, 11)
	f.crit_chance = 8; f.crit_damage = 2; f.dodge_chance = 9
	f.abilities = [EABL.sorrows_touch(), EABL.wail_of_loss()]
	f.flavor_text = "A weeping shadow born from concentrated sorrow. Its touch carries the weight of every loss ever felt in this place."
	return f


static func create_sorrow_shade(n: String, lvl: int = 11) -> FighterData:
	var f := EH.base(n, "Sorrow Shade", lvl)
	f.health = EH.es(428, 492, 4, 6, lvl, 11); f.max_health = f.health
	f.mana = EH.es(16, 19, 1, 2, lvl, 11); f.max_mana = f.mana
	f.physical_attack = EH.es(12, 16, 0, 2, lvl, 11)
	f.physical_defense = EH.es(21, 28, 1, 2, lvl, 11)
	f.magic_attack = EH.es(71, 82, 2, 4, lvl, 11)
	f.magic_defense = EH.es(34, 41, 2, 3, lvl, 11)
	f.speed = EH.es(31, 37, 2, 3, lvl, 11)
	f.crit_chance = 8; f.crit_damage = 2; f.dodge_chance = 12
	f.abilities = [EABL.grief_surge(), EABL.shattered_trust()]
	f.flavor_text = "A shadow crystallized from the sanctum's deepest sorrows. Unlike grief shades born elsewhere, this one carries the weight of shattered memories and broken trust."
	return f


static func create_hollow_watcher(n: String, lvl: int = 11) -> FighterData:
	var f := EH.base(n, "Hollow Watcher", lvl)
	f.health = EH.es(432, 493, 5, 8, lvl, 11); f.max_health = f.health
	f.mana = EH.es(8, 11, 1, 2, lvl, 11); f.max_mana = f.mana
	f.physical_attack = EH.es(38, 46, 2, 4, lvl, 11)
	f.physical_defense = EH.es(35, 43, 2, 3, lvl, 11)
	f.magic_attack = EH.es(12, 16, 0, 2, lvl, 11)
	f.magic_defense = EH.es(29, 36, 1, 3, lvl, 11)
	f.speed = EH.es(29, 35, 1, 3, lvl, 11)
	f.crit_chance = 7; f.crit_damage = 2; f.dodge_chance = 7
	f.abilities = [EABL.blind_strike(), EABL.sense_intent()]
	f.flavor_text = "A faceless guardian that perceives the world through stolen senses. It anticipates its enemies' movements before they act."
	return f


# =============================================================================
# Deep sanctum enemies (levels 12-13) -- used by P11
# =============================================================================

static func create_mirror_self(n: String, lvl: int = 12) -> FighterData:
	var f := EH.base(n, "Mirror Self", lvl)
	f.health = EH.es(418, 477, 5, 8, lvl, 12); f.max_health = f.health
	f.mana = EH.es(16, 19, 1, 2, lvl, 12); f.max_mana = f.mana
	f.physical_attack = EH.es(68, 79, 2, 4, lvl, 12)
	f.physical_defense = EH.es(34, 42, 2, 3, lvl, 12)
	f.magic_attack = EH.es(68, 79, 2, 4, lvl, 12)
	f.magic_defense = EH.es(34, 42, 2, 3, lvl, 12)
	f.speed = EH.es(32, 38, 2, 3, lvl, 12)
	f.crit_chance = 11; f.crit_damage = 3; f.dodge_chance = 12
	f.abilities = [EABL.mirrored_slash(), EABL.reflected_spell()]
	f.flavor_text = "A perfect reflection of the one who gazes upon it. It fights with borrowed skill, turning your own strengths against you."
	return f


static func create_void_weaver(n: String, lvl: int = 12) -> FighterData:
	var f := EH.base(n, "Void Weaver", lvl)
	f.health = EH.es(462, 524, 4, 7, lvl, 12); f.max_health = f.health
	f.mana = EH.es(19, 23, 1, 2, lvl, 12); f.max_mana = f.mana
	f.physical_attack = EH.es(10, 14, 0, 2, lvl, 12)
	f.physical_defense = EH.es(27, 34, 1, 3, lvl, 12)
	f.magic_attack = EH.es(71, 85, 3, 5, lvl, 12)
	f.magic_defense = EH.es(48, 56, 2, 4, lvl, 12)
	f.speed = EH.es(30, 36, 2, 3, lvl, 12)
	f.crit_chance = 9; f.crit_damage = 2; f.dodge_chance = 13
	f.abilities = [EABL.void_bolt(), EABL.unravel()]
	f.flavor_text = "A spindly entity that weaves threads of nothingness between its fingers. Where its threads fall, memory and meaning unravel."
	return f


static func create_mnemonic_golem(n: String, lvl: int = 12) -> FighterData:
	var f := EH.base(n, "Mnemonic Golem", lvl)
	f.health = EH.es(583, 666, 6, 9, lvl, 12); f.max_health = f.health
	f.mana = EH.es(7, 10, 1, 1, lvl, 12); f.max_mana = f.mana
	f.physical_attack = EH.es(97, 112, 3, 5, lvl, 12)
	f.physical_defense = EH.es(53, 62, 2, 4, lvl, 12)
	f.magic_attack = EH.es(8, 12, 0, 1, lvl, 12)
	f.magic_defense = EH.es(42, 49, 2, 3, lvl, 12)
	f.speed = EH.es(19, 25, 1, 2, lvl, 12)
	f.crit_chance = 15; f.crit_damage = 3; f.dodge_chance = 4
	f.abilities = [EABL.memory_slam(), EABL.crystallize()]
	f.flavor_text = "A hulking automaton built from thousands of compressed memories. Each fist carries the petrified weight of forgotten lives."
	return f


# =============================================================================
# Act III boss enemies (level 13)
# =============================================================================

static func create_the_warden(n: String, lvl: int = 13) -> FighterData:
	var f := EH.base(n, "The Warden", lvl)
	f.health = EH.es(651, 736, 6, 9, lvl, 13); f.max_health = f.health
	f.mana = EH.es(18, 22, 1, 2, lvl, 13); f.max_mana = f.mana
	f.physical_attack = EH.es(12, 16, 0, 2, lvl, 13)
	f.physical_defense = EH.es(38, 44, 2, 3, lvl, 13)
	f.magic_attack = EH.es(100, 114, 3, 5, lvl, 13)
	f.magic_defense = EH.es(47, 53, 2, 4, lvl, 13)
	f.speed = EH.es(28, 33, 2, 3, lvl, 13)
	f.crit_chance = 14; f.crit_damage = 3; f.dodge_chance = 12
	f.abilities = [EABL.sanctum_judgment(), EABL.barrier_of_ages(), EABL.decree_of_exile()]
	f.flavor_text = "The sanctum's supreme guardian, an entity of crystallized law and ancient purpose. It judges all who enter and finds them wanting."
	return f


static func create_fractured_protector(n: String, lvl: int = 13) -> FighterData:
	var f := EH.base(n, "Fractured Protector", lvl)
	f.health = EH.es(611, 689, 5, 8, lvl, 13); f.max_health = f.health
	f.mana = EH.es(17, 20, 1, 2, lvl, 13); f.max_mana = f.mana
	f.physical_attack = EH.es(87, 99, 2, 4, lvl, 13)
	f.physical_defense = EH.es(32, 39, 2, 3, lvl, 13)
	f.magic_attack = EH.es(79, 91, 2, 4, lvl, 13)
	f.magic_defense = EH.es(35, 41, 2, 3, lvl, 13)
	f.speed = EH.es(30, 36, 2, 3, lvl, 13)
	f.crit_chance = 15; f.crit_damage = 3; f.dodge_chance = 13
	f.abilities = [EABL.desperate_strike(), EABL.memory_seal(), EABL.forgetting_touch()]
	f.flavor_text = "Once a noble defender of the memory sanctum, now cracked and unstable. It lashes out with desperate fury, no longer certain what it protects."
	return f


# =============================================================================
# P9: Beneath the Lighthouse (unique enemies)
# Wisps strip party mag_def, Guardian buffs team defense
# =============================================================================

static func create_fading_wisp(n: String, lvl: int = 10) -> FighterData:
	var f := EH.base(n, "Fading Wisp", lvl)
	f.health = EH.es(306, 350, 4, 7, lvl, 10); f.max_health = f.health
	f.mana = EH.es(16, 19, 1, 2, lvl, 10); f.max_mana = f.mana
	f.physical_attack = EH.es(10, 14, 0, 2, lvl, 10)
	f.physical_defense = EH.es(22, 28, 1, 3, lvl, 10)
	f.magic_attack = EH.es(70, 81, 2, 4, lvl, 10)
	f.magic_defense = EH.es(33, 40, 2, 3, lvl, 10)
	f.speed = EH.es(33, 39, 2, 3, lvl, 10)
	f.crit_chance = 12; f.crit_damage = 2; f.dodge_chance = 19
	f.abilities = [EABL.flicker_bolt(), EABL.dim_aura()]
	f.flavor_text = "A dying wisp that gutters like a candle in the wind. Its fading light still carries enough spite to burn."
	return f


static func create_dim_guardian(n: String, lvl: int = 10) -> FighterData:
	var f := EH.base(n, "Dim Guardian", lvl)
	f.health = EH.es(391, 449, 4, 6, lvl, 10); f.max_health = f.health
	f.mana = EH.es(7, 10, 1, 1, lvl, 10); f.max_mana = f.mana
	f.physical_attack = EH.es(55, 65, 2, 3, lvl, 10)
	f.physical_defense = EH.es(42, 49, 2, 3, lvl, 10)
	f.magic_attack = EH.es(8, 12, 0, 1, lvl, 10)
	f.magic_defense = EH.es(36, 43, 1, 3, lvl, 10)
	f.speed = EH.es(25, 32, 1, 2, lvl, 10)
	f.crit_chance = 11; f.crit_damage = 2; f.dodge_chance = 9
	f.abilities = [EABL.fading_blow(), EABL.waning_ward()]
	f.flavor_text = "A sentinel fading from existence, its form barely visible in the dim light. What strength it has left, it devotes entirely to defense."
	return f


# =============================================================================
# P12 GT: Guardian's Threshold (unique enemies)
# Tank + taunt / magic + attack suppression / mixed + speed control
# =============================================================================

static func create_ward_construct(n: String, lvl: int = 12) -> FighterData:
	var f := EH.base(n, "Ward Construct", lvl)
	f.health = EH.es(572, 660, 6, 9, lvl, 12); f.max_health = f.health
	f.mana = EH.es(7, 10, 1, 1, lvl, 12); f.max_mana = f.mana
	f.physical_attack = EH.es(113, 129, 3, 5, lvl, 12)
	f.physical_defense = EH.es(58, 67, 2, 4, lvl, 12)
	f.magic_attack = EH.es(8, 12, 0, 1, lvl, 12)
	f.magic_defense = EH.es(46, 54, 2, 3, lvl, 12)
	f.speed = EH.es(21, 28, 1, 2, lvl, 12)
	f.crit_chance = 9; f.crit_damage = 3; f.dodge_chance = 7
	f.abilities = [EABL.reinforced_strike(), EABL.warding_presence()]
	f.flavor_text = "A massive stone construct bound by ancient wards. It was built to hold the threshold against any intrusion, and it has never failed."
	return f


static func create_null_phantom(n: String, lvl: int = 12) -> FighterData:
	var f := EH.base(n, "Null Phantom", lvl)
	f.health = EH.es(407, 466, 4, 7, lvl, 12); f.max_health = f.health
	f.mana = EH.es(20, 23, 1, 2, lvl, 12); f.max_mana = f.mana
	f.physical_attack = EH.es(10, 14, 0, 2, lvl, 12)
	f.physical_defense = EH.es(29, 36, 1, 3, lvl, 12)
	f.magic_attack = EH.es(82, 95, 3, 5, lvl, 12)
	f.magic_defense = EH.es(52, 61, 2, 4, lvl, 12)
	f.speed = EH.es(32, 39, 2, 3, lvl, 12)
	f.crit_chance = 7; f.crit_damage = 2; f.dodge_chance = 10
	f.abilities = [EABL.null_lance(), EABL.nullification()]
	f.flavor_text = "A phantom of pure negation that erases whatever it touches. Magic withers in its presence, and even thoughts lose coherence."
	return f


static func create_threshold_echo(n: String, lvl: int = 12) -> FighterData:
	var f := EH.base(n, "Threshold Echo", lvl)
	f.health = EH.es(435, 497, 5, 8, lvl, 12); f.max_health = f.health
	f.mana = EH.es(16, 20, 1, 2, lvl, 12); f.max_mana = f.mana
	f.physical_attack = EH.es(75, 87, 2, 4, lvl, 12)
	f.physical_defense = EH.es(36, 45, 2, 3, lvl, 12)
	f.magic_attack = EH.es(75, 87, 2, 4, lvl, 12)
	f.magic_defense = EH.es(36, 45, 2, 3, lvl, 12)
	f.speed = EH.es(33, 40, 2, 3, lvl, 12)
	f.crit_chance = 8; f.crit_damage = 3; f.dodge_chance = 14
	f.abilities = [EABL.liminal_strike(), EABL.threshold_bind()]
	f.flavor_text = "A repeating impression left at the boundary between memory and void. It strikes with the force of a moment that refuses to be forgotten."
	return f


# =============================================================================
# P12 FA: Forgotten Archive (unique enemies)
# Tank + taunt / magic + silence / magic + DoT / physical + defense debuff
# =============================================================================

static func create_archive_keeper(n: String, lvl: int = 12) -> FighterData:
	var f := EH.base(n, "Archive Keeper", lvl)
	f.health = EH.es(589, 675, 6, 9, lvl, 12); f.max_health = f.health
	f.mana = EH.es(8, 10, 1, 1, lvl, 12); f.max_mana = f.mana
	f.physical_attack = EH.es(117, 134, 3, 5, lvl, 12)
	f.physical_defense = EH.es(59, 70, 2, 4, lvl, 12)
	f.magic_attack = EH.es(8, 12, 0, 1, lvl, 12)
	f.magic_defense = EH.es(47, 56, 2, 3, lvl, 12)
	f.speed = EH.es(21, 28, 1, 2, lvl, 12)
	f.crit_chance = 10; f.crit_damage = 3; f.dodge_chance = 9
	f.abilities = [EABL.archive_slam(), EABL.guardian_oath()]
	f.flavor_text = "An immense golem formed from compressed scrolls and petrified ink. It was sworn to protect the archive and will crush any who desecrate it."
	return f


static func create_silent_archivist(n: String, lvl: int = 11) -> FighterData:
	var f := EH.base(n, "Silent Archivist", lvl)
	f.health = EH.es(469, 534, 5, 8, lvl, 11); f.max_health = f.health
	f.mana = EH.es(12, 14, 1, 2, lvl, 11); f.max_mana = f.mana
	f.physical_attack = EH.es(14, 18, 0, 2, lvl, 11)
	f.physical_defense = EH.es(32, 40, 2, 3, lvl, 11)
	f.magic_attack = EH.es(76, 88, 3, 5, lvl, 11)
	f.magic_defense = EH.es(39, 46, 2, 3, lvl, 11)
	f.speed = EH.es(29, 35, 1, 3, lvl, 11)
	f.crit_chance = 9; f.crit_damage = 2; f.dodge_chance = 11
	f.abilities = [EABL.archived_spell(), EABL.silence()]
	f.flavor_text = "A robed figure that glides between shelves of crystallized memory. It enforces silence with absolute authority, sealing the voices of intruders."
	return f


static func create_lost_record(n: String, lvl: int = 10) -> FighterData:
	var f := EH.base(n, "Lost Record", lvl)
	f.health = EH.es(364, 424, 5, 7, lvl, 10); f.max_health = f.health
	f.mana = EH.es(16, 20, 1, 2, lvl, 10); f.max_mana = f.mana
	f.physical_attack = EH.es(10, 14, 0, 2, lvl, 10)
	f.physical_defense = EH.es(24, 30, 1, 3, lvl, 10)
	f.magic_attack = EH.es(78, 92, 2, 5, lvl, 10)
	f.magic_defense = EH.es(34, 42, 2, 3, lvl, 10)
	f.speed = EH.es(33, 40, 2, 3, lvl, 10)
	f.crit_chance = 9; f.crit_damage = 2; f.dodge_chance = 16
	f.abilities = [EABL.fragmented_blast(), EABL.corrupted_text()]
	f.flavor_text = "A swirling mass of broken text and scattered data, once a coherent record of the past. Its fragmented knowledge strikes like shrapnel."
	return f


static func create_faded_page(n: String, lvl: int = 10) -> FighterData:
	var f := EH.base(n, "Faded Page", lvl)
	f.health = EH.es(518, 593, 5, 8, lvl, 10); f.max_health = f.health
	f.mana = EH.es(8, 10, 1, 1, lvl, 10); f.max_mana = f.mana
	f.physical_attack = EH.es(65, 76, 2, 4, lvl, 10)
	f.physical_defense = EH.es(44, 52, 2, 3, lvl, 10)
	f.magic_attack = EH.es(8, 12, 0, 1, lvl, 10)
	f.magic_defense = EH.es(37, 45, 2, 3, lvl, 10)
	f.speed = EH.es(27, 33, 1, 2, lvl, 10)
	f.crit_chance = 8; f.crit_damage = 2; f.dodge_chance = 8
	f.abilities = [EABL.binding_press(), EABL.eroding_script()]
	f.flavor_text = "A brittle construct of yellowed parchment and fading ink. Though its contents are nearly illegible, its binding grip remains strong."
	return f
