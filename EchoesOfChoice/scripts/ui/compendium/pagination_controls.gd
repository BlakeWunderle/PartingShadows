class_name PaginationControls extends HBoxContainer

## Reusable pagination UI with prev/next buttons and page counter.
## Emits page_changed signal when user navigates.

signal page_changed(new_page: int)

var current_page: int = 1:
	set(value):
		current_page = clampi(value, 1, total_pages)
		_update_ui()

var total_pages: int = 1:
	set(value):
		total_pages = maxi(1, value)
		current_page = clampi(current_page, 1, total_pages)
		_update_ui()

var _prev_btn: Button
var _page_label: Label
var _next_btn: Button


func _ready() -> void:
	alignment = BoxContainer.ALIGNMENT_CENTER
	add_theme_constant_override("separation", 12)

	# Prev button
	_prev_btn = Button.new()
	_prev_btn.text = "< Prev"
	_prev_btn.custom_minimum_size = Vector2(100, 32)
	_prev_btn.add_theme_font_size_override("font_size", SettingsManager.font_size)
	_prev_btn.pressed.connect(_on_prev)
	add_child(_prev_btn)

	# Page label
	_page_label = Label.new()
	_page_label.custom_minimum_size = Vector2(120, 32)
	_page_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_page_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_page_label.add_theme_font_size_override("font_size", SettingsManager.font_size)
	add_child(_page_label)

	# Next button
	_next_btn = Button.new()
	_next_btn.text = "Next >"
	_next_btn.custom_minimum_size = Vector2(100, 32)
	_next_btn.add_theme_font_size_override("font_size", SettingsManager.font_size)
	_next_btn.pressed.connect(_on_next)
	add_child(_next_btn)

	_update_ui()


func _on_prev() -> void:
	if current_page > 1:
		current_page -= 1
		page_changed.emit(current_page)


func _on_next() -> void:
	if current_page < total_pages:
		current_page += 1
		page_changed.emit(current_page)


func _update_ui() -> void:
	if not is_node_ready():
		return

	_prev_btn.disabled = (current_page <= 1)
	_next_btn.disabled = (current_page >= total_pages)
	_page_label.text = "Page %d / %d" % [current_page, total_pages]
