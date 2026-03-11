class_name BattleDBS3Act45

## Story 3 Acts IV-V battle configs: the cult investigation and final confrontation.

const BattleData := preload("res://scripts/data/battle_data.gd")
const EnemyDB := preload("res://scripts/data/story3/enemy_db_s3_act45.gd")


static func create_battle(battle_id: String) -> BattleData:
	match battle_id:
		"S3_CultUnderbelly": return s3_cult_underbelly()
		"S3_CultCatacombs": return s3_cult_catacombs()
		"S3_CultRitualChamber": return s3_cult_ritual_chamber()
		"S3_DreamNexus": return s3_dream_nexus()
		_:
			push_error("Unknown Story 3 Act IV-V battle: %s" % battle_id)
			return s3_cult_underbelly()


# =============================================================================
# Act IV: The Investigation
# =============================================================================

static func s3_cult_underbelly() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_CultUnderbelly"
	b.scene_image = "res://assets/art/battles/city_streets.png"
	b.enemies = [
		EnemyDB.create_cult_acolyte("Brother Voss"),
		EnemyDB.create_cult_enforcer("Sister Maren"),
		EnemyDB.create_cult_hexer("Brother Callum"),
	]
	b.pre_battle_text = [
		"The town wears a different face in the gray hours before dawn. Alleyways that seemed charming by day are narrow and watchful in the dark.",
		"Lira leads them through the back alleys. 'The baker, the blacksmith, the woman who sells flowers. Half the town serves the Thread. They have been watching you since you arrived.'",
		"They do not get far before they are noticed. A shopkeeper steps from a doorway, but in his hand is a blade, not a broom. Two more appear behind him.",
		"'The innkeeper said you might be trouble,' the shopkeeper says. His eyes are wrong. Too calm. Too certain. 'We cannot let you interfere with the Loom.'",
		"The cult of the Thread has been hiding in plain sight. Half the town is in on it.",
	]
	b.post_battle_text = [
		"The cult agents fall. One of them drops a key, ornate and old, stamped with the Thread's sigil.",
		"'The cellar,' one traveler says. 'Under the inn. This key fits the locks we saw.'",
		"They move through the empty streets toward the inn. The door is unlocked. The common room is dark. And the cellar door stands open, as if it was expecting them.",
	]
	b.next_battle_id = "S3_CultCatacombs"
	b.music_track = "res://assets/audio/music/battle/Fantasy Tension - Circle of the Serpent.ogg"
	b.cutscene_track = "res://assets/audio/music/cutscene/#1 Alt 2.wav"
	return b


static func s3_cult_catacombs() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_CultCatacombs"
	b.scene_image = "res://assets/art/battles/sealed_gate.png"
	b.enemies = [
		EnemyDB.create_thread_guard("Loom Watcher"),
		EnemyDB.create_dream_hound("Bound Hound"),
		EnemyDB.create_dream_hound("Chain Fang"),
	]
	b.pre_battle_text = [
		"Beneath the inn, the cellar gives way to something much older. Stone corridors stretch in directions that no building above could contain.",
		"The walls are carved with the Thread's symbols, and real threads, physical ones, are strung between pillars. They hum with a low vibration, like plucked harp strings.",
		"A guard in woven armor stands at a junction. Beside it, two hounds made of dream-stuff, tethered to the physical world by the same threads that power the Loom.",
		"'I told you,' Lira says quietly. 'The Loom is not just in the dream. It has roots here. Physical roots. I have been listening to them hum through the floorboards my entire life.'",
	]
	b.post_battle_text = [
		"The hounds dissolve, their threads severed. The guard collapses, and the passage ahead opens into a vast underground chamber.",
		"The hum of the threads grows louder. Light pulses from below. They are close to the heart of it.",
	]
	b.next_battle_id = "S3_CultRitualChamber"
	b.music_track = "res://assets/audio/music/battle/Fantasy Tension - Cursed Kingdoms.ogg"
	return b


