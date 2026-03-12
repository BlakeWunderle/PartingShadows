class_name SettingsPanel extends VBoxContainer

## Reusable settings UI panel. Embed in title screen or pause overlay.
## All controls read from and write to SettingsManager.

signal back_pressed

var _music_slider: HSlider
var _music_label: Label
var _master_slider: HSlider
var _master_label: Label
var _text_speed_btn: OptionButton
var _battle_speed_btn: OptionButton
var _font_size_btn: OptionButton
var _fullscreen_btn: CheckButton
var _color_blind_btn: OptionButton
var _screen_reader_btn: CheckButton

const TEXT_SPEEDS: Array[float] = [0.04, 0.02, 0.01, 0.0]
const TEXT_SPEED_LABELS: Array[String] = ["Slow", "Normal", "Fast", "Instant"]
const BATTLE_SPEEDS: Array[float] = [1.8, 1.2, 0.6]
const BATTLE_SPEED_LABELS: Array[String] = ["Slow", "Normal", "Fast"]
const FONT_SIZES: Array[int] = [14, 18, 22, 26]
const FONT_SIZE_LABELS: Array[String] = ["Small", "Normal", "Large", "Extra Large"]
const COLOR_BLIND_MODES: Array[String] = ["normal", "deuteranopia", "protanopia", "tritanopia"]
const COLOR_BLIND_LABELS: Array[String] = ["Normal", "Deuteranopia", "Protanopia", "Tritanopia"]


func _ready() -> void:
	add_theme_constant_override("separation", 10)
	_build_ui()
	_sync_from_settings()


func _build_ui() -> void:
	# Title
	var title := Label.new()
	title.text = "SETTINGS"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 24)
	title.add_theme_color_override("font_color", Color(0.9, 0.8, 0.5))
	add_child(title)

	var sep := HSeparator.new()
	add_child(sep)

	# Scroll container so settings fit on smaller screens
	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	add_child(scroll)

	var inner := VBoxContainer.new()
	inner.add_theme_constant_override("separation", 8)
	inner.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.add_child(inner)

	# Music Volume
	_music_slider = HSlider.new()
	_music_label = Label.new()
	_add_slider_row(inner, "Music Volume", _music_slider, _music_label)
	_music_slider.value_changed.connect(_on_music_volume_changed)

	# Master Volume
	_master_slider = HSlider.new()
	_master_label = Label.new()
	_add_slider_row(inner, "Master Volume", _master_slider, _master_label)
	_master_slider.value_changed.connect(_on_master_volume_changed)

	# Text Speed
	_text_speed_btn = OptionButton.new()
	_add_dropdown_row(inner, "Text Speed", _text_speed_btn, TEXT_SPEED_LABELS)
	_text_speed_btn.item_selected.connect(_on_text_speed_selected)

	# Battle Speed
	_battle_speed_btn = OptionButton.new()
	_add_dropdown_row(inner, "Battle Speed", _battle_speed_btn, BATTLE_SPEED_LABELS)
	_battle_speed_btn.item_selected.connect(_on_battle_speed_selected)

	# Font Size
	_font_size_btn = OptionButton.new()
	_add_dropdown_row(inner, "Font Size", _font_size_btn, FONT_SIZE_LABELS)
	_font_size_btn.item_selected.connect(_on_font_size_selected)

	# Fullscreen
	_fullscreen_btn = CheckButton.new()
	_add_toggle_row(inner, "Fullscreen", _fullscreen_btn)
	_fullscreen_btn.toggled.connect(_on_fullscreen_toggled)

	# Color Blind Mode
	_color_blind_btn = OptionButton.new()
	_add_dropdown_row(inner, "Color Blind Mode", _color_blind_btn, COLOR_BLIND_LABELS)
	_color_blind_btn.item_selected.connect(_on_color_blind_selected)

	# Screen Reader Hints
	_screen_reader_btn = CheckButton.new()
	_add_toggle_row(inner, "Screen Reader Hints", _screen_reader_btn)
	_screen_reader_btn.toggled.connect(_on_screen_reader_toggled)

	# Bottom buttons
	var btn_row := HBoxContainer.new()
	btn_row.add_theme_constant_override("separation", 12)
	btn_row.alignment = BoxContainer.ALIGNMENT_CENTER
	add_child(btn_row)

	var defaults_btn := Button.new()
	defaults_btn.text = "Reset Defaults"
	defaults_btn.custom_minimum_size = Vector2(140, 36)
	defaults_btn.pressed.connect(_on_defaults_pressed)
	btn_row.add_child(defaults_btn)

	var back_btn := Button.new()
	back_btn.text = "Back"
	back_btn.custom_minimum_size = Vector2(140, 36)
	back_btn.pressed.connect(func() -> void: back_pressed.emit())
	btn_row.add_child(back_btn)


