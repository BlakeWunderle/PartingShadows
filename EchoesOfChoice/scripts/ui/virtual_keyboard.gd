class_name VirtualKeyboard extends PanelContainer

## On-screen keyboard for controller-based text entry.
## Emits signals as the player selects characters, backspaces, or confirms.

signal character_entered(ch: String)
signal backspace_pressed
signal confirmed

const ROWS: Array[String] = ["QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"]
const COLUMNS: int = 10

var _grid: GridContainer
var _char_buttons: Array[Button] = []
var _special_buttons: Array[Button] = []  # Space, -, '
var _backspace_btn: Button
var _done_btn: Button


func _ready() -> void:
	_build_ui()


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
	margin.add_child(vbox)

	# Row 1: QWERTYUIOP (10 keys)
	_grid = GridContainer.new()
	_grid.columns = COLUMNS
	_grid.add_theme_constant_override("h_separation", 3)
	_grid.add_theme_constant_override("v_separation", 3)
	vbox.add_child(_grid)

	for ch: String in ROWS[0]:
		_add_char_button(ch)

	# Row 2: ASDFGHJKL (9 keys, centered)
	var row2_hbox := HBoxContainer.new()
	row2_hbox.add_theme_constant_override("separation", 3)
	row2_hbox.alignment = BoxContainer.ALIGNMENT_CENTER
	vbox.add_child(row2_hbox)

	for ch: String in ROWS[1]:
		var btn := _create_key_button(ch, ch)
		row2_hbox.add_child(btn)
		_char_buttons.append(btn)

	# Row 3: ZXCVBNM + special chars (centered)
	var row3_hbox := HBoxContainer.new()
	row3_hbox.add_theme_constant_override("separation", 3)
	row3_hbox.alignment = BoxContainer.ALIGNMENT_CENTER
	vbox.add_child(row3_hbox)

	for ch: String in ROWS[2]:
		var btn := _create_key_button(ch, ch)
		row3_hbox.add_child(btn)
		_char_buttons.append(btn)

	# Special keys: - ' Space
	var dash_btn := _create_key_button("-", "-")
	row3_hbox.add_child(dash_btn)
	_char_buttons.append(dash_btn)

	var apos_btn := _create_key_button("'", "'")
	row3_hbox.add_child(apos_btn)
	_char_buttons.append(apos_btn)

	var space_btn := _create_key_button("SPC", " ")
	space_btn.custom_minimum_size = Vector2(60, 34)
	space_btn.tooltip_text = "Space"
	row3_hbox.add_child(space_btn)
	_char_buttons.append(space_btn)

	# Bottom row: Backspace + Done
	var bottom := HBoxContainer.new()
	bottom.add_theme_constant_override("separation", 8)
	bottom.alignment = BoxContainer.ALIGNMENT_CENTER
	vbox.add_child(bottom)

	_backspace_btn = Button.new()
	_backspace_btn.text = "Backspace"
	_backspace_btn.custom_minimum_size = Vector2(120, 36)
	_backspace_btn.focus_mode = Control.FOCUS_ALL
	_apply_focus_style(_backspace_btn)
	_backspace_btn.pressed.connect(func() -> void: backspace_pressed.emit())
	bottom.add_child(_backspace_btn)

	_done_btn = Button.new()
	_done_btn.text = "Done"
	_done_btn.custom_minimum_size = Vector2(120, 36)
	_done_btn.focus_mode = Control.FOCUS_ALL
	_apply_focus_style(_done_btn)
	_done_btn.pressed.connect(func() -> void: confirmed.emit())
	bottom.add_child(_done_btn)

	_wire_focus()


func _add_char_button(ch: String) -> void:
	var btn := _create_key_button(ch, ch)
	_grid.add_child(btn)
	_char_buttons.append(btn)


func _create_key_button(display: String, emit_ch: String) -> Button:
	var btn := Button.new()
	btn.text = display
	btn.custom_minimum_size = Vector2(36, 34)
	btn.focus_mode = Control.FOCUS_ALL
	_apply_focus_style(btn)
	btn.pressed.connect(func() -> void: character_entered.emit(emit_ch))
	return btn


func _wire_focus() -> void:
	# Row boundaries: row1 = 0..9, row2 = 10..18, row3 = 19..30 (7 letters + 3 special)
	var row1_start: int = 0
	var row1_end: int = 9
	var row2_start: int = 10
	var row2_end: int = 18
	var row3_start: int = 19
	var row3_end: int = _char_buttons.size() - 1

	# Wire each row internally (left/right wrap)
	_wire_row(row1_start, row1_end)
	_wire_row(row2_start, row2_end)
	_wire_row(row3_start, row3_end)

	# Wire up/down between rows
	for i: int in range(row1_start, row1_end + 1):
		var col: int = i - row1_start
		# Row 1 down → Row 2 (map 10 cols to 9)
		var r2_idx: int = row2_start + mini(col, row2_end - row2_start)
		_char_buttons[i].focus_neighbor_bottom = _char_buttons[r2_idx].get_path()
		# Row 1 up → bottom buttons (wrap)
		if col < 5:
			_char_buttons[i].focus_neighbor_top = _backspace_btn.get_path()
		else:
			_char_buttons[i].focus_neighbor_top = _done_btn.get_path()

	for i: int in range(row2_start, row2_end + 1):
		var col: int = i - row2_start
		# Row 2 up → Row 1
		var r1_idx: int = row1_start + mini(col, row1_end - row1_start)
		_char_buttons[i].focus_neighbor_top = _char_buttons[r1_idx].get_path()
		# Row 2 down → Row 3 (map 9 cols to row3 size)
		var r3_idx: int = row3_start + mini(col, row3_end - row3_start)
		_char_buttons[i].focus_neighbor_bottom = _char_buttons[r3_idx].get_path()

	for i: int in range(row3_start, row3_end + 1):
		var col: int = i - row3_start
		# Row 3 up → Row 2
		var r2_idx: int = row2_start + mini(col, row2_end - row2_start)
		_char_buttons[i].focus_neighbor_top = _char_buttons[r2_idx].get_path()
		# Row 3 down → bottom buttons
		if col < (row3_end - row3_start + 1) / 2:
			_char_buttons[i].focus_neighbor_bottom = _backspace_btn.get_path()
		else:
			_char_buttons[i].focus_neighbor_bottom = _done_btn.get_path()

	# Wire bottom buttons
	_backspace_btn.focus_neighbor_left = _done_btn.get_path()
	_backspace_btn.focus_neighbor_right = _done_btn.get_path()
	_done_btn.focus_neighbor_left = _backspace_btn.get_path()
	_done_btn.focus_neighbor_right = _backspace_btn.get_path()
	_backspace_btn.focus_neighbor_top = _char_buttons[row3_start].get_path()
	_done_btn.focus_neighbor_top = _char_buttons[row3_end].get_path()
	_backspace_btn.focus_neighbor_bottom = _char_buttons[row1_start].get_path()
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
	if event.is_action_pressed("cancel"):
		get_viewport().set_input_as_handled()
		backspace_pressed.emit()


func grab_first_focus() -> void:
	if not _char_buttons.is_empty():
		_char_buttons[0].grab_focus()


static func _apply_focus_style(btn: Button) -> void:
	var focus_sb := StyleBoxFlat.new()
	focus_sb.bg_color = Color(0.2, 0.2, 0.3, 0.9)
	focus_sb.border_color = Color.WHITE
	focus_sb.set_border_width_all(3)
	focus_sb.set_corner_radius_all(4)
	focus_sb.set_content_margin_all(6)
	btn.add_theme_stylebox_override("focus", focus_sb)
