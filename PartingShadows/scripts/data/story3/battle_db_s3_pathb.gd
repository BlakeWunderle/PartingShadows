class_name BattleDBS3PathB

## Story 3 Path B battle configs: the investigation path where Lira's true nature
## is uncovered. Triggers when the player chooses not to trust Lira at
## S3_TownRealization.

const BattleData := preload("res://scripts/data/battle_data.gd")
const EnemyDB := preload("res://scripts/data/story3/enemy_db_s3_pathb.gd")


static func create_battle(battle_id: String) -> BattleData:
	match battle_id:
		"S3_B_InnSearch": return s3_b_inn_search()
		"S3_B_CultConfrontation": return s3_b_cult_confrontation()
		"S3_B_CallumsTruth": return s3_b_callums_truth()
		"S3_B_TunnelBreach": return s3_b_tunnel_breach()
		"S3_B_ThornesWard": return s3_b_thornes_ward()
		"S3_B_LoomHeart": return s3_b_loom_heart()
		"S3_B_DreamInvasion": return s3_b_dream_invasion()
		"S3_B_DreamNexus": return s3_b_dream_nexus()
		_:
			push_error("Unknown Story 3 Path B battle: %s" % battle_id)
			return s3_b_inn_search()


# =============================================================================
# Act III: The Investigation
# =============================================================================

static func s3_b_inn_search() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_B_InnSearch"
	b.scene_image = "res://assets/art/battles/weary_traveler_night.png"
	b.enemies = [
		EnemyDB.create_cellar_sentinel("Bound Sentinel"),
		EnemyDB.create_bound_stalker("Sleeping Fang"),
		EnemyDB.create_bound_stalker("Night Prowler"),
	]
	b.pre_battle_text = [
		"They wait until the inn is silent. Lira retired to her room an hour ago, and the common room is dark.",
		"The travelers move through the hallways on quiet feet. Past the bar. Past the kitchen. To a door half-hidden behind a shelf of preserves.",
		"Behind it is not a servant's quarters. It is a chamber. Thread sigils cover every wall, pulsing faintly with the same light they saw in the dream. A loom sits in the corner, smaller than the one in the dream but unmistakably the same design.",
		"On a desk, a guest book. Not the one in the common room. This one is older, the leather cracked and dry. The entries go back centuries.",
		"The handwriting does not change. Every page, every name, every note. The same hand. Lira's hand.",
		"A sound rises from beneath the floor. The sigils flare. Bound creatures stir in the passage below, tethered to the physical world by threads of woven power.",
	]
	b.post_battle_text = [
		"The bound creatures dissolve into loose threads. The passage below is open.",
		"One traveler holds the guest book, staring at the final entry. Written yesterday, in the same handwriting as the entry from two hundred years ago.",
		"'She has been doing this,' one says quietly, 'for a very long time.'",
		"They hear footsteps above. The town is starting to stir. They need to move.",
	]
	b.next_battle_id = "S3_B_CultConfrontation"
	b.music_track = "res://assets/audio/music/battle_dark/MUSC_Black_Moon_52BPM_Eminor_1644_Full_Loop.wav"
	b.cutscene_track = "res://assets/audio/music/cutscene/Sad Despair 06.wav"
	return b


static func s3_b_cult_confrontation() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_B_CultConfrontation"
	b.scene_image = "res://assets/art/battles/cult_alleys.png"
	b.enemies = [
		EnemyDB.create_thread_disciple("Brother Voss"),
		EnemyDB.create_thread_warden("Sister Maren"),
	]
	b.pre_battle_text = [
		"They slip out the back of the inn into the gray light before dawn. The alleys are narrow and the shadows are long.",
		"They do not get far. A man steps from a doorway, blade drawn. The shopkeeper. Behind him, a woman in woven armor, her stance that of a trained fighter.",
		"'You were supposed to trust her,' the shopkeeper says. His eyes are calm. Too calm. 'Everyone trusts her.'",
		"A third figure hangs back in the shadows. The hexer, Callum. His hands are raised, but they are shaking.",
		"'Voss, wait,' Callum says. 'They found the book. They know.'",
		"'Then they know too much,' Voss replies. 'The Loom will not be denied.'",
		"Callum does not move to attack. Something in his eyes is different from the others.",
	]
	b.post_battle_text = [
		"Voss falls. Maren staggers, clutching a wound, and drops to one knee.",
		"In the silence, Callum sheathes the blade he never drew against the travelers. His hands are still shaking.",
		"'I have been waiting years for someone to look past her act,' he says. 'I need to tell you something about the serving girl. About what she really is.'",
		"He glances at the sky. 'Not here. Follow me. There is a place the Thread does not watch.'",
	]
	b.next_battle_id = "S3_B_CallumsTruth"
	b.music_track = "res://assets/audio/music/battle/Fantasy Tension - Bloody Night.ogg"
	b.cutscene_track = "res://assets/audio/music/cutscene/#9.wav"
	return b


