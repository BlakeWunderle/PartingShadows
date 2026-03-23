class_name BattleDBS3

## Story 3 Acts I-II battle configs: the first two dreams and the town between them.

const BattleData := preload("res://scripts/data/battle_data.gd")
const EnemyDB := preload("res://scripts/data/story3/enemy_db_s3.gd")


static func create_battle(battle_id: String) -> BattleData:
	match battle_id:
		"S3_WearyTraveler": return s3_weary_traveler()
		"S3_DreamMeadow": return s3_dream_meadow()
		"S3_DreamMirrorHall": return s3_dream_mirror_hall()
		"S3_DreamFogGarden": return s3_dream_fog_garden()
		"S3_TownMorning": return s3_town_morning()
		"S3_DreamReturn": return s3_dream_return()
		"S3_DreamLabyrinth": return s3_dream_labyrinth()
		"S3_DreamClockTower": return s3_dream_clock_tower()
		"S3_DreamNightmare": return s3_dream_nightmare()
		_:
			push_error("Unknown Story 3 Act I-II battle: %s" % battle_id)
			return s3_weary_traveler()


# =============================================================================
# Act I: The First Dream
# =============================================================================

static func s3_weary_traveler() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_WearyTraveler"
	b.scene_image = "res://assets/art/battles/weary_traveler_inn.png"
	b.is_town_stop = true
	b.pre_battle_text = [
		"Before heading upstairs, the innkeeper slides a worn leather journal across the bar. 'Just sign the guest book,' she says. 'Everyone does.'",
		"The pages are thick and yellowed with age. Hundreds of names in hundreds of hands. The travelers write their names and trades without a second thought.",
		"The rooms are small but clean. The beds are soft. The pillows smell faintly of lavender.",
	]
	b.post_battle_text = [
		"The candles gutter. The inn grows silent. And somewhere between waking and dreaming, something stirs.",
	]
	b.next_battle_id = "S3_DreamMeadow"
	b.music_track = "res://assets/audio/music/town/Medieval Tavern 03.wav"
	b.cutscene_track = "res://assets/audio/music/cutscene/#4.wav"
	return b


static func s3_dream_meadow() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_DreamMeadow"
	b.scene_image = "res://assets/art/battles/dream_meadow.png"
	b.enemies = [
		EnemyDB.create_dream_wisp("Glimmer"),
		EnemyDB.create_dream_wisp("Flicker"),
		EnemyDB.create_phantasm("The Unseen"),
	]
	b.pre_battle_text = [
		"A meadow stretches in every direction, lit by a sky that has no sun. The grass moves without wind, and the colors are slightly wrong.",
		"This is not a place any of them recognize. Each stands alone in the field, and none can remember how they got here.",
		"Shapes drift through the tall grass. Flickering lights. A translucent figure that watches from just out of reach.",
		"Something about this place is hostile. The lights are converging.",
	]
	b.post_battle_text = [
		"The lights scatter. The meadow ripples like the surface of a pond, and the dream collapses inward.",
		"In the moment before waking, something else moves at the edge of the meadow. A figure, small and luminous, dancing between the tall grass. It pauses, turns, and seems to wave.",
		"Behind it, something follows. A shape of pure darkness, ragged at the edges, moving with the deliberate speed of a predator. The dancer's pace quickens, and it vanishes into the grass just ahead of the shadow's reach.",
	]
	b.choices = [
		{"label": "The meadow forks: left, a corridor of silver mirrors stretches into the distance.", "battle_id": "S3_DreamMirrorHall"},
		{"label": "The meadow forks: right, a garden of pale flowers sways in a fog that breathes.", "battle_id": "S3_DreamFogGarden"},
	]
	b.music_track = "res://assets/audio/music/battle_dark/MUSC_Secret_Garden_76BPM_Eminor_1644_Full_Loop.wav"
	b.cutscene_track = "res://assets/audio/music/cutscene/#10.wav"
	return b


static func s3_dream_mirror_hall() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_DreamMirrorHall"
	b.scene_image = "res://assets/art/battles/dream_mirror_hall.png"
	b.enemies = [
		EnemyDB.create_mirror_shade("Reflected Self"),
		EnemyDB.create_sleep_stalker("Prowler"),
		EnemyDB.create_shade_moth("Duskwing"),
	]
	b.pre_battle_text = [
		"The mirrors stretch endlessly, each reflecting a version of the world that is slightly different. In one, the sky is red. In another, the traveler's face is not quite their own.",
		"Something moves in the reflections. A shadow with borrowed features, a predator with familiar eyes.",
		"The mirrors shatter in sequence, and the things inside step through.",
	]
	b.post_battle_text = [
		"The last mirror cracks and the hall dissolves into white noise. The dream is ending.",
		"In the final unbroken mirror, a figure dances, bright and quick. It presses a hand to the glass and the mirror glows warm before shattering.",
		"Then a shadow fills every remaining reflection at once. A dark shape, formless and hungry, slamming against the glass from the inside. The mirrors crack under the impact. Whatever the dancer is running from, it is close behind.",
		"Morning. The shutters rattle in a breeze. It was a strange night, but the bed was comfortable and the dawn is bright.",
	]
	b.next_battle_id = "S3_TownMorning"
	b.music_track = "res://assets/audio/music/battle/Fantasy Tension - Twilight Monastery.ogg"
	return b


