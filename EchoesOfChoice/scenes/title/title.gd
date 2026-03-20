extends Control

## Title screen with animated reveal and menu.
## Shows Continue and Load Game options when saves exist.

const ChoiceMenu := preload("res://scripts/ui/choice_menu.gd")
const StoryDB := preload("res://scripts/data/story_db.gd")
const SettingsPanel := preload("res://scripts/ui/settings_panel.gd")
const ConfirmDialog := preload("res://scripts/ui/confirm_dialog.gd")
const CompendiumPanelNew := preload("res://scripts/ui/compendium/compendium_panel.gd")

enum Mode { MAIN_MENU, PLAY_MODE, LOAD_SLOTS, SETTINGS, COMPENDIUM }

var _title_label: Label
var _subtitle_label: Label
var _menu: ChoiceMenu
var _vbox: VBoxContainer
var _mode: Mode = Mode.MAIN_MENU
var _has_saves: bool = false
var _error_label: Label
var _settings_panel: SettingsPanel
var _compendium_panel: CompendiumPanelNew
var _confirm_dialog: ConfirmDialog
var _pending_delete_slot: int = -1


func _ready() -> void:
	MusicManager.play_music("res://assets/audio/music/menu/Land of Heroes Alt LOOP.wav")
	_build_ui()
	_play_reveal()


func _build_ui() -> void:
	# Background image
	var bg := TextureRect.new()
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	bg.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	bg.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	bg.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	var bg_path := _pick_title_background()
	if ResourceLoader.exists(bg_path):
		bg.texture = load(bg_path)
	add_child(bg)

	# Center container
	var center := CenterContainer.new()
	center.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(center)

	_vbox = VBoxContainer.new()
	_vbox.add_theme_constant_override("separation", 16)
	_vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	center.add_child(_vbox)

	# Title
	_title_label = Label.new()
	_title_label.text = "ECHOES OF CHOICE"
	_title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_title_label.add_theme_font_size_override("font_size", 56)
	_title_label.modulate.a = 0.0
	_vbox.add_child(_title_label)

	# Subtitle
	_subtitle_label = Label.new()
	_subtitle_label.text = "Some paths can't be retraced."
	_subtitle_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_subtitle_label.add_theme_font_size_override("font_size", 20)
	_subtitle_label.modulate.a = 0.0
	_vbox.add_child(_subtitle_label)

	# Spacer
	var spacer := Control.new()
	spacer.custom_minimum_size = Vector2(0, 24)
	_vbox.add_child(spacer)

	# Menu
	_menu = ChoiceMenu.new()
	_menu.modulate.a = 0.0
	_menu.visible = false
	_menu.choice_selected.connect(_on_menu_choice)
	_vbox.add_child(_menu)

	# Error label (hidden by default)
	_error_label = Label.new()
	_error_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_error_label.add_theme_font_size_override("font_size", 16)
	_error_label.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))
	_error_label.visible = false
	_vbox.add_child(_error_label)

	# Settings panel (hidden by default)
	_settings_panel = SettingsPanel.new()
	_settings_panel.visible = false
	_settings_panel.back_pressed.connect(_show_main_menu)
	_vbox.add_child(_settings_panel)

	# Compendium panel (hidden by default, global context)
	_compendium_panel = CompendiumPanelNew.new()
	_compendium_panel.visible = false
	_compendium_panel.set_context(CompendiumPanelNew.Context.GLOBAL, -1)
	_compendium_panel.close_requested.connect(_show_main_menu)
	_vbox.add_child(_compendium_panel)

	# Version label (bottom-right corner)
	var version_label := Label.new()
	var version_str: String = ProjectSettings.get_setting("application/config/version", "")
	if not version_str.is_empty():
		version_label.text = "v" + version_str
	version_label.add_theme_font_size_override("font_size", 13)
	version_label.add_theme_color_override("font_color", Color(0.5, 0.55, 0.6, 0.7))
	version_label.set_anchors_preset(Control.PRESET_BOTTOM_RIGHT)
	version_label.grow_horizontal = Control.GROW_DIRECTION_BEGIN
	version_label.grow_vertical = Control.GROW_DIRECTION_BEGIN
	version_label.offset_left = -80
	version_label.offset_top = -30
	add_child(version_label)

	# Confirm dialog (overlays entire screen)
	_confirm_dialog = ConfirmDialog.new()
	add_child(_confirm_dialog)


static var _cached_bg: String = ""

