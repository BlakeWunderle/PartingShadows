extends Control

## Controller assignment screen for local co-op.
## Players register their devices (keyboard or gamepad) before starting.
## Once all slots filled, shows New Story / Load Save / Back options.

const ChoiceMenu := preload("res://scripts/ui/choice_menu.gd")
const StoryDB := preload("res://scripts/data/story_db.gd")
const ConfirmDialog := preload("res://scripts/ui/confirm_dialog.gd")
const TitleScene := preload("res://scenes/title/title.gd")

enum Phase { ASSIGNING, MENU, LOAD_SLOTS, STORY_SELECT }

var _phase: Phase = Phase.ASSIGNING
var _slot_labels: Array[Label] = []
var _device_labels: Array[Label] = []
var _claimed_devices: Array[int] = []  # device_id per slot (-2 = unclaimed)
var _header_label: Label
var _hint_label: Label
var _menu: ChoiceMenu
var _menu_container: Control
var _confirm_dialog: ConfirmDialog
var _load_slot_actions: Array[Dictionary] = []
var _stories: Array[Dictionary] = []
var _pending_delete_slot: int = -1

const UNCLAIMED: int = -2


func _ready() -> void:
	MusicManager.play_music("res://assets/audio/music/menu/Land of Heroes Alt LOOP.wav")
	_build_ui()
	_reset_slots()


func _build_ui() -> void:
	# Background
	var bg := TextureRect.new()
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	bg.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	bg.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	bg.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	var bg_path: String = TitleScene._cached_bg
	if bg_path.is_empty():
		bg_path = "res://assets/art/ui/title_background.png"
	if ResourceLoader.exists(bg_path):
		bg.texture = load(bg_path)
	add_child(bg)

	# Center layout
	var center := CenterContainer.new()
	center.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(center)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 20)
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	center.add_child(vbox)

	# Header
	_header_label = Label.new()
	_header_label.text = "CONTROLLER ASSIGNMENT"
	_header_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_header_label.add_theme_font_size_override("font_size", 36)
	_header_label.add_theme_constant_override("outline_size", 2)
	_header_label.add_theme_color_override("font_outline_color", Color(0.0, 0.0, 0.0, 1.0))
	vbox.add_child(_header_label)

	var sep := HSeparator.new()
	vbox.add_child(sep)

	# Player slot cards
	var cards_hbox := HBoxContainer.new()
	cards_hbox.add_theme_constant_override("separation", 40)
	cards_hbox.alignment = BoxContainer.ALIGNMENT_CENTER
	vbox.add_child(cards_hbox)

	for i: int in LocalCoop.player_count:
		var card := PanelContainer.new()
		card.custom_minimum_size = Vector2(240, 140)
		cards_hbox.add_child(card)

		var margin := MarginContainer.new()
		margin.add_theme_constant_override("margin_left", 16)
		margin.add_theme_constant_override("margin_top", 12)
		margin.add_theme_constant_override("margin_right", 16)
		margin.add_theme_constant_override("margin_bottom", 12)
		card.add_child(margin)

		var card_vbox := VBoxContainer.new()
		card_vbox.add_theme_constant_override("separation", 10)
		card_vbox.alignment = BoxContainer.ALIGNMENT_CENTER
		margin.add_child(card_vbox)

		var slot_label := Label.new()
		slot_label.text = "Player %d" % (i + 1)
		slot_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		slot_label.add_theme_font_size_override("font_size", 24)
		slot_label.add_theme_color_override("font_color", Color(0.9, 0.85, 0.7))
		card_vbox.add_child(slot_label)
		_slot_labels.append(slot_label)

		var device_label := Label.new()
		device_label.text = "Press any button to join"
		device_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		device_label.add_theme_font_size_override("font_size", 16)
		device_label.add_theme_color_override("font_color", Color(0.6, 0.65, 0.7))
		card_vbox.add_child(device_label)
		_device_labels.append(device_label)

	# Hint
	_hint_label = Label.new()
	_hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_hint_label.add_theme_font_size_override("font_size", 16)
	_hint_label.add_theme_color_override("font_color", Color(0.5, 0.55, 0.6))
	_hint_label.text = "Press B / Escape to unclaim  |  Escape/B with nothing claimed to exit"
	vbox.add_child(_hint_label)

	# Menu (hidden until all slots claimed)
	_menu_container = Control.new()
	_menu_container.custom_minimum_size = Vector2(400, 0)
	_menu_container.visible = false
	vbox.add_child(_menu_container)

	_menu = ChoiceMenu.new()
	_menu.choice_selected.connect(_on_menu_choice)
	_menu_container.add_child(_menu)

	# Confirm dialog
	_confirm_dialog = ConfirmDialog.new()
	add_child(_confirm_dialog)


func _reset_slots() -> void:
	LocalCoop.clear_active_player()
	_claimed_devices.clear()
	for i: int in LocalCoop.player_count:
		_claimed_devices.append(UNCLAIMED)
	LocalCoop.player_devices.clear()
	_update_display()


