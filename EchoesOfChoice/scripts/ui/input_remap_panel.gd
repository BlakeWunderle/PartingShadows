class_name InputRemapPanel extends VBoxContainer

## Key binding remapping panel. Shows current keyboard bindings for each action
## and lets the player rebind by clicking a button and pressing a key.

signal back_pressed

var _buttons: Dictionary = {}  # action_name -> Button
var _listening_action: String = ""


func _ready() -> void:
	add_theme_constant_override("separation", 10)
	_build_ui()


func _build_ui() -> void:
	# Title
	var title := Label.new()
	title.text = "KEY BINDINGS"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 24)
	title.add_theme_color_override("font_color", Color(0.9, 0.8, 0.5))
	add_child(title)

	var sep := HSeparator.new()
	add_child(sep)

	# Scroll area for bindings
	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	scroll.custom_minimum_size = Vector2(0, 280)
	add_child(scroll)

	var bindings_vbox := VBoxContainer.new()
	bindings_vbox.add_theme_constant_override("separation", 6)
	bindings_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.add_child(bindings_vbox)

	# One row per action
	for action: String in InputConfig.ACTION_NAMES:
		var row := HBoxContainer.new()
		row.add_theme_constant_override("separation", 12)
		bindings_vbox.add_child(row)

		var label := Label.new()
		label.text = InputConfig.ACTION_DISPLAY_NAMES.get(action, action)
		label.custom_minimum_size = Vector2(140, 0)
		label.add_theme_font_size_override("font_size", SettingsManager.font_size)
		row.add_child(label)

		var btn := Button.new()
		btn.text = InputConfig.get_key_name(action)
		btn.custom_minimum_size = Vector2(160, 32)
		btn.add_theme_font_size_override("font_size", SettingsManager.font_size)
		var bound_action: String = action
		btn.pressed.connect(func() -> void: _start_listening(bound_action))
		row.add_child(btn)
		_buttons[action] = btn

	# Bottom buttons
	var btn_row := HBoxContainer.new()
	btn_row.add_theme_constant_override("separation", 12)
	btn_row.alignment = BoxContainer.ALIGNMENT_CENTER
	add_child(btn_row)

	var reset_btn := Button.new()
	reset_btn.text = "Reset Defaults"
	reset_btn.custom_minimum_size = Vector2(160, 36)
	reset_btn.add_theme_font_size_override("font_size", SettingsManager.font_size)
	reset_btn.pressed.connect(_on_reset)
	btn_row.add_child(reset_btn)

	var back_btn := Button.new()
	back_btn.text = "Back"
	back_btn.custom_minimum_size = Vector2(140, 36)
	back_btn.add_theme_font_size_override("font_size", SettingsManager.font_size)
	back_btn.pressed.connect(func() -> void: back_pressed.emit())
	btn_row.add_child(back_btn)


func _start_listening(action: String) -> void:
	_listening_action = action
	_buttons[action].text = "Press a key..."


func _unhandled_key_input(event: InputEvent) -> void:
	if _listening_action.is_empty():
		return
	if not event is InputEventKey:
		return
	if not event.pressed:
		return

	var key_event: InputEventKey = event as InputEventKey
	InputConfig.rebind_action(_listening_action, key_event.keycode)
	_buttons[_listening_action].text = InputConfig.get_key_name(_listening_action)
	_listening_action = ""
	get_viewport().set_input_as_handled()


func _on_reset() -> void:
	_listening_action = ""
	InputConfig.reset_bindings()
	_refresh_buttons()


func _refresh_buttons() -> void:
	for action: String in _buttons:
		_buttons[action].text = InputConfig.get_key_name(action)