static func s3_b_callums_truth() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_B_CallumsTruth"
	b.scene_image = "res://assets/art/battles/cult_catacombs.png"
	b.is_town_stop = true
	b.pre_battle_text = [
		"Callum leads them to a cellar beneath an abandoned mill on the edge of town. The walls are bare stone, free of sigils.",
		"'This is the only place in town she cannot hear,' he says. 'I scraped the threads out of the walls myself, a little at a time, over years.'",
		"He sits on an overturned crate and does not look at them when he speaks.",
		"'Lira is not a victim. She is the Threadmaster. She has been for centuries.'",
		"'She was a child once. A real one. She found the Loom in the caves beneath the town when she was young. It consumed her. Remade her. She became something that lives in the dream, something that feeds on sleeping minds.'",
		"'The serving girl is a mask. The dancer in the dream is bait. And the shadow that chases her through every dream? Her own creation. Theater. It makes travelers feel protective of her. They fight for her. They trust her. And every ounce of trust feeds the Loom.'",
		"'The innkeeper is another puppet. Lira wears faces the way other people wear clothes. She has been the innkeeper, the healer, the old woman at the edge of town. Whatever face draws travelers in and makes them sleep easy.'",
		"'Every person who trusts her feeds the Loom willingly. That is how she likes it. Consent given through deception is still consent, in her eyes.'",
		"He pauses. 'I joined the cult because I believed. She told us we were protecting the town, channeling energy that would otherwise go to waste. I stayed because I saw what she really was, and I was afraid. I am still afraid.'",
		"'But I can teach you something she does not know I learned. How to sever the threads. How to cut the Loom's connections without being consumed by them. I have been practicing in secret for years, waiting for someone strong enough to use it.'",
	]
	b.post_battle_text = [
		"The travelers rest and absorb what they have learned. Callum teaches them the severing technique, showing them how to recognize the threads and cut them cleanly.",
		"'Thorne guards the lower passages,' Callum says. 'He is a true believer. He thinks she is a goddess. He will not let you pass without a fight.'",
		"'Beyond him is the heart of the Loom. The physical anchor. Destroy it, and she loses her hold on the waking world. Then you will have to face her in the dream, where she is strongest.'",
		"He stands. 'I cannot go with you. She would sense me. But I will make sure the path behind you stays clear.'",
	]
	b.next_battle_id = "S3_B_TunnelBreach"
	b.music_track = "res://assets/audio/music/town/Town Village 02(L).wav"
	b.cutscene_track = "res://assets/audio/music/cutscene/Sad Despair 10.wav"
	return b


static func s3_b_tunnel_breach() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_B_TunnelBreach"
	b.scene_image = "res://assets/art/battles/cult_catacombs.png"
	b.enemies = [
		EnemyDB.create_tunnel_sentinel("Gate Guard"),
		EnemyDB.create_thread_sniper("Bolt Caster"),
		EnemyDB.create_pale_devotee("Brother Hale"),
	]
	b.pre_battle_text = [
		"The entrance to the passages is not where Callum described. The cult has sealed the old way and opened a new one, freshly carved, behind the blacksmith's forge.",
		"They find it by following the hum. The threads are louder now, vibrating at a pitch that sets the teeth on edge. Something has changed since the morning. The cult is preparing.",
		"A heavy door stands at the top of a stairway. Three guards wait on the landing beyond. The sentinel at the center holds a blade wrapped in glowing thread. Beside him, a hooded figure crouches with hands raised, fingers trailing light. A third stands behind them, chanting softly, the words rising and falling like a hymn.",
		"'The Threadmaster will not be disturbed,' the sentinel says. He does not draw the blade. It is already drawn.",
	]
	b.post_battle_text = [
		"The guards fall. The chanting stops. The passage ahead descends steeply, the walls narrowing until only one person can walk abreast.",
		"The hum deepens. The sigils on the walls pulse faster. Whatever is at the bottom knows they are coming.",
	]
	b.next_battle_id = "S3_B_ThornesWard"
	b.music_track = "res://assets/audio/music/battle/Fantasy Tension - Altar of the Forgotten.ogg"
	return b


# =============================================================================
# Act IV: The Heart of the Loom
# =============================================================================

