extends Control

## Party creation scene. Story-aware: tavern intro (S1), cave amnesia (S2),
## or inn arrival (S3). 3 character creation loops with story-specific narrative.

const DialoguePanel := preload("res://scripts/ui/dialogue_panel.gd")
const NameInput := preload("res://scripts/ui/name_input.gd")
const ChoiceMenu := preload("res://scripts/ui/choice_menu.gd")
const FighterData := preload("res://scripts/data/fighter_data.gd")
const FighterDB := preload("res://scripts/data/fighter_db.gd")

enum State {
	INTRO, NAME_1, CLASS_1, CONFIRM_1,
	BRIDGE_1, NAME_2, CLASS_2, CONFIRM_2,
	BRIDGE_2, NAME_3, CLASS_3, CONFIRM_3,
	OUTRO, DONE,
}

const BASE_CLASS_OPTIONS: Array[Dictionary] = [
	{"label": "Squire", "description": "A sturdy warrior who fights with steel and shield."},
	{"label": "Mage", "description": "A wielder of arcane forces and elemental magic."},
	{"label": "Entertainer", "description": "A charismatic performer who inspires allies."},
	{"label": "Tinker", "description": "A brilliant mind who turns knowledge into power."},
	{"label": "Wildling", "description": "A primal soul who communes with nature and beasts."},
]

const BASE_CLASS_IDS: Array[String] = ["Squire", "Mage", "Entertainer", "Tinker", "Wildling"]

var _state: State = State.INTRO
var _current_name: String = ""
var _party: Array[FighterData] = []
var _class_options: Array[Dictionary] = []
var _class_ids: Array[String] = []

var _dialogue: DialoguePanel
var _name_input: NameInput
var _choice_menu: ChoiceMenu
var _scene_image: TextureRect
var _vbox: VBoxContainer


func _is_s2() -> bool:
	return GameState.current_story_id == "story_2"


func _is_s3() -> bool:
	return GameState.current_story_id == "story_3"


func _ready() -> void:
	if _is_s2():
		MusicManager.play_music("res://assets/audio/music/cutscene/#12 Cave Horn.wav")
	else:
		MusicManager.play_music("res://assets/audio/music/town/Medieval Tavern 03.wav")
	_class_options = BASE_CLASS_OPTIONS.duplicate(true)
	_class_ids = BASE_CLASS_IDS.duplicate()
	if UnlockManager.is_unlocked("story_1_complete"):
		_class_options.append({"label": "Wanderer",
			"description": "A wilderness-raised fighter who learned to endure the land's magic."})
		_class_ids.append("Wanderer")
	if _is_s2():
		for i: int in range(_class_options.size()):
			_class_options[i]["label"] = "???"
	_build_ui()
	_set_state(State.INTRO)


func _build_ui() -> void:
	# Background image
	_scene_image = TextureRect.new()
	_scene_image.set_anchors_preset(Control.PRESET_FULL_RECT)
	_scene_image.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_scene_image.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	_scene_image.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	if _is_s3():
		_scene_image.texture = load("res://assets/art/battles/weary_traveler_inn.png")
	elif _is_s2():
		_scene_image.texture = load("res://assets/art/battles/cave_awakening.png")
	else:
		_scene_image.texture = load("res://assets/art/battles/copper_mug.png")
	add_child(_scene_image)

	# Dark overlay for text readability
	var overlay := ColorRect.new()
	overlay.set_anchors_preset(Control.PRESET_FULL_RECT)
	overlay.color = Color(0, 0, 0, 0.55)
	add_child(overlay)

	var margin := MarginContainer.new()
	margin.anchor_left = 0.0
	margin.anchor_top = 0.0
	margin.anchor_right = 1.0
	margin.anchor_bottom = 0.5
	margin.add_theme_constant_override("margin_left", 80)
	margin.add_theme_constant_override("margin_right", 80)
	margin.add_theme_constant_override("margin_top", 60)
	margin.add_theme_constant_override("margin_bottom", 20)
	add_child(margin)

	_vbox = VBoxContainer.new()
	_vbox.add_theme_constant_override("separation", 16)
	margin.add_child(_vbox)

	_dialogue = DialoguePanel.new()
	_dialogue.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_dialogue.all_text_finished.connect(_on_text_finished)
	_dialogue.visible = false
	_vbox.add_child(_dialogue)

	_name_input = NameInput.new()
	_name_input.name_entered.connect(_on_name_entered)
	_name_input.visible = false
	_vbox.add_child(_name_input)

	_choice_menu = ChoiceMenu.new()
	_choice_menu.choice_selected.connect(_on_class_selected)
	_choice_menu.visible = false
	_vbox.add_child(_choice_menu)


