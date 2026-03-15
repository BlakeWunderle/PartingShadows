class_name PortraitCard extends VBoxContainer

## Compact portrait card showing fighter image, name, and HP/MP bars.
## Used in the battle scene to display all party members and enemies simultaneously.

const Enums := preload("res://scripts/data/enums.gd")
const FighterData := preload("res://scripts/data/fighter_data.gd")

var _frame: PanelContainer
var _portrait: TextureRect
var _name_label: Label
var _hp_bar: ProgressBar
var _mp_bar: ProgressBar
var _is_enemy: bool = false
var _fighter_ref: FighterData

# Active highlight stylebox
var _active_style: StyleBoxFlat
var _default_style: StyleBoxFlat


func _ready() -> void:
	_build_ui()


func _build_ui() -> void:
	add_theme_constant_override("separation", 2)

	# Portrait frame
	_frame = PanelContainer.new()
	_frame.custom_minimum_size = Vector2(110, 130)
	_frame.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_frame.size_flags_vertical = Control.SIZE_EXPAND_FILL

	_default_style = StyleBoxFlat.new()
	_default_style.bg_color = Color(0.1, 0.1, 0.14, 0.8)
	_default_style.set_border_width_all(2)
	_default_style.border_color = Color(0.25, 0.25, 0.3, 0.6)
	_default_style.set_corner_radius_all(4)
	_frame.add_theme_stylebox_override("panel", _default_style)

	_active_style = StyleBoxFlat.new()
	_active_style.bg_color = Color(0.1, 0.1, 0.14, 0.8)
	_active_style.set_border_width_all(3)
	_active_style.border_color = Color(0.2, 0.9, 0.8, 1.0)  # Bright teal
	_active_style.set_corner_radius_all(4)

	add_child(_frame)

	_portrait = TextureRect.new()
	_portrait.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_portrait.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	_portrait.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_portrait.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_portrait.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	_frame.add_child(_portrait)

	# Name label
	_name_label = Label.new()
	_name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_name_label.add_theme_font_size_override("font_size", 11)
	_name_label.clip_text = true
	_name_label.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
	add_child(_name_label)

	# HP bar
	_hp_bar = ProgressBar.new()
	_hp_bar.custom_minimum_size = Vector2(0, 8)
	_hp_bar.show_percentage = false
	add_child(_hp_bar)

	# MP bar (hidden for enemies)
	_mp_bar = ProgressBar.new()
	_mp_bar.custom_minimum_size = Vector2(0, 6)
	_mp_bar.show_percentage = false
	_mp_bar.modulate = Color(0.3, 0.5, 0.9)
	add_child(_mp_bar)


func setup(fighter: FighterData, is_enemy: bool, portrait_tex: Texture2D) -> void:
	_fighter_ref = fighter
	_is_enemy = is_enemy
	_mp_bar.visible = not is_enemy

	if portrait_tex:
		_portrait.texture = portrait_tex

	_name_label.text = fighter.character_name
	_update_bars(fighter)


func update_display(fighter: FighterData) -> void:
	_fighter_ref = fighter
	_update_bars(fighter)


func set_active(active: bool) -> void:
	_frame.add_theme_stylebox_override("panel", _active_style if active else _default_style)


func set_dead(dead: bool) -> void:
	if dead:
		modulate = Color(0.4, 0.4, 0.4, 0.7)
	else:
		modulate = Color(1, 1, 1, 1)


func get_fighter() -> FighterData:
	return _fighter_ref


func _update_bars(fighter: FighterData) -> void:
	_hp_bar.max_value = fighter.max_health
	_hp_bar.value = maxi(0, fighter.health)

	var palette: Dictionary = SettingsManager.get_palette()
	var hp_pct: float = float(fighter.health) / float(maxi(1, fighter.max_health))
	if hp_pct > 0.5:
		_hp_bar.modulate = palette["hp_high"]
	elif hp_pct > 0.25:
		_hp_bar.modulate = palette["hp_mid"]
	else:
		_hp_bar.modulate = palette["hp_low"]

	if not _is_enemy:
		_mp_bar.max_value = fighter.max_mana
		_mp_bar.value = maxi(0, fighter.mana)
