class_name PortraitCard extends VBoxContainer

## Compact portrait card showing fighter image, name, HP/MP bars, and status effects.
## Used in the battle scene to display all party members and enemies simultaneously.

const Enums := preload("res://scripts/data/enums.gd")
const FighterData := preload("res://scripts/data/fighter_data.gd")

var _frame: PanelContainer
var _portrait: TextureRect
var _name_label: Label
var _hp_bar: ProgressBar
var _mp_bar: ProgressBar
var _status_label: RichTextLabel
var _is_enemy: bool = false
var _fighter_ref: FighterData

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
	_name_label.add_theme_font_size_override("font_size", 11)
	_name_label.clip_text = true
	_name_label.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
	add_child(_name_label)

	# HP bar -- uses stylebox for distinct color
	_hp_bar = ProgressBar.new()
	_hp_bar.custom_minimum_size = Vector2(0, 10)
	_hp_bar.show_percentage = false

	_hp_bg = StyleBoxFlat.new()
	_hp_bg.bg_color = Color(0.15, 0.15, 0.15, 0.9)
	_hp_bg.set_corner_radius_all(2)
	_hp_bar.add_theme_stylebox_override("background", _hp_bg)

	_hp_fill = StyleBoxFlat.new()
	_hp_fill.bg_color = Color(0.2, 0.8, 0.3)  # Green
	_hp_fill.set_corner_radius_all(2)
	_hp_bar.add_theme_stylebox_override("fill", _hp_fill)

	add_child(_hp_bar)

	# MP bar -- blue, hidden for enemies
	_mp_bar = ProgressBar.new()
	_mp_bar.custom_minimum_size = Vector2(0, 7)
	_mp_bar.show_percentage = false

	_mp_bg = StyleBoxFlat.new()
	_mp_bg.bg_color = Color(0.12, 0.12, 0.18, 0.9)
	_mp_bg.set_corner_radius_all(2)
	_mp_bar.add_theme_stylebox_override("background", _mp_bg)

	_mp_fill = StyleBoxFlat.new()
	_mp_fill.bg_color = Color(0.3, 0.45, 0.95)  # Distinct blue
	_mp_fill.set_corner_radius_all(2)
	_mp_bar.add_theme_stylebox_override("fill", _mp_fill)

	add_child(_mp_bar)

	# Status effects label (compact, fixed height to prevent bouncing)
	_status_label = RichTextLabel.new()
	_status_label.bbcode_enabled = true
	_status_label.fit_content = false
	_status_label.scroll_active = false
	_status_label.add_theme_font_size_override("normal_font_size", 9)
	_status_label.custom_minimum_size = Vector2(0, 14)
	_status_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_status_label)


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
		_mp_bar.value = maxi(0, fighter.mana)

	_update_status(fighter)


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