func _set_state(new_state: State) -> void:
	_state = new_state
	_dialogue.visible = false
	_name_input.visible = false
	_choice_menu.visible = false

	match _state:
		State.INTRO:
			_show_dialogue(_get_intro_text())
		State.NAME_1:
			if _is_s2():
				_name_input.show_prompt("A leather bracelet on this one's wrist. Letters are stamped into it...")
			elif _is_s3():
				_name_input.show_prompt("The traveler nearest the fire raises a cup. 'Long road? I'm...'")
			else:
				_name_input.show_prompt("'What is your name, young warrior?'")
		State.NAME_2:
			if _is_s2():
				_name_input.show_prompt("Scratched into the back of a belt buckle, barely legible...")
			elif _is_s3():
				_name_input.show_prompt("The second traveler leans forward. 'Name's...'")
			else:
				_name_input.show_prompt("'And what is your name?'")
		State.NAME_3:
			if _is_s2():
				_name_input.show_prompt("Stitched into the collar of a torn cloak...")
			elif _is_s3():
				_name_input.show_prompt("The third traveler nods a greeting. 'Call me...'")
			else:
				_name_input.show_prompt("'And you? What is your name?'")
		State.CLASS_1, State.CLASS_2, State.CLASS_3:
			if _is_s2():
				_show_dialogue(["Something stirs. A reflex. A memory buried in muscle and bone. What comes naturally?"])
			elif _is_s3():
				_show_dialogue(["'And what do you do for a living?' the innkeeper asks, refilling their cup."])
			else:
				_show_dialogue(["What is your calling?"])
		State.CONFIRM_1, State.CONFIRM_2, State.CONFIRM_3:
			var fighter: FighterData = _party.back()
			_show_dialogue(["%s the %s joins the party!" % [
				fighter.character_name, fighter.character_type]])
		State.BRIDGE_1:
			_show_dialogue(_get_bridge_1_text())
		State.BRIDGE_2:
			_show_dialogue(_get_bridge_2_text())
		State.OUTRO:
			_show_dialogue(_get_outro_text())
		State.DONE:
			_finish()


func _show_dialogue(lines: Array) -> void:
	_dialogue.show_text(lines)


func _on_text_finished() -> void:
	match _state:
		State.INTRO:
			_set_state(State.NAME_1)
		State.CLASS_1, State.CLASS_2, State.CLASS_3:
			_dialogue.visible = false
			_choice_menu.show_choices(_class_options)
		State.CONFIRM_1:
			_set_state(State.BRIDGE_1)
		State.CONFIRM_2:
			_set_state(State.BRIDGE_2)
		State.CONFIRM_3:
			_set_state(State.OUTRO)
		State.BRIDGE_1:
			_set_state(State.NAME_2)
		State.BRIDGE_2:
			_set_state(State.NAME_3)
		State.OUTRO:
			_set_state(State.DONE)


func _on_name_entered(player_name: String) -> void:
	_current_name = player_name
	_name_input.visible = false

	match _state:
		State.NAME_1:
			if _is_s2():
				_show_dialogue(["'%s.' The name feels right. But nothing else does." % player_name])
			elif _is_s3():
				_show_dialogue(["'%s.' A firm handshake. The firelight catches old scars on their knuckles." % player_name])
			else:
				_show_dialogue(["'Greetings, %s. You look like someone who can handle themselves.'" % player_name])
			_state = State.CLASS_1
		State.NAME_2:
			if _is_s2():
				_show_dialogue(["'%s.' Another name reclaimed from the dark." % player_name])
			elif _is_s3():
				_show_dialogue(["'%s.' They pull up a chair without being invited. Road dust on their boots." % player_name])
			else:
				_show_dialogue(["'Greetings, %s. Good, we'll need the help.'" % player_name])
			_state = State.CLASS_2
		State.NAME_3:
			if _is_s2():
				_show_dialogue(["'%s.' Three names. Three strangers. It's a start." % player_name])
			elif _is_s3():
				_show_dialogue(["'%s.' Three travelers at one table. The innkeeper smiles as if she expected it." % player_name])
			else:
				_show_dialogue(["'Greetings, %s. That makes three. That should be enough.'" % player_name])
			_state = State.CLASS_3


func _on_class_selected(index: int) -> void:
	_choice_menu.hide_menu()
	var class_id: String = _class_ids[index]
	var fighter: FighterData = FighterDB.create_player(class_id, _current_name)
	_party.append(fighter)

	match _state:
		State.CLASS_1: _set_state(State.CONFIRM_1)
		State.CLASS_2: _set_state(State.CONFIRM_2)
		State.CLASS_3: _set_state(State.CONFIRM_3)


func _finish() -> void:
	GameState.set_party(_party)
	for fighter: RefCounted in _party:
		GameLog.info("Party: %s the %s" % [fighter.character_name, fighter.character_type])
	GameState.advance_to_battle(GameState.get_first_battle_id())
	SceneManager.change_scene("res://scenes/narrative/narrative.tscn")


