extends CanvasLayer

## Global pause menu overlay accessible from any gameplay scene via ESC.
## Shows Resume, Save, Quit to Title, and Quit Game options.
## Save opens a slot picker sub-menu.

const StoryDB := preload("res://scripts/data/story_db.gd")
const SettingsPanel := preload("res://scripts/ui/settings_panel.gd")
const ConfirmDialog := preload("res://scripts/ui/confirm_dialog.gd")
const FighterPicker := preload("res://scripts/ui/fighter_picker.gd")
const CompendiumPanelNew := preload("res://scripts/ui/compendium/compendium_panel.gd")
const InputRemapPanel := preload("res://scripts/ui/input_remap_panel.gd")
const TipOverlay := preload("res://scripts/ui/tip_overlay.gd")
const PauseSaveSlots_C := preload("res://scripts/autoload/pause_save_slots.gd")

enum Mode { HIDDEN, MAIN_MENU, SAVE_SLOTS, SETTINGS, COMPENDIUM, KEY_BINDINGS, WAITING_MP, FIGHTER_PICK }

var _mode: Mode = Mode.HIDDEN
var _panel: Control
var _main_vbox: VBoxContainer
var _save_vbox: VBoxContainer
var _settings_panel: SettingsPanel
var _compendium_panel: CompendiumPanelNew
var _remap_panel: InputRemapPanel
var _resume_btn: Button
var _save_btn: Button
var _title_btn: Button
var _feedback_label: Label
var _confirm_dialog: ConfirmDialog
var _open_mp_btn: Button
var _fighter_picker: FighterPicker
var _tip_overlay: TipOverlay
var _center_panel: PanelContainer
var _pause_title: Label
var _pause_sep: HSeparator
var _panel_expanded: bool = false
var _pending_save_slot: int = -1
var _save_slots: PauseSaveSlots_C
var _prev_focus: Control = null


func _ready() -> void:
	layer = 99  # Below SceneManager fader (100)
	process_mode = Node.PROCESS_MODE_ALWAYS
	_save_slots = PauseSaveSlots_C.new(self)
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
	_center_panel = PanelContainer.new()
	_center_panel.set_anchors_preset(Control.PRESET_CENTER)
	_center_panel.offset_left = -200.0
	_center_panel.offset_top = -280.0
	_center_panel.offset_right = 200.0
	_center_panel.offset_bottom = 280.0
	_panel.add_child(_center_panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 20)
	margin.add_theme_constant_override("margin_top", 16)
	margin.add_theme_constant_override("margin_right", 20)
	margin.add_theme_constant_override("margin_bottom", 16)
	_center_panel.add_child(margin)

	var root_vbox := VBoxContainer.new()
	root_vbox.add_theme_constant_override("separation", 10)
	margin.add_child(root_vbox)

	# Title
	_pause_title = Label.new()
	_pause_title.text = "PAUSED"
	_pause_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_pause_title.add_theme_font_size_override("font_size", 26)
	_pause_title.add_theme_color_override("font_color", Color.WHITE)
	_pause_title.add_theme_constant_override("outline_size", 2)
	_pause_title.add_theme_color_override("font_outline_color", Color.BLACK)
	root_vbox.add_child(_pause_title)

	_pause_sep = HSeparator.new()
	root_vbox.add_child(_pause_sep)

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

	# Compendium panel (hidden by default, global context like title screen)
	_compendium_panel = CompendiumPanelNew.new()
	_compendium_panel.visible = false
	_compendium_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_compendium_panel.grid_columns = 5
	_compendium_panel.items_per_page = 10
	_compendium_panel.set_context(CompendiumPanelNew.Context.GLOBAL)
	_compendium_panel.close_requested.connect(_back_to_main)
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
	_apply_focus_style(btn)
	return btn


static func _apply_focus_style(btn: Button) -> void:
	var focus_sb := StyleBoxFlat.new()
	focus_sb.bg_color = Color(0.2, 0.2, 0.3, 0.9)
	focus_sb.border_color = Color.WHITE
	focus_sb.set_border_width_all(3)
	focus_sb.set_corner_radius_all(4)
	focus_sb.set_content_margin_all(6)
	btn.add_theme_stylebox_override("focus", focus_sb)


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

	_prev_focus = get_viewport().gui_get_focus_owner()
	_mode = Mode.MAIN_MENU
	_panel.visible = true
	_main_vbox.visible = true
	_save_vbox.visible = false
	_settings_panel.visible = false

	# In multiplayer: don't pause the tree (breaks networking), relabel quit
	if NetManager.is_multiplayer_active:
		_save_btn.visible = NetManager.is_host
		_open_mp_btn.visible = false
		_title_btn.text = "Leave Session"
		# Notify other players to also show pause overlay
		var my_name: String = NetManager.peer_names.get(
			multiplayer.get_unique_id(), "Player")
		_rpc_pause_sync.rpc(my_name)
	else:
		_save_btn.visible = true
		_title_btn.text = "Quit to Title"
		get_tree().paused = true
		# Show "Open to Multiplayer" only during narrative or town_stop with a party
		var can_open_mp: bool = GameState.game_phase in [
			GameState.GamePhase.NARRATIVE, GameState.GamePhase.TOWN_STOP] \
			and not GameState.party.is_empty()
		_open_mp_btn.visible = can_open_mp

	_resume_btn.call_deferred("grab_focus")


