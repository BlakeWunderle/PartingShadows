class_name BattleDBS3Act2

## Story 3 expanded Act II: extended second dream + waking investigation.
## New battles: DreamThreads, DrownedCorridor/ShatteredGallery, DreamShadowChase,
## TownInvestigation (town stop), MarketConfrontation, CellarDiscovery.

const BattleData := preload("res://scripts/data/battle_data.gd")
const EnemyDB := preload("res://scripts/data/story3/enemy_db_s3_act2.gd")


static func create_battle(battle_id: String) -> BattleData:
	match battle_id:
		"S3_DreamThreads": return s3_dream_threads()
		"S3_DreamDrownedCorridor": return s3_dream_drowned_corridor()
		"S3_DreamShatteredGallery": return s3_dream_shattered_gallery()
		"S3_DreamShadowChase": return s3_dream_shadow_chase()
		"S3_TownInvestigation": return s3_town_investigation()
		"S3_MarketConfrontation": return s3_market_confrontation()
		"S3_CellarDiscovery": return s3_cellar_discovery()
		_:
			push_error("Unknown Story 3 Act II expansion battle: %s" % battle_id)
			return s3_dream_threads()


# =============================================================================
# Extended Second Dream
# =============================================================================

static func s3_dream_threads() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_DreamThreads"
	b.scene_image = "res://assets/art/battles/dream_threads.png"
	b.enemies = [
		EnemyDB.create_thread_lurker("Ceiling Crawler"),
		EnemyDB.create_dream_sentinel("Still Guard"),
		EnemyDB.create_gloom_spinner("Dark Weaver"),
	]
	b.pre_battle_text = [
		"The broken architecture deepens. The impossible corridors stretch further and the gravity grows more uncertain.",
		"But something new is visible now. Between the walls, between the floors, threads. Thousands of them, strung like spider silk, faintly luminous and vibrating with a low hum.",
		"They are not random. The threads form patterns. Sigils. The same symbols carved into doorframes back in the town, now woven into the fabric of the dream itself.",
		"Something drops from the ceiling. Something that was hiding in the threads, waiting.",
	]
	b.post_battle_text = [
		"The threads snap where the creatures fell, and new ones begin to grow in their place. Whatever maintains them is automatic. Relentless.",
		"Ahead, the threads converge in two directions. One passage fills with dark water, its surface rippling with submerged light. The other opens into a vast space where frames hang in the void like paintings in an abandoned gallery.",
	]
	b.choices = [
		{"label": "The Drowned Corridor", "description": "Dark water fills the passage, threads of light running beneath the surface like veins.", "battle_id": "S3_DreamDrownedCorridor"},
		{"label": "The Shattered Gallery", "description": "Broken frames hang in the void, each holding a fragment of someone's dream.", "battle_id": "S3_DreamShatteredGallery"},
	]
	b.music_track = "res://assets/audio/music/battle/Fantasy Tension - The Darkness.ogg"
	return b


static func s3_dream_drowned_corridor() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_DreamDrownedCorridor"
	b.scene_image = "res://assets/art/battles/dream_drowned_corridor.png"
	b.enemies = [
		EnemyDB.create_drowned_reverie("Lost Dreamer"),
		EnemyDB.create_riptide_beast("Current Fang"),
		EnemyDB.create_depth_crawler("Thread Dredger"),
	]
	b.pre_battle_text = [
		"The corridor is flooded to the waist. The water is not wet. It is heavy, thick, like walking through liquid memory.",
		"Beneath the surface, threads of light pulse in rhythm, carrying stolen energy somewhere deeper. This is a channel, a current, and it has been flowing for a very long time.",
		"A figure stands half-submerged, its upper body translucent and flickering. It turns slowly, and its face is a composite of a dozen people who slept here before.",
		"Something fast moves with the current. And something clings to the threads below, waiting for a misstep.",
	]
	b.post_battle_text = [
		"The water drains as the creatures dissolve. The threads beneath the surface dim but do not die.",
		"Through the empty corridor, the faint trail of the dancer's light flickers and fades. The shadow was here, too. Smears of darkness stain the walls where it passed.",
		"The corridor opens into a wider space where both paths converge.",
	]
	b.next_battle_id = "S3_DreamShadowChase"
	b.music_track = "res://assets/audio/music/battle/Fantasy Tension - Fire Water.ogg"
	return b


