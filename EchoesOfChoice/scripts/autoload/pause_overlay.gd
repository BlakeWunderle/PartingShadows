extends CanvasLayer

## Global pause menu overlay accessible from any gameplay scene via ESC.
## Shows Resume, Save, Quit to Title, and Quit Game options.
## Save opens a slot picker sub-menu.

const StoryDB := preload("res://scripts/data/story_db.gd")
const SettingsPanel := preload("res://scripts/ui/settings_panel.gd")
const ConfirmDialog := preload("res://scripts/ui/confirm_dialog.gd")

enum Mode { HIDDEN, MAIN_MENU, SAVE_SLOTS, SETTINGS }

var _mode: Mode = Mode.HIDDEN
var _panel: Control
var _main_vbox: VBoxContainer
var _save_vbox: VBoxContainer
var _settings_panel: SettingsPanel
var _resume_btn: Button
var _feedback_label: Label
var _confirm_dialog: ConfirmDialog
var _pending_save_slot: int = -1


func _ready() -> void:
	layer = 99  # Below SceneManager fader (100)
	process_mode = Node.PROCESS_MODE_ALWAYS
	_build_ui()
	_panel.visible = false


# =============================================================================
# UI construction
# =============================================================================

func _build_ui() -> void:
	_panel = Control.new()
	_panel.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(_panel)

	# Dark backdrop
	var bg := ColorRect.new()
	bg.color = Color(0.0, 0.0, 0.0, 0.6)
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	_panel.add_child(bg)

	# Center panel container
	var center := PanelContainer.new()
	center.set_anchors_preset(Control.PRESET_CENTER)
	center.offset_left = -200.0
	center.offset_top = -280.0
	center.offset_right = 200.0
	center.offset_bottom = 280.0
	_panel.add_child(center)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 20)
	margin.add_theme_constant_override("margin_top", 16)
	margin.add_theme_constant_override("margin_right", 20)
	margin.add_theme_constant_override("margin_bottom", 16)
	center.add_child(margin)

	var root_vbox := VBoxContainer.new()
	root_vbox.add_theme_constant_override("separation", 10)
	margin.add_child(root_vbox)

	# Title
	var title := Label.new()
	title.text = "PAUSED"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 26)
	title.add_theme_color_override("font_color", Color(0.9, 0.8, 0.5))
	root_vbox.add_child(title)

	var sep := HSeparator.new()
	root_vbox.add_child(sep)

	# Main menu buttons
	_main_vbox = VBoxContainer.new()
	_main_vbox.add_theme_constant_override("separation", 6)
	root_vbox.add_child(_main_vbox)

	_resume_btn = _make_button("Resume")
	_resume_btn.pressed.connect(_resume)
	_main_vbox.add_child(_resume_btn)

	var save_btn := _make_button("Save")
	save_btn.pressed.connect(_show_save_slots)
	_main_vbox.add_child(save_btn)

	var settings_btn := _make_button("Settings")
	settings_btn.pressed.connect(_show_settings)
	_main_vbox.add_child(settings_btn)

	var logs_btn := _make_button("Copy Logs")
	logs_btn.pressed.connect(_copy_logs)
	_main_vbox.add_child(logs_btn)

	var title_btn := _make_button("Quit to Title")
	title_btn.pressed.connect(_quit_to_title)
	_main_vbox.add_child(title_btn)

	var quit_btn := _make_button("Quit Game")
	quit_btn.pressed.connect(_quit_game)
	_main_vbox.add_child(quit_btn)

	# Feedback label for copy confirmation
	_feedback_label = Label.new()
	_feedback_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_feedback_label.add_theme_font_size_override("font_size", 16)
	_feedback_label.add_theme_color_override("font_color", Color(0.5, 1.0, 0.5))
	_feedback_label.visible = false
	root_vbox.add_child(_feedback_label)

	# Save slot sub-menu (hidden by default)
	_save_vbox = VBoxContainer.new()
	_save_vbox.add_theme_constant_override("separation", 6)
	_save_vbox.visible = false
	root_vbox.add_child(_save_vbox)

	# Settings panel (hidden by default)
	_settings_panel = SettingsPanel.new()
	_settings_panel.visible = false
	_settings_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_settings_panel.back_pressed.connect(_back_to_main)
	root_vbox.add_child(_settings_panel)

	# Confirm dialog (overlays entire screen)
	_confirm_dialog = ConfirmDialog.new()
	_panel.add_child(_confirm_dialog)