func _update_display() -> void:
	for i: int in LocalCoop.player_count:
		if _claimed_devices[i] == UNCLAIMED:
			_device_labels[i].text = "Press any button to join"
			_device_labels[i].add_theme_color_override("font_color", Color(0.6, 0.65, 0.7))
		elif _claimed_devices[i] == -1:
			_device_labels[i].text = "Keyboard + Mouse"
			_device_labels[i].add_theme_color_override("font_color", Color(0.3, 0.9, 0.5))
		else:
			_device_labels[i].text = "Gamepad %d" % (_claimed_devices[i] + 1)
			_device_labels[i].add_theme_color_override("font_color", Color(0.3, 0.9, 0.5))


func _all_claimed() -> bool:
	for d: int in _claimed_devices:
		if d == UNCLAIMED:
			return false
	return true


func _is_device_taken(device_id: int) -> bool:
	return device_id in _claimed_devices


func _first_unclaimed_slot() -> int:
	for i: int in _claimed_devices.size():
		if _claimed_devices[i] == UNCLAIMED:
			return i
	return -1


# =============================================================================
# Input handling during assignment phase
# =============================================================================

func _input(event: InputEvent) -> void:
	# In MENU phase, Escape/B cancels back to ASSIGNING (re-pick devices)
	if _phase == Phase.MENU:
		if event is InputEventKey and event.pressed and not event.echo \
				and event.keycode == KEY_ESCAPE:
			_reset_slots()
			_phase = Phase.ASSIGNING
			_menu_container.visible = false
			get_viewport().set_input_as_handled()
		elif event is InputEventJoypadButton and event.pressed \
				and event.is_action("cancel"):
			_reset_slots()
			_phase = Phase.ASSIGNING
			_menu_container.visible = false
			get_viewport().set_input_as_handled()
		return

	if _phase != Phase.ASSIGNING:
		return

	# Keyboard claim: Enter/Space
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_ENTER or event.keycode == KEY_SPACE \
				or event.keycode == KEY_KP_ENTER:
			if not _is_device_taken(-1):
				_claim_device(-1)
				get_viewport().set_input_as_handled()
		elif event.keycode == KEY_ESCAPE:
			# If nothing claimed yet, exit co-op setup entirely
			if _claimed_devices.is_empty() or _claimed_devices[0] == UNCLAIMED:
				LocalCoop.stop()
				SceneManager.change_scene("res://scenes/title/title.tscn")
			else:
				_unclaim_device(-1)
			get_viewport().set_input_as_handled()

	# Gamepad claim: A button (joypad button 0)
	elif event is InputEventJoypadButton and event.pressed:
		if event.is_action("confirm"):
			if not _is_device_taken(event.device):
				_claim_device(event.device)
				get_viewport().set_input_as_handled()
		elif event.is_action("cancel"):
			# If nothing claimed yet, exit co-op setup entirely
			if _claimed_devices.is_empty() or _claimed_devices[0] == UNCLAIMED:
				LocalCoop.stop()
				SceneManager.change_scene("res://scenes/title/title.tscn")
			else:
				_unclaim_device(event.device)
			get_viewport().set_input_as_handled()


func _claim_device(device_id: int) -> void:
	var slot: int = _first_unclaimed_slot()
	if slot < 0:
		return
	_claimed_devices[slot] = device_id
	_update_display()
	GameLog.info("ControllerAssign: Player %d claimed device %d" % [slot + 1, device_id])
	if _all_claimed():
		_show_action_menu()


func _unclaim_device(device_id: int) -> void:
	# Find which slot has this device and unclaim it (also unclaim slots after it)
	var found: int = -1
	for i: int in _claimed_devices.size():
		if _claimed_devices[i] == device_id:
			found = i
			break
	if found < 0:
		# If no match and we're in assignment with all claimed, go back
		if _all_claimed():
			_phase = Phase.ASSIGNING
			_menu_container.visible = false
		return
	# Unclaim this slot and any after it (to keep assignment order)
	for i: int in range(found, _claimed_devices.size()):
		_claimed_devices[i] = UNCLAIMED
	_phase = Phase.ASSIGNING
	_menu_container.visible = false
	_update_display()


# =============================================================================
# Action menu (after all controllers assigned)
# =============================================================================

func _show_action_menu() -> void:
	_finalize_devices()
	LocalCoop.set_active_player(0)
	_phase = Phase.MENU
	_menu_container.visible = true
	var options: Array[Dictionary] = [
		{"label": "New Story"},
	]
	if SaveManager.has_any_save():
		options.append({"label": "Load Save"})
	options.append({"label": "Cancel"})
	_menu.show_choices(options)


func _on_menu_choice(index: int) -> void:
	match _phase:
		Phase.MENU:
			_handle_action_choice(index)
		Phase.LOAD_SLOTS:
			_handle_load_choice(index)
		Phase.STORY_SELECT:
			_handle_story_choice(index)