func _pick_title_background() -> String:
	if not _cached_bg.is_empty():
		return _cached_bg
	var options: Array[String] = ["res://assets/art/ui/title_background.png"]
	if UnlockManager.is_unlocked("story_1_complete"):
		options.append("res://assets/art/ui/title_background_s2.png")
	if UnlockManager.is_unlocked("story_2_complete"):
		options.append("res://assets/art/ui/title_background_s3.png")
	_cached_bg = options[randi() % options.size()]
	return _cached_bg


func _play_reveal() -> void:
	var tween := create_tween()
	tween.tween_interval(0.3)
	tween.tween_property(_title_label, "modulate:a", 1.0, 1.5)
	tween.tween_interval(0.3)
	tween.tween_property(_subtitle_label, "modulate:a", 1.0, 1.0)
	tween.tween_interval(0.5)
	await tween.finished
	_show_main_menu()


# =============================================================================
# Main menu
# =============================================================================

func _show_load_error() -> void:
	_error_label.text = "Save data could not be loaded."
	_error_label.visible = true
	await get_tree().create_timer(2.0).timeout
	_error_label.visible = false


func _show_main_menu() -> void:
	_mode = Mode.MAIN_MENU
	_has_saves = SaveManager.has_any_save()
	_settings_panel.visible = false
	_compendium_panel.visible = false
	_title_label.visible = true
	_subtitle_label.visible = true
	_menu.visible = true

	var options: Array[Dictionary] = []
	if _has_saves:
		options.append({"label": "Continue"})
	options.append({"label": "New Game"})
	if _has_saves:
		options.append({"label": "Load Game"})
	options.append({"label": "Settings"})
	options.append({"label": "Compendium"})
	options.append({"label": "Credits"})
	options.append({"label": "Quit"})

	_menu.show_choices(options)
	var t := create_tween()
	t.tween_property(_menu, "modulate:a", 1.0, 0.4)


func _on_menu_choice(index: int) -> void:
	match _mode:
		Mode.MAIN_MENU:
			_handle_main_choice(index)
		Mode.PLAY_MODE:
			_handle_play_mode_choice(index)
		Mode.LOAD_SLOTS:
			_handle_load_choice(index)


func _handle_main_choice(index: int) -> void:
	# Map index to label based on menu structure
	var labels: Array[String] = []
	if _has_saves:
		labels.append("Continue")
	labels.append("New Game")
	if _has_saves:
		labels.append("Load Game")
	labels.append("Settings")
	labels.append("Compendium")
	labels.append("Credits")
	labels.append("Quit")

	if index < 0 or index >= labels.size():
		return

	match labels[index]:
		"Continue":
			var slot: int = _find_best_continue_slot()
			if slot >= 0 and SaveManager.load_from_slot(slot):
				SceneManager.change_scene("res://scenes/narrative/narrative.tscn")
			else:
				_show_load_error()
		"New Game":
			_show_play_mode()
		"Load Game":
			_show_load_slots()
		"Settings":
			_show_settings()
		"Compendium":
			_show_compendium()
		"Credits":
			SceneManager.change_scene("res://scenes/credits/credits.tscn")
		"Quit":
			_confirm_dialog.confirmed.connect(_on_quit_confirmed, CONNECT_ONE_SHOT)
			_confirm_dialog.show_confirm("Are you sure you want to quit?")


func _find_best_continue_slot() -> int:
	var slot: int = SaveManager.get_last_used_slot()
	if slot >= 0:
		return slot
	if SaveManager.has_autosave():
		return SaveManager.AUTOSAVE_SLOT
	for i: int in SaveManager.MAX_SAVE_SLOTS:
		if SaveManager.has_save(i):
			return i
	return -1


# =============================================================================
# Play mode submenu (New Game -> Single / Co-op / Online)
# =============================================================================

func _show_play_mode() -> void:
	_mode = Mode.PLAY_MODE
	var options: Array[Dictionary] = [
		{"label": "Single Player"},
		{"label": "Local Co-op (2 Players)"},
		{"label": "Local Co-op (3 Players)"},
		{"label": "Online Multiplayer"},
		{"label": "Back"},
	]
	_menu.show_choices(options)