static func s3_dream_shattered_gallery() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_DreamShatteredGallery"
	b.scene_image = "res://assets/art/battles/dream_shattered_gallery.png"
	b.enemies = [
		EnemyDB.create_fragment_golem("Dream Husk"),
		EnemyDB.create_portrait_wight("Faded Dreamer"),
		EnemyDB.create_gallery_shade("Frame Shadow"),
	]
	b.pre_battle_text = [
		"The gallery stretches into the void. Frames hang in the air without walls to support them, each one holding a fragment of someone's dream.",
		"A child's birthday party, frozen mid-laugh. An old woman tending a garden that no longer exists. A soldier's last morning before a battle he did not survive.",
		"The cult has been cataloging dreams. Stealing them, storing them, using them as raw material.",
		"A hulking shape assembled from broken frames lurches forward. It is made of a hundred stolen moments, glued together by threads and hunger.",
	]
	b.post_battle_text = [
		"The frames shatter as the golem collapses. The stolen dreams scatter like sparks, each one a brief flash of someone else's life before it fades.",
		"In the last intact frame, the dancer's silhouette is visible, pressed against the glass from the inside. It waves, urgently, and points toward the passage ahead.",
		"Behind the frame, the shadow fills the space like spilled ink, reaching for the dancer's outline.",
		"The gallery narrows into a corridor that converges with the other path.",
	]
	b.next_battle_id = "S3_DreamShadowChase"
	b.music_track = "res://assets/audio/music/battle/Fantasy Tension - War Ready.ogg"
	return b


static func s3_dream_shadow_chase() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_DreamShadowChase"
	b.is_boss = true
	b.scene_image = "res://assets/art/battles/dream_shadow_chase.png"
	b.enemies = [
		EnemyDB.create_dread_tendril("Dark Arm"),
		EnemyDB.create_shadow_pursuer("The Hunter"),
		EnemyDB.create_faded_voice("Whisper"),
	]
	b.pre_battle_text = [
		"The space opens into a vast dark expanse. The threads here are thicker, older, and they converge toward something below.",
		"The dancer is here. Not a trail of light this time, but the figure itself, standing in the open, breathing hard, looking over its shoulder.",
		"Behind it, the shadow coils and surges. Not following any more. Hunting.",
		"For the first time, the shadow turns its attention to the travelers. It has been herding them. Every corridor, every choice, has been driving them toward this convergence.",
		"A piece of the shadow splits off, fast and bladed. Another tendril reaches from the darkness. And a voice, faded and hollow, echoes from everywhere at once.",
		"The dancer does not flee. It stands between the travelers and the shadow, arms raised, light flickering against the dark.",
	]
	b.post_battle_text = [
		"The shadow recoils, diminished but not destroyed. Its pieces scatter into the threads and vanish.",
		"The dancer stumbles, dimmer than before. It has spent something defending them. It gestures ahead, where the dream deepens further, and then fades like a candle in wind.",
		"Two passages appear in the space below.",
	]
	b.choices = [
		{"label": "The Living Labyrinth", "description": "Walls of shifting stone form a labyrinth that breathes.", "battle_id": "S3_DreamLabyrinth"},
		{"label": "The Frozen Clock Tower", "description": "A clock tower rises, its hands frozen at midnight.", "battle_id": "S3_DreamClockTower"},
	]
	b.music_track = "res://assets/audio/music/battle/Demon's Lair LOOP.wav"
	return b


# =============================================================================
# Waking Investigation
# =============================================================================

static func s3_town_investigation() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_TownInvestigation"
	b.scene_image = "res://assets/art/battles/weary_traveler_inn.png"
	b.is_town_stop = true
	b.pre_battle_text = [
		"Morning. All three travelers are standing in the hallway outside their rooms, pale and shaking.",
		"'I heard you,' one says. 'In the dream. I heard your voice.'",
		"'I heard you too.'",
		"'There was someone else,' the third says. 'A figure. Dancing. It stood between us and the shadow at the end. It was protecting us.'",
		"'Both nights. The same figure. The same dream. The same creatures.' Silence. Then: 'We were in the same dream. All three of us.'",
		"They sit in the common room and compare notes. The meadow. The threads. The gallery of stolen dreams. The shadow that hunted the dancer. Every detail matches.",
		"'The threads are real,' one says. 'I saw them woven into the architecture. Sigils. The same symbols carved into the doorframes downstairs. Someone built this dream on purpose.'",
		"'And they are stealing from us. Every night. Every dream. Something is being taken, and we wake up a little more tired than we should be.'",
		"Something in this town is doing this to them. And tonight, it will happen again.",
		"They spend the morning preparing. Sharpening weapons. Studying the town with new eyes.",
	]
	b.post_battle_text = [
		"The town looks different when you know what to look for. Thread sigils on the baker's doorframe. The shopkeeper's too-calm eyes. A cellar door with three heavy locks.",
		"Time to find out what this town is hiding.",
	]
	b.next_battle_id = "S3_MarketConfrontation"
	b.music_track = "res://assets/audio/music/town/Town Village 05(L).wav"
	return b


