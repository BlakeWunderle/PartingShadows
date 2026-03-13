extends Control

## Title screen with animated reveal and menu.
## Shows Continue and Load Game options when saves exist.

const ChoiceMenu := preload("res://scripts/ui/choice_menu.gd")
const StoryDB := preload("res://scripts/data/story_db.gd")
const SettingsPanel := preload("res://scripts/ui/settings_panel.gd")

enum Mode { MAIN_MENU, LOAD_SLOTS, SETTINGS }

var _title_label: Label
var _subtitle_label: Label
var _menu: ChoiceMenu
var _vbox: VBoxContainer
var _mode: Mode = Mode.MAIN_MENU
var _has_saves: bool = false
var _error_label: Label
var _settings_panel: SettingsPanel


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


func _pick_title_background() -> String:
	var s1 := "res://assets/art/ui/title_background.png"
	var s2 := "res://assets/art/ui/title_background_s2.png"
	var s3 := "res://assets/art/ui/title_background_s3.png"
	var options: Array[String] = [s1]
	if UnlockManager.is_unlocked("story_1_complete") and ResourceLoader.exists(s2):
		options.append(s2)
	if UnlockManager.is_unlocked("story_2_complete") and ResourceLoader.exists(s3):
		options.append(s3)
	return options[randi() % options.size()]


func _play_reveal() -> void:
	await get_tree().create_timer(0.3).timeout

	var t1 := create_tween()
	t1.tween_property(_title_label, "modulate:a", 1.0, 1.5)
	await t1.finished

	await get_tree().create_timer(0.3).timeout

	var t2 := create_tween()
	t2.tween_property(_subtitle_label, "modulate:a", 1.0, 1.0)
	await t2.finished

	await get_tree().create_timer(0.5).timeout
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
	_menu.visible = true

	var options: Array[Dictionary] = []
	if _has_saves:
		options.append({"label": "Continue"})
	options.append({"label": "New Game"})
	if _has_saves:
		options.append({"label": "Load Game"})
	options.append({"label": "Settings"})
	options.append({"label": "Quit"})

	_menu.show_choices(options)
	var t := create_tween()
	t.tween_property(_menu, "modulate:a", 1.0, 0.4)


func _on_menu_choice(index: int) -> void:
	match _mode:
		Mode.MAIN_MENU:
			_handle_main_choice(index)
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
			if UnlockManager.is_unlocked("story_1_complete"):
				SceneManager.change_scene("res://scenes/story_select/story_select.tscn")
			else:
				GameState.start_new_game("story_1")
				SceneManager.change_scene("res://scenes/party_creation/party_creation.tscn")
		"Load Game":
			_show_load_slots()
		"Settings":
			_show_settings()
		"Quit":
			get_tree().quit()


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
# Settings
# =============================================================================

func _show_settings() -> void:
	_mode = Mode.SETTINGS
	_menu.hide_menu()
	_settings_panel.visible = true


# =============================================================================
# Load slot picker
# =============================================================================

func _show_load_slots() -> void:
	_mode = Mode.LOAD_SLOTS

	var options: Array[Dictionary] = []

	# 3 manual slots
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
		else:
			options.append({"label": "Slot %d: Empty" % [i + 1], "disabled": true})

	# Autosave slot
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
	else:
		options.append({"label": "Autosave: Empty", "disabled": true})

	options.append({"label": "Back"})
	_menu.show_choices(options)


func _handle_load_choice(index: int) -> void:
	var total_slots: int = SaveManager.MAX_SAVE_SLOTS + 1  # 3 manual + 1 autosave
	if index >= total_slots:
		# Back
		_show_main_menu()
		return

	# Map index to slot (0-2 = manual, 3 = autosave)
	var slot: int = index
	if index == SaveManager.MAX_SAVE_SLOTS:
		slot = SaveManager.AUTOSAVE_SLOT

	if SaveManager.load_from_slot(slot):
		SceneManager.change_scene("res://scenes/narrative/narrative.tscn")
	else:
		_show_load_error()
