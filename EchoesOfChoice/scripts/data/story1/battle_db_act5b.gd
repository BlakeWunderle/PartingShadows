class_name BattleDBAct5B

## Story 1 Act V Path B battle configurations: Sever the Ritual.
## Flow: GateBattle → RitualAnchorBattle → SanctumCollapseBattle → StrangerUndoneBattle

const BattleData := preload("res://scripts/data/battle_data.gd")
const EnemyDB := preload("res://scripts/data/story1/enemy_db_act5b.gd")


static func create_battle(battle_id: String) -> BattleData:
	match battle_id:
		"RitualAnchorBattle": return ritual_anchor_battle()
		"SanctumCollapseBattle": return sanctum_collapse_battle()
		"StrangerUndoneBattle": return stranger_undone_battle()
		_:
			push_error("Unknown Story 1 Act V Path B battle: %s" % battle_id)
			return ritual_anchor_battle()


# =============================================================================
# Prog 12B: Ritual Anchor (destroy the sigil pillars)
# =============================================================================

static func ritual_anchor_battle() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "RitualAnchorBattle"
	b.scene_image = "res://assets/art/battles/void_cavern.png"
	b.enemies = [
		EnemyDB.create_sigil_colossus("Pillarguard"),
		EnemyDB.create_ritual_conduit("The Conduit"),
		EnemyDB.create_void_sentinel("Nullblade"),
	]
	b.pre_battle_text = [
		"The side passage narrows before opening into a chamber of blinding light. Three massive pillars of carved stone stand in a triangle, covered in the Stranger's sigils. They pulse in unison like a heartbeat.",
		"Energy flows upward through the ceiling, feeding something above. This is the Stranger's power source. The ritual that sustains him is anchored here.",
		"A colossus of living stone stands between the pillars, runes glowing across its body. A crystalline conduit floats between the anchors, mending cracks as fast as they form. A silent sentinel of void energy guards the perimeter.",
		"Destroying these pillars will sever the Stranger's connection to whatever dark power he has been channeling. Without them, he is just a man.",
	]
	b.post_battle_text = [
		"The colossus crumbles. The conduit shatters. The sentinel dissolves into nothing.",
		"The pillars crack, one by one, and the sigils on their surfaces die like embers drowning in rain. The energy flowing upward stutters, thins, and stops.",
		"Somewhere above, a sound like a man screaming through clenched teeth reverberates through the stone. The Stranger felt that.",
		"The chamber shakes. Dust falls from the ceiling. The pillars are breaking apart and the room is going with them.",
		"Deeper in, a passage continues downward. The air coming from it is thin and cold, stripped of the dark power that saturated everything above.",
	]
	b.next_battle_id = "SanctumCollapseBattle"
	b.music_track = "res://assets/audio/music/boss/Awakening of the Juggernaut_FULL.wav"
	b.cutscene_track = "res://assets/audio/music/cutscene/#15 Dark Strings Swell.wav"
	return b


# =============================================================================
# Prog 13B: Sanctum Collapse (desperate reserves, sanctum crumbling)
# =============================================================================

static func sanctum_collapse_battle() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "SanctumCollapseBattle"
	b.scene_image = "res://assets/art/battles/tunnels.png"
	b.enemies = [
		EnemyDB.create_void_horror("The Hollow"),
		EnemyDB.create_fractured_shadow("Splinter"),
		EnemyDB.create_shadow_remnant("Fadelight"),
	]
	b.pre_battle_text = [
		"The passage shakes violently. Stones fall from the ceiling and cracks race along the walls. The ritual's collapse is tearing the sanctum apart.",
		"The Stranger's voice echoes through the stone, raw and furious. 'What have you done? Do you know what you've destroyed? Years. Decades of work. All of it.'",
		"Shapes coalesce from the darkness ahead. Not constructs this time. Fragments of the Stranger himself, split off in desperation. A howling mass of void energy. A flickering shadow that moves too fast to follow. A fading remnant that drains the light from the air.",
		"His last reserves, thrown at the party with no strategy and no restraint. Just rage.",
	]
	b.post_battle_text = [
		"The fragments dissolve. The shaking intensifies.",
		"The party runs. Stone collapses behind them, sealing the passage they came through. Ahead, a final chamber opens up, smaller than the rest, barely lit.",
		"A figure stands at the center. Smaller than before. No longer wreathed in shadow, no longer blurring at the edges. Just a person in a dark cloak, breathing hard, hands shaking.",
		"The Stranger. Without his ritual. Without his power. Just himself.",
	]
	b.next_battle_id = "StrangerUndoneBattle"
	b.music_track = "res://assets/audio/music/battle_dark/MUSC_Black_Moon_52BPM_Eminor_1644_Full_Loop.wav"
	b.cutscene_track = "res://assets/audio/music/cutscene/#12 Cave Horn.wav"
	return b


# =============================================================================
# Prog 13B: Stranger Undone (final boss -- diminished but desperate)
# =============================================================================

static func stranger_undone_battle() -> BattleData:
	var b := BattleData.new()
	b.battle_id = "StrangerUndoneBattle"
	b.scene_image = "res://assets/art/battles/void_cavern.png"
	b.is_final_battle = true
	b.enemies = [
		EnemyDB.create_stranger_undone("The Stranger"),
	]
	b.pre_battle_text = [
		"The Stranger stands in the center of a dying chamber. The sigils on the walls are dark. The air is still.",
		"He looks smaller. The shadow that clung to him like a second skin is gone, peeled away with the ritual. His eyes are human again, wide and furious and afraid.",
		"'You think this changes anything?' His voice cracks. No echo. No resonance. Just a man's voice in a collapsing room.",
		"'I was trying to save this world. Everything I did, every sigil, every shadow. It was all to hold back something worse.'",
		"He draws a blade. Real steel, not conjured darkness. His hands are shaking but his grip is sure.",
		"'If you want to be the heroes, then earn it.'",
	]
	b.post_battle_text = [
		"The Stranger falls. Not like glass shattering. Not like darkness fracturing. He just collapses, quietly, the blade clattering from his hand onto the stone.",
		"The chamber is silent except for dripping water and settling dust.",
		"A leather journal lies on the ground beside him, fallen from his cloak. The pages are full of cramped handwriting. Diagrams. Formulas. Notes in the margins, increasingly frantic.",
		"The first page reads: 'I believe I have found a way to seal the rift. If the sigils hold, the shadow will be contained. No one else has to die.'",
		"The last page reads: 'They will not understand. They never understand. I will do what must be done, whether they thank me for it or not.'",
		"The party climbs out of the collapsing tunnels in silence. They emerge into grey daylight.",
		"The sky is clearing, slowly. Not the dramatic burst of sunlight that follows a villain's defeat. A gradual thinning, like fog burning off. The world will heal. It will take time.",
		"People emerge from hiding. A child asks what happened. No one has a simple answer.",
		"The barkeep at The Copper Mug pours cups without being asked. He looks at the party and sees something in their faces that he doesn't ask about.",
		"The Stranger is gone. The shadow is fading. But the journal sits heavy in a pocket, full of questions that will never be answered.",
	]
	b.post_scene_image = "res://assets/art/battles/city_streets.png"
	b.music_track = "res://assets/audio/music/boss/The Battle of Ages_FULL.wav"
	b.cutscene_track = "res://assets/audio/music/cutscene/Sad Despair 10.wav"
	return b
