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
	_panel.custom_minimum_size = Vector2(400, 0)
	center.add_child(_panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 12)
	margin.add_theme_constant_override("margin_top", 12)
	margin.add_theme_constant_override("margin_right", 12)
	margin.add_theme_constant_override("margin_bottom", 12)
	_panel.add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 20)
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	margin.add_child(vbox)

	_message_label = Label.new()
	_message_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_message_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_message_label.add_theme_font_size_override("font_size", SettingsManager.font_size)
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

	# Cross-link focus neighbors for horizontal keyboard/gamepad navigation
	_yes_btn.focus_neighbor_left = _no_btn.get_path()
	_yes_btn.focus_neighbor_right = _no_btn.get_path()
	_no_btn.focus_neighbor_left = _yes_btn.get_path()
	_no_btn.focus_neighbor_right = _yes_btn.get_path()


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
	btn.add_theme_font_size_override("font_size", SettingsManager.font_size)
	return btn


func _unhandled_input(event: InputEvent) -> void:
	if not visible:
		return
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		_respond(false)
