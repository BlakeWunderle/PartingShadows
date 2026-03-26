class_name ClassDetailModal extends DetailModalBase

## Detail modal for class entries: portrait, stats, abilities, flavor text, tier tree.

var class_data: Dictionary = {}
var discovered_classes: Dictionary = {}  ## class_id -> discovered status
var is_global: bool = false  ## True when viewed from title screen (no "YOU ARE HERE")
const Registry := preload("res://scripts/ui/compendium/compendium_registry.gd")
var _FighterDB := preload("res://scripts/data/fighter_db.gd")
var _FighterDBT1 := preload("res://scripts/data/fighter_db_t1.gd")
var _FighterDBT2 := preload("res://scripts/data/fighter_db_t2.gd")
var _focusable_rows: Array[Dictionary] = []  ## [{row: HBoxContainer, class_id: String}]


func _init(data: Dictionary, discovered: Dictionary, global: bool = false) -> void:
	class_data = data
	discovered_classes = discovered
	is_global = global


func _input(event: InputEvent) -> void:
	if not is_inside_tree():
		return
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("confirm"):
		for entry: Dictionary in _focusable_rows:
			var row: HBoxContainer = entry["row"]
			if is_instance_valid(row) and row.has_focus():
				_navigate_to_class(entry["class_id"])
				return
	super._input(event)


func build_content(container: VBoxContainer) -> void:
	# Split into left (portrait + tree) and right (info)
	var hbox := HBoxContainer.new()
	hbox.add_theme_constant_override("separation", 20)
	hbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
	container.add_child(hbox)

	# Left side
	var left_panel := VBoxContainer.new()
	left_panel.add_theme_constant_override("separation", 12)
	left_panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hbox.add_child(left_panel)

	# Portrait
	var portrait := TextureRect.new()
	portrait.custom_minimum_size = Vector2(200, 200)
	portrait.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	portrait.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

	var portrait_path: String = class_data.get("portrait_path", "")
	if portrait_path.is_empty() or not ResourceLoader.exists(portrait_path):
		portrait_path = "res://assets/art/ui/placeholder_portrait.png"
	if ResourceLoader.exists(portrait_path):
		portrait.texture = load(portrait_path)

	left_panel.add_child(portrait)

	# Tier tree
	var tree_label := Label.new()
	tree_label.text = "Class Tree"
	tree_label.add_theme_font_size_override("font_size", SettingsManager.font_size + 2)
	tree_label.add_theme_color_override("font_color", Color(0.9, 0.8, 0.5))
	left_panel.add_child(tree_label)

	var tree_container := VBoxContainer.new()
	tree_container.add_theme_constant_override("separation", 4)
	_build_tier_tree(tree_container)
	left_panel.add_child(tree_container)

	# Right side: Info panel
	var info_panel := VBoxContainer.new()
	info_panel.add_theme_constant_override("separation", 8)
	info_panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	info_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	hbox.add_child(info_panel)

	# Name and tier
	var name_label := Label.new()
	var tier: int = class_data.get("tier", 0)
	var tier_names: Array[String] = ["Base Class", "Tier 1", "Tier 2"]
	var tier_text: String = tier_names[clampi(tier, 0, tier_names.size() - 1)]
	name_label.text = class_data.get("display_name", "Unknown") + " (" + tier_text + ")"
	name_label.add_theme_font_size_override("font_size", 20)
	name_label.add_theme_color_override("font_color", Color(0.9, 0.8, 0.5))
	name_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	info_panel.add_child(name_label)

	# Separator
	var sep := HSeparator.new()
	info_panel.add_child(sep)

	# Flavor text (only if present)
	var flavor: String = class_data.get("flavor_text", "")
	if not flavor.is_empty():
		var flavor_label := Label.new()
		flavor_label.text = flavor
		flavor_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		flavor_label.add_theme_font_size_override("font_size", SettingsManager.font_size)
		flavor_label.add_theme_color_override("font_color", Color(0.9, 0.9, 0.8))
		info_panel.add_child(flavor_label)
		var sep2 := HSeparator.new()
		info_panel.add_child(sep2)

	# Abilities
	var abilities_label := Label.new()
	abilities_label.text = "Abilities:"
	abilities_label.add_theme_font_size_override("font_size", SettingsManager.font_size + 2)
	abilities_label.add_theme_color_override("font_color", Color(0.9, 0.8, 0.5))
	info_panel.add_child(abilities_label)

	var abilities: Array = class_data.get("abilities", [])
	if abilities.is_empty():
		var none_label := Label.new()
		none_label.text = "  (No abilities data)"
		none_label.add_theme_font_size_override("font_size", SettingsManager.font_size)
		none_label.add_theme_color_override("font_color", Color(0.6, 0.6, 0.6))
		info_panel.add_child(none_label)
	for ability: Dictionary in abilities:
		var name_text: String = "  • " + ability.get("name", "???")
		var cost: int = ability.get("mana_cost", 0)
		if cost > 0:
			name_text += "  (%d MP)" % cost
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


