class_name ConfirmDialog extends ColorRect

## Modal confirmation dialog with Yes/No buttons.
## Displays a message and emits confirmed(accepted: bool) on response.

signal confirmed(accepted: bool)

var _panel: PanelContainer
var _message_label: Label
var _yes_btn: Button
var _no_btn: Button


func _init() -> void:
	# Full-screen semi-transparent backdrop
	set_anchors_preset(Control.PRESET_FULL_RECT)
	color = Color(0.0, 0.0, 0.0, 0.55)
	mouse_filter = Control.MOUSE_FILTER_STOP
	visible = false


func _ready() -> void:
	_build_ui()


func _build_ui() -> void:
	var center := CenterContainer.new()
	center.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(center)

	_panel = PanelContainer.new()
	var panel_style := StyleBoxFlat.new()
	panel_style.bg_color = Color(0.08, 0.12, 0.18)
	panel_style.border_color = Color(0.2, 0.4, 0.45)
	panel_style.set_border_width_all(2)
	panel_style.set_corner_radius_all(8)
	panel_style.set_content_margin_all(24)
	_panel.add_theme_stylebox_override("panel", panel_style)
	_panel.custom_minimum_size = Vector2(400, 0)
	center.add_child(_panel)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 20)
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	_panel.add_child(vbox)

	_message_label = Label.new()
	_message_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_message_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_message_label.add_theme_font_size_override("font_size", SettingsManager.font_size)
	_message_label.add_theme_color_override("font_color", Color(0.85, 0.9, 0.95))
	vbox.add_child(_message_label)

	var btn_row := HBoxContainer.new()
	btn_row.add_theme_constant_override("separation", 16)
	btn_row.alignment = BoxContainer.ALIGNMENT_CENTER
	vbox.add_child(btn_row)

	_yes_btn = _make_button("Yes")
	_yes_btn.pressed.connect(func() -> void: _respond(true))
	btn_row.add_child(_yes_btn)

	_no_btn = _make_button("No")
	_no_btn.pressed.connect(func() -> void: _respond(false))
	btn_row.add_child(_no_btn)


func show_confirm(message: String) -> void:
	_message_label.text = message
	visible = true
	_no_btn.grab_focus()


func _respond(accepted: bool) -> void:
	visible = false
	confirmed.emit(accepted)


func _make_button(text: String) -> Button:
	var btn := Button.new()
	btn.text = text
	btn.custom_minimum_size = Vector2(120, 40)
	btn.focus_mode = Control.FOCUS_ALL

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
	btn.add_theme_font_size_override("font_size", SettingsManager.font_size)

	# Wire focus neighbors for horizontal navigation
	btn.focus_neighbor_left = btn.get_path()
	btn.focus_neighbor_right = btn.get_path()
	return btn


func _make_style(bg_color: Color, border_color: Color) -> StyleBoxFlat:
	var s := StyleBoxFlat.new()
	s.bg_color = bg_color
	s.border_color = border_color
	s.set_border_width_all(2)
	s.set_corner_radius_all(6)
	s.set_content_margin_all(10)
	return s


func _unhandled_input(event: InputEvent) -> void:
	if not visible:
		return
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		_respond(false)
