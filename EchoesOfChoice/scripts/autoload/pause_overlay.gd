extends CanvasLayer

## Global pause menu overlay accessible from any gameplay scene via ESC.
## Shows Resume, Save, Quit to Title, and Quit Game options.
## Save opens a slot picker sub-menu.

const StoryDB := preload("res://scripts/data/story_db.gd")
const SettingsPanel := preload("res://scripts/ui/settings_panel.gd")
const ConfirmDialog := preload("res://scripts/ui/confirm_dialog.gd")
const FighterPicker := preload("res://scripts/ui/fighter_picker.gd")
const CompendiumPanel := preload("res://scripts/ui/compendium_panel.gd")
const InputRemapPanel := preload("res://scripts/ui/input_remap_panel.gd")
const TipOverlay := preload("res://scripts/ui/tip_overlay.gd")

enum Mode { HIDDEN, MAIN_MENU, SAVE_SLOTS, SETTINGS, COMPENDIUM, KEY_BINDINGS, WAITING_MP, FIGHTER_PICK }

var _mode: Mode = Mode.HIDDEN
var _panel: Control
var _main_vbox: VBoxContainer
var _save_vbox: VBoxContainer
var _settings_panel: SettingsPanel
var _compendium_panel: CompendiumPanel
var _remap_panel: InputRemapPanel
var _resume_btn: Button
var _save_btn: Button
var _title_btn: Button
var _feedback_label: Label
var _confirm_dialog: ConfirmDialog
var _open_mp_btn: Button
var _fighter_picker: FighterPicker
var _tip_overlay: TipOverlay
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

	_save_btn = _make_button("Save")
	_save_btn.pressed.connect(_show_save_slots)
	_main_vbox.add_child(_save_btn)

	_open_mp_btn = _make_button("Open to Multiplayer")
	_open_mp_btn.pressed.connect(_open_to_multiplayer)
	_main_vbox.add_child(_open_mp_btn)

	var settings_btn := _make_button("Settings")
	settings_btn.pressed.connect(_show_settings)
	_main_vbox.add_child(settings_btn)

	var compendium_btn := _make_button("Compendium")
	compendium_btn.pressed.connect(_show_compendium)
	_main_vbox.add_child(compendium_btn)

	var logs_btn := _make_button("Copy Logs")
	logs_btn.pressed.connect(_copy_logs)
	_main_vbox.add_child(logs_btn)

	_title_btn = _make_button("Quit to Title")
	_title_btn.pressed.connect(_quit_to_title)
	_main_vbox.add_child(_title_btn)

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
	_settings_panel.key_bindings_pressed.connect(_show_key_bindings)
	root_vbox.add_child(_settings_panel)

	# Compendium panel (hidden by default)
	_compendium_panel = CompendiumPanel.new()
	_compendium_panel.visible = false
	_compendium_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_compendium_panel.back_pressed.connect(_back_to_main)
	root_vbox.add_child(_compendium_panel)

	# Key bindings panel (hidden by default)
	_remap_panel = InputRemapPanel.new()
	_remap_panel.visible = false
	_remap_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_remap_panel.back_pressed.connect(_back_to_main)
	root_vbox.add_child(_remap_panel)

	# Confirm dialog (overlays entire screen)
	_confirm_dialog = ConfirmDialog.new()
	_panel.add_child(_confirm_dialog)

	_tip_overlay = TipOverlay.new()
	_panel.add_child(_tip_overlay)


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
			Mode.COMPENDIUM:
				_back_to_main()
			Mode.KEY_BINDINGS:
				_back_to_main()
			Mode.WAITING_MP:
				_cancel_open_mp()
			Mode.FIGHTER_PICK:
				pass  # FighterPicker handles its own ESC
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

	# In multiplayer: don't pause the tree (breaks networking), hide save, relabel quit
	if NetManager.is_multiplayer_active:
		_save_btn.visible = false
		_open_mp_btn.visible = false
		_title_btn.text = "Leave Session"
	else:
		_save_btn.visible = true
		_title_btn.text = "Quit to Title"
		get_tree().paused = true
		# Show "Open to Multiplayer" only during narrative or town_stop with a party
		var can_open_mp: bool = GameState.game_phase in [
			GameState.GamePhase.NARRATIVE, GameState.GamePhase.TOWN_STOP] \
			and not GameState.party.is_empty()
		_open_mp_btn.visible = can_open_mp

	_resume_btn.grab_focus()


