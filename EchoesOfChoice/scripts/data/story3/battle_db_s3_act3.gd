class_name BattleDBS3Act3

## Story 3 Act III battle configs: the lucid dream and the cult's dream sanctum.

const BattleData := preload("res://scripts/data/battle_data.gd")
const EnemyDB := preload("res://scripts/data/story3/enemy_db_s3_act3.gd")


static func create_battle(battle_id: String) -> BattleData:
	match battle_id:
		"S3_TownRealization": return s3_town_realization()
		"S3_LucidDream": return s3_lucid_dream()
		"S3_DreamTemple": return s3_dream_temple()
		"S3_DreamVoid": return s3_dream_void()
		"S3_DreamSanctum": return s3_dream_sanctum()
		_:
			push_error("Unknown Story 3 Act III battle: %s" % battle_id)
			return s3_town_realization()


static func s3_town_realization() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_TownRealization"
	b.scene_image = "res://assets/art/battles/wanderers_rest.png"
	b.is_town_stop = true
	b.pre_battle_text = [
		"The innkeeper smiles when they come downstairs. 'Sleep well?' she asks, as if she already knows the answer.",
		"The travelers exchange glances but say nothing to her. Over breakfast, they plan quietly.",
		"'Tonight, we go in together,' one says. 'On purpose. If we are sharing dreams, we need to understand why.'",
		"'And we need to stay awake as long as we can. Watch who watches us.'",
		"They spend the day preparing. Sharpening weapons. Studying the town. They notice things they missed before: a symbol carved into a doorframe, a shopkeeper who watches them too carefully, a cellar door that has three locks.",
		"One of them pulls the guest book from behind the bar and spreads it open. The entries go back decades. Name after name. But the later pages are wrong. The handwriting grows unsteady. Some names are half-formed, as if the writers fell asleep mid-stroke. A few entries are just meaningless scrawls. And on every page, faint lines of thread-thin ink connect the names like a web.",
		"'Every name in this book,' one traveler says quietly. 'Every person who ever slept here. They were all feeding it.'",
		"A knock at the door. The serving girl, Lira, stands in the hallway, pale and trembling.",
		"'I know what you are planning,' she says. 'Because I have been there too. Every night. I am the one who has been dancing.'",
		"She steps inside and closes the door. 'I have lived in this town my whole life. The dreams started when I was a child. I learned to move through them, to resist what the Loom does. But I could never fight it alone.'",
		"'I can help you. I know the dream better than anyone. And I know things about this town that will make your blood run cold.'",
		"'There is something else you should know,' Lira says. 'The Loom knows I resist it. It sends something after me every night. A shadow. It cannot kill me, but it can drive me out, keep me running. That is why I could never stay long enough to fight back.'",
		"She spends the day training them, teaching them how to hold their awareness in the dream, how to recognize the Thread's traps, how to fight while sleeping. Her years of navigating the dream world have taught her things about mind and body that no academy could. Old limitations fall away under her guidance.",
	]
	b.post_battle_text = [
		"Night falls. They fight the pull of sleep for as long as they can, talking in one room with the candles burning. Lira sits with them, steady and calm.",
		"But the exhaustion is not natural. It settles like a weight, and one by one their eyes close.",
		"The dream is waiting. And this time, they step into it together.",
	]
	b.next_battle_id = "S3_LucidDream"
	b.music_track = "res://assets/audio/music/town/Medieval Tavern 03.wav"
	b.cutscene_track = "res://assets/audio/music/cutscene/#14.wav"
	return b


static func s3_lucid_dream() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_LucidDream"
	b.scene_image = "res://assets/art/battles/memory_sanctum.png"
	b.enemies = [
		EnemyDB.create_lucid_phantom("Aware One"),
		EnemyDB.create_thread_spinner("Spindle"),
		EnemyDB.create_cult_shade("Dark Strand"),
	]
	b.pre_battle_text = [
		"The dream is different this time. They are standing together, aware, remembering who they are and how they got here.",
		"Lira is beside them. Not the luminous fae of previous nights, but herself, solid and aware. She moves with a dancer's grace, her familiarity with this place evident in every step.",
		"The landscape is the same broken architecture, but now they can see what holds it together: threads. Thousands of luminous threads stretching between every surface, vibrating like the strings of an instrument.",
		"Symbols are woven into the threads. Not random patterns. Deliberate markings. The sigils of a cult.",
		"'Stay close,' Lira says. 'The deeper we go, the more the Loom will fight us.'",
		"At the far end of the architecture, a dark shape watches. The shadow that has hunted Lira through every dream. In the light of their combined awareness, it recoils, but does not flee.",
		"A phantom turns to face them. Unlike the mindless creatures of previous nights, this one is aware. It sees them seeing it.",
		"'You should not be awake,' it says.",
	]
	b.post_battle_text = [
		"The phantom dissolves, and the threads it was guarding go slack. Behind them, the architecture opens into two passages.",
		"Through one, the faint outline of a temple, ancient and deliberate. Through the other, nothing at all. A gap in the dream where the weaving has frayed.",
	]
	b.choices = [
		{"label": "The temple: columns of woven light frame a doorway older than memory.", "battle_id": "S3_DreamTemple"},
		{"label": "The void: the threads fray into darkness where something moves between dreams.", "battle_id": "S3_DreamVoid"},
	]
	b.music_track = "res://assets/audio/music/battle_dark/08_Rotten_Memories.wav"
	b.cutscene_track = "res://assets/audio/music/cutscene/#13a Horn Call.wav"
	return b


