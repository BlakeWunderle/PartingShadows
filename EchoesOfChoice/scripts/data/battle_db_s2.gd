class_name BattleDBS2

## Story 2 battle configurations: "Echoes in the Dark"

const BattleData := preload("res://scripts/data/battle_data.gd")
const EnemyDBS2 := preload("res://scripts/data/enemy_db_s2.gd")


static func create_battle(battle_id: String) -> BattleData:
	match battle_id:
		"S2_CaveAwakening": return s2_cave_awakening()
		"S2_DeepCavern": return s2_deep_cavern()
		"S2_CaveExit": return s2_cave_exit()
		_:
			push_error("Unknown Story 2 battle: %s" % battle_id)
			return s2_cave_awakening()


static func s2_cave_awakening() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S2_CaveAwakening"
	b.scene_image = "res://assets/art/battles/void_cavern.png"
	b.enemies = [
		EnemyDBS2.create_glow_worm("Luminara"),
		EnemyDBS2.create_glow_worm("Flicker"),
		EnemyDBS2.create_crystal_spider("Prism"),
	]
	b.pre_battle_text = [
		"The cave stretches ahead, lit only by veins of faintly glowing crystal running through the walls.",
		"The group moves cautiously. Every sound echoes strangely, as if the cave is listening.",
		"A wet, pulsing glow rounds a corner ahead. Two worm-like creatures, each longer than an arm, cling to the ceiling. Their bodies throb with bioluminescent light.",
		"Behind them, something clicks across the stone. A spider, but wrong. Its body is translucent crystal, refracting the worms' glow into sharp prismatic shards.",
		"They turn toward the party in unison, as if guided by a single mind.",
	]
	b.post_battle_text = [
		"The creatures dissolve into fading light and broken crystal. No blood. No bodies. Just... nothing.",
		"The air hums for a moment, then goes silent.",
		"Whatever these things were, they weren't natural. Nothing about this place is.",
		"The crystal veins in the walls pulse faintly, like a heartbeat.",
	]
	b.next_battle_id = "S2_DeepCavern"
	b.music_track = "res://assets/audio/music/battle/Unknown Creatures LOOP.wav"
	b.cutscene_track = "res://assets/audio/music/cutscene/#12 Cave Horn.wav"
	return b


static func s2_deep_cavern() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S2_DeepCavern"
	b.scene_image = "res://assets/art/battles/tunnels.png"
	b.enemies = [
		EnemyDBS2.create_shade_crawler("Umbral"),
		EnemyDBS2.create_shade_crawler("Murk"),
		EnemyDBS2.create_echo_wisp("Resonance"),
	]
	b.pre_battle_text = [
		"The tunnel narrows and the crystal light fades. Darkness presses in from all sides.",
		"Someone notices markings on the wall. Not natural formations. Symbols, scratched deep into the rock. None of them are recognizable.",
		"A sound rises from deeper in the cave. Not words. Not music. Something between the two, distorted and wrong.",
		"Shadows peel away from the walls and begin to move. Two formless shapes slither across the floor toward the party.",
		"Above them, a sphere of warped light hovers, the source of the sound. It pulses, and the shadows surge forward.",
	]
	b.post_battle_text = [
		"The shadows disperse like smoke and the floating sphere winks out with a sharp pop.",
		"In the silence that follows, something becomes clear. The symbols on the walls are everywhere. Floor, ceiling, every surface.",
		"One of the party traces a symbol and feels a jolt. Not pain. Recognition. Like a word on the tip of the tongue that won't come.",
		"The tunnel opens into a wider chamber. Ahead, a pale light that isn't crystal. Daylight.",
	]
	b.next_battle_id = "S2_CaveExit"
	b.music_track = "res://assets/audio/music/battle/Fantasy Tension - The Tomb of Mystery.ogg"
	b.cutscene_track = "res://assets/audio/music/cutscene/#15 Dark Strings Swell.wav"
	return b


static func s2_cave_exit() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "S2_CaveExit"
	b.scene_image = "res://assets/art/battles/void_cavern.png"
	b.enemies = [
		EnemyDBS2.create_cave_maw("The Threshold"),
		EnemyDBS2.create_vein_leech("Gnawer"),
		EnemyDBS2.create_stone_moth("Dustwing"),
	]
	b.pre_battle_text = [
		"The exit is close. A ragged circle of daylight glows at the end of the chamber.",
		"But between the party and the light, the cave itself moves.",
		"The stone floor splits open. Rows of crystalline teeth line the gap, grinding slowly. The cave has a mouth.",
		"A bloated leech clings to the wall beside it, pulsing with stolen light. Above, a grey moth the size of a shield hovers on stone-dust wings.",
		"The message is clear. This cave does not want them to leave.",
	]
	b.post_battle_text = [
		"The maw in the floor shudders and goes still. The teeth crack and crumble. The guardians shatter.",
		"The party stumbles toward the light and emerges into open air.",
		"Blinding sunlight. Wind. The smell of grass and earth.",
		"Behind them, the cave entrance is barely visible. A crack in a hillside, easy to miss. Easy to forget.",
		"No one remembers how they got here. No one knows where 'here' is.",
		"But they're alive. And they have names, skills, and each other. That will have to be enough for now.",
	]
	b.is_final_battle = true
	b.music_track = "res://assets/audio/music/battle/Fantasy Tension - Chamber of the Occult.ogg"
	b.cutscene_track = "res://assets/audio/music/cutscene/Sad Despair 02.wav"
	return b
