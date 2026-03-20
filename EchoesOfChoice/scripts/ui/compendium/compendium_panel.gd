class_name CompendiumPanelNew extends VBoxContainer

## Main compendium panel with 3 tabs (Classes, Enemies, Battles).
## Shows discovered content with details, ??? for undiscovered.
## Supports both global (title menu) and save-specific (pause menu) contexts.

signal close_requested

enum Tab { CLASSES, ENEMIES, BATTLES }
enum Context { GLOBAL, SAVE_SPECIFIC }

const CompendiumListView := preload("res://scripts/ui/compendium/compendium_list_view.gd")
const DetailModalBase := preload("res://scripts/ui/compendium/detail_modal_base.gd")
const ClassDetailModal := preload("res://scripts/ui/compendium/class_detail_modal.gd")
const EnemyDetailModal := preload("res://scripts/ui/compendium/enemy_detail_modal.gd")
const BattleDetailModal := preload("res://scripts/ui/compendium/battle_detail_modal.gd")

var current_tab: Tab = Tab.CLASSES
var context_mode: Context = Context.GLOBAL
var save_slot: int = -1  ## -1 = global, 0-2 = specific save
var grid_columns: int = 5  ## Columns for card grid
var items_per_page: int = 10  ## Cards per page (2 rows × 5 columns)

var _classes_btn: Button
var _enemies_btn: Button
var _battles_btn: Button
var _list_view: CompendiumListView
var _active_modal: DetailModalBase
var _FighterDB := preload("res://scripts/data/fighter_db.gd")
var _BattleDB := preload("res://scripts/data/battle_db.gd")
var _EnemyRouter := preload("res://scripts/data/enemy_db_router.gd")


func _ready() -> void:
	add_theme_constant_override("separation", 12)
	_build_ui()
	refresh_data()


func set_context(ctx: Context, slot: int = -1) -> void:
	context_mode = ctx
	save_slot = slot
	if is_node_ready():
		refresh_data()


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

	_classes_btn = _create_tab_button("Classes")
	_classes_btn.pressed.connect(func() -> void: _switch_tab(Tab.CLASSES))
	tab_row.add_child(_classes_btn)

	_enemies_btn = _create_tab_button("Enemies")
	_enemies_btn.pressed.connect(func() -> void: _switch_tab(Tab.ENEMIES))
	tab_row.add_child(_enemies_btn)

	_battles_btn = _create_tab_button("Battles")
	_battles_btn.pressed.connect(func() -> void: _switch_tab(Tab.BATTLES))
	tab_row.add_child(_battles_btn)

	# List view
	_list_view = CompendiumListView.new()
	_list_view.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_list_view.card_clicked.connect(_on_card_clicked)
	add_child(_list_view)

	# Back button
	var back_btn := Button.new()
	back_btn.text = "Back"
	back_btn.custom_minimum_size = Vector2(140, 36)
	back_btn.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	back_btn.add_theme_font_size_override("font_size", SettingsManager.font_size)
	back_btn.pressed.connect(func() -> void: close_requested.emit())
	add_child(back_btn)


func _create_tab_button(label: String) -> Button:
	var btn := Button.new()
	btn.text = label
	btn.custom_minimum_size = Vector2(120, 32)
	btn.add_theme_font_size_override("font_size", SettingsManager.font_size)
	return btn


func _switch_tab(tab: Tab) -> void:
	current_tab = tab
	refresh_data()