func _resume() -> void:
	if NetManager.is_multiplayer_active:
		_rpc_resume_sync.rpc()
	_do_resume_local()


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
	_resume_btn.call_deferred("grab_focus")


# =============================================================================
# Settings sub-menu
# =============================================================================

func _show_settings() -> void:
	_mode = Mode.SETTINGS
	_main_vbox.visible = false
	_settings_panel.visible = true
	_settings_panel.focus_first()


func _show_compendium() -> void:
	_mode = Mode.COMPENDIUM
	_main_vbox.visible = false
	_pause_title.visible = false
	_pause_sep.visible = false
	# Use most of the screen for compendium (narrower for 5-col grid)
	_panel_expanded = true
	_center_panel.set_anchors_preset(Control.PRESET_FULL_RECT)
	_center_panel.offset_left = 180.0
	_center_panel.offset_top = 30.0
	_center_panel.offset_right = -180.0
	_center_panel.offset_bottom = -30.0
	_compendium_panel.visible = true
	_compendium_panel.refresh_data()
	_tip_overlay.show_tip_once("compendium",
		"The compendium tracks enemies, classes, and battles you've " +
		"encountered in this playthrough.\n\n" +
		"Click cards for detailed information and stats!")


func _show_key_bindings() -> void:
	_mode = Mode.KEY_BINDINGS
	_main_vbox.visible = false
	_settings_panel.visible = false
	_remap_panel.visible = true
	_remap_panel.focus_first()


# =============================================================================
# Save slot sub-menu
# =============================================================================

func _show_save_slots() -> void:
	_save_slots.show_save_slots()


func _on_save_slot_selected(slot: int) -> void:
	_save_slots.on_save_slot_selected(slot)


func _on_overwrite_confirmed(accepted: bool) -> void:
	_save_slots.on_overwrite_confirmed(accepted)


func _do_save(slot: int) -> void:
	_save_slots.do_save(slot)


func _on_delete_slot_selected(slot: int) -> void:
	_save_slots.on_delete_slot_selected(slot)


func _on_delete_confirmed(accepted: bool) -> void:
	_save_slots.on_delete_confirmed(accepted)


func _back_to_main() -> void:
	_mode = Mode.MAIN_MENU
	_save_vbox.visible = false
	_settings_panel.visible = false
	_compendium_panel.visible = false
	_remap_panel.visible = false
	_pause_title.visible = true
	_pause_sep.visible = true
	# Restore default center panel size only if it was expanded
	if _panel_expanded:
		_panel_expanded = false
		_center_panel.set_anchors_preset(Control.PRESET_CENTER)
		_center_panel.offset_left = -200.0
		_center_panel.offset_top = -280.0
		_center_panel.offset_right = 200.0
		_center_panel.offset_bottom = 280.0
	_main_vbox.visible = true
	_resume_btn.call_deferred("grab_focus")


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


# =============================================================================
# Multiplayer pause sync
# =============================================================================

func _do_resume_local() -> void:
	# Reset sub-panels if open
	if _mode in [Mode.SAVE_SLOTS, Mode.SETTINGS, Mode.COMPENDIUM, Mode.KEY_BINDINGS]:
		_back_to_main()
	_mode = Mode.HIDDEN
	_panel.visible = false
	_pause_title.text = "PAUSED"
	if not NetManager.is_multiplayer_active:
		get_tree().paused = false
	if is_instance_valid(_prev_focus):
		_prev_focus.grab_focus()
	_prev_focus = null


@rpc("any_peer", "call_remote", "reliable")
func _rpc_pause_sync(pauser_name: String) -> void:
	if _mode != Mode.HIDDEN:
		# Already paused — just update title to show who paused
		_pause_title.text = "PAUSED by %s" % pauser_name
		return
	_pause_title.text = "PAUSED by %s" % pauser_name
	_prev_focus = get_viewport().gui_get_focus_owner()
	_mode = Mode.MAIN_MENU
	_panel.visible = true
	_main_vbox.visible = true
	_save_vbox.visible = false
	_settings_panel.visible = false
	_save_btn.visible = false
	_open_mp_btn.visible = false
	_title_btn.text = "Leave Session"
	_resume_btn.call_deferred("grab_focus")


@rpc("any_peer", "call_remote", "reliable")
func _rpc_resume_sync() -> void:
	if _mode == Mode.HIDDEN:
		return
	_do_resume_local()