static func s3_b_thornes_ward() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_B_ThornesWard"
	b.scene_image = "res://assets/art/battles/cult_catacombs.png"
	b.enemies = [
		EnemyDB.create_thread_ritualist("High Ritualist Thorne"),
		EnemyDB.create_passage_guardian("Loom Champion"),
		EnemyDB.create_warding_shadow("Warding Shadow"),
	]
	b.pre_battle_text = [
		"The passages beneath the inn stretch deeper than any cellar should. The walls are carved with the Thread's symbols, and physical threads hum between the pillars like plucked strings.",
		"Thorne stands at a junction, his robes covered in sigils that pulse with the Loom's light. Behind him, a guard in woven armor and a shade that flickers between states of being.",
		"'You should have slept when you had the chance,' Thorne says. His voice carries the certainty of a man who has never doubted. 'She gave this town purpose. She gave all of us purpose. You would take that away.'",
		"'She is harvesting people,' one traveler says.",
		"'She is sustaining us,' Thorne replies. 'The town has prospered for two hundred years. No plague. No famine. No war. All she asks is a few hours of dreaming. You call that a crime?'",
		"His hands begin to glow. 'I call it a gift.'",
	]
	b.post_battle_text = [
		"Thorne falls to his knees. The sigils on his robes go dark.",
		"'You do not understand what you are doing,' he whispers. 'Without her, this town is nothing. Just another forgotten village on a forgotten road.'",
		"The passage ahead opens into a vast underground chamber. The hum of the threads grows louder. Light pulses from below.",
	]
	b.next_battle_id = "S3_B_LoomHeart"
	b.music_track = "res://assets/audio/music/battle/Fantasy Tension - Storming the Citadel.ogg"
	return b


static func s3_b_loom_heart() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_B_LoomHeart"
	b.scene_image = "res://assets/art/battles/cult_ritual_chamber.png"
	b.enemies = [
		EnemyDB.create_shadow_innkeeper("The Innkeeper"),
		EnemyDB.create_astral_weaver("Weaver Aldric"),
		EnemyDB.create_loom_tendril("Loom Tendril"),
	]
	b.pre_battle_text = [
		"The ritual chamber is enormous. The physical Loom stands at its center, threads of light spinning into patterns that hurt to look at directly.",
		"Aldric kneels before the Loom, his hands moving through the threads. He is not here physically. His body is somewhere in the dream, projecting his will through the weave.",
		"A figure steps from behind the Loom. The innkeeper. The practiced smile. The warm eyes.",
		"'She will not be pleased that you came this far,' the innkeeper says. But the voice is wrong. Layered. Hollow.",
		"A whisper from the shadows, barely audible. Maren's voice. 'The threads on the left side. Cut those first. It weakens the binding.'",
		"She is gone before anyone can respond. The fog that held her has lifted, and what remains is a woman who saw the truth too late and is trying to make it right.",
	]
	b.post_battle_text = [
		"The innkeeper's form ripples and dissolves. Not like a person dying. Like a puppet coming unstrung. Thread and shadow, given a face and a smile, and now just thread and shadow again.",
		"Aldric's projection shatters. Somewhere in the dream, his real body collapses.",
		"The physical Loom cracks. Threads snap and flare. The chamber shudders.",
		"And then the dream pulls them in. Not gently, not like sleep. Like a hand reaching through the floor and dragging them under.",
		"The last thing they see is the Loom, broken and sparking. The last thing they hear is a voice they recognize.",
		"Lira's voice. Not the serving girl's warmth. Not the dancer's grace. Something older and colder and very, very awake.",
		"'You broke my roots,' she says. 'Now come and see what grows without them.'",
	]
	b.next_battle_id = "S3_B_DreamInvasion"
	b.music_track = "res://assets/audio/music/battle/Fantasy Tension - The Last Crusade.ogg"
	b.cutscene_track = "res://assets/audio/music/cutscene/Sad Despair 11.wav"
	return b


# =============================================================================
# Act V: The True Threadmaster
# =============================================================================

