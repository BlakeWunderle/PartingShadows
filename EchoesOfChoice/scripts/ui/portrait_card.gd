class_name PortraitCard extends VBoxContainer

## Compact portrait card showing fighter image, name, HP/MP bars, and status effects.
## Used in the battle scene to display all party members and enemies simultaneously.

const Enums := preload("res://scripts/data/enums.gd")
const FighterData := preload("res://scripts/data/fighter_data.gd")

var _frame: PanelContainer
var _portrait: TextureRect
var _name_label: Label
var _hp_bar: ProgressBar
var _hp_label: Label
var _mp_bar: ProgressBar
var _mp_label: Label
var _status_label: RichTextLabel
var _is_enemy: bool = false
var _fighter_ref: FighterData
var _hp_tween: Tween
var _mp_tween: Tween

# Active highlight stylebox
var _active_style: StyleBoxFlat
var _default_style: StyleBoxFlat

# Bar fill styles
var _hp_fill: StyleBoxFlat
var _hp_bg: StyleBoxFlat
var _mp_fill: StyleBoxFlat
var _mp_bg: StyleBoxFlat


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
	_name_label.add_theme_font_override("font", preload("res://assets/fonts/CormorantGaramond-SemiBold.ttf"))
	_name_label.add_theme_font_size_override("font_size", 13)
	_name_label.clip_text = true
	_name_label.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
	add_child(_name_label)

	# HP bar -- uses stylebox for distinct color
	var hp_container := Control.new()
	hp_container.custom_minimum_size = Vector2(0, 12)
	add_child(hp_container)

	_hp_bar = ProgressBar.new()
	_hp_bar.custom_minimum_size = Vector2(0, 12)
	_hp_bar.set_anchors_preset(Control.PRESET_FULL_RECT)
	_hp_bar.show_percentage = false

	_hp_bg = StyleBoxFlat.new()
	_hp_bg.bg_color = Color(0.15, 0.15, 0.15, 0.9)
	_hp_bg.set_corner_radius_all(2)
	_hp_bar.add_theme_stylebox_override("background", _hp_bg)

	_hp_fill = StyleBoxFlat.new()
	_hp_fill.bg_color = Color(0.2, 0.8, 0.3)  # Green
	_hp_fill.set_corner_radius_all(2)
	_hp_bar.add_theme_stylebox_override("fill", _hp_fill)

	hp_container.add_child(_hp_bar)

	_hp_label = Label.new()
	_hp_label.set_anchors_preset(Control.PRESET_FULL_RECT)
	_hp_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_hp_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_hp_label.add_theme_font_size_override("font_size", 9)
	_hp_label.add_theme_color_override("font_color", Color(1, 1, 1, 0.9))
	_hp_label.add_theme_constant_override("outline_size", 2)
	_hp_label.add_theme_color_override("font_outline_color", Color(0, 0, 0, 0.8))
	hp_container.add_child(_hp_label)

	# MP bar -- blue, hidden for enemies
	var mp_container := Control.new()
	mp_container.custom_minimum_size = Vector2(0, 10)
	add_child(mp_container)

	_mp_bar = ProgressBar.new()
	_mp_bar.custom_minimum_size = Vector2(0, 10)
	_mp_bar.set_anchors_preset(Control.PRESET_FULL_RECT)
	_mp_bar.show_percentage = false

	_mp_bg = StyleBoxFlat.new()
	_mp_bg.bg_color = Color(0.12, 0.12, 0.18, 0.9)
	_mp_bg.set_corner_radius_all(2)
	_mp_bar.add_theme_stylebox_override("background", _mp_bg)

	_mp_fill = StyleBoxFlat.new()
	_mp_fill.bg_color = Color(0.3, 0.45, 0.95)  # Distinct blue
	_mp_fill.set_corner_radius_all(2)
	_mp_bar.add_theme_stylebox_override("fill", _mp_fill)

	mp_container.add_child(_mp_bar)

	_mp_label = Label.new()
	_mp_label.set_anchors_preset(Control.PRESET_FULL_RECT)
	_mp_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_mp_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_mp_label.add_theme_font_size_override("font_size", 8)
	_mp_label.add_theme_color_override("font_color", Color(1, 1, 1, 0.9))
	_mp_label.add_theme_constant_override("outline_size", 2)
	_mp_label.add_theme_color_override("font_outline_color", Color(0, 0, 0, 0.8))
	mp_container.add_child(_mp_label)

	# Status effects label (compact, fixed height to prevent bouncing)
	_status_label = RichTextLabel.new()
	_status_label.bbcode_enabled = true
	_status_label.fit_content = false
	_status_label.scroll_active = false
	_status_label.add_theme_font_size_override("normal_font_size", 9)
	_status_label.custom_minimum_size = Vector2(0, 14)
	_status_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_status_label)

	# Center pivot for death scale animation
	pivot_offset = Vector2(55, 90)  # Approximate center of card


