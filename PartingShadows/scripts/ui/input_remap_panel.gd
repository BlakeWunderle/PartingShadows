class_name InputRemapPanel extends VBoxContainer

## Key binding remapping panel. Shows current keyboard and controller bindings
## for each action. Keyboard bindings are remappable; controller bindings are
## fixed but displayed for reference.

signal back_pressed

var _kb_buttons: Dictionary = {}  # action_name -> Button (keyboard)
var _pad_buttons: Dictionary = {}  # action_name -> Button (gamepad)
var _listening_action: String = ""
var _listening_type: String = ""  # "keyboard" or "gamepad"

## Gamepad button display names
const _GAMEPAD_NAMES: Dictionary = {
	JOY_BUTTON_A: "A",
	JOY_BUTTON_B: "B",
	JOY_BUTTON_X: "X",
	JOY_BUTTON_Y: "Y",
	JOY_BUTTON_START: "Start",
	JOY_BUTTON_BACK: "Select",
	JOY_BUTTON_DPAD_UP: "D-Pad Up",
	JOY_BUTTON_DPAD_DOWN: "D-Pad Down",
	JOY_BUTTON_DPAD_LEFT: "D-Pad Left",
	JOY_BUTTON_DPAD_RIGHT: "D-Pad Right",
	JOY_BUTTON_LEFT_SHOULDER: "LB",
	JOY_BUTTON_RIGHT_SHOULDER: "RB",
}


func _ready() -> void:
	add_theme_constant_override("separation", 10)
	_build_ui()


func _build_ui() -> void:
	# Title
	var title := Label.new()
	title.text = "KEY BINDINGS"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 24)
	title.add_theme_color_override("font_color", Color.WHITE)
	title.add_theme_constant_override("outline_size", 2)
	title.add_theme_color_override("font_outline_color", Color.BLACK)
	add_child(title)

	var sep := HSeparator.new()
	add_child(sep)

	# Column headers
	var header := HBoxContainer.new()
	header.add_theme_constant_override("separation", 8)
	add_child(header)

	var action_header := Label.new()
	action_header.text = "Action"
	action_header.custom_minimum_size = Vector2(110, 0)
	action_header.add_theme_font_size_override("font_size", 14)
	action_header.add_theme_color_override("font_color", Color(0.7, 0.7, 0.7))
	header.add_child(action_header)

	var keyboard_header := Label.new()
	keyboard_header.text = "Keyboard"
	keyboard_header.custom_minimum_size = Vector2(120, 0)
	keyboard_header.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	keyboard_header.add_theme_font_size_override("font_size", 14)
	keyboard_header.add_theme_color_override("font_color", Color(0.7, 0.7, 0.7))
	header.add_child(keyboard_header)

	var gamepad_header := Label.new()
	gamepad_header.text = "Controller"
	gamepad_header.custom_minimum_size = Vector2(120, 0)
	gamepad_header.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	gamepad_header.add_theme_font_size_override("font_size", 14)
	gamepad_header.add_theme_color_override("font_color", Color(0.7, 0.7, 0.7))
	header.add_child(gamepad_header)

	# Scroll area for bindings
	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	scroll.follow_focus = true
	scroll.custom_minimum_size = Vector2(0, 260)
	add_child(scroll)

	var bindings_vbox := VBoxContainer.new()
	bindings_vbox.add_theme_constant_override("separation", 6)
	bindings_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.add_child(bindings_vbox)

	# One row per action
	for action: String in InputConfig.ACTION_NAMES:
		var row := HBoxContainer.new()
		row.add_theme_constant_override("separation", 8)
		bindings_vbox.add_child(row)

		var label := Label.new()
		label.text = InputConfig.ACTION_DISPLAY_NAMES.get(action, action)
		label.custom_minimum_size = Vector2(110, 0)
		label.add_theme_font_size_override("font_size", SettingsManager.font_size)
		row.add_child(label)

		# Keyboard binding button (remappable)
		var kb_btn := Button.new()
		kb_btn.text = InputConfig.get_key_name(action)
		kb_btn.custom_minimum_size = Vector2(120, 32)
		kb_btn.focus_mode = Control.FOCUS_ALL
		kb_btn.add_theme_font_size_override("font_size", SettingsManager.font_size)
		_apply_focus_style(kb_btn)
		var bound_action: String = action
		kb_btn.pressed.connect(func() -> void: _start_listening(bound_action, "keyboard"))
		row.add_child(kb_btn)
		_kb_buttons[action] = kb_btn

		# Controller binding button (remappable)
		var pad_btn := Button.new()
		pad_btn.text = _get_gamepad_display(action)
		pad_btn.custom_minimum_size = Vector2(120, 32)
		pad_btn.focus_mode = Control.FOCUS_ALL
		pad_btn.add_theme_font_size_override("font_size", SettingsManager.font_size)
		_apply_focus_style(pad_btn)
		pad_btn.pressed.connect(func() -> void: _start_listening(bound_action, "gamepad"))
		row.add_child(pad_btn)
		_pad_buttons[action] = pad_btn

	# Bottom buttons
	var btn_row := HBoxContainer.new()
	btn_row.add_theme_constant_override("separation", 12)
	btn_row.alignment = BoxContainer.ALIGNMENT_CENTER
	add_child(btn_row)

	var reset_btn := Button.new()
	reset_btn.text = "Reset Defaults"
	reset_btn.custom_minimum_size = Vector2(160, 36)
	reset_btn.focus_mode = Control.FOCUS_ALL
	reset_btn.add_theme_font_size_override("font_size", SettingsManager.font_size)
	_apply_focus_style(reset_btn)
	reset_btn.pressed.connect(_on_reset)
	btn_row.add_child(reset_btn)

	var back_btn := Button.new()
	back_btn.text = "Back"
	back_btn.custom_minimum_size = Vector2(140, 36)
	back_btn.focus_mode = Control.FOCUS_ALL
	back_btn.add_theme_font_size_override("font_size", SettingsManager.font_size)
	_apply_focus_style(back_btn)
	back_btn.pressed.connect(func() -> void: back_pressed.emit())
	btn_row.add_child(back_btn)


