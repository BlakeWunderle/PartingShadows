class_name TipOverlay extends ColorRect

## One-time contextual help tip overlay.
## Tracks seen tips in user://tips_seen.json so each tip shows only once.

signal dismissed

const TIPS_PATH := "user://tips_seen.json"

var _panel: PanelContainer
var _message_label: RichTextLabel
var _dismiss_btn: Button
var _seen_tips: Dictionary = {}


func _init() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	color = Color(0.0, 0.0, 0.0, 0.6)
	mouse_filter = Control.MOUSE_FILTER_STOP
	visible = false
	_load_seen()


func _ready() -> void:
	_build_ui()


func _build_ui() -> void:
	var center := CenterContainer.new()
	center.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(center)

	_panel = PanelContainer.new()
	var panel_style := StyleBoxFlat.new()
	panel_style.bg_color = Color(0.06, 0.1, 0.16)
	panel_style.border_color = Color(0.2, 0.45, 0.5)
	panel_style.set_border_width_all(2)
	panel_style.set_corner_radius_all(10)
	panel_style.set_content_margin_all(24)
	_panel.add_theme_stylebox_override("panel", panel_style)
	_panel.custom_minimum_size = Vector2(520, 0)
	center.add_child(_panel)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 16)
	_panel.add_child(vbox)

	# Tip header
	var header := Label.new()
	header.text = "TIP"
	header.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	header.add_theme_font_size_override("font_size", 16)
	header.add_theme_color_override("font_color", Color(0.9, 0.8, 0.5))
	vbox.add_child(header)

	_message_label = RichTextLabel.new()
	_message_label.bbcode_enabled = true
	_message_label.fit_content = true
	_message_label.scroll_active = false
	_message_label.add_theme_font_size_override("normal_font_size", SettingsManager.font_size)
	_message_label.add_theme_color_override("default_color", Color(0.8, 0.85, 0.9))
	vbox.add_child(_message_label)

	_dismiss_btn = Button.new()
	_dismiss_btn.text = "Got it"
	_dismiss_btn.custom_minimum_size = Vector2(140, 38)
	_dismiss_btn.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	_dismiss_btn.focus_mode = Control.FOCUS_ALL
	_dismiss_btn.pressed.connect(_dismiss)
	_style_button(_dismiss_btn)
	vbox.add_child(_dismiss_btn)


func show_tip(tip_id: String, text: String) -> void:
	if _seen_tips.has(tip_id):
		return
	_message_label.clear()
	_message_label.append_text(text)
	visible = true
	_dismiss_btn.grab_focus()


func _dismiss() -> void:
	visible = false
	dismissed.emit()


func mark_seen(tip_id: String) -> void:
	_seen_tips[tip_id] = true
	_save_seen()


func was_seen(tip_id: String) -> bool:
	return _seen_tips.has(tip_id)


func show_tip_once(tip_id: String, text: String) -> void:
	if _seen_tips.has(tip_id):
		return
	_seen_tips[tip_id] = true
	_save_seen()
	_message_label.clear()
	_message_label.append_text(text)
	visible = true
	_dismiss_btn.grab_focus()


func _load_seen() -> void:
	if not FileAccess.file_exists(TIPS_PATH):
		return
	var file := FileAccess.open(TIPS_PATH, FileAccess.READ)
	if not file:
		return
	var json := JSON.new()
	if json.parse(file.get_as_text()) == OK and json.data is Dictionary:
		_seen_tips = json.data
	file.close()


func _save_seen() -> void:
	var file := FileAccess.open(TIPS_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(_seen_tips))
		file.close()


func _style_button(btn: Button) -> void:
	var normal := _make_style(Color(0.1, 0.16, 0.22), Color(0.2, 0.4, 0.45))
	var hover := _make_style(Color(0.14, 0.22, 0.3), Color(0.3, 0.55, 0.6))
	btn.add_theme_stylebox_override("normal", normal)
	btn.add_theme_stylebox_override("hover", hover)
	btn.add_theme_color_override("font_color", Color(0.85, 0.9, 0.95))
	btn.add_theme_font_size_override("font_size", SettingsManager.font_size)


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
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		_dismiss()