func _handle_action_choice(index: int) -> void:
	var labels: Array[String] = ["New Story"]
	if SaveManager.has_any_save():
		labels.append("Load Save")
	labels.append("Cancel")

	if index < 0 or index >= labels.size():
		return

	match labels[index]:
		"New Story":
			_finalize_devices()
			if UnlockManager.is_unlocked("story_1_complete"):
				_show_story_select()
			else:
				GameState.start_new_game("story_1")
				SceneManager.change_scene("res://scenes/party_creation/party_creation.tscn")
		"Load Save":
			_show_load_slots()
		"Cancel":
			_reset_slots()
			_phase = Phase.ASSIGNING
			_menu_container.visible = false


# =============================================================================
# Story select (inline, reuses menu)
# =============================================================================

func _show_story_select() -> void:
	_phase = Phase.STORY_SELECT
	_stories = StoryDB.get_all_stories()
	var options: Array[Dictionary] = []
	for story: Dictionary in _stories:
		var unlocked: bool = UnlockManager.is_unlocked(story.get("unlock_requirement", ""))
		if unlocked:
			options.append({"label": story.get("title", "Unknown")})
		else:
			options.append({
				"label": story.get("title", "Unknown") + " (Locked)",
				"disabled": true,
			})
	options.append({"label": "Back"})
	_menu.show_choices(options)


func _handle_story_choice(index: int) -> void:
	if index >= _stories.size():
		_show_action_menu()
		return
	var story: Dictionary = _stories[index]
	GameState.start_new_game(story.get("story_id", "story_1"))
	SceneManager.change_scene("res://scenes/party_creation/party_creation.tscn")


# =============================================================================
# Load save (inline, reuses menu)
# =============================================================================

func _show_load_slots() -> void:
	_phase = Phase.LOAD_SLOTS
	_load_slot_actions.clear()
	var options: Array[Dictionary] = []

	for i: int in SaveManager.MAX_SAVE_SLOTS:
		var summary: Dictionary = SaveManager.get_save_summary(i)
		if summary.get("exists", false):
			var story_title: String = StoryDB.get_story(
				summary.get("story_id", "story_1")).get("title", "")
			options.append({"label": "Slot %d: %s the %s - Lv %d (%s)" % [
				i + 1,
				summary.get("lead_name", "???"),
				summary.get("lead_class", "???"),
				summary.get("level", 1),
				story_title,
			]})
			_load_slot_actions.append({"action": "load", "slot": i})
			options.append({"label": "  Delete Slot %d" % [i + 1]})
			_load_slot_actions.append({"action": "delete", "slot": i})
		else:
			options.append({"label": "Slot %d: Empty" % [i + 1], "disabled": true})
			_load_slot_actions.append({"action": "load", "slot": i})

	# Autosave
	var auto_summary: Dictionary = SaveManager.get_save_summary(SaveManager.AUTOSAVE_SLOT)
	if auto_summary.get("exists", false):
		var auto_story: String = StoryDB.get_story(
			auto_summary.get("story_id", "story_1")).get("title", "")
		options.append({"label": "Autosave: %s the %s - Lv %d (%s)" % [
			auto_summary.get("lead_name", "???"),
			auto_summary.get("lead_class", "???"),
			auto_summary.get("level", 1),
			auto_story,
		]})
		_load_slot_actions.append({"action": "load", "slot": SaveManager.AUTOSAVE_SLOT})
		options.append({"label": "  Delete Autosave"})
		_load_slot_actions.append({"action": "delete", "slot": SaveManager.AUTOSAVE_SLOT})
	else:
		options.append({"label": "Autosave: Empty", "disabled": true})
		_load_slot_actions.append({"action": "load", "slot": SaveManager.AUTOSAVE_SLOT})

	options.append({"label": "Back"})
	_load_slot_actions.append({"action": "back", "slot": -1})
	_menu.show_choices(options)


func _handle_load_choice(index: int) -> void:
	if index < 0 or index >= _load_slot_actions.size():
		return
	var entry: Dictionary = _load_slot_actions[index]
	match entry["action"]:
		"back":
			_show_action_menu()
		"delete":
			_pending_delete_slot = int(entry["slot"])
			_confirm_dialog.confirmed.connect(_on_delete_confirmed, CONNECT_ONE_SHOT)
			_confirm_dialog.show_confirm("Delete this save? This cannot be undone.")
		"load":
			_finalize_devices()
			var slot: int = int(entry["slot"])
			if SaveManager.load_from_slot(slot):
				LocalCoop.assign_slots(GameState.party.size())
				var target: String = "res://scenes/town_stop/town_stop.tscn" \
					if GameState.game_phase == GameState.GamePhase.TOWN_STOP \
					else "res://scenes/narrative/narrative.tscn"
				SceneManager.change_scene(target)


func _on_delete_confirmed(accepted: bool) -> void:
	if accepted and _pending_delete_slot >= 0:
		SaveManager.delete_save(_pending_delete_slot)
		_show_load_slots()
	_pending_delete_slot = -1


# =============================================================================
# Finalize
# =============================================================================

func _finalize_devices() -> void:
	LocalCoop.player_devices.clear()
	for d: int in _claimed_devices:
		LocalCoop.player_devices.append(d)
	GameLog.info("ControllerAssign: Devices finalized: %s" % str(LocalCoop.player_devices))