func _handle_play_mode_choice(index: int) -> void:
	match index:
		0:  # Single Player
			if UnlockManager.is_unlocked("story_1_complete"):
				SceneManager.change_scene("res://scenes/story_select/story_select.tscn")
			else:
				GameState.start_new_game("story_1")
				SceneManager.change_scene("res://scenes/party_creation/party_creation.tscn")
		1:  # Local Co-op (2 Players)
			LocalCoop.start(2)
			SceneManager.change_scene("res://scenes/controller_assign/controller_assign.tscn")
		2:  # Local Co-op (3 Players)
			LocalCoop.start(3)
			SceneManager.change_scene("res://scenes/controller_assign/controller_assign.tscn")
		3:  # Online Multiplayer
			SceneManager.change_scene("res://scenes/lobby/lobby.tscn")
		4:  # Back
			_show_main_menu()


# =============================================================================
# Settings
# =============================================================================

func _show_settings() -> void:
	_mode = Mode.SETTINGS
	_menu.hide_menu()
	_settings_panel.visible = true
	_settings_panel.grab_focus()


func _show_compendium() -> void:
	_mode = Mode.COMPENDIUM
	_menu.hide_menu()
	_title_label.visible = false
	_subtitle_label.visible = false
	_compendium_panel.visible = true
	_compendium_panel.refresh_data()


func _on_quit_confirmed(accepted: bool) -> void:
	if accepted:
		get_tree().quit()


# =============================================================================
# Load slot picker
# =============================================================================

var _load_slot_actions: Array[Dictionary] = []  # [{action: "load"/"delete"/"back", slot: int}]


func _show_load_slots() -> void:
	_mode = Mode.LOAD_SLOTS
	_load_slot_actions.clear()

	var options: Array[Dictionary] = []

	# 3 manual slots
	for i: int in SaveManager.MAX_SAVE_SLOTS:
		var summary: Dictionary = SaveManager.get_save_summary(i)
		if summary.get("exists", false):
			var story_title: String = StoryDB.get_story(
				summary.get("story_id", "story_1")).get("title", "")
			var mp_tag: String = ""
			if summary.get("is_local_coop", false):
				mp_tag = " [Co-op]"
			elif summary.get("is_multiplayer", false):
				mp_tag = " [Online]"
			var secs: float = summary.get("play_seconds", 0.0)
			var h: int = int(secs) / 3600
			var m: int = (int(secs) % 3600) / 60
			options.append({"label": "Slot %d: %s the %s - Lv %d (%s)%s [%dh %dm]" % [
				i + 1,
				summary.get("lead_name", "???"),
				summary.get("lead_class", "???"),
				summary.get("level", 1),
				story_title,
				mp_tag,
				h, m,
			]})
			_load_slot_actions.append({"action": "load", "slot": i})
			options.append({"label": "  Delete Slot %d" % [i + 1]})
			_load_slot_actions.append({"action": "delete", "slot": i})
		else:
			options.append({"label": "Slot %d: Empty" % [i + 1], "disabled": true})
			_load_slot_actions.append({"action": "load", "slot": i})

	# Autosave slot
	var auto_summary: Dictionary = SaveManager.get_save_summary(SaveManager.AUTOSAVE_SLOT)
	if auto_summary.get("exists", false):
		var auto_story: String = StoryDB.get_story(
			auto_summary.get("story_id", "story_1")).get("title", "")
		var auto_mp_tag: String = ""
		if auto_summary.get("is_local_coop", false):
			auto_mp_tag = " [Co-op]"
		elif auto_summary.get("is_multiplayer", false):
			auto_mp_tag = " [Online]"
		var auto_secs: float = auto_summary.get("play_seconds", 0.0)
		var auto_h: int = int(auto_secs) / 3600
		var auto_m: int = (int(auto_secs) % 3600) / 60
		options.append({"label": "Autosave: %s the %s - Lv %d (%s)%s [%dh %dm]" % [
			auto_summary.get("lead_name", "???"),
			auto_summary.get("lead_class", "???"),
			auto_summary.get("level", 1),
			auto_story,
			auto_mp_tag,
			auto_h, auto_m,
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
			_show_main_menu()
		"delete":
			_pending_delete_slot = int(entry["slot"])
			_confirm_dialog.confirmed.connect(_on_delete_save_confirmed, CONNECT_ONE_SHOT)
			_confirm_dialog.show_confirm("Delete this save? This cannot be undone.")
		"load":
			var slot: int = int(entry["slot"])
			if SaveManager.load_from_slot(slot):
				SceneManager.change_scene("res://scenes/narrative/narrative.tscn")
			else:
				_show_load_error()


func _on_delete_save_confirmed(accepted: bool) -> void:
	if accepted and _pending_delete_slot >= 0:
		SaveManager.delete_save(_pending_delete_slot)
		_show_load_slots()  # Refresh
	_pending_delete_slot = -1