func _build_tier_tree(container: VBoxContainer) -> void:
	var class_id: String = class_data.get("class_id", "")
	var tier: int = class_data.get("tier", 0)

	if tier == 0:
		# T0: show this class → clickable T1 children only
		_add_tree_row(container, class_id, 0, class_id)
		for t1_id: String in _get_t1_children(class_id):
			_add_clickable_tree_row(container, t1_id, 1, class_id)
	elif tier == 1:
		# T1: show T0 parent → this T1 → T2 children
		var t0: String = _t1_to_t0().get(class_id, "")
		_add_clickable_tree_row(container, t0, 0, class_id)
		_add_tree_row(container, class_id, 1, class_id)
		for t2_id: String in _get_t2_children(class_id):
			_add_clickable_tree_row(container, t2_id, 2, class_id)
	else:
		# T2: show T0 → parent T1 → this T2
		var t1: String = _t2_to_t1().get(class_id, "")
		var t0: String = _t1_to_t0().get(t1, "")
		_add_clickable_tree_row(container, t0, 0, class_id)
		_add_clickable_tree_row(container, t1, 1, class_id)
		_add_tree_row(container, class_id, 2, class_id)


## Add a tree row with portrait (non-clickable, for the current class).
func _add_tree_row(container: VBoxContainer, node_class_id: String, indent: int, current_class_id: String) -> void:
	var is_discovered := discovered_classes.has(node_class_id)
	var display_name: String = _FighterDB.get_display_name(node_class_id) if is_discovered else "???"

	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 6)
	if indent > 0:
		var spacer := Control.new()
		spacer.custom_minimum_size = Vector2(20 * indent, 0)
		row.add_child(spacer)
	container.add_child(row)

	_add_portrait_thumb(row, node_class_id, is_discovered, display_name)

	var node_label := Label.new()
	if not is_discovered:
		node_label.text = "???"
		node_label.add_theme_color_override("font_color", Color(0.5, 0.5, 0.5))
	else:
		node_label.text = display_name
		node_label.add_theme_color_override("font_color", Color.WHITE)
	node_label.add_theme_font_size_override("font_size", SettingsManager.font_size)
	node_label.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	row.add_child(node_label)


## Add a clickable tree row that navigates to that class's modal on click.
func _add_clickable_tree_row(container: VBoxContainer, node_class_id: String, indent: int, current_class_id: String) -> void:
	var is_discovered := discovered_classes.has(node_class_id)
	var display_name: String = _FighterDB.get_display_name(node_class_id) if is_discovered else "???"

	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 6)
	if indent > 0:
		var spacer := Control.new()
		spacer.custom_minimum_size = Vector2(20 * indent, 0)
		row.add_child(spacer)
	container.add_child(row)

	_add_portrait_thumb(row, node_class_id, is_discovered, display_name)

	var node_label := Label.new()
	if not is_discovered:
		node_label.text = "???"
		node_label.add_theme_color_override("font_color", Color(0.5, 0.5, 0.5))
	else:
		node_label.text = display_name
		node_label.add_theme_color_override("font_color", Color.WHITE)
	node_label.add_theme_font_size_override("font_size", SettingsManager.font_size)
	node_label.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	row.add_child(node_label)

	# Make discovered rows clickable/focusable to navigate
	if is_discovered:
		row.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		row.focus_mode = Control.FOCUS_ALL
		_focusable_rows.append({"row": row, "class_id": node_class_id})
		# Focus highlight
		var highlight := ColorRect.new()
		highlight.color = Color(0.3, 0.5, 0.8, 0.2)
		highlight.visible = false
		highlight.set_anchors_preset(Control.PRESET_FULL_RECT)
		highlight.mouse_filter = Control.MOUSE_FILTER_IGNORE
		row.add_child(highlight)
		row.focus_entered.connect(func() -> void:
			highlight.visible = true
			node_label.add_theme_color_override("font_color", Color(0.5, 0.75, 1.0))
		)
		row.focus_exited.connect(func() -> void:
			highlight.visible = false
			node_label.add_theme_color_override("font_color", Color.WHITE)
		)
		row.gui_input.connect(func(event: InputEvent) -> void:
			if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
				_navigate_to_class(node_class_id)
				row.accept_event()
		)


