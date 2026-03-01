class_name FighterBar extends HBoxContainer

## Health/mana bar for a single fighter in the battle HUD.

var _name_label: Label
var _hp_bar: ProgressBar
var _hp_label: Label
var _mp_bar: ProgressBar
var _mp_label: Label
var _is_enemy: bool = false


func _ready() -> void:
	_build_ui()


func _build_ui() -> void:
	add_theme_constant_override("separation", 8)

	_name_label = Label.new()
	_name_label.custom_minimum_size = Vector2(140, 0)
	_name_label.add_theme_font_size_override("font_size", 14)
	add_child(_name_label)

	# HP bar
	var hp_box := VBoxContainer.new()
	hp_box.add_theme_constant_override("separation", 0)
	hp_box.custom_minimum_size = Vector2(120, 0)
	add_child(hp_box)

	_hp_bar = ProgressBar.new()
	_hp_bar.custom_minimum_size = Vector2(120, 14)
	_hp_bar.show_percentage = false
	hp_box.add_child(_hp_bar)

	_hp_label = Label.new()
	_hp_label.add_theme_font_size_override("font_size", 11)
	_hp_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hp_box.add_child(_hp_label)

	# MP bar (hidden for enemies)
	var mp_box := VBoxContainer.new()
	mp_box.add_theme_constant_override("separation", 0)
	mp_box.custom_minimum_size = Vector2(80, 0)
	add_child(mp_box)

	_mp_bar = ProgressBar.new()
	_mp_bar.custom_minimum_size = Vector2(80, 14)
	_mp_bar.show_percentage = false
	mp_box.add_child(_mp_bar)

	_mp_label = Label.new()
	_mp_label.add_theme_font_size_override("font_size", 11)
	_mp_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	mp_box.add_child(_mp_label)

	_mp_bar.get_parent().visible = false


func setup(fighter: FighterData, is_enemy: bool = false) -> void:
	_is_enemy = is_enemy
	_mp_bar.get_parent().visible = not is_enemy
	update_display(fighter)


func update_display(fighter: FighterData) -> void:
	_name_label.text = "%s (%s)" % [fighter.character_name, fighter.character_type]

	_hp_bar.max_value = fighter.max_health
	_hp_bar.value = maxi(0, fighter.health)
	_hp_label.text = "%d/%d" % [maxi(0, fighter.health), fighter.max_health]

	# Color HP bar based on percentage
	var hp_pct: float = float(fighter.health) / float(fighter.max_health)
	if hp_pct > 0.5:
		_hp_bar.modulate = Color(0.3, 0.85, 0.3)  # Green
	elif hp_pct > 0.25:
		_hp_bar.modulate = Color(0.9, 0.7, 0.1)  # Yellow
	else:
		_hp_bar.modulate = Color(0.9, 0.2, 0.2)  # Red

	if not _is_enemy:
		_mp_bar.max_value = fighter.max_mana
		_mp_bar.value = maxi(0, fighter.mana)
		_mp_label.text = "%d/%d" % [maxi(0, fighter.mana), fighter.max_mana]
		_mp_bar.modulate = Color(0.3, 0.5, 0.9)  # Blue
