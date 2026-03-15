class_name ChoiceMenu extends VBoxContainer

## Clickable button menu for player choices.
## Supports vertical list (default) and 2-column grid layout.

signal choice_selected(index: int)

const BUTTON_MIN_SIZE := Vector2(320, 48)
const GRID_BUTTON_MIN_SIZE := Vector2(180, 44)

var _buttons: Array[Button] = []
var _grid: GridContainer


func _ready() -> void:
	add_theme_constant_override("separation", 10)
	alignment = BoxContainer.ALIGNMENT_CENTER


## Show a list of choices. Each option dict has:
##   "label": String (required)
##   "description": String (optional, shown as smaller text below label)
##   "disabled": bool (optional)
## Set use_grid=true for 2-column Pokemon-style layout.
func show_choices(options: Array, use_grid: bool = false) -> void:
	_clear_buttons()
	visible = true

	var btn_parent: Control = self
	if use_grid:
		_grid = GridContainer.new()
		_grid.columns = 2
		_grid.add_theme_constant_override("h_separation", 12)
		_grid.add_theme_constant_override("v_separation", 8)
		add_child(_grid)
		btn_parent = _grid

	for i: int in options.size():
		var opt: Dictionary = options[i]
		var btn := Button.new()
		btn.custom_minimum_size = GRID_BUTTON_MIN_SIZE if use_grid else BUTTON_MIN_SIZE
		btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		btn.focus_mode = Control.FOCUS_ALL
		btn.add_theme_font_size_override("font_size", SettingsManager.font_size)

		if opt.has("description") and not opt["description"].is_empty():
			btn.text = "%s\n  %s" % [opt["label"], opt["description"]]
		else:
			btn.text = opt["label"]

		if opt.get("disabled", false):
			btn.disabled = true
			btn.modulate.a = 0.5

		if SettingsManager.screen_reader:
			btn.tooltip_text = "Option %d of %d: %s" % [i + 1, options.size(), opt["label"]]

		var idx: int = i
		btn.pressed.connect(func() -> void: _on_button_pressed(idx))
		btn_parent.add_child(btn)
		_buttons.append(btn)

	_wire_focus(use_grid)

	# Focus first enabled button
	for btn: Button in _buttons:
		if not btn.disabled:
			btn.grab_focus()
			break


func _on_button_pressed(index: int) -> void:
	choice_selected.emit(index)


func _clear_buttons() -> void:
	for btn: Button in _buttons:
		btn.queue_free()
	_buttons.clear()
	if _grid:
		_grid.queue_free()
		_grid = null


func hide_menu() -> void:
	_clear_buttons()
	visible = false


func _wire_focus(use_grid: bool = false) -> void:
	var enabled: Array[Button] = []
	for btn: Button in _buttons:
		if not btn.disabled:
			enabled.append(btn)

	if enabled.is_empty():
		return

	if use_grid:
		_wire_grid_focus(enabled)
	else:
		_wire_list_focus(enabled)


func _wire_list_focus(enabled: Array[Button]) -> void:
	for i: int in enabled.size():
		var btn: Button = enabled[i]
		var prev: Button = enabled[(i - 1 + enabled.size()) % enabled.size()]
		var next_btn: Button = enabled[(i + 1) % enabled.size()]
		btn.focus_neighbor_top = prev.get_path()
		btn.focus_neighbor_bottom = next_btn.get_path()


func _wire_grid_focus(enabled: Array[Button]) -> void:
	## Wire 2-column grid navigation: up/down between rows, left/right between columns.
	var cols: int = 2
	for i: int in enabled.size():
		var btn: Button = enabled[i]
		var row: int = i / cols
		var col: int = i % cols

		# Left/right within row
		if col > 0:
			btn.focus_neighbor_left = enabled[i - 1].get_path()
		elif enabled.size() > 1:
			btn.focus_neighbor_left = enabled[mini(i + 1, enabled.size() - 1)].get_path()

		if col < cols - 1 and i + 1 < enabled.size():
			btn.focus_neighbor_right = enabled[i + 1].get_path()
		elif col == cols - 1 or i + 1 >= enabled.size():
			btn.focus_neighbor_right = enabled[i - col].get_path()

		# Up/down between rows
		var up_idx: int = i - cols
		if up_idx >= 0:
			btn.focus_neighbor_top = enabled[up_idx].get_path()
		else:
			# Wrap to last row
			var last_row_start: int = (enabled.size() - 1) / cols * cols
			var wrap_idx: int = mini(last_row_start + col, enabled.size() - 1)
			btn.focus_neighbor_top = enabled[wrap_idx].get_path()

		var down_idx: int = i + cols
		if down_idx < enabled.size():
			btn.focus_neighbor_bottom = enabled[down_idx].get_path()
		else:
			# Wrap to first row
			var wrap_idx: int = mini(col, enabled.size() - 1)
			btn.focus_neighbor_bottom = enabled[wrap_idx].get_path()
