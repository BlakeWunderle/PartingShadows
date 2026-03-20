class_name ClassDetailModal extends DetailModalBase

## Detail modal for class entries: portrait, stats, abilities, flavor text, tier tree.

var class_data: Dictionary = {}
var discovered_classes: Dictionary = {}  ## class_id -> discovered status
var is_global: bool = false  ## True when viewed from title screen (no "YOU ARE HERE")
var _FighterDB := preload("res://scripts/data/fighter_db.gd")
var _FighterDBT1 := preload("res://scripts/data/fighter_db_t1.gd")
var _FighterDBT2 := preload("res://scripts/data/fighter_db_t2.gd")


func _init(data: Dictionary, discovered: Dictionary, global: bool = false) -> void:
	class_data = data
	discovered_classes = discovered
	is_global = global


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

	# Flavor text
	var flavor_label := Label.new()
	flavor_label.text = class_data.get("flavor_text", "A skilled fighter ready for battle.")
	flavor_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	flavor_label.add_theme_font_size_override("font_size", SettingsManager.font_size)
	flavor_label.add_theme_color_override("font_color", Color(0.9, 0.9, 0.8))
	info_panel.add_child(flavor_label)

	# Separator
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


func _build_tier_tree(container: VBoxContainer) -> void:
	var class_id: String = class_data.get("class_id", "")
	var tier: int = class_data.get("tier", 0)

	# Find the T0 root for this class
	var t0_class: String = _get_t0_root(class_id, tier)

	# Build tree from T0
	if not t0_class.is_empty():
		_add_tree_node(container, t0_class, 0, class_id)


func _get_t0_root(class_id: String, tier: int) -> String:
	if tier == 0:
		return class_id

	# Map T1/T2 to their T0 root
	var t1_to_t0 := {
		"Duelist": "Squire", "Ranger": "Squire", "MartialArtist": "Squire",
		"Invoker": "Mage", "Acolyte": "Mage",
		"Bard": "Entertainer", "Dervish": "Entertainer", "Orator": "Entertainer",
		"Artificer": "Tinker", "Cosmologist": "Tinker", "Arithmancer": "Tinker",
		"Herbalist": "Wildling", "Shaman": "Wildling", "Beastcaller": "Wildling",
		"Sentinel": "Wanderer", "Pathfinder": "Wanderer",
	}

	if tier == 1:
		return t1_to_t0.get(class_id, "")

	# T2 -> T1 mapping
	var t2_to_t1 := {
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

	# T2 - find parent T1 first, then T0
	var t1_parent: String = t2_to_t1.get(class_id, "")
	if not t1_parent.is_empty():
		return t1_to_t0.get(t1_parent, "")

	return ""


func _add_tree_node(container: VBoxContainer, node_class_id: String, indent: int, current_class_id: String) -> void:
	var is_current := (node_class_id == current_class_id)
	var is_discovered := discovered_classes.has(node_class_id)

	var node_label := Label.new()
	var indent_str := "  ".repeat(indent)
	var display_name: String = node_class_id if not is_discovered else _FighterDB.get_display_name(node_class_id)

	if not is_discovered:
		node_label.text = indent_str + "??? (Undiscovered)"
		node_label.add_theme_color_override("font_color", Color(0.5, 0.5, 0.5))
	elif is_current and not is_global:
		node_label.text = indent_str + "► " + display_name + " (YOU ARE HERE)"
		node_label.add_theme_color_override("font_color", Color(0.9, 0.8, 0.5))
	else:
		node_label.text = indent_str + display_name
		node_label.add_theme_color_override("font_color", Color.WHITE)

	node_label.add_theme_font_size_override("font_size", SettingsManager.font_size)
	container.add_child(node_label)

	# Get children (upgrade options)
	var children: Array = _get_upgrade_options(node_class_id)
	for child_id: String in children:
		_add_tree_node(container, child_id, indent + 1, current_class_id)


func _get_upgrade_options(class_id: String) -> Array:
	# Get upgrade items for this class
	var upgrade_items: Array = _FighterDB.get_default_upgrade_items(class_id)
	return upgrade_items