## Navigate to another class modal by replacing this one.
func _navigate_to_class(target_class_id: String) -> void:
	var tier: int = CompendiumManager.get_tier(target_class_id)
	var abilities: Array = []
	for a: RefCounted in _FighterDB.get_abilities_for_class(target_class_id):
		abilities.append({
			"name": a.ability_name,
			"description": a.get_compendium_description(),
			"mana_cost": a.mana_cost,
		})
	var target_data := {
		"class_id": target_class_id,
		"display_name": _FighterDB.get_display_name(target_class_id),
		"name": _FighterDB.get_display_name(target_class_id),
		"tier": tier,
		"portrait_path": Registry.get_class_portrait_path(target_class_id),
		"flavor_text": _FighterDB.get_flavor_text(target_class_id),
		"abilities": abilities,
	}

	# Get the CanvasLayer parent, spawn new modal, close this one
	var layer: Node = get_parent()
	var new_modal := ClassDetailModal.new(target_data, discovered_classes, is_global)
	new_modal.close_requested.connect(func() -> void:
		if layer:
			layer.queue_free()
	)
	# Remove self and add new modal to same layer
	layer.remove_child(self)
	layer.add_child(new_modal)
	queue_free()


func _add_portrait_thumb(row: HBoxContainer, class_id: String, is_discovered: bool, display_name: String) -> void:
	var thumb := TextureRect.new()
	thumb.custom_minimum_size = Vector2(48, 48)
	thumb.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	thumb.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	if is_discovered:
		var path: String = "res://assets/art/portraits/classes/%s_m.png" % Registry.to_portrait_key(display_name)
		if ResourceLoader.exists(path):
			thumb.texture = load(path)
	row.add_child(thumb)


static func _t1_to_t0() -> Dictionary:
	return {
		"Duelist": "Squire", "Ranger": "Squire", "MartialArtist": "Squire",
		"Invoker": "Mage", "Acolyte": "Mage",
		"Bard": "Entertainer", "Dervish": "Entertainer", "Orator": "Entertainer",
		"Artificer": "Tinker", "Cosmologist": "Tinker", "Arithmancer": "Tinker",
		"Herbalist": "Wildling", "Shaman": "Wildling", "Beastcaller": "Wildling",
		"Sentinel": "Wanderer", "Pathfinder": "Wanderer",
	}


static func _t2_to_t1() -> Dictionary:
	return {
		"Cavalry": "Duelist", "Dragoon": "Duelist",
		"Mercenary": "Ranger", "Hunter": "Ranger",
		"Ninja": "MartialArtist", "Monk": "MartialArtist",
		"Infernalist": "Invoker", "Tidecaller": "Invoker", "Tempest": "Invoker",
		"Paladin": "Acolyte", "Priest": "Acolyte", "Warlock": "Acolyte",
		"Warcrier": "Bard", "Minstrel": "Bard",
		"Illusionist": "Dervish", "Mime": "Dervish",
		"Laureate": "Orator", "Elegist": "Orator",
		"Alchemist": "Artificer", "Bombardier": "Artificer",
		"Chronomancer": "Cosmologist", "Astronomer": "Cosmologist",
		"Automaton": "Arithmancer", "Technomancer": "Arithmancer",
		"Blighter": "Herbalist", "GroveKeeper": "Herbalist",
		"WitchDoctor": "Shaman", "Spiritwalker": "Shaman",
		"Falconer": "Beastcaller", "Shapeshifter": "Beastcaller",
		"Bulwark": "Sentinel", "Aegis": "Sentinel",
		"Trailblazer": "Pathfinder", "Survivalist": "Pathfinder",
	}


static func _get_t1_children(t0_id: String) -> Array[String]:
	var mapping := _t1_to_t0()
	var children: Array[String] = []
	for t1_id: String in mapping:
		if mapping[t1_id] == t0_id:
			children.append(t1_id)
	return children


static func _get_t2_children(t1_id: String) -> Array[String]:
	var mapping := _t2_to_t1()
	var children: Array[String] = []
	for t2_id: String in mapping:
		if mapping[t2_id] == t1_id:
			children.append(t2_id)
	return children