func refresh_data() -> void:
	if not is_node_ready():
		return

	# Update tab button styling
	_classes_btn.modulate = Color.WHITE if current_tab == Tab.CLASSES else Color(0.6, 0.6, 0.6)
	_enemies_btn.modulate = Color.WHITE if current_tab == Tab.ENEMIES else Color(0.6, 0.6, 0.6)
	_battles_btn.modulate = Color.WHITE if current_tab == Tab.BATTLES else Color(0.6, 0.6, 0.6)

	# Get data from CompendiumManager based on context
	var discoveries: Dictionary
	if context_mode == Context.GLOBAL:
		discoveries = CompendiumManager.get_global_discoveries()
	else:
		discoveries = CompendiumManager.get_save_discoveries(save_slot)

	# Build content for active tab
	match current_tab:
		Tab.CLASSES:
			_build_classes_tab(discoveries)
		Tab.ENEMIES:
			_build_enemies_tab(discoveries)
		Tab.BATTLES:
			_build_battles_tab(discoveries)


func _build_classes_tab(discoveries: Dictionary) -> void:
	var discovered_classes: Dictionary = discoveries.get("classes", {})
	var all_class_ids: Array = _get_all_class_ids()

	var items: Array = []
	for class_id: String in all_class_ids:
		var is_discovered := discovered_classes.has(class_id)
		var abilities: Array = []
		if is_discovered:
			for a: RefCounted in _FighterDB.get_abilities_for_class(class_id):
				abilities.append({
					"name": a.ability_name,
					"description": a.get_description(),
					"mana_cost": a.mana_cost,
					"cooldown": a.cooldown,
				})
		var item_dict := {
			"is_discovered": is_discovered,
			"data": {
				"class_id": class_id,
				"name": _FighterDB.get_display_name(class_id) if is_discovered else "???",
				"tier": CompendiumManager.get_tier(class_id),
				"portrait_path": _get_class_portrait_path(class_id) if is_discovered else "",
				"flavor_text": "",
				"abilities": abilities,
				"display_name": _FighterDB.get_display_name(class_id) if is_discovered else "???",
			}
		}
		items.append(item_dict)

	_list_view.set_items(items, items_per_page, grid_columns)


func _build_enemies_tab(discoveries: Dictionary) -> void:
	var discovered_enemies: Dictionary = discoveries.get("enemies", {})

	var items: Array = []
	for class_id: String in discovered_enemies:
		var enemy_data: Dictionary = discovered_enemies[class_id]
		var abilities: Array = []
		var flavor_text := ""
		var fighter: RefCounted = _EnemyRouter.create_enemy(class_id)
		if fighter:
			for a: RefCounted in fighter.abilities:
				abilities.append({
					"name": a.ability_name,
					"description": a.get_description(),
					"mana_cost": a.mana_cost,
					"cooldown": a.cooldown,
				})
			flavor_text = fighter.flavor_text
		var item_dict := {
			"is_discovered": true,
			"data": {
				"class_id": class_id,
				"name": enemy_data.get("name", "Unknown"),
				"portrait_path": _get_enemy_portrait_path(class_id),
				"story_id": enemy_data.get("story_id", "story_1"),
				"abilities": abilities,
				"flavor_text": flavor_text,
			}
		}
		items.append(item_dict)

	# Sort by story, then by name
	items.sort_custom(func(a: Dictionary, b: Dictionary) -> bool:
		var story_a: String = a["data"].get("story_id", "")
		var story_b: String = b["data"].get("story_id", "")
		if story_a != story_b:
			return story_a < story_b
		return a["data"].get("name", "") < b["data"].get("name", "")
	)

	_list_view.set_items(items, items_per_page, grid_columns)


func _build_battles_tab(discoveries: Dictionary) -> void:
	var completed_battles: Dictionary = discoveries.get("battles", {})

	var items: Array = []
	for battle_id: String in completed_battles:
		# Load real battle data
		var battle := _BattleDB.create_battle(battle_id)
		var scene_image := ""
		var flavor_text := ""
		var enemy_names: Array[String] = []
		if battle:
			scene_image = battle.scene_image
			flavor_text = battle.pre_battle_text[0] if not battle.pre_battle_text.is_empty() else ""
			# Deduplicated enemy type names
			var seen_types: Dictionary = {}
			for enemy: RefCounted in battle.enemies:
				if not seen_types.has(enemy.character_type):
					seen_types[enemy.character_type] = true
					enemy_names.append(enemy.character_type)

		var item_dict := {
			"is_discovered": true,
			"data": {
				"battle_id": battle_id,
				"name": CompendiumManager.format_battle_name(battle_id),
				"portrait_path": scene_image,
				"scene_image": scene_image,
				"flavor_text": flavor_text,
				"story_id": _guess_story_from_battle_id(battle_id),
				"enemy_names": enemy_names,
			}
		}
		items.append(item_dict)

	_list_view.set_items(items, items_per_page, grid_columns)