# --- Story 1: Tavern narrative ---

func _get_intro_text() -> Array[String]:
	if _is_s2():
		return _get_intro_text_s2()
	if _is_s3():
		return _get_intro_text_s3()
	return [
		"The Copper Mug. Your regular haunt. You know every crack in the floorboards, every stain on the bar.",
		"But tonight something is different. The fire burns low without anyone stoking it. The other regulars have gone quiet.",
		"A shrouded stranger sits in the corner booth, one that was empty just a moment ago.",
		"The air feels heavy. Wrong. Like the room itself is holding its breath.",
		"The stranger catches your eye and waves you over.",
	]


func _get_bridge_1_text() -> Array[String]:
	if _is_s2():
		return _get_bridge_1_text_s2()
	if _is_s3():
		return _get_bridge_1_text_s3()
	return [
		"Shortly after, another warrior overhears the conversation and slides into the booth.",
		"The stranger looks them over and asks the same question.",
	]


func _get_bridge_2_text() -> Array[String]:
	if _is_s2():
		return _get_bridge_2_text_s2()
	if _is_s3():
		return _get_bridge_2_text_s3()
	return [
		"One last warrior takes a seat at the now crowded table.",
		"The stranger doesn't even hesitate.",
	]


func _get_outro_text() -> Array[String]:
	if _is_s2():
		return _get_outro_text_s2()
	if _is_s3():
		return _get_outro_text_s3()
	return [
		"The stranger leans in close, voice barely above a whisper.",
		"'Something evil has taken root beyond the forest. The city needs heroes whether it knows it or not.'",
		"'Find the source. End it. I'll be watching, and I'll find you when the time is right.'",
		"The stranger raises a glass but doesn't drink. Just holds it, watching the liquid catch the firelight.",
		"Then they set it down, untouched, and disappear into the crowd. The coin left on the table is gold. Blank on one side.",
	]


# --- Story 2: Cave amnesia narrative ---

func _get_intro_text_s2() -> Array[String]:
	return [
		"Darkness. Complete, suffocating darkness.",
		"A sound. Dripping water. The echo of breathing that isn't yours.",
		"Your eyes adjust. Stone walls. A low ceiling. A cave.",
		"You don't know where you are. You don't know how you got here.",
		"You don't know who you are.",
		"But you're not alone. Two other figures stir in the darkness nearby.",
	]


func _get_bridge_1_text_s2() -> Array[String]:
	return [
		"A groan from deeper in the cave. Someone else is here.",
		"They stumble into the faint light, clutching their head. Same confusion. Same emptiness.",
	]


func _get_bridge_2_text_s2() -> Array[String]:
	return [
		"A third figure pulls themselves up from the stone floor, blinking against the dim glow.",
		"No recognition. No memory. Just another stranger in the dark.",
	]


func _get_outro_text_s2() -> Array[String]:
	return [
		"Three strangers. No memories. A cave that hums with a light that shouldn't exist.",
		"The crystal veins in the walls pulse faintly, pointing deeper into the dark.",
		"Whatever answers exist, they're not here. The only way out is forward.",
	]


# --- Story 3: Inn arrival narrative ---

func _get_intro_text_s3() -> Array[String]:
	return [
		"The road has been long and the light is fading. A town appears between the hills, smaller than expected, but the sign above the inn door glows warm in the dusk.",
		"'The Weary Traveler.' The name alone is enough.",
		"Inside, the common room is everything a tired body could want. A fire crackles in the hearth. The smell of roasted meat and fresh bread fills the air.",
		"The innkeeper, a thin woman with deep-set eyes, looks up from behind the bar. Her smile is practiced and perfect.",
		"'Welcome. You look like you could use a meal and a bed. Sit anywhere you like.'",
		"The long table near the fire has room. Other travelers are already eating.",
	]


func _get_bridge_1_text_s3() -> Array[String]:
	return [
		"Another traveler settles onto the bench across the table, setting down a heavy pack.",
		"'Mind if I sit? Everywhere else is taken.' It isn't, but the fire is warm and the company is welcome.",
	]


func _get_bridge_2_text_s3() -> Array[String]:
	return [
		"A third traveler appears at the end of the table, plate in hand, looking for a seat.",
		"'Room for one more?' They sit without waiting for an answer.",
	]


func _get_outro_text_s3() -> Array[String]:
	return [
		"Three strangers sharing a table, a meal, and stories of the road.",
		"The innkeeper refills their cups without being asked. 'Stay as long as you like,' she says. 'Most people do.'",
		"A young serving girl with auburn hair clears the plates. She pauses, watching the three of them for a moment longer than seems natural, then disappears into the kitchen.",
		"The fire burns low. The conversation fades. The beds upstairs are calling.",
		"Sleep comes fast. Faster than it should.",
	]