func _add_slider_row(parent: VBoxContainer, label_text: String, slider: HSlider, value_label: Label) -> void:
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 8)
	parent.add_child(row)

	var lbl := Label.new()
	lbl.text = label_text
	lbl.custom_minimum_size = Vector2(160, 0)
	lbl.add_theme_font_size_override("font_size", 16)
	row.add_child(lbl)

	slider.min_value = 0.0
	slider.max_value = 100.0
	slider.step = 1.0
	slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	slider.custom_minimum_size = Vector2(140, 0)
	row.add_child(slider)

	value_label.custom_minimum_size = Vector2(48, 0)
	value_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	value_label.add_theme_font_size_override("font_size", 16)
	row.add_child(value_label)


func _add_dropdown_row(parent: VBoxContainer, label_text: String, option_btn: OptionButton, items: Array) -> void:
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 8)
	parent.add_child(row)

	var lbl := Label.new()
	lbl.text = label_text
	lbl.custom_minimum_size = Vector2(160, 0)
	lbl.add_theme_font_size_override("font_size", 16)
	row.add_child(lbl)

	for item: String in items:
		option_btn.add_item(item)
	option_btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_child(option_btn)


func _add_toggle_row(parent: VBoxContainer, label_text: String, check_btn: CheckButton) -> void:
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 8)
	parent.add_child(row)

	var lbl := Label.new()
	lbl.text = label_text
	lbl.custom_minimum_size = Vector2(160, 0)
	lbl.add_theme_font_size_override("font_size", 16)
	row.add_child(lbl)

	check_btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_child(check_btn)


# =============================================================================
# Sync UI from SettingsManager state
# =============================================================================

func _sync_from_settings() -> void:
	_music_slider.set_value_no_signal(SettingsManager.music_volume * 100.0)
	_music_label.text = "%d%%" % int(SettingsManager.music_volume * 100.0)

	_master_slider.set_value_no_signal(SettingsManager.master_volume * 100.0)
	_master_label.text = "%d%%" % int(SettingsManager.master_volume * 100.0)

	_text_speed_btn.select(_find_index(TEXT_SPEEDS, SettingsManager.text_speed, 1))
	_battle_speed_btn.select(_find_index(BATTLE_SPEEDS, SettingsManager.combat_pause, 1))
	_font_size_btn.select(_find_index_int(FONT_SIZES, SettingsManager.font_size, 1))

	_fullscreen_btn.set_pressed_no_signal(SettingsManager.fullscreen)
	_color_blind_btn.select(_find_index_str(COLOR_BLIND_MODES, SettingsManager.color_blind_mode, 0))
	_screen_reader_btn.set_pressed_no_signal(SettingsManager.screen_reader)


func _find_index(arr: Array[float], val: float, fallback: int) -> int:
	for i: int in arr.size():
		if absf(arr[i] - val) < 0.001:
			return i
	return fallback


func _find_index_int(arr: Array[int], val: int, fallback: int) -> int:
	for i: int in arr.size():
		if arr[i] == val:
			return i
	return fallback


func _find_index_str(arr: Array[String], val: String, fallback: int) -> int:
	for i: int in arr.size():
		if arr[i] == val:
			return i
	return fallback


# =============================================================================
# Callbacks
# =============================================================================

func _on_music_volume_changed(value: float) -> void:
	SettingsManager.music_volume = value / 100.0
	_music_label.text = "%d%%" % int(value)


func _on_master_volume_changed(value: float) -> void:
	SettingsManager.master_volume = value / 100.0
	_master_label.text = "%d%%" % int(value)


func _on_text_speed_selected(index: int) -> void:
	SettingsManager.text_speed = TEXT_SPEEDS[index]


func _on_battle_speed_selected(index: int) -> void:
	SettingsManager.combat_pause = BATTLE_SPEEDS[index]


func _on_font_size_selected(index: int) -> void:
	SettingsManager.font_size = FONT_SIZES[index]


func _on_fullscreen_toggled(pressed: bool) -> void:
	SettingsManager.fullscreen = pressed


func _on_color_blind_selected(index: int) -> void:
	SettingsManager.color_blind_mode = COLOR_BLIND_MODES[index]


func _on_screen_reader_toggled(pressed: bool) -> void:
	SettingsManager.screen_reader = pressed


func _on_defaults_pressed() -> void:
	SettingsManager.reset_defaults()
	_sync_from_settings()
