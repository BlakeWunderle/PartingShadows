class_name VirtualKeyboard extends PanelContainer

## On-screen keyboard for controller-based text entry.
## QWERTY layout with centered, staggered rows like a real keyboard.
## L3 (left stick click) toggles caps lock.

signal character_entered(ch: String)
signal backspace_pressed
signal confirmed

const ROWS: Array[String] = ["QWERTYUIOP", "ASDFGHJKL-", "ZXCVBNM'"]
const _BODY_FONT: FontFile = preload("res://assets/fonts/CormorantGaramond-SemiBold.ttf")
## Characters that are not affected by caps lock
const _NON_ALPHA: Array[String] = ["-", "'"]

var _char_buttons: Array[Button] = []
var _char_values: Array[String] = []  # base (uppercase) character per button
var _space_btn: Button
var _backspace_btn: Button
var _done_btn: Button
var _caps_btn: Button
var _caps_lock: bool = false


func _ready() -> void:
	_build_ui()
	_update_caps_display()


func _build_ui() -> void:
	custom_minimum_size = Vector2(420, 0)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 8)
	margin.add_theme_constant_override("margin_right", 8)
	margin.add_theme_constant_override("margin_top", 6)
	margin.add_theme_constant_override("margin_bottom", 6)
	add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 3)
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	margin.add_child(vbox)

	# All rows centered
	for row_str: String in ROWS:
		var row_hbox := HBoxContainer.new()
		row_hbox.add_theme_constant_override("separation", 3)
		row_hbox.alignment = BoxContainer.ALIGNMENT_CENTER
		vbox.add_child(row_hbox)
		for ch: String in row_str:
			var btn := _create_key_button(ch)
			row_hbox.add_child(btn)
			_char_buttons.append(btn)
			_char_values.append(ch)

	# Bottom row: Caps + Space + Backspace + Done
	var bottom := HBoxContainer.new()
	bottom.add_theme_constant_override("separation", 6)
	bottom.alignment = BoxContainer.ALIGNMENT_CENTER
	vbox.add_child(bottom)

	_caps_btn = Button.new()
	_caps_btn.text = "\u25b3"  # △ hollow up arrow (caps off)
	_caps_btn.custom_minimum_size = Vector2(42, 34)
	_caps_btn.focus_mode = Control.FOCUS_ALL
	_caps_btn.add_theme_font_override("font", _BODY_FONT)
	_caps_btn.add_theme_font_size_override("font_size", 18)
	_apply_key_style(_caps_btn)
	_apply_focus_style(_caps_btn)
	_caps_btn.pressed.connect(_toggle_caps)
	bottom.add_child(_caps_btn)

	_space_btn = Button.new()
	_space_btn.text = "Space"
	_space_btn.custom_minimum_size = Vector2(100, 34)
	_space_btn.focus_mode = Control.FOCUS_ALL
	_space_btn.add_theme_font_override("font", _BODY_FONT)
	_space_btn.add_theme_font_size_override("font_size", 18)
	_apply_key_style(_space_btn)
	_apply_focus_style(_space_btn)
	_space_btn.pressed.connect(func() -> void: character_entered.emit(" "))
	bottom.add_child(_space_btn)

	_backspace_btn = Button.new()
	_backspace_btn.text = "Backspace"
	_backspace_btn.custom_minimum_size = Vector2(100, 34)
	_backspace_btn.focus_mode = Control.FOCUS_ALL
	_backspace_btn.add_theme_font_override("font", _BODY_FONT)
	_backspace_btn.add_theme_font_size_override("font_size", 18)
	_apply_key_style(_backspace_btn)
	_apply_focus_style(_backspace_btn)
	_backspace_btn.pressed.connect(func() -> void: backspace_pressed.emit())
	bottom.add_child(_backspace_btn)

	_done_btn = Button.new()
	_done_btn.text = "Done"
	_done_btn.custom_minimum_size = Vector2(100, 34)
	_done_btn.focus_mode = Control.FOCUS_ALL
	_done_btn.add_theme_font_override("font", _BODY_FONT)
	_done_btn.add_theme_font_size_override("font_size", 18)
	_apply_key_style(_done_btn)
	_apply_focus_style(_done_btn)
	_done_btn.pressed.connect(func() -> void: confirmed.emit())
	bottom.add_child(_done_btn)

	_wire_focus()