func _on_card_clicked(item_data: Dictionary, is_discovered: bool) -> void:
	if not is_discovered:
		return

	# Close any existing modal first
	if _active_modal and is_instance_valid(_active_modal):
		var layer: Node = _active_modal.get_parent()
		if layer:
			layer.queue_free()
		_active_modal = null

	# Open appropriate detail modal
	var modal: DetailModalBase
	match current_tab:
		Tab.CLASSES:
			var discoveries: Dictionary
			if context_mode == Context.GLOBAL:
				discoveries = CompendiumManager.get_global_discoveries()
			else:
				discoveries = CompendiumManager.get_save_discoveries(save_slot)
			modal = ClassDetailModal.new(item_data, discoveries.get("classes", {}), context_mode == Context.GLOBAL)
		Tab.ENEMIES:
			modal = EnemyDetailModal.new(item_data)
		Tab.BATTLES:
			modal = BattleDetailModal.new(item_data)

	if modal:
		_active_modal = modal
		modal.close_requested.connect(_on_modal_closed)
		# Add modal on a CanvasLayer above everything (including pause overlay at 99)
		var layer := CanvasLayer.new()
		layer.layer = 110
		layer.name = "CompendiumModalLayer"
		get_tree().root.add_child(layer)
		layer.add_child(modal)


func _on_modal_closed() -> void:
	# Clean up the CanvasLayer when modal closes
	if _active_modal and is_instance_valid(_active_modal):
		var layer: Node = _active_modal.get_parent()
		if layer:
			layer.queue_free()
	_active_modal = null


## Get all class IDs (T0, T1, T2) for the compendium
func _get_all_class_ids() -> Array:
	return [
		# T0
		"Squire", "Mage", "Entertainer", "Tinker", "Wildling", "Wanderer",
		# T1
		"Duelist", "Ranger", "MartialArtist",
		"Invoker", "Acolyte",
		"Bard", "Dervish", "Orator",
		"Artificer", "Cosmologist", "Arithmancer",
		"Herbalist", "Shaman", "Beastcaller",
		"Sentinel", "Pathfinder",
		# T2 (complete list)
		"Cavalry", "Dragoon", "Mercenary", "Hunter", "Ninja", "Monk",
		"Infernalist", "Tidecaller", "Tempest", "Paladin", "Priest", "Warlock",
		"Warcrier", "Minstrel", "Illusionist", "Mime", "Laureate", "Elegist",
		"Alchemist", "Bombardier", "Chronomancer", "Astronomer", "Automaton", "Technomancer",
		"Blighter", "GroveKeeper", "WitchDoctor", "Spiritwalker", "Falconer", "Shapeshifter",
		"Bulwark", "Aegis", "Trailblazer", "Survivalist",
	]


func _get_class_portrait_path(class_id: String) -> String:
	# Default to male variant for compendium
	return "res://assets/art/portraits/classes/%s_m.png" % class_id.to_lower()


func _get_enemy_portrait_path(class_id: String) -> String:
	return "res://assets/art/portraits/enemies/%s.png" % class_id.to_lower()


func _guess_story_from_battle_id(battle_id: String) -> String:
	if battle_id.begins_with("s2_"):
		return "story_2"
	elif battle_id.begins_with("s3_"):
		return "story_3"
	return "story_1"
