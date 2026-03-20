class_name EnemyDetailModal extends DetailModalBase

## Detail modal for enemy entries: portrait, stats, abilities, flavor text.

var enemy_data: Dictionary = {}
var _EnemyRouter := preload("res://scripts/data/enemy_db_router.gd")


func _init(data: Dictionary) -> void:
	enemy_data = data


func build_content(container: VBoxContainer) -> void:
	var hbox := HBoxContainer.new()
	hbox.add_theme_constant_override("separation", 20)
	hbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
	container.add_child(hbox)

	# Left side: Portrait
	var portrait_container := VBoxContainer.new()
	portrait_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hbox.add_child(portrait_container)

	var portrait := TextureRect.new()
	portrait.custom_minimum_size = Vector2(256, 256)
	portrait.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	portrait.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

	var portrait_path: String = enemy_data.get("portrait_path", "")
	if portrait_path.is_empty() or not ResourceLoader.exists(portrait_path):
		portrait_path = "res://assets/art/ui/placeholder_portrait.png"
	if ResourceLoader.exists(portrait_path):
		portrait.texture = load(portrait_path)

	portrait_container.add_child(portrait)

	# Right side: Info panel
	var info_panel := VBoxContainer.new()
	info_panel.add_theme_constant_override("separation", 8)
	info_panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	info_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	hbox.add_child(info_panel)

	# Name
	var name_label := Label.new()
	name_label.text = enemy_data.get("name", "Unknown Enemy")
	name_label.add_theme_font_size_override("font_size", 20)
	name_label.add_theme_color_override("font_color", Color(0.9, 0.8, 0.5))
	info_panel.add_child(name_label)

	# Story label
	var story_id: String = enemy_data.get("story_id", "story_1")
	var story_names := {
		"story_1": "Story 1: The Stranger's Shadow",
		"story_2": "Story 2: Echoes in the Dark",
		"story_3": "Story 3: The Woven Night",
	}
	var story_label := Label.new()
	story_label.text = "Encountered in: " + story_names.get(story_id, story_id)
	story_label.add_theme_font_size_override("font_size", SettingsManager.font_size)
	story_label.add_theme_color_override("font_color", Color(0.7, 0.7, 0.7))
	info_panel.add_child(story_label)

	# Separator
	var sep := HSeparator.new()
	info_panel.add_child(sep)

	# Flavor text
	var flavor_label := Label.new()
	flavor_label.text = enemy_data.get("flavor_text", "")
	flavor_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	flavor_label.add_theme_font_size_override("font_size", SettingsManager.font_size)
	flavor_label.add_theme_color_override("font_color", Color(0.9, 0.9, 0.8))
	info_panel.add_child(flavor_label)

	# Another separator
	var sep2 := HSeparator.new()
	info_panel.add_child(sep2)

	# Stats (from base enemy definition)
	var stats_label := Label.new()
	stats_label.text = "Base Stats:"
	stats_label.add_theme_font_size_override("font_size", SettingsManager.font_size + 2)
	stats_label.add_theme_color_override("font_color", Color(0.9, 0.8, 0.5))
	info_panel.add_child(stats_label)

	var stats_text := _format_stats()
	var stats_display := Label.new()
	stats_display.text = stats_text
	stats_display.add_theme_font_size_override("font_size", SettingsManager.font_size)
	info_panel.add_child(stats_display)

	# Separator
	var sep3 := HSeparator.new()
	info_panel.add_child(sep3)

	# Abilities
	var abilities_label := Label.new()
	abilities_label.text = "Abilities:"
	abilities_label.add_theme_font_size_override("font_size", SettingsManager.font_size + 2)
	abilities_label.add_theme_color_override("font_color", Color(0.9, 0.8, 0.5))
	info_panel.add_child(abilities_label)

	var abilities: Array = enemy_data.get("abilities", [])
	if abilities.is_empty():
		var none_label := Label.new()
		none_label.text = "  (No abilities data)"
		none_label.add_theme_font_size_override("font_size", SettingsManager.font_size)
		none_label.add_theme_color_override("font_color", Color(0.6, 0.6, 0.6))
		info_panel.add_child(none_label)
	for ability: Variant in abilities:
		if ability is Dictionary:
			var name_text := "  • " + ability.get("name", "???")
			var cost: int = ability.get("mana_cost", 0)
			if cost > 0:
				name_text += "  (%d MP)" % cost
			var cd: int = ability.get("cooldown", 0)
			if cd > 0:
				name_text += "  [%d turn CD]" % cd
			var ability_name_label := Label.new()
			ability_name_label.text = name_text
			ability_name_label.add_theme_font_size_override("font_size", SettingsManager.font_size)
			ability_name_label.add_theme_color_override("font_color", Color.WHITE)
			info_panel.add_child(ability_name_label)
			var desc: String = ability.get("description", "")
			if not desc.is_empty():
				var desc_label := Label.new()
				desc_label.text = "      " + desc
				desc_label.add_theme_font_size_override("font_size", SettingsManager.font_size - 1)
				desc_label.add_theme_color_override("font_color", Color(0.7, 0.7, 0.7))
				desc_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
				info_panel.add_child(desc_label)
		elif ability is String:
			var ability_label := Label.new()
			ability_label.text = "  • " + ability
			ability_label.add_theme_font_size_override("font_size", SettingsManager.font_size)
			info_panel.add_child(ability_label)


func _format_stats() -> String:
	var class_id: String = enemy_data.get("class_id", "")
	if class_id.is_empty():
		return "Stats unavailable"

	var fighter: RefCounted = _EnemyRouter.create_enemy(class_id)
	if not fighter:
		return "Stats unavailable"

	var lines: Array[String] = [
		"HP: %d  |  MP: %d" % [fighter.max_health, fighter.max_mana],
		"ATK: %d  |  DEF: %d" % [fighter.physical_attack, fighter.physical_defense],
		"MAG: %d  |  MDEF: %d" % [fighter.magic_attack, fighter.magic_defense],
		"SPD: %d  |  CRIT: %d%%  |  DODGE: %d%%" % [fighter.speed, fighter.crit_chance, fighter.dodge_chance],
	]
	return "\n".join(lines)