func _create_key_button(ch: String) -> Button:
	var btn := Button.new()
	btn.text = ch.to_lower()
	btn.custom_minimum_size = Vector2(36, 34)
	btn.focus_mode = Control.FOCUS_ALL
	btn.add_theme_font_override("font", _BODY_FONT)
	btn.add_theme_font_size_override("font_size", 18)
	_apply_key_style(btn)
	_apply_focus_style(btn)
	btn.pressed.connect(func() -> void: _emit_char(ch))
	return btn


func _emit_char(base_ch: String) -> void:
	if base_ch in _NON_ALPHA:
		character_entered.emit(base_ch)
	elif _caps_lock:
		character_entered.emit(base_ch.to_upper())
	else:
		character_entered.emit(base_ch.to_lower())


func _toggle_caps() -> void:
	_caps_lock = not _caps_lock
	_update_caps_display()


func _update_caps_display() -> void:
	# Update caps button indicator
	if _caps_lock:
		_caps_btn.text = "\u25b2"  # ▲ filled up arrow (caps on)
	else:
		_caps_btn.text = "\u25b3"  # △ hollow up arrow (caps off)
	# Update character button labels
	for i: int in _char_buttons.size():
		var ch: String = _char_values[i]
		if ch in _NON_ALPHA:
			continue
		_char_buttons[i].text = ch.to_upper() if _caps_lock else ch.to_lower()


func _wire_focus() -> void:
	# Row boundaries: row1=0..9, row2=10..19, row3=20..27
	var row1_start: int = 0
	var row1_end: int = 9
	var row2_start: int = 10
	var row2_end: int = 19
	var row3_start: int = 20
	var row3_end: int = _char_buttons.size() - 1

	_wire_row(row1_start, row1_end)
	_wire_row(row2_start, row2_end)
	_wire_row(row3_start, row3_end)

	# Up/down between rows
	for i: int in range(row1_start, row1_end + 1):
		var col: int = i - row1_start
		var r2_idx: int = row2_start + mini(col, row2_end - row2_start)
		_char_buttons[i].focus_neighbor_bottom = _char_buttons[r2_idx].get_path()
		# Top row up wraps to bottom buttons
		if col < 3:
			_char_buttons[i].focus_neighbor_top = _caps_btn.get_path()
		elif col < 5:
			_char_buttons[i].focus_neighbor_top = _space_btn.get_path()
		elif col < 7:
			_char_buttons[i].focus_neighbor_top = _backspace_btn.get_path()
		else:
			_char_buttons[i].focus_neighbor_top = _done_btn.get_path()

	# Row 3 is 2 keys shorter and centered, so it sits 1 key-slot to the right of row 2.
	# Offset by 1 so up/down navigation tracks the visual position rather than the array index.
	for i: int in range(row2_start, row2_end + 1):
		var col: int = i - row2_start
		var r1_idx: int = row1_start + mini(col, row1_end - row1_start)
		_char_buttons[i].focus_neighbor_top = _char_buttons[r1_idx].get_path()
		var r3_col: int = clampi(col - 1, 0, row3_end - row3_start)
		_char_buttons[i].focus_neighbor_bottom = _char_buttons[row3_start + r3_col].get_path()

	for i: int in range(row3_start, row3_end + 1):
		var col: int = i - row3_start
		var r2_col: int = mini(col + 1, row2_end - row2_start)
		_char_buttons[i].focus_neighbor_top = _char_buttons[row2_start + r2_col].get_path()
		# Row 3 down → bottom buttons
		if col < 2:
			_char_buttons[i].focus_neighbor_bottom = _caps_btn.get_path()
		elif col < 4:
			_char_buttons[i].focus_neighbor_bottom = _space_btn.get_path()
		elif col < 6:
			_char_buttons[i].focus_neighbor_bottom = _backspace_btn.get_path()
		else:
			_char_buttons[i].focus_neighbor_bottom = _done_btn.get_path()

	# Bottom buttons left/right (Caps ↔ Space ↔ Backspace ↔ Done, wrapping)
	_caps_btn.focus_neighbor_right = _space_btn.get_path()
	_caps_btn.focus_neighbor_left = _done_btn.get_path()
	_space_btn.focus_neighbor_left = _caps_btn.get_path()
	_space_btn.focus_neighbor_right = _backspace_btn.get_path()
	_backspace_btn.focus_neighbor_left = _space_btn.get_path()
	_backspace_btn.focus_neighbor_right = _done_btn.get_path()
	_done_btn.focus_neighbor_left = _backspace_btn.get_path()
	_done_btn.focus_neighbor_right = _caps_btn.get_path()

	# Bottom buttons up → row 3
	_caps_btn.focus_neighbor_top = _char_buttons[row3_start].get_path()
	_space_btn.focus_neighbor_top = _char_buttons[row3_start + 2].get_path()
	_backspace_btn.focus_neighbor_top = _char_buttons[row3_start + 4].get_path()
	_done_btn.focus_neighbor_top = _char_buttons[row3_end].get_path()

	# Bottom buttons down → row 1 (wrap)
	_caps_btn.focus_neighbor_bottom = _char_buttons[row1_start].get_path()
	_space_btn.focus_neighbor_bottom = _char_buttons[row1_start + 3].get_path()
	_backspace_btn.focus_neighbor_bottom = _char_buttons[row1_start + 6].get_path()
	_done_btn.focus_neighbor_bottom = _char_buttons[row1_end].get_path()