static func s3_market_confrontation() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_MarketConfrontation"
	b.scene_image = "res://assets/art/battles/town_market_tense.png"
	b.enemies = [
		EnemyDB.create_market_watcher("Shopkeeper Voss"),
		EnemyDB.create_thread_smith("Smith Hagen"),
		EnemyDB.create_hex_herbalist("Herbalist Wren"),
	]
	b.pre_battle_text = [
		"The market square is busy. Merchants call out prices. Children chase each other between the stalls. Everything looks normal.",
		"But the travelers are watching now. The shopkeeper's hands move beneath the counter when he thinks no one is looking. The blacksmith's hammer pauses every time they walk past. The herbalist's eyes track them with the focus of a predator.",
		"One traveler stops at a doorframe and traces the carved sigil with a finger. 'Thread,' they say, loud enough to be heard.",
		"The market goes quiet. Not all at once. In a wave, starting from the shopkeeper and spreading outward.",
		"'You should not have looked so closely,' the shopkeeper says. He draws a blade from beneath his apron. The blacksmith raises his hammer. The herbalist reaches into a pouch of something that is not lavender.",
		"Half the town serves the Thread. And now they know the travelers know.",
	]
	b.post_battle_text = [
		"The cult agents fall. The rest of the market scatters, ordinary citizens who had no idea what was happening in their midst.",
		"One of the fallen drops a key. Ornate and old, stamped with the Thread's sigil.",
		"'The cellar,' one traveler says. 'Under the inn. This fits the locks we saw.'",
	]
	b.next_battle_id = "S3_CellarDiscovery"
	b.music_track = "res://assets/audio/music/battle/Defending The Kingdom LOOP.wav"
	return b


static func s3_cellar_discovery() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_CellarDiscovery"
	b.scene_image = "res://assets/art/battles/inn_cellar.png"
	b.enemies = [
		EnemyDB.create_cellar_watcher("Bound Sentinel"),
		EnemyDB.create_thread_construct("Woven Golem"),
		EnemyDB.create_ink_shade("Cellar Shadow"),
	]
	b.pre_battle_text = [
		"The three locks open with a single turn of the key. The cellar door swings inward, and the air that rises from below smells of dust and something sweet and wrong.",
		"Stone steps descend into a space much larger than the inn above could contain. Thread sigils cover every surface, pulsing faintly.",
		"Real threads, physical ones, are strung between pillars. They hum with the same vibration the travelers felt in the dream. The Loom has roots here. Physical roots.",
		"A bound creature patrols the darkness, tethered to the walls by threads that glow and tighten when it moves. Beside it, a humanoid shape woven entirely from threads stands motionless until it detects the intruders.",
		"In the corner, a fragment of shadow pools and drips upward, defying gravity. Dream-stuff, leaked through to the waking world.",
	]
	b.post_battle_text = [
		"The creatures fall. The threads in the cellar dim but do not go dark. Whatever powers them is deeper than this.",
		"On a stone table, the travelers find the guest book from upstairs. Not the one behind the bar. An older one. Centuries older. The names go back further than the town itself.",
		"'This is not just a cult,' one says. 'This has been happening for generations. Maybe longer.'",
		"They climb back upstairs. The common room is empty. The innkeeper's apron hangs on a hook. A cup sits half-filled on the bar.",
		"A knock at the door. The serving girl, Lira, stands in the hallway, pale and trembling.",
		"'I know what you found,' she says. 'Because I have been trying to find it my whole life. Let me explain.'",
	]
	b.next_battle_id = "S3_TownRealization"
	b.music_track = "res://assets/audio/music/battle/Unknown Creatures LOOP.wav"
	return b