func setup(fighter: FighterData, is_enemy: bool, portrait_tex: Texture2D) -> void:
	_fighter_ref = fighter
	_is_enemy = is_enemy
	_mp_bar.get_parent().visible = not is_enemy

	if portrait_tex:
		_portrait.texture = portrait_tex
	if fighter.is_shadow:
		var shader := load("res://resources/shaders/shadow_portrait.gdshader") as Shader
		var mat := ShaderMaterial.new()
		mat.shader = shader
		_portrait.material = mat

	_name_label.text = fighter.character_name
	_update_bars(fighter, true)


func update_display(fighter: FighterData) -> void:
	_fighter_ref = fighter
	_update_bars(fighter)


func set_active(active: bool) -> void:
	_frame.add_theme_stylebox_override("panel", _active_style if active else _default_style)


func set_dead(dead: bool) -> void:
	if dead:
		if modulate == Color(1, 1, 1, 1) and is_inside_tree():
			# First time dying -- animate
			var tw := create_tween().set_parallel(true)
			tw.tween_property(self, "modulate", Color(0.4, 0.4, 0.4, 0.7), 0.4)
			tw.tween_property(self, "scale", Vector2(0.95, 0.95), 0.3).set_ease(Tween.EASE_IN)
		else:
			modulate = Color(0.4, 0.4, 0.4, 0.7)
		_status_label.clear()
	else:
		modulate = Color(1, 1, 1, 1)
		scale = Vector2(1, 1)


func get_fighter() -> FighterData:
	return _fighter_ref


## Spawn a floating number above the card that drifts up and fades out.
## Added to the scene root (not this VBoxContainer) to prevent layout bounce.
func show_floating_text(text: String, color: Color) -> void:
	if not is_inside_tree():
		return
	var label := Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size", 16)
	label.add_theme_color_override("font_color", color)
	label.add_theme_constant_override("outline_size", 3)
	label.add_theme_color_override("font_outline_color", Color(0, 0, 0, 0.9))
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	# Add to scene root so the label doesn't affect VBoxContainer layout
	var scene_root: Node = get_tree().current_scene
	scene_root.add_child(label)
	var card_pos: Vector2 = global_position
	label.global_position = Vector2(card_pos.x + size.x * 0.5 - 20, card_pos.y - 10)

	var tw := create_tween().set_parallel(true)
	tw.tween_property(label, "global_position:y", card_pos.y - 40.0, 0.8).set_ease(Tween.EASE_OUT)
	tw.tween_property(label, "modulate:a", 0.0, 0.8).set_ease(Tween.EASE_IN).set_delay(0.3)
	tw.chain().tween_callback(label.queue_free)


func _update_bars(fighter: FighterData, instant: bool = false) -> void:
	_hp_bar.max_value = fighter.max_health
	var target_hp: float = float(maxi(0, fighter.health))
	_hp_label.text = "%d/%d" % [maxi(0, fighter.health), fighter.max_health]

	# Tween HP bar smoothly (instant on first setup)
	if instant or not is_inside_tree():
		_hp_bar.value = target_hp
	else:
		if _hp_tween and _hp_tween.is_valid():
			_hp_tween.kill()
		_hp_tween = create_tween()
		_hp_tween.tween_property(_hp_bar, "value", target_hp, 0.35).set_ease(Tween.EASE_OUT)

	# Color HP fill based on percentage (color blind aware)
	var palette: Dictionary = SettingsManager.get_palette()
	var hp_pct: float = float(fighter.health) / float(maxi(1, fighter.max_health))
	if hp_pct > 0.5:
		_hp_fill.bg_color = palette["hp_high"]
	elif hp_pct > 0.25:
		_hp_fill.bg_color = palette["hp_mid"]
	else:
		_hp_fill.bg_color = palette["hp_low"]

	if not _is_enemy:
		_mp_bar.max_value = fighter.max_mana
		var target_mp: float = float(maxi(0, fighter.mana))
		_mp_label.text = "%d/%d" % [maxi(0, fighter.mana), fighter.max_mana]

		if instant or not is_inside_tree():
			_mp_bar.value = target_mp
		else:
			if _mp_tween and _mp_tween.is_valid():
				_mp_tween.kill()
			_mp_tween = create_tween()
			_mp_tween.tween_property(_mp_bar, "value", target_mp, 0.25).set_ease(Tween.EASE_OUT)

		_mp_fill.bg_color = palette["mp"]

	_update_status(fighter)
	_update_tooltip(fighter)