static func s3_dream_fog_garden() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_DreamFogGarden"
	b.scene_image = "res://assets/art/battles/dream_fog_garden.png"
	b.enemies = [
		EnemyDB.create_fog_wraith("Pale Mist"),
		EnemyDB.create_thorn_dreamer("Brambleshade"),
		EnemyDB.create_slumber_beast("Drowsy Bear"),
	]
	b.pre_battle_text = [
		"The fog is alive. It breathes in slow, heavy waves, and the flowers that grow through it are pale and thorned.",
		"Something large moves behind the mist. Vines coil around ankles, and the garden hums with a sound like a lullaby played wrong.",
		"The fog parts, and the things living in it are no longer hiding.",
	]
	b.post_battle_text = [
		"The garden folds in on itself like a closing book. The fog recedes into nothing.",
		"As the mist clears, a faint trail of golden light lingers in the air, as if someone danced through the garden ahead of them, leaving a path to follow.",
		"But behind the trail, the fog darkens. Something moves through it, low and fast, swallowing the light where it passes. The golden path fades to nothing in its wake.",
		"Sunlight. Birdsong. The smell of breakfast from the common room below. Just a bad dream.",
	]
	b.next_battle_id = "S3_TownMorning"
	b.music_track = "res://assets/audio/music/battle/Fantasy Tension - Dark Fables.ogg"
	return b


# =============================================================================
# Act II: The Second Dream
# =============================================================================

static func s3_town_morning() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_TownMorning"
	b.scene_image = "res://assets/art/battles/town_square_day.png"
	b.is_town_stop = true
	b.pre_battle_text = [
		"The morning is pleasant. The town square is busy with merchants, and the air smells of fresh bread and iron from the smithy.",
		"The innkeeper suggests visiting the market. 'We get good traders through here. Weapons, armor, supplies. You'll want to be prepared for the road ahead.'",
		"The serving girl from the night before brings their breakfast. Her name is Lira, the innkeeper says. Lira lingers a moment too long, watching them with an expression that is hard to read, before retreating to the kitchen.",
		"The travelers spend the day exploring. The town is charming. Normal. Friendly faces and honest prices.",
		"One traveler pauses at the guest book on the bar, flipping idly through its pages. The names stretch back years. Hundreds of entries. Some of the handwriting near the end trails off strangely, as if the writers were drowsy. They close the book and think nothing more of it.",
		"Only one thing nags at the back of each mind: last night's dream. But dreams are just dreams.",
	]
	b.post_battle_text = [
		"Evening falls. The innkeeper serves roast and ale, and the fire crackles pleasantly. The travelers return to their rooms, content.",
		"Sleep comes again, faster than it should. The darkness behind closed eyes deepens, and the meadow is waiting.",
	]
	b.next_battle_id = "S3_DreamReturn"
	b.music_track = "res://assets/audio/music/town/Medieval Tavern 03.wav"
	b.cutscene_track = "res://assets/audio/music/cutscene/#3.wav"
	return b


static func s3_dream_return() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_DreamReturn"
	b.scene_image = "res://assets/art/battles/dream_return.png"
	b.enemies = [
		EnemyDB.create_nightmare_hound("Gnasher"),
		EnemyDB.create_dream_weaver("Silken One"),
		EnemyDB.create_hollow_echo("Fading Voice"),
	]
	b.pre_battle_text = [
		"The dream is back, but it has changed. The meadow is gone. In its place is a landscape of broken architecture and impossible geometry.",
		"Corridors twist upward into darkness. Staircases lead to ceilings. The sky is the color of a bruise.",
		"This time, the creatures are waiting. They are larger, angrier, and they seem to recognize the intruders.",
		"A hound made of shadow snarls. Something woven from light hangs in the air, watching. An echo of a voice that never existed whispers from the walls.",
	]
	b.post_battle_text = [
		"The dream shudders. The broken architecture groans. Through the noise, a passage opens deeper into the structure.",
		"The dancing figure is back. Brighter than before, moving with purpose through the wreckage. It gestures ahead, urgently, and fades into a trail of light.",
		"But the figure does not linger. A dark shape surges through the wreckage behind it, fast and silent. The dancer flees, and the shadow follows, close enough to touch.",
	]
	b.next_battle_id = "S3_DreamThreads"
	b.music_track = "res://assets/audio/music/battle_dark/04_Eyes_in_the_Woods.wav"
	b.cutscene_track = "res://assets/audio/music/cutscene/#15 Dark Strings Swell.wav"
	return b


