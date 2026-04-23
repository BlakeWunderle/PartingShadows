class_name BattleDetailModal extends DetailModalBase

## Detail modal for battle entries: background image, enemy list, flavor text.

var battle_data: Dictionary = {}


func _init(data: Dictionary) -> void:
	battle_data = data


func build_content(container: VBoxContainer) -> void:
	var hbox := HBoxContainer.new()
	hbox.add_theme_constant_override("separation", 20)
	hbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
	container.add_child(hbox)

	# Left side: Battle background
	var background_container := VBoxContainer.new()
	background_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hbox.add_child(background_container)

	var background := TextureRect.new()
	background.custom_minimum_size = Vector2(400, 300)
	background.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	background.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

	var background_path: String = battle_data.get("scene_image", "")
	if background_path.is_empty() or not ResourceLoader.exists(background_path):
		background_path = "res://assets/art/ui/placeholder_background.png"
	if ResourceLoader.exists(background_path):
		background.texture = load(background_path)

	background_container.add_child(background)

	# Right side: Info panel
	var info_panel := VBoxContainer.new()
	info_panel.add_theme_constant_override("separation", 8)
	info_panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	info_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	hbox.add_child(info_panel)

	# Battle name/ID
	var name_label := Label.new()
	var battle_id: String = battle_data.get("battle_id", "Unknown Battle")
	name_label.text = CompendiumManager.format_battle_name(battle_id)
	name_label.add_theme_font_size_override("font_size", 20)
	name_label.add_theme_color_override("font_color", Color(0.9, 0.8, 0.5))
	name_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	info_panel.add_child(name_label)

	# Story label
	var story_id: String = battle_data.get("story_id", "story_1")
	var story_names := {
		"story_1": "Story 1: The Stranger's Shadow",
		"story_2": "Story 2: Echoes in the Dark",
		"story_3": "Story 3: The Woven Night",
	}
	var story_label := Label.new()
	story_label.text = story_names.get(story_id, story_id)
	story_label.add_theme_font_size_override("font_size", SettingsManager.font_size)
	story_label.add_theme_color_override("font_color", Color(0.7, 0.7, 0.7))
	info_panel.add_child(story_label)

	# Completion status
	var battle_id_val: String = battle_data.get("battle_id", "")
	var win_count: int = CompendiumManager.get_battle_win_count(battle_id_val)
	var status_label := Label.new()
	if win_count > 1:
		status_label.text = "Completed (%d times)" % win_count
	else:
		status_label.text = "Completed"
	status_label.add_theme_font_size_override("font_size", SettingsManager.font_size)
	status_label.add_theme_color_override("font_color", Color(0.5, 0.9, 0.5))
	info_panel.add_child(status_label)

	# Separator
	var sep := HSeparator.new()
	info_panel.add_child(sep)

	# Flavor text (only if present)
	var flavor: String = battle_data.get("flavor_text", "")
	if not flavor.is_empty():
		var flavor_label := Label.new()
		flavor_label.text = flavor
		flavor_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		flavor_label.add_theme_font_size_override("font_size", SettingsManager.font_size)
		flavor_label.add_theme_color_override("font_color", Color(0.9, 0.9, 0.8))
		info_panel.add_child(flavor_label)
		var sep2 := HSeparator.new()
		info_panel.add_child(sep2)

	# Enemies faced
	var enemies_label := Label.new()
	enemies_label.text = "Enemies Encountered:"
	enemies_label.add_theme_font_size_override("font_size", SettingsManager.font_size + 2)
	enemies_label.add_theme_color_override("font_color", Color(0.9, 0.8, 0.5))
	info_panel.add_child(enemies_label)

	var enemies_info: Array = battle_data.get("enemies_info", [])
	if enemies_info.is_empty():
		var placeholder := Label.new()
		placeholder.text = "  (Enemy details unavailable)"
		placeholder.add_theme_font_size_override("font_size", SettingsManager.font_size)
		placeholder.add_theme_color_override("font_color", Color(0.6, 0.6, 0.6))
		info_panel.add_child(placeholder)
	else:
		for enemy_info: Variant in enemies_info:
			var row := HBoxContainer.new()
			row.add_theme_constant_override("separation", 10)
			info_panel.add_child(row)

			var enemy_name: String
			var portrait_path: String
			if enemy_info is Dictionary:
				enemy_name = enemy_info.get("name", "???")
				portrait_path = enemy_info.get("portrait_path", "")
			else:
				enemy_name = str(enemy_info)
				portrait_path = ""

			# Enemy portrait (large)
			var thumb := TextureRect.new()
			thumb.custom_minimum_size = Vector2(72, 72)
			thumb.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
			thumb.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			if not portrait_path.is_empty() and ResourceLoader.exists(portrait_path):
				thumb.texture = load(portrait_path)
			row.add_child(thumb)

			var enemy_label := Label.new()
			enemy_label.text = enemy_name
			enemy_label.add_theme_font_size_override("font_size", SettingsManager.font_size + 1)
			enemy_label.size_flags_vertical = Control.SIZE_SHRINK_CENTER
			row.add_child(enemy_label)