func _update_tooltip(fighter: FighterData) -> void:
	if not SettingsManager.screen_reader:
		tooltip_text = ""
		return
	var tip: String = "%s: HP %d/%d" % [fighter.character_name, maxi(0, fighter.health), fighter.max_health]
	if not _is_enemy:
		tip += ", MP %d/%d" % [maxi(0, fighter.mana), fighter.max_mana]
	if not fighter.modified_stats.is_empty():
		var status_parts: Array[String] = []
		for mod: Dictionary in fighter.modified_stats:
			var stat: Enums.StatType = mod["stat"]
			var dpt: int = mod.get("damage_per_turn", 0)
			if dpt > 0:
				status_parts.append("DOT %d" % dpt)
			elif stat == Enums.StatType.TAUNT:
				status_parts.append("TAUNT")
			else:
				status_parts.append(_stat_abbrev(stat))
		tip += ", Status: " + ", ".join(status_parts)
	tooltip_text = tip


func _update_status(fighter: FighterData) -> void:
	_status_label.clear()
	if fighter.modified_stats.is_empty():
		return

	var palette: Dictionary = SettingsManager.get_palette()
	var buff_hex: String = palette["buff"].to_html(false)
	var debuff_hex: String = palette["debuff"].to_html(false)

	# Aggregate same-type effects
	var groups: Dictionary = {}
	var group_order: Array = []
	for mod: Dictionary in fighter.modified_stats:
		var stat: Enums.StatType = mod["stat"]
		var turns: int = mod["turns"]
		var is_negative: bool = mod["is_negative"]
		var dpt: int = mod.get("damage_per_turn", 0)
		var key: String = "%d_%s_%d" % [stat, is_negative, dpt]

		if groups.has(key):
			groups[key]["count"] += 1
			groups[key]["max_turns"] = maxi(groups[key]["max_turns"], turns)
		else:
			groups[key] = {
				"stat": stat, "is_negative": is_negative, "dpt": dpt,
				"count": 1, "max_turns": turns,
			}
			group_order.append(key)

	var parts: Array[String] = []
	for key: String in group_order:
		var g: Dictionary = groups[key]
		var stat: Enums.StatType = g["stat"]
		var is_negative: bool = g["is_negative"]
		var dpt: int = g["dpt"]
		var count: int = g["count"]
		var max_turns: int = g["max_turns"]

		var tag: String
		if dpt > 0:
			tag = "DOT"
		elif stat == Enums.StatType.TAUNT:
			tag = "TAUNT"
		else:
			tag = _stat_abbrev(stat)

		var color: String
		if stat == Enums.StatType.TAUNT:
			color = "yellow"
		elif is_negative:
			color = "#" + debuff_hex
		else:
			color = "#" + buff_hex

		if count > 1:
			parts.append("[color=%s]%sx%d[/color]" % [color, tag, count])
		else:
			parts.append("[color=%s]%s[/color]" % [color, tag])

	_status_label.append_text(" ".join(parts))


static func _stat_abbrev(stat: Enums.StatType) -> String:
	match stat:
		Enums.StatType.PHYSICAL_ATTACK: return "P.ATK"
		Enums.StatType.PHYSICAL_DEFENSE: return "P.DEF"
		Enums.StatType.MAGIC_ATTACK: return "M.ATK"
		Enums.StatType.MAGIC_DEFENSE: return "M.DEF"
		Enums.StatType.ATTACK: return "ATK"
		Enums.StatType.DEFENSE: return "DEF"
		Enums.StatType.SPEED: return "SPD"
		Enums.StatType.HEALTH: return "HP"
		Enums.StatType.DODGE_CHANCE: return "DODGE"
		_: return "BUFF"