func _make_button(text: String) -> Button:
	var btn := Button.new()
	btn.text = text
	btn.custom_minimum_size = Vector2(280, 36)
	btn.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	btn.focus_mode = Control.FOCUS_ALL
	btn.add_theme_font_size_override("font_size", SettingsManager.font_size)
	return btn


# =============================================================================
# Input
# =============================================================================

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		match _mode:
			Mode.HIDDEN:
				_show_pause()
			Mode.MAIN_MENU:
				_resume()
			Mode.SAVE_SLOTS:
				_back_to_main()
			Mode.SETTINGS:
				_back_to_main()
		get_viewport().set_input_as_handled()


# =============================================================================
# Main menu actions
# =============================================================================

func _show_pause() -> void:
	# Only pause during gameplay
	if GameState.game_phase == GameState.GamePhase.TITLE:
		return
	if GameState.game_phase == GameState.GamePhase.ENDING:
		return
	if SceneManager.is_transitioning():
		return

	_mode = Mode.MAIN_MENU
	_panel.visible = true
	_main_vbox.visible = true
	_save_vbox.visible = false
	_settings_panel.visible = false
	get_tree().paused = true
	_resume_btn.grab_focus()


func _resume() -> void:
	_mode = Mode.HIDDEN
	_panel.visible = false
	get_tree().paused = false


func _quit_to_title() -> void:
	_confirm_dialog.confirmed.connect(_on_quit_to_title_confirmed, CONNECT_ONE_SHOT)
	_confirm_dialog.show_confirm("Return to title? Unsaved progress will be lost.")


func _on_quit_to_title_confirmed(accepted: bool) -> void:
	if not accepted:
		return
	_mode = Mode.HIDDEN
	_panel.visible = false
	get_tree().paused = false
	GameState.game_phase = GameState.GamePhase.TITLE
	SceneManager.change_scene("res://scenes/title/title.tscn")


func _copy_logs() -> void:
	var context: Array[String] = [
		"Phase: %s" % _phase_name(),
		"Battle: %s" % GameState.current_battle_id,
		"Party: %s" % _party_summary(),
	]
	GameLog.copy_to_clipboard(context)
	_feedback_label.text = "Copied to clipboard!"
	_feedback_label.visible = true
	await get_tree().create_timer(1.5).timeout
	if _mode != Mode.HIDDEN:
		_feedback_label.visible = false


func _quit_game() -> void:
	_confirm_dialog.confirmed.connect(_on_quit_game_confirmed, CONNECT_ONE_SHOT)
	_confirm_dialog.show_confirm("Are you sure you want to quit?")


func _on_quit_game_confirmed(accepted: bool) -> void:
	if not accepted:
		return
	get_tree().quit()


# =============================================================================
# Settings sub-menu
# =============================================================================

func _show_settings() -> void:
	_mode = Mode.SETTINGS
	_main_vbox.visible = false
	_settings_panel.visible = true


# =============================================================================
# Save slot sub-menu
# =============================================================================

