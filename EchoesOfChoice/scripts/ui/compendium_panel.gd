class_name CompendiumPanel extends VBoxContainer

## Compendium viewer with Enemies and Classes tabs.
## Reads from CompendiumManager to show what the player has encountered.

signal back_pressed

enum Tab { ENEMIES, CLASSES }

var _tab: Tab = Tab.ENEMIES
var _enemies_btn: Button
var _classes_btn: Button
var _content_vbox: VBoxContainer
var _scroll: ScrollContainer


func _ready() -> void:
	add_theme_constant_override("separation", 10)
	_build_ui()
	_refresh()


func _build_ui() -> void:
	# Title
	var title := Label.new()
	title.text = "COMPENDIUM"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 24)
	title.add_theme_color_override("font_color", Color(0.9, 0.8, 0.5))
	add_child(title)

	var sep := HSeparator.new()
	add_child(sep)

	# Tab buttons
	var tab_row := HBoxContainer.new()
	tab_row.add_theme_constant_override("separation", 8)
	tab_row.alignment = BoxContainer.ALIGNMENT_CENTER
	add_child(tab_row)

	_enemies_btn = _tab_button("Enemies")
	_enemies_btn.pressed.connect(func() -> void: _switch_tab(Tab.ENEMIES))
	tab_row.add_child(_enemies_btn)

	_classes_btn = _tab_button("Classes")
	_classes_btn.pressed.connect(func() -> void: _switch_tab(Tab.CLASSES))
	tab_row.add_child(_classes_btn)

	# Scroll area
	_scroll = ScrollContainer.new()
	_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	_scroll.custom_minimum_size = Vector2(0, 300)
	add_child(_scroll)

	_content_vbox = VBoxContainer.new()
	_content_vbox.add_theme_constant_override("separation", 4)
	_content_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_scroll.add_child(_content_vbox)

	# Back button
	var back_btn := Button.new()
	back_btn.text = "Back"
	back_btn.custom_minimum_size = Vector2(140, 36)
	back_btn.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	back_btn.add_theme_font_size_override("font_size", SettingsManager.font_size)
	back_btn.pressed.connect(func() -> void: back_pressed.emit())
	add_child(back_btn)


func _tab_button(text: String) -> Button:
	var btn := Button.new()
	btn.text = text
	btn.custom_minimum_size = Vector2(120, 32)
	btn.add_theme_font_size_override("font_size", SettingsManager.font_size)
	return btn


func _switch_tab(tab: Tab) -> void:
	_tab = tab
	_refresh()


func _refresh() -> void:
	# Clear content
	for child: Node in _content_vbox.get_children():
		child.queue_free()

	# Update tab button styling
	_enemies_btn.modulate = Color.WHITE if _tab == Tab.ENEMIES else Color(0.6, 0.6, 0.6)
	_classes_btn.modulate = Color.WHITE if _tab == Tab.CLASSES else Color(0.6, 0.6, 0.6)

	match _tab:
		Tab.ENEMIES:
			_build_enemies_tab()
		Tab.CLASSES:
			_build_classes_tab()


func _build_enemies_tab() -> void:
	var enemies: Dictionary = CompendiumManager.get_seen_enemies()
	if enemies.is_empty():
		_add_entry("No enemies encountered yet.")
		return

	# Group by story
	var by_story: Dictionary = {}
	for id: String in enemies:
		var data: Dictionary = enemies[id]
		var story: String = data.get("story_id", "story_1")
		if not by_story.has(story):
			by_story[story] = []
		by_story[story].append(data)

	var story_names: Dictionary = {
		"story_1": "Story 1: The Stranger's Shadow",
		"story_2": "Story 2: Echoes in the Dark",
		"story_3": "Story 3: The Woven Night",
	}

	for story_id: String in ["story_1", "story_2", "story_3"]:
		if not by_story.has(story_id):
			continue
		_add_header(story_names.get(story_id, story_id))
		var entries: Array = by_story[story_id]
		entries.sort_custom(func(a: Dictionary, b: Dictionary) -> bool:
			return a["name"] < b["name"])
		for entry: Dictionary in entries:
			var abilities: Array = entry.get("abilities", [])
			var text: String = entry["name"]
			if not abilities.is_empty():
				text += " - " + ", ".join(abilities)
			_add_entry(text)


func _build_classes_tab() -> void:
	var classes: Dictionary = CompendiumManager.get_seen_classes()
	if classes.is_empty():
		_add_entry("No classes discovered yet.")
		return

	# Group by tier
	var by_tier: Dictionary = {0: [], 1: [], 2: []}
	for id: String in classes:
		var data: Dictionary = classes[id]
		var tier: int = int(data.get("tier", 2))
		if not by_tier.has(tier):
			by_tier[tier] = []
		by_tier[tier].append(data["display_name"])

	var tier_names: Array[String] = ["Base Classes", "Tier 1 Classes", "Tier 2 Classes"]
	for tier: int in [0, 1, 2]:
		var names: Array = by_tier.get(tier, [])
		if names.is_empty():
			continue
		_add_header(tier_names[tier])
		names.sort()
		for n: String in names:
			_add_entry(n)


func _add_header(text: String) -> void:
	var lbl := Label.new()
	lbl.text = text
	lbl.add_theme_font_size_override("font_size", 16)
	lbl.add_theme_color_override("font_color", Color(0.9, 0.8, 0.5))
	_content_vbox.add_child(lbl)


func _add_entry(text: String) -> void:
	var lbl := Label.new()
	lbl.text = "  " + text
	lbl.add_theme_font_size_override("font_size", SettingsManager.font_size)
	lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_content_vbox.add_child(lbl)