func _wire_row(start: int, end_idx: int) -> void:
	for i: int in range(start, end_idx + 1):
		var col: int = i - start
		var row_size: int = end_idx - start + 1
		var left_idx: int = start + ((col - 1 + row_size) % row_size)
		var right_idx: int = start + ((col + 1) % row_size)
		_char_buttons[i].focus_neighbor_left = _char_buttons[left_idx].get_path()
		_char_buttons[i].focus_neighbor_right = _char_buttons[right_idx].get_path()


func _input(event: InputEvent) -> void:
	if not visible:
		return
	if LocalCoop.is_event_gated(event):
		return
	if event.is_action_pressed("cancel"):
		get_viewport().set_input_as_handled()
		backspace_pressed.emit()
		return
	if event.is_action_pressed("pause"):
		get_viewport().set_input_as_handled()
		confirmed.emit()
		return
	# L3 (left stick click) toggles caps lock
	if event is InputEventJoypadButton and event.pressed:
		if event.button_index == JOY_BUTTON_LEFT_STICK:
			get_viewport().set_input_as_handled()
			_toggle_caps()


func grab_first_focus() -> void:
	if not _char_buttons.is_empty():
		_char_buttons[0].grab_focus()


static func _apply_key_style(btn: Button) -> void:
	# Subtle dark style for keyboard keys — overrides the vivid theme blue
	var normal_sb := StyleBoxFlat.new()
	normal_sb.bg_color = Color(0.08, 0.12, 0.18, 0.7)
	normal_sb.border_color = Color(0.2, 0.35, 0.55, 0.5)
	normal_sb.set_border_width_all(1)
	normal_sb.set_corner_radius_all(4)
	normal_sb.set_content_margin_all(4)
	btn.add_theme_stylebox_override("normal", normal_sb)

	var hover_sb := StyleBoxFlat.new()
	hover_sb.bg_color = Color(0.14, 0.22, 0.35, 0.85)
	hover_sb.border_color = Color(0.3, 0.55, 0.85, 0.8)
	hover_sb.set_border_width_all(2)
	hover_sb.set_corner_radius_all(4)
	hover_sb.set_content_margin_all(4)
	btn.add_theme_stylebox_override("hover", hover_sb)

	var pressed_sb := StyleBoxFlat.new()
	pressed_sb.bg_color = Color(0.06, 0.1, 0.16, 0.9)
	pressed_sb.border_color = Color(0.3, 0.55, 0.85, 0.8)
	pressed_sb.set_border_width_all(2)
	pressed_sb.set_corner_radius_all(4)
	pressed_sb.set_content_margin_all(4)
	btn.add_theme_stylebox_override("pressed", pressed_sb)


static func _apply_focus_style(btn: Button) -> void:
	var focus_sb := StyleBoxFlat.new()
	focus_sb.bg_color = Color(0.2, 0.2, 0.3, 0.9)
	focus_sb.border_color = Color.WHITE
	focus_sb.set_border_width_all(3)
	focus_sb.set_corner_radius_all(4)
	focus_sb.set_content_margin_all(6)
	btn.add_theme_stylebox_override("focus", focus_sb)
