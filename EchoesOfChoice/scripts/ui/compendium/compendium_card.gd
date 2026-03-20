class_name CompendiumCard extends PanelContainer

## Grid card showing portrait + name for discovered content, or ??? for undiscovered.

signal clicked(item_data: Dictionary)

var item_data: Dictionary = {}
var is_discovered: bool = true

var _portrait: TextureRect
var _name_label: Label
var _is_hovered: bool = false
var _hover_style: StyleBoxFlat


func _ready() -> void:
	custom_minimum_size = Vector2(150, 180)
	mouse_filter = Control.MOUSE_FILTER_STOP

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 8)
	vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	vbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
	add_child(vbox)

	# Portrait
	_portrait = TextureRect.new()
	_portrait.custom_minimum_size = Vector2(128, 128)
	_portrait.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	_portrait.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	_portrait.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	vbox.add_child(_portrait)

	# Name label
	_name_label = Label.new()
	_name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_name_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_name_label.add_theme_font_size_override("font_size", SettingsManager.font_size)
	vbox.add_child(_name_label)

	_update_display()


func set_item(data: Dictionary, discovered: bool) -> void:
	item_data = data
	is_discovered = discovered
	if is_node_ready():
		_update_display()


func _update_display() -> void:
	if not is_node_ready():
		return

	if is_discovered:
		# Show actual content
		var portrait_path: String = item_data.get("portrait_path", "")
		if portrait_path.is_empty() or not ResourceLoader.exists(portrait_path):
			portrait_path = "res://assets/art/ui/placeholder_portrait.png"

		if ResourceLoader.exists(portrait_path):
			_portrait.texture = load(portrait_path)

		_name_label.text = item_data.get("name", "Unknown")
		_name_label.add_theme_color_override("font_color", Color.WHITE)
	else:
		# Show ??? placeholder
		var mystery_path := "res://assets/art/ui/undiscovered_card.png"
		if ResourceLoader.exists(mystery_path):
			_portrait.texture = load(mystery_path)

		_name_label.text = "???"
		_name_label.add_theme_color_override("font_color", Color(0.5, 0.5, 0.5))

	_update_style()


func _update_style() -> void:
	if _is_hovered:
		if not _hover_style:
			_hover_style = StyleBoxFlat.new()
			_hover_style.bg_color = Color(0.3, 0.3, 0.4, 0.8)
			_hover_style.border_color = Color(0.9, 0.8, 0.5)
			_hover_style.border_width_left = 2
			_hover_style.border_width_right = 2
			_hover_style.border_width_top = 2
			_hover_style.border_width_bottom = 2
		add_theme_stylebox_override("panel", _hover_style)
	else:
		remove_theme_stylebox_override("panel")


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			clicked.emit(item_data)


func _on_mouse_entered() -> void:
	_is_hovered = true
	_update_style()


func _on_mouse_exited() -> void:
	_is_hovered = false
	_update_style()


func _notification(what: int) -> void:
	if what == NOTIFICATION_MOUSE_ENTER:
		_on_mouse_entered()
	elif what == NOTIFICATION_MOUSE_EXIT:
		_on_mouse_exited()
