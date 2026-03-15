class_name WaitingOverlay extends CenterContainer

## Simple "Waiting for [Player Name]..." overlay with animated dots.
## Reused across party creation, battle, and town stops.

var _label: Label
var _dot_count: int = 0
var _base_text: String = "Waiting"
var _dot_timer: Timer


func _init() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	visible = false

	var panel := PanelContainer.new()
	panel.add_theme_stylebox_override("panel", _create_style())
	add_child(panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 32)
	margin.add_theme_constant_override("margin_right", 32)
	margin.add_theme_constant_override("margin_top", 16)
	margin.add_theme_constant_override("margin_bottom", 16)
	panel.add_child(margin)

	_label = Label.new()
	_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_label.add_theme_font_size_override("font_size", 22)
	_label.add_theme_color_override("font_color", Color(0.85, 0.9, 0.95))
	margin.add_child(_label)

	_dot_timer = Timer.new()
	_dot_timer.wait_time = 0.5
	_dot_timer.timeout.connect(_animate_dots)
	add_child(_dot_timer)


func show_waiting(player_name: String) -> void:
	_base_text = "Waiting for %s" % player_name
	_dot_count = 0
	_label.text = _base_text + "..."
	visible = true
	_dot_timer.start()


func hide_waiting() -> void:
	visible = false
	_dot_timer.stop()


func _animate_dots() -> void:
	_dot_count = (_dot_count + 1) % 4
	_label.text = _base_text + ".".repeat(_dot_count + 1)


func _create_style() -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.08, 0.12, 0.16, 0.9)
	style.border_color = Color(0.2, 0.35, 0.4)
	style.set_border_width_all(2)
	style.set_corner_radius_all(8)
	return style