static func s3_dream_labyrinth() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_DreamLabyrinth"
	b.scene_image = "res://assets/art/battles/dream_labyrinth.png"
	b.enemies = [
		EnemyDB.create_twilight_stalker("Duskfang"),
		EnemyDB.create_waking_terror("Screamer"),
		EnemyDB.create_somnolent_serpent("Coilshadow"),
	]
	b.pre_battle_text = [
		"The walls shift. A corridor that was behind is now ahead. The floor tilts underfoot, and gravity feels like a suggestion.",
		"Something moves at the edge of vision. Fast. Too fast. A blade of twilight slashes through the air where a head just was.",
		"A scream echoes from every direction at once. The labyrinth is not a place. It is a trap.",
	]
	b.post_battle_text = [
		"The walls stop moving. A passage opens in the floor, dropping into a vast dark space below.",
		"A trail of soft light leads through the passage, as though the dancing figure passed this way moments ago, leaving breadcrumbs in the dark.",
		"Behind them, something scrapes against the walls. The shadow again, closer now. The breadcrumbs of light flicker and die where it passes.",
		"In the distance, something enormous stirs.",
	]
	b.next_battle_id = "S3_DreamNightmare"
	b.music_track = "res://assets/audio/music/battle/Fantasy Tension - The Tomb of Mystery.ogg"
	return b


static func s3_dream_clock_tower() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_DreamClockTower"
	b.scene_image = "res://assets/art/battles/dream_clock_tower.png"
	b.enemies = [
		EnemyDB.create_clock_specter("Frozen Hand"),
		EnemyDB.create_clock_specter("Still Pendulum"),
		EnemyDB.create_dusk_sentinel("Twilight Warden"),
	]
	b.pre_battle_text = [
		"The clock tower rises impossibly high. Its face is cracked, its hands locked at midnight. The air tastes of dust and stopped time.",
		"Specters drift between the gears, their forms flickering between moments. A sentinel stands at the landing, unmoving, watching.",
		"The clock begins to tick. Once. Twice. Then the specters turn.",
	]
	b.post_battle_text = [
		"The clock strikes thirteen. The tower cracks open, revealing the dark space beneath all dreams.",
		"A luminous figure stands on the lowest landing, dancing in place. It points downward, toward the dark space, then vanishes like a blown candle.",
		"A shadow pours down from the broken clockface like spilled ink, reaching for the spot where the figure stood. It pools at the base of the tower, coiling and waiting.",
		"Something waits below. Something that has been dreaming of them.",
	]
	b.next_battle_id = "S3_DreamNightmare"
	b.music_track = "res://assets/audio/music/battle/Fantasy Tension - Chamber of the Occult.ogg"
	return b


static func s3_dream_nightmare() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S3_DreamNightmare"
	b.scene_image = "res://assets/art/battles/dream_nightmare.png"
	b.enemies = [
		EnemyDB.create_the_nightmare("The Nightmare"),
		EnemyDB.create_nightmare_guard("Dread Sentinel"),
		EnemyDB.create_void_echo("Fading Cry"),
	]
	b.pre_battle_text = [
		"The space beneath the dream is vast and formless. A presence fills it, heavier than air, denser than thought.",
		"It takes shape slowly. A face made of every fear that was ever forgotten upon waking. Eyes like collapsed stars. A mouth that speaks in the language of paralysis.",
		"At the edge of the vast space, the dark shape that has stalked through every dream coils around the creature's base, feeding it. The Nightmare and the shadow are connected. One hunts. The other devours.",
		"For the first time in the dream, a voice cuts through the silence. Not the creature's voice. A human voice.",
		"'Can you hear me?' One of the travelers is speaking. And the others can hear them.",
		"In a dream. They can hear each other. In the same dream.",
	]
	b.post_battle_text = [
		"The Nightmare dissolves, screaming in frequencies that vibrate the bones. The dream tears apart.",
		"In the last moment before waking, the dancer appears one final time. Dimmer than before. Exhausted. It presses both hands against the fading dreamscape as if holding a door open.",
		"The shadow slams into the barrier from the other side. The dancer buckles but holds. Just long enough.",
	]
	b.next_battle_id = "S3_TownInvestigation"
	b.music_track = "res://assets/audio/music/boss/Impending Terror_FULL.wav"
	b.cutscene_track = "res://assets/audio/music/cutscene/#11.wav"
	return b
