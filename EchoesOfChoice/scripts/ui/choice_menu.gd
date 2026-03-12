class_name ChoiceMenu extends VBoxContainer

## Vertical list of clickable buttons for player choices.
## Replaces numbered Console.ReadLine menus from C#.

signal choice_selected(index: int)

const BUTTON_MIN_SIZE := Vector2(320, 48)

var _buttons: Array[Button] = []


func _ready() -> void:
	add_theme_constant_override("separation", 10)
	alignment = BoxContainer.ALIGNMENT_CENTER


## Show a list of choices. Each option dict has:
##   "label": String (required)
##   "description": String (optional, shown as smaller text below label)
##   "disabled": bool (optional)
func show_choices(options: Array) -> void:
	_clear_buttons()
	visible = true

	for i: int in options.size():
		var opt: Dictionary = options[i]
		var btn := Button.new()
		btn.custom_minimum_size = BUTTON_MIN_SIZE
		btn.focus_mode = Control.FOCUS_ALL
		_style_button(btn)

		if opt.has("description") and not opt["description"].is_empty():
			btn.text = "%s\n  %s" % [opt["label"], opt["description"]]
		else:
			btn.text = opt["label"]

		if opt.get("disabled", false):
			btn.disabled = true
			btn.modulate.a = 0.5

		var idx: int = i
		btn.pressed.connect(func() -> void: _on_button_pressed(idx))
		add_child(btn)
		_buttons.append(btn)

	_wire_focus()

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


func hide_menu() -> void:
	_clear_buttons()
	visible = false


static func _make_style(bg_color: Color, border_color: Color) -> StyleBoxFlat:
	var s := StyleBoxFlat.new()
	s.bg_color = bg_color
	s.border_color = border_color
	s.set_border_width_all(2)
	s.set_corner_radius_all(6)
	s.set_content_margin_all(12)
	return s


func _style_button(btn: Button) -> void:
	var normal := _make_style(Color(0.1, 0.16, 0.22), Color(0.2, 0.4, 0.45))
	var hover := _make_style(Color(0.14, 0.22, 0.3), Color(0.3, 0.55, 0.6))
	var pressed := _make_style(Color(0.08, 0.12, 0.18), Color(0.25, 0.5, 0.55))
	var focus := _make_style(Color(0.12, 0.19, 0.26), Color(0.35, 0.65, 0.7))
	btn.add_theme_stylebox_override("normal", normal)
	btn.add_theme_stylebox_override("hover", hover)
	btn.add_theme_stylebox_override("pressed", pressed)
	btn.add_theme_stylebox_override("focus", focus)
	btn.add_theme_color_override("font_color", Color(0.85, 0.9, 0.95))
	btn.add_theme_color_override("font_hover_color", Color(0.95, 1.0, 1.0))
	btn.add_theme_color_override("font_pressed_color", Color(0.7, 0.8, 0.85))
	btn.add_theme_color_override("font_focus_color", Color(0.9, 0.95, 1.0))
	btn.add_theme_font_size_override("font_size", SettingsManager.font_size)


func _wire_focus() -> void:
	var enabled: Array[Button] = []
	for btn: Button in _buttons:
		if not btn.disabled:
			enabled.append(btn)

	for i: int in enabled.size():
		var btn: Button = enabled[i]
		var prev: Button = enabled[(i - 1 + enabled.size()) % enabled.size()]
		var next_btn: Button = enabled[(i + 1) % enabled.size()]
		btn.focus_neighbor_top = prev.get_path()
		btn.focus_neighbor_bottom = next_btn.get_path()
