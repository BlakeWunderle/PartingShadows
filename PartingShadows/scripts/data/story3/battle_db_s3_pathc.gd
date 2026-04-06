class_name BattleDBS3PathC

## Story 3 Path C battle configs: the true ally path where Lira is the
## Threadmaster's first prisoner. Branches from Path A after S3_DreamSanctum
## when the party earns Lira's full trust through honest conversation.

const BattleData := preload("res://scripts/data/battle_data.gd")
const EnemyDB := preload("res://scripts/data/story3/enemy_db_s3_pathc.gd")


static func create_battle(battle_id: String) -> BattleData:
	match battle_id:
		"S3_C_LirasConfession": return s3_c_liras_confession()
		"S3_C_DreamDescent": return s3_c_dream_descent()
		"S3_C_CultInterception": return s3_c_cult_interception()
		"S3_C_ThreadmasterLair": return s3_c_threadmaster_lair()
		"S3_C_DreamNexus": return s3_c_dream_nexus()
		_:
			push_error("Unknown Story 3 Path C battle: %s" % battle_id)
			return s3_c_liras_confession()


# =============================================================================
# Act IV: Lira's Truth
# =============================================================================

static func s3_c_liras_confession() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_C_LirasConfession"
	b.scene_image = "res://assets/art/battles/weary_traveler_night.png"
	b.is_town_stop = true
	b.pre_battle_text = [
		"Lira stops in the hallway. She does not turn around for a long time.",
		"'The voice,' she says at last. 'You heard it too.'",
		"'In the dream, when the Threadmaster spoke through the guardian, its voice had the same cadence as yours,' one traveler says. 'Not the same words. The same rhythm. As if it learned to speak by listening to you.'",
		"Lira sits down on the floor of the hallway, her back against the wall. She looks very small.",
		"'I am not what I told you I was,' she says. 'I did not learn to resist the Loom. I was born in it.'",
		"'I was a child in this town. Centuries ago. I found a cave beneath the inn, and inside it was something old. Something that had been dreaming for longer than the town had existed. The Threadmaster.'",
		"'It did not consume me. It chained me. I am its anchor to the waking world. My life, my dreaming mind, is what lets it reach through to harvest sleeping travelers. It chose me because a child's mind dreams more vividly than any other.'",
		"'The dancing figure in the dreams? That is me. Genuinely me, genuinely fighting. The shadow chasing me? Its leash. It cannot let me go, and I cannot break free alone.'",
		"She pulls back her sleeve. Faint lines of thread-thin light run beneath her skin, pulsing in time with something far below.",
		"'I did not tell you because everyone I have ever told has either run or died trying to help. I did not want you to be next.'",
		"A long silence. Then one of the travelers sits down beside her.",
		"'We are not running,' they say. 'Tell us how to end this.'",
		"Lira looks up. For the first time since they met her, the practiced composure is gone. What is left is a woman who has been fighting alone for a very long time.",
		"'The Sanctum Guardian is dead. The Loom's defenses are in chaos. If we go into the dream now, together, we can reach the Threadmaster before it rebuilds. No one has ever tried to go straight for its heart. No one has ever had allies strong enough.'",
		"'Until now,' one traveler says.",
		"Lira teaches them everything she knows about the deep dream. The paths that lead to the Threadmaster's lair. The things that guard it. How to move through the layers without being lost.",
	]
	b.post_battle_text = [
		"They sleep willingly, for the last time. But this time the dream does not pull them down. Lira guides them in, through layers no traveler has ever seen.",
		"For the first time in centuries, Lira is not running. She is leading.",
	]
	b.next_battle_id = "S3_C_DreamDescent"
	b.music_track = "res://assets/audio/music/town/Medieval Celtic 07(L).wav"
	b.cutscene_track = "res://assets/audio/music/cutscene/Sad Despair 13.wav"
	return b