static func s3_b_dream_invasion() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_B_DreamInvasion"
	b.scene_image = "res://assets/art/battles/dream_sanctum.png"
	b.enemies = [
		EnemyDB.create_cathedral_warden("Loom Warden"),
		EnemyDB.create_dream_binder("Thread Binder"),
		EnemyDB.create_weft_stalker("The Weft Predator"),
	]
	b.pre_battle_text = [
		"The dream is different from what they remember. The broken architecture, the impossible geometry. All of it is gone.",
		"In its place is something deliberate. Beautiful, even. Soaring arches of woven light. Corridors that curve like music. A cathedral built thread by thread over centuries by a single mind.",
		"This is not a cage. It is a home. Lira built this place, and she has had a very long time to perfect it.",
		"Dream guardians stir at the edges of the cathedral. They are stronger here, drawing power from the architecture itself. But the travelers have Callum's severing technique, and they know what lies at the center.",
		"They cut through the first threads. The cathedral shudders. Somewhere ahead, a light flares.",
	]
	b.post_battle_text = [
		"The guardians fall. The threads they protected go slack, and a section of the cathedral unravels like pulled stitching.",
		"A voice echoes through the collapsing architecture. Familiar. Wrong.",
		"'You should have trusted me,' Lira says. 'It would have been so much easier.'",
		"The cathedral opens ahead into the nexus at its heart.",
	]
	b.next_battle_id = "S3_B_DreamNexus"
	b.music_track = "res://assets/audio/music/battle/Fantasy Tension - Duskfall Requiem.ogg"
	b.cutscene_track = "res://assets/audio/music/cutscene/#15 Dark Strings Swell.wav"
	return b


static func s3_b_dream_nexus() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_B_DreamNexus"
	b.scene_image = "res://assets/art/battles/dream_nexus.png"
	b.is_final_battle = true
	b.is_boss = true
	b.enemies = [
		EnemyDB.create_lira_threadmaster("Lira, the Threadmaster"),
		EnemyDB.create_tattered_deception("Tattered Shadow"),
		EnemyDB.create_dream_bastion("Dream's Last Defense"),
	]
	b.pre_battle_text = [
		"The Dream Nexus. Every thread converges here, every stolen dream, every drained night of rest.",
		"But there is no ancient faceless being at the center. No creature that abandoned flesh long ago. There is only Lira.",
		"She stands where the Threadmaster should be, threads extending from her fingers like puppet strings. She looks the same. The serving girl. The dancer. But her eyes are old. Centuries old.",
		"'I was a child when I found the Loom,' she says. 'I was afraid of it. And then I was not.'",
		"'The shadow was my first creation. It made me look hunted. Vulnerable. Every traveler who protected me in the dream fed the Loom with their courage and their trust. A much richer harvest than fear ever was.'",
		"'The innkeeper, the Threadmaster, every face this town has worn. They are all me. I am the dream. I am the Loom. I am every night of stolen rest this town has ever taken.'",
		"'You could have slept. You could have trusted me and walked away thinking you had won. Others have. They always do.'",
		"She smiles. It is the practiced smile of the innkeeper. The warm smile of the serving girl. The luminous grace of the dancer. All the same smile. All the same lie.",
		"'But you had to look.'",
	]
	b.post_battle_text = [
		"Lira screams as the last thread snaps. Not the Threadmaster's scream. Lira's. A girl's voice, centuries old, finally breaking.",
		"The Loom collapses inward, threads unraveling in cascading waves. The nexus tears itself apart.",
		"For one moment, the travelers see her as she was. A child in a cave, reaching for something she did not understand. Small hands touching threads of light, and the light reaching back, pouring into her, remaking her into something that would never be a child again.",
		"Then the image dissolves. Every stolen dream cascades outward. A child's nightmare. A mother's hope. An old man's memory of a face he loved. Thousands of fragments, set free.",
		"They are standing in the cellar. The physical Loom is dark, its threads disintegrated. The walls are just walls. The hum is gone.",
		"There is no body. No trace of the girl who poured ale and smiled and asked if they slept well. She was woven into the Loom so completely that when it broke, she broke with it.",
		"Dawn light streams through the cellar door. Brother Callum waits in the common room. He does not celebrate.",
		"'She was a real child once,' he says quietly. 'Before the Loom took her. I try to remember that.'",
		"The town wakes. For the first time in years, every person in it slept through the night without dreaming. Without losing anything. The cult members stir from a fog they did not know they were in, blinking at the sigils on their hands as if seeing them for the first time.",
		"But there is no kind innkeeper to smooth things over. No serving girl to pour the morning ale. Just an empty inn and a sign that reads 'The Weary Traveler.'",
		"Callum walks them to the edge of town. 'Someone should tell the truth about what happened here,' he says. 'Might as well be the one who stayed too long.'",
		"They leave the town by midmorning. Their dreams that night are their own.",
	]
	b.post_scene_image = "res://assets/art/battles/town_edge_dawn.png"
	b.music_track = "res://assets/audio/music/boss/The Battle of Ages_FULL.wav"
	b.cutscene_track = "res://assets/audio/music/cutscene/Sad Despair 08.wav"
	return b