func _resume() -> void:
	_mode = Mode.HIDDEN
	_panel.visible = false
	if not NetManager.is_multiplayer_active:
		get_tree().paused = false


func _quit_to_title() -> void:
	_confirm_dialog.confirmed.connect(_on_quit_to_title_confirmed, CONNECT_ONE_SHOT)
	if NetManager.is_multiplayer_active:
		_confirm_dialog.show_confirm("Leave the multiplayer session?")
	else:
		_confirm_dialog.show_confirm("Return to title? Unsaved progress will be lost.")


func _on_quit_to_title_confirmed(accepted: bool) -> void:
	if not accepted:
		return
	_mode = Mode.HIDDEN
	_panel.visible = false
	if not NetManager.is_multiplayer_active:
		get_tree().paused = false
	else:
		NetManager.leave_session()
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
# Open to Multiplayer
# =============================================================================

func _open_to_multiplayer() -> void:
	get_tree().paused = false
	for fighter: RefCounted in GameState.party:
		fighter.owner_peer_id = 1
	NetManager.target_player_count = 2
	var err := NetManager.host_game()
	if err != OK:
		_feedback_label.text = "Failed to start server."
		_feedback_label.visible = true
		get_tree().paused = true
		return
	_mode = Mode.WAITING_MP
	_main_vbox.visible = false
	_feedback_label.text = "Waiting for a player to join..."
	_feedback_label.visible = true
	NetManager.player_joined.connect(_on_mp_player_joined)


func _on_mp_player_joined(_peer_id: int, _player_name: String) -> void:
	if NetManager.player_joined.is_connected(_on_mp_player_joined):
		NetManager.player_joined.disconnect(_on_mp_player_joined)
	NetManager.target_player_count = NetManager.get_connected_peer_count()
	_show_fighter_picker_mp()


func _show_fighter_picker_mp() -> void:
	_mode = Mode.FIGHTER_PICK
	_feedback_label.visible = false
	_fighter_picker = FighterPicker.new()
	_fighter_picker.local_only = true
	_panel.add_child(_fighter_picker)
	_fighter_picker.setup(GameState.party, NetManager.target_player_count)
	_fighter_picker.assignment_confirmed.connect(_on_mp_fighter_confirmed)
	_fighter_picker.assignment_cancelled.connect(_on_mp_fighter_cancelled)


func _on_mp_fighter_confirmed(_slot_owners: Dictionary) -> void:
	_fighter_picker.queue_free()
	_fighter_picker = null
	NetManager.broadcast_slot_assignments()
	NetManager.broadcast_game_state()
	_mode = Mode.HIDDEN
	_panel.visible = false
	NetManager.reload_current_scene_all_peers()


func _on_mp_fighter_cancelled() -> void:
	_fighter_picker.queue_free()
	_fighter_picker = null
	_cancel_open_mp()


func _cancel_open_mp() -> void:
	if NetManager.player_joined.is_connected(_on_mp_player_joined):
		NetManager.player_joined.disconnect(_on_mp_player_joined)
	NetManager.leave_session()
	_mode = Mode.MAIN_MENU
	_main_vbox.visible = true
	_feedback_label.visible = false
	get_tree().paused = true
	_resume_btn.grab_focus()


# =============================================================================
# Settings sub-menu
# =============================================================================

func _show_settings() -> void:
	_mode = Mode.SETTINGS
	_main_vbox.visible = false
	_settings_panel.visible = true


func _show_compendium() -> void:
	_mode = Mode.COMPENDIUM
	_main_vbox.visible = false
	_compendium_panel.visible = true
	_compendium_panel._refresh()
	_tip_overlay.show_tip_once("compendium",
		"The compendium tracks every enemy and class you have " +
		"encountered across all playthroughs.\n\n" +
		"Check enemy abilities here to plan your strategy!")


func _show_key_bindings() -> void:
	_mode = Mode.KEY_BINDINGS
	_main_vbox.visible = false
	_settings_panel.visible = false
	_remap_panel.visible = true


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
			var secs: float = summary.get("play_seconds", 0.0)
			var h: int = int(secs) / 3600
			var m: int = (int(secs) % 3600) / 60
			label = "Slot %d: %s the %s - Lv %d (%s) [%dh %dm]" % [
				i + 1,
				summary.get("lead_name", "???"),
				summary.get("lead_class", "???"),
				summary.get("level", 1),
				story_title,
				h, m,
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
	_compendium_panel.visible = false
	_remap_panel.visible = false
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