static func s3_c_dream_descent() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_C_DreamDescent"
	b.scene_image = "res://assets/art/battles/dream_void.png"
	b.enemies = [
		EnemyDB.create_abyssal_dreamer("Deep Watcher"),
		EnemyDB.create_thread_devourer("Frayed Hunger"),
		EnemyDB.create_slumbering_colossus("Sleeping Mountain"),
	]
	b.pre_battle_text = [
		"The deep dream is nothing like the layers above. There is no architecture, no broken geometry. Just vast open darkness, lit by threads that stretch in every direction like a web across the sky.",
		"Lira moves through it with the confidence of someone who has walked this path a thousand times. 'I have been here before,' she says. 'Always alone. Always running. Never going deeper than this.'",
		"Things stir in the darkness. Entities that exist in the space between dreams, feeding on the Loom's overflow. They are not part of the Threadmaster's design. They are parasites, drawn by the energy.",
		"A massive shape shifts in the distance. Something that was sleeping for centuries, now awake because the Sanctum Guardian's fall sent tremors through the deep dream.",
		"'Stay close,' Lira says. 'The things down here do not obey the Threadmaster. They obey nothing.'",
	]
	b.post_battle_text = [
		"The deep dream creatures scatter into the darkness. Ahead, the threads grow denser, converging toward a point of light.",
		"Lira stumbles. The threads beneath her skin pulse brighter. 'It knows I am coming,' she says. 'It is pulling at me. Trying to drag me back.'",
		"She straightens. 'It has been pulling at me for centuries. I am used to it.'",
	]
	b.next_battle_id = "S3_C_CultInterception"
	b.music_track = "res://assets/audio/music/battle/Fantasy Tension - Elegy of the Fallen.ogg"
	b.cutscene_track = "res://assets/audio/music/cutscene/#12 Cave Horn.wav"
	return b


# =============================================================================
# Act IV: The Dream War
# =============================================================================

static func s3_c_cult_interception() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_C_CultInterception"
	b.scene_image = "res://assets/art/battles/dream_temple.png"
	b.enemies = [
		EnemyDB.create_dream_priest("High Priest Thorne"),
		EnemyDB.create_astral_enforcer("Astral Blade"),
		EnemyDB.create_oneiric_guardian("Dream Wall"),
	]
	b.pre_battle_text = [
		"A barrier of woven light blocks the path. Behind it, figures shimmer into existence. Not dream creatures. People. Cult members who have used the Loom's power to project themselves into the dream.",
		"Thorne stands at their center, but he looks different here. Taller. Brighter. The dream enhances what the dreamer believes about themselves, and Thorne believes he is a god's chosen priest.",
		"'You cannot reach the Threadmaster,' Thorne says. His voice echoes in ways that physical throats cannot produce. 'It sustains us. All of us. The town, the Loom, the Thread. Without it, everything falls apart.'",
		"'Everything falls apart anyway,' Lira says. 'You are just too comfortable to notice.'",
		"Thorne's face twists. 'You were given a gift, girl. Immortality. A purpose. And you spit on it.'",
		"'I was given a cage,' Lira replies. 'And I am done living in it.'",
	]
	b.post_battle_text = [
		"The dream-projections shatter. Somewhere in the waking world, Thorne and the others collapse, their connection to the Loom severed.",
		"'You fools,' Thorne's fading voice echoes. 'Without the Threadmaster, the town dies.'",
		"'The town was never alive,' Lira says quietly. 'It was being fed on. There is a difference.'",
		"The barrier dissolves. The path ahead opens into something vast and dark and old.",
	]
	b.next_battle_id = "S3_C_ThreadmasterLair"
	b.music_track = "res://assets/audio/music/battle/Fantasy Tension - Weeping Walls.ogg"
	return b


static func s3_c_threadmaster_lair() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_C_ThreadmasterLair"
	b.scene_image = "res://assets/art/battles/dream_sanctum.png"
	b.enemies = [
		EnemyDB.create_nightmare_sentinel("Lair Guardian"),
		EnemyDB.create_memory_eater("Memory Drinker"),
		EnemyDB.create_anchor_chain("Lira's Chain"),
	]
	b.pre_battle_text = [
		"The Threadmaster's inner sanctum is not a place. It is a presence. The air is thick with centuries of stolen dreams, and the darkness breathes.",
		"A voice fills the space. Not loud. Intimate. As if it is speaking from inside their skulls.",
		"'Lira.' The voice is patient. Ancient. Amused. 'You have brought visitors. How thoughtful.'",
		"Threads of darkness writhe outward from the center and wrap around Lira's wrists, her ankles, her throat. She gasps. The chains beneath her skin blaze with light.",
		"'You belong to me,' the Threadmaster says. 'You have always belonged to me. Every year of your long life has been my gift. Every breath you take is because I allow it.'",
		"Lira's hands shake. For a moment, the centuries of captivity weigh on her visibly. Then she looks at the travelers.",
		"'Fight it with me,' she says. 'I cannot hold it alone. But I do not have to.'",
	]
	b.post_battle_text = [
		"The chain shatters. Lira screams, not in pain but in release, as centuries of binding unravel from her body. The light beneath her skin flares and then goes still.",
		"The inner defenses crumble. The breathing darkness recoils.",
		"And at the center of the sanctum, the Threadmaster's true form is exposed. Not the formless presence. Not the voice. A shape. Old beyond reckoning, woven from the first dreams ever dreamed, sustained by every stolen night since.",
		"Lira stands, shaking but free. Truly free for the first time in her life.",
		"'I have waited centuries for this,' she says.",
	]
	b.next_battle_id = "S3_C_DreamNexus"
	b.music_track = "res://assets/audio/music/battle/Fantasy Tension - Fallen Realm.ogg"
	b.cutscene_track = "res://assets/audio/music/cutscene/Sad Despair 04.wav"
	return b