func _get_gamepad_display(action: String) -> String:
	var bindings: Array = InputConfig._GAMEPAD_BINDINGS.get(action, [])
	var parts: Array[String] = []
	for binding: Dictionary in bindings:
		if binding["type"] == "button":
			var idx: int = int(binding["index"])
			if InputConfig._nintendo_layout:
				if idx == JOY_BUTTON_A:
					idx = JOY_BUTTON_B
				elif idx == JOY_BUTTON_B:
					idx = JOY_BUTTON_A
			parts.append(_GAMEPAD_NAMES.get(idx, "Btn %d" % idx))
		elif binding["type"] == "axis":
			var axis_val: float = binding["value"]
			if int(binding["axis"]) == JOY_AXIS_LEFT_Y:
				parts.append("Stick " + ("Up" if axis_val < 0 else "Down"))
			elif int(binding["axis"]) == JOY_AXIS_LEFT_X:
				parts.append("Stick " + ("Left" if axis_val < 0 else "Right"))
	if parts.is_empty():
		return "-"
	return " / ".join(parts)


func focus_first() -> void:
	var first_action: String = InputConfig.ACTION_NAMES[0] if not InputConfig.ACTION_NAMES.is_empty() else ""
	if not first_action.is_empty() and _kb_buttons.has(first_action):
		_kb_buttons[first_action].grab_focus()


func _start_listening(action: String, type: String) -> void:
	_listening_action = action
	_listening_type = type
	if type == "keyboard":
		_kb_buttons[action].text = "Press key..."
	else:
		_pad_buttons[action].text = "Press btn..."


func _unhandled_key_input(event: InputEvent) -> void:
	if _listening_action.is_empty() or _listening_type != "keyboard":
		return
	if not event is InputEventKey:
		return
	if not event.pressed:
		return

	var key_event: InputEventKey = event as InputEventKey
	InputConfig.rebind_action(_listening_action, key_event.keycode)
	_kb_buttons[_listening_action].text = InputConfig.get_key_name(_listening_action)
	_listening_action = ""
	_listening_type = ""
	get_viewport().set_input_as_handled()


func _unhandled_input(event: InputEvent) -> void:
	if _listening_action.is_empty() or _listening_type != "gamepad":
		return
	if not event is InputEventJoypadButton:
		return
	if not event.pressed:
		return

	var btn_event: InputEventJoypadButton = event as InputEventJoypadButton
	InputConfig.rebind_gamepad_action(_listening_action, btn_event.button_index)
	_pad_buttons[_listening_action].text = _get_gamepad_display(_listening_action)
	_listening_action = ""
	_listening_type = ""
	get_viewport().set_input_as_handled()


func _input(event: InputEvent) -> void:
	if not visible:
		return
	if not _listening_action.is_empty():
		return
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		back_pressed.emit()


func _on_reset() -> void:
	_listening_action = ""
	_listening_type = ""
	InputConfig.reset_bindings()
	_refresh_buttons()


func _refresh_buttons() -> void:
	for action: String in _kb_buttons:
		_kb_buttons[action].text = InputConfig.get_key_name(action)
	for action: String in _pad_buttons:
		_pad_buttons[action].text = _get_gamepad_display(action)


static func _apply_focus_style(btn: Button) -> void:
	var focus_sb := StyleBoxFlat.new()
	focus_sb.bg_color = Color(0.2, 0.2, 0.3, 0.9)
	focus_sb.border_color = Color.WHITE
	focus_sb.set_border_width_all(3)
	focus_sb.set_corner_radius_all(4)
	focus_sb.set_content_margin_all(6)
	btn.add_theme_stylebox_override("focus", focus_sb)