static func s3_dream_temple() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_DreamTemple"
	b.scene_image = "res://assets/art/battles/shattered_sanctum.png"
	b.enemies = [
		EnemyDB.create_dream_warden("Temple Guard"),
		EnemyDB.create_thought_leech("Mind Eater"),
		EnemyDB.create_loom_sentinel("Stone Thread"),
	]
	b.pre_battle_text = [
		"The temple is old. Not old like ruins. Old like the idea of temples, as if this is the first one ever dreamed.",
		"The walls are woven from threads of light, and the cult's sigils are everywhere. This is not a place the cult found. They built it, thread by thread, in the dreams of every traveler who slept at the inn.",
		"Lira's hand brushes one of the sigils and it flares. 'I have seen this place before,' she whispers. 'They built it from the dreams of children. My dreams, when I was young.'",
		"A dark shape coils around one of the pillars. The shadow. It hisses at their approach, threads of darkness lashing outward. 'It is weaker here,' Lira says. 'It draws its power from the Loom. Cut the threads and it has nothing left.'",
		"Guardians stand at the altar. They are not creatures of nightmare. They are constructs of purpose, placed here to protect something.",
	]
	b.post_battle_text = [
		"The guardians fall, and the temple's threads begin to unravel. Behind the altar, a passage leads deeper, toward the heart of the dream.",
		"The sigils on the walls pulse faster. Whatever is at the center knows they are coming.",
	]
	b.next_battle_id = "S3_DreamSanctum"
	b.music_track = "res://assets/audio/music/battle/Fantasy Tension - Altar of the Forgotten.ogg"
	return b


static func s3_dream_void() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_DreamVoid"
	b.scene_image = "res://assets/art/battles/memory_depths.png"
	b.enemies = [
		EnemyDB.create_void_spinner("Thread Ripper"),
		EnemyDB.create_lucid_phantom("Watcher"),
		EnemyDB.create_thread_spinner("Mender"),
	]
	b.pre_battle_text = [
		"The void between dreams is a place that should not exist. It is the gap between threads, the space where the weaving fails.",
		"Here, the cult's work is visible for what it is. A loom of psychic energy, stretching across hundreds of sleeping minds, harvesting something from each dreamer.",
		"Lira moves carefully through the torn threads. 'This is where the weaving is weakest,' she says. 'If we can reach the core, we can see what they are really doing.'",
		"The shadow darts between the torn threads, faster here, more desperate. It lunges at Lira, and she spins away. 'It knows what we are doing,' she says. 'It is trying to stop us before we reach the core.'",
		"Spinners work frantically to repair the gaps, while phantoms patrol the edges. They are not happy to see intruders who are awake enough to understand what they are looking at.",
	]
	b.post_battle_text = [
		"The spinners scatter. Through the torn threads, the travelers can see the core of the Loom. A sanctum of woven power, protected by the strongest guardian the cult has placed in the dream.",
	]
	b.next_battle_id = "S3_DreamSanctum"
	b.music_track = "res://assets/audio/music/battle_dark/01_Static_Presence.wav"
	return b


static func s3_dream_sanctum() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_DreamSanctum"
	b.scene_image = "res://assets/art/battles/sanctum_core.png"
	b.enemies = [
		EnemyDB.create_sanctum_guardian("Loom Guardian"),
		EnemyDB.create_cult_shade("Shadow Weaver"),
		EnemyDB.create_dream_warden("Core Defender"),
	]
	b.pre_battle_text = [
		"The sanctum pulses with stolen energy. Threads converge here from every direction, each one connected to a sleeping mind somewhere in the town. Somewhere beyond the town.",
		"Lira steps forward. 'I have fought this guardian before,' she says. 'Always alone. Always losing. Not tonight.'",
		"The shadow coils around the guardian's base, feeding it strength. This is where it lives. This is where it was born.",
		"At the center stands the Loom Guardian. It is not a creature. It is a function, woven into the dream itself, tasked with one purpose: protect the Loom at any cost.",
		"Beyond the guardian, in the threads themselves, the travelers can see flashes of the cult's purpose. Robed figures chanting. A cellar beneath the inn. A ritual that requires the psychic energy of dreamers.",
		"'They are harvesting us,' one traveler says. 'Every night. Every dream. They take something and we wake up tired.'",
	]
	b.post_battle_text = [
		"The guardian shatters. The shadow screams and tears free from the wreckage, fleeing into the threads like a wounded animal. It is fast, but it is diminished. Without the guardian, it has lost something.",
		"The threads go wild, snapping and reforming. The dream convulses.",
		"In the last moment before waking, the travelers see it clearly: the cellar beneath the inn. Robed figures around a circle of woven thread. The innkeeper, standing at the center, eyes closed, hands raised.",
		"They wake up. It is still dark. And now they know exactly what they are dealing with.",
		"'The Thread,' one says, reading a symbol sketched from memory. 'That is what they call themselves. And they have been doing this for years.'",
		"Dawn is hours away. They have until then to prepare. Because tonight, they are not going to sleep. Tonight, they are going underneath the inn.",
	]
	b.next_battle_id = "S3_CultUnderbelly"
	b.music_track = "res://assets/audio/music/boss/Awakening of the Juggernaut_FULL.wav"
	b.cutscene_track = "res://assets/audio/music/cutscene/Sad Despair 09.wav"
	return b