# =============================================================================
# Act V: The Ancient Enemy
# =============================================================================

static func s3_c_dream_nexus() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_C_DreamNexus"
	b.scene_image = "res://assets/art/battles/dream_nexus.png"
	b.is_final_battle = true
	b.is_boss = true
	b.enemies = [
		EnemyDB.create_dream_shackle("Binding of Ages"),
		EnemyDB.create_ancient_threadmaster("The Threadmaster"),
		EnemyDB.create_loom_heart("Heart of the Loom"),
	]
	b.pre_battle_text = [
		"The Dream Nexus. Every thread converges here. Every stolen dream. Every century of harvest.",
		"The Threadmaster has no face. It has no body, not really. It is a thing that predates the town, the Loom, perhaps the concept of dreaming itself. It built the Loom because it was hungry, and it found a child bright enough to power the entire system.",
		"It turns its attention to Lira. Not with eyes. With weight. With ownership.",
		"'You are nothing without me,' it says. 'A serving girl in a forgotten town. I gave you centuries. I gave you purpose. I gave you the dance.'",
		"Lira steps forward. The threads that once bound her hang slack at her sides, severed and dead.",
		"'You gave me a cage,' she says. 'And a leash. And a smile to wear while you fed on everyone I served.'",
		"She looks at the travelers. Not for permission. For solidarity.",
		"'I am everything without you,' she says to the Threadmaster. 'And I am not alone.'",
	]
	b.post_battle_text = [
		"Lira drives her hand into the last thread. Not the travelers. Lira. Her fingers close around the strand of light and she pulls.",
		"'This ends now,' she says.",
		"The Threadmaster howls. A sound older than language, older than fear. The Loom tears apart. Every thread snaps. Every stolen dream cascades outward in a wave of light.",
		"For one moment, the travelers see every face the Threadmaster ever wore. The innkeeper. A healer in a mountain village. A merchant on a coastal road. A priest in a forgotten temple. A dozen identities across centuries. All masks. None of them Lira.",
		"Then the light fades. The darkness fades. Everything fades.",
		"They wake in the cellar. The physical Loom is dark. Its threads have disintegrated. The walls are just walls. The hum is gone.",
		"Lira sits on the floor, breathing hard. She looks different. Smaller. Younger, somehow. The centuries of the Loom's weight have lifted, and what remains is a woman who has been fighting alone for a very long time.",
		"'Is it over?' she asks. Not rhetorically. She genuinely does not know.",
		"The threads are gone. The hum is silent. It is over.",
		"The town wakes. For the first time in centuries, every person in it slept through the night without dreaming. Without losing anything. The cult members stir from a fog they did not know they were in.",
		"Lira walks into the sunrise. She stands in the doorway of the inn and watches the light cross the street.",
		"'I have never seen the morning without feeling the Loom pulling at me,' she says. 'It is quiet. For the first time in my life, it is quiet.'",
		"She stays. Not as a guardian. Not as a prisoner. Just as a person who finally gets to choose what happens next.",
		"The travelers leave by midmorning, truly rested. Their dreams that night are kind.",
	]
	b.post_scene_image = "res://assets/art/battles/town_edge_dawn.png"
	b.music_track = "res://assets/audio/music/boss/The Battle of Ages_FULL.wav"
	b.cutscene_track = "res://assets/audio/music/cutscene/Sad Despair 15.wav"
	return b