static func s3_cult_ritual_chamber() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_CultRitualChamber"
	b.scene_image = "res://assets/art/battles/echo_gallery.png"
	b.enemies = [
		EnemyDB.create_cult_ritualist("High Ritualist Sera"),
		EnemyDB.create_high_weaver("Weaver Aldric"),
		EnemyDB.create_thread_guard("Loom Champion"),
	]
	b.pre_battle_text = [
		"The ritual chamber is enormous. A web of threads stretches from floor to ceiling, each one vibrating with stolen energy. At the center, a loom, not a metaphor but a physical device, spins threads of light into patterns.",
		"Two figures stand at the loom. One chants in a language that scrapes the inside of the skull. The other manipulates the threads with practiced hands.",
		"'You should not have come here,' the ritualist says without turning. 'Every traveler who sleeps in this town feeds the Loom. We have sustained it for decades. You are the first to notice.'",
		"'And you will be the last,' the weaver finishes. The threads tighten around the chamber like a closing fist.",
	]
	b.post_battle_text = [
		"The ritualist and weaver fall. The physical loom cracks, but does not break. The threads flare, brighter than before.",
		"Lira stares at the cracking loom. 'She is not just the leader,' Lira says quietly. 'She IS the Loom. Destroying her agents will not stop it.'",
		"A voice fills the chamber. The innkeeper's voice, but amplified, echoing from the threads themselves.",
		"'Fools. The Loom does not need me to operate it. It needs me to restrain it.'",
		"The threads whip outward. The shadow erupts from the cracking loom, larger than it has ever been, and wraps itself around Lira before anyone can move. She screams, and the darkness swallows her whole.",
		"The chamber dissolves. The travelers are dragged back into the dream, deeper than they have ever been. But Lira is not beside them. The shadow has her, bound in threads of darkness at the heart of the Loom.",
		"They stand in a nexus of woven light, and at its center stands the Threadmaster, the innkeeper, her true form revealed: a weaver of dreams who has spent decades building the Loom and feeding it the psychic energy of hundreds.",
	]
	b.next_battle_id = "S3_DreamNexus"
	b.music_track = "res://assets/audio/music/battle/Fantasy Tension - Arcane Thrones.ogg"
	b.cutscene_track = "res://assets/audio/music/cutscene/Sad Despair 05.wav"
	return b


# =============================================================================
# Act V: The Confrontation
# =============================================================================

static func s3_dream_nexus() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_DreamNexus"
	b.scene_image = "res://assets/art/battles/eye_of_oblivion.png"
	b.is_final_battle = true
	b.enemies = [
		EnemyDB.create_the_threadmaster("The Threadmaster"),
		EnemyDB.create_high_weaver("Loom Echo"),
	]
	b.pre_battle_text = [
		"The Dream Nexus is the heart of the Loom. Every thread converges here, every stolen dream, every drained night of rest. The air is thick with the energy of a thousand sleepers.",
		"Behind the Threadmaster, Lira hangs suspended in a web of dark threads, the shadow coiled around her like a cage. Her eyes are open but distant, trapped between sleep and waking.",
		"'Your little dancer belongs to the Loom now,' the Threadmaster says. 'She always did. She just did not know it.'",
		"The Threadmaster stands at the center, threads extending from her fingers like puppet strings. She is not the innkeeper anymore. She is something older, something that learned to weave dreams before the town existed.",
		"'I built the Loom to feed,' she says. 'Every weary traveler. Every restless sleeper. Their dreams sustained me, and the town prospered in return. A fair trade.'",
		"'There is nothing fair about stealing from the unconscious,' one traveler replies.",
		"The Threadmaster's face hardens. 'Then let us settle this the way dreams always end. With one side waking, and the other forgotten.'",
	]
	b.post_battle_text = [
		"The Threadmaster screams as the last thread snaps. The Loom collapses inward, threads unraveling in cascading waves. The nexus tears itself apart.",
		"The shadow shrieks, a sound like tearing cloth, and dissolves into wisps of dark thread that scatter and fade. The thing that hunted Lira's dreams for years is gone in an instant.",
		"Lira falls free from the web, gasping. One of the travelers catches her before she hits the ground.",
		"For one moment, the travelers see every dream the Loom ever stole: a child's nightmare, a mother's hope, an old man's memory of a face he loved. Thousands of stolen fragments, set free.",
		"Then they are standing in the cellar. The physical loom is dark, its threads disintegrated. The walls are just walls. The hum is gone.",
		"Lira stands in the silence, shaken but whole. The power that the Loom stole from her as a child flows back through her. She looks different now. Steadier. Freer. The luminous dancer and the quiet serving girl finally the same person.",
		"Dawn light streams through the cellar door. The innkeeper lies unconscious on the floor, aged decades in an instant, the power that sustained her finally spent.",
		"The town wakes up. For the first time in years, every person in it slept through the night without dreaming. Without losing anything.",
		"The sign above the inn door has faded. 'The Weary Traveler.' It makes a different kind of sense now.",
		"Lira walks them to the edge of town. 'I spent my whole life dreaming of escape,' she says. 'Now I think I will stay. Someone needs to make sure the threads stay quiet.'",
		"They leave the town by midmorning, rested for the first time since they arrived.",
	]
	b.music_track = "res://assets/audio/music/boss/The Battle of Ages_FULL.wav"
	b.cutscene_track = "res://assets/audio/music/cutscene/Sad Despair 12.wav"
	return b