func _show_save_slots() -> void:
	_mode = Mode.SAVE_SLOTS
	_main_vbox.visible = false

	# Clear old slot buttons
	for child: Node in _save_vbox.get_children():
		child.queue_free()

	# Build slot buttons with summaries
	for i: int in SaveManager.MAX_SAVE_SLOTS:
		var summary: Dictionary = SaveManager.get_save_summary(i)
		var label: String
		if summary.get("exists", false):
			var story_title: String = StoryDB.get_story(
				summary.get("story_id", "story_1")).get("title", "")
			label = "Slot %d: %s the %s - Lv %d (%s)" % [
				i + 1,
				summary.get("lead_name", "???"),
				summary.get("lead_class", "???"),
				summary.get("level", 1),
				story_title,
			]
		else:
			label = "Slot %d: Empty" % [i + 1]
		var btn := _make_button(label)
		var slot: int = i  # Capture for lambda
		btn.pressed.connect(_on_save_slot_selected.bind(slot))
		_save_vbox.add_child(btn)

		# Delete button for occupied slots
		if summary.get("exists", false):
			var del_btn := _make_button("  Delete Slot %d" % [i + 1])
			del_btn.add_theme_color_override("font_color", Color(0.8, 0.4, 0.4))
			del_btn.custom_minimum_size.y = 28
			del_btn.pressed.connect(_on_delete_slot_selected.bind(slot))
			_save_vbox.add_child(del_btn)

	# Back button
	var back_btn := _make_button("Back")
	back_btn.pressed.connect(_back_to_main)
	_save_vbox.add_child(back_btn)

	_save_vbox.visible = true

	# Focus first slot after frame so buttons are ready
	await get_tree().process_frame
	if _save_vbox.get_child_count() > 0:
		var first: Button = _save_vbox.get_child(0) as Button
		if first:
			first.grab_focus()


func _on_save_slot_selected(slot: int) -> void:
	if SaveManager.has_save(slot):
		_pending_save_slot = slot
		_confirm_dialog.confirmed.connect(_on_overwrite_confirmed, CONNECT_ONE_SHOT)
		_confirm_dialog.show_confirm("Overwrite this save?")
	else:
		_do_save(slot)


func _on_overwrite_confirmed(accepted: bool) -> void:
	if accepted and _pending_save_slot >= 0:
		_do_save(_pending_save_slot)
	_pending_save_slot = -1


func _do_save(slot: int) -> void:
	SaveManager.save_to_slot(slot)
	for i: int in _save_vbox.get_child_count():
		var btn: Button = _save_vbox.get_child(i) as Button
		if btn and i == slot:
			btn.text = "Slot %d: Saved!" % [slot + 1]
	await get_tree().create_timer(0.6).timeout
	if _mode == Mode.SAVE_SLOTS:
		_back_to_main()


func _on_delete_slot_selected(slot: int) -> void:
	_pending_save_slot = slot
	_confirm_dialog.confirmed.connect(_on_delete_confirmed, CONNECT_ONE_SHOT)
	_confirm_dialog.show_confirm("Delete this save? This cannot be undone.")


func _on_delete_confirmed(accepted: bool) -> void:
	if accepted and _pending_save_slot >= 0:
		SaveManager.delete_save(_pending_save_slot)
		_show_save_slots()  # Refresh the slot list
	_pending_save_slot = -1


func _back_to_main() -> void:
	_mode = Mode.MAIN_MENU
	_save_vbox.visible = false
	_settings_panel.visible = false
	_main_vbox.visible = true
	_resume_btn.grab_focus()


func _phase_name() -> String:
	match GameState.game_phase:
		GameState.GamePhase.TITLE: return "Title"
		GameState.GamePhase.PARTY_CREATION: return "Party Creation"
		GameState.GamePhase.NARRATIVE: return "Narrative"
		GameState.GamePhase.BATTLE: return "Battle"
		GameState.GamePhase.TOWN_STOP: return "Town Stop"
		GameState.GamePhase.ENDING: return "Ending"
		_: return "Unknown"


func _party_summary() -> String:
	if GameState.party.is_empty():
		return "(none)"
	var parts: Array[String] = []
	for fighter: RefCounted in GameState.party:
		parts.append("%s the %s (Lv%d)" % [
			fighter.character_name, fighter.character_type, fighter.level])
	return ", ".join(parts)
