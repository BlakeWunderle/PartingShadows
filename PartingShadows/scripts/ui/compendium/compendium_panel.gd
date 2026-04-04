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
const Registry := preload("res://scripts/ui/compendium/compendium_registry.gd")

var current_tab: Tab = Tab.CLASSES
var context_mode: Context = Context.GLOBAL
var save_slot: int = -1  ## -1 = global, 0-2 = specific save
var grid_columns: int = 5  ## Columns for card grid
var items_per_page: int = 10  ## Cards per page (2 rows × 5 columns)

var _classes_btn: Button
var _enemies_btn: Button
var _battles_btn: Button
var _back_btn: Button
var _list_view: CompendiumListView
var _active_modal: DetailModalBase
var _FighterDB: GDScript
var _BattleDB: GDScript
var _EnemyRouter: GDScript


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
	title.add_theme_color_override("font_color", Color.WHITE)
	title.add_theme_constant_override("outline_size", 2)
	title.add_theme_color_override("font_outline_color", Color.BLACK)
	title.add_theme_constant_override("shadow_offset_x", 3)
	title.add_theme_constant_override("shadow_offset_y", 3)
	title.add_theme_color_override("font_shadow_color", Color(0.0, 0.0, 0.0, 0.85))
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

	# Wire tab focus neighbors (left/right between tabs)
	_classes_btn.focus_neighbor_right = _enemies_btn.get_path()
	_enemies_btn.focus_neighbor_left = _classes_btn.get_path()
	_enemies_btn.focus_neighbor_right = _battles_btn.get_path()
	_battles_btn.focus_neighbor_left = _enemies_btn.get_path()

	# List view
	_list_view = CompendiumListView.new()
	_list_view.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_list_view.card_clicked.connect(_on_card_clicked)
	add_child(_list_view)

	# Back button
	_back_btn = Button.new()
	_back_btn.text = "Back"
	_back_btn.custom_minimum_size = Vector2(140, 36)
	_back_btn.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	_back_btn.add_theme_font_size_override("font_size", SettingsManager.font_size)
	_back_btn.pressed.connect(func() -> void: close_requested.emit())
	_apply_focus_style(_back_btn)
	add_child(_back_btn)

	# Wire pagination → back button
	_list_view.set_bottom_neighbor(_back_btn)
	_back_btn.focus_neighbor_top = _list_view.get_pagination_target().get_path()

	# Wire tabs ↔ card grid (d-pad up from top row → tabs, d-pad down from tabs → cards)
	_list_view.set_top_neighbor(_enemies_btn)
	_classes_btn.focus_neighbor_bottom = _list_view.get_first_card_path()
	_enemies_btn.focus_neighbor_bottom = _list_view.get_first_card_path()
	_battles_btn.focus_neighbor_bottom = _list_view.get_first_card_path()


func _create_tab_button(label: String) -> Button:
	var btn := Button.new()
	btn.text = label
	btn.custom_minimum_size = Vector2(120, 32)
	btn.add_theme_font_size_override("font_size", SettingsManager.font_size)
	_apply_focus_style(btn)
	return btn


## Apply a gold-border focus style to a button so controller users can see focus.
static func _apply_focus_style(btn: Button) -> void:
	var focus_sb := StyleBoxFlat.new()
	focus_sb.bg_color = Color(0.2, 0.2, 0.3, 0.9)
	focus_sb.border_color = Color.WHITE
	focus_sb.set_border_width_all(3)
	focus_sb.set_corner_radius_all(4)
	focus_sb.set_content_margin_all(6)
	btn.add_theme_stylebox_override("focus", focus_sb)


func _input(event: InputEvent) -> void:
	if not visible:
		return
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		close_requested.emit()
		return
	if event is InputEventJoypadButton and event.pressed:
		if event.button_index == JOY_BUTTON_LEFT_SHOULDER:
			_switch_tab(wrapi(current_tab - 1, 0, 3) as Tab)
			get_viewport().set_input_as_handled()
		elif event.button_index == JOY_BUTTON_RIGHT_SHOULDER:
			_switch_tab(wrapi(current_tab + 1, 0, 3) as Tab)
			get_viewport().set_input_as_handled()


func _switch_tab(tab: Tab) -> void:
	current_tab = tab
	refresh_data()


func _ensure_data_loaded() -> void:
	if _FighterDB == null:
		_FighterDB = load("res://scripts/data/fighter_db.gd")
		_BattleDB = load("res://scripts/data/battle_db.gd")
		_EnemyRouter = load("res://scripts/data/enemy_db_router.gd")


func refresh_data() -> void:
	if not is_node_ready():
		return
	_ensure_data_loaded()

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

	# Re-wire cross-component focus after cards are rebuilt
	_rewire_focus()


func _build_classes_tab(discoveries: Dictionary) -> void:
	var discovered_classes: Dictionary = discoveries.get("classes", {})
	var all_class_ids: Array = Registry.get_all_class_ids()

	var items: Array = []
	for class_id: String in all_class_ids:
		var is_discovered := discovered_classes.has(class_id)
		var abilities: Array = []
		if is_discovered:
			for a: RefCounted in _FighterDB.get_abilities_for_class(class_id):
				abilities.append({
					"name": a.ability_name,
					"description": a.get_compendium_description(),
					"mana_cost": a.mana_cost,

				})
		var _paths: Dictionary = Registry.get_class_portrait_paths(class_id) if is_discovered else {}
		var item_dict := {
			"is_discovered": is_discovered,
			"data": {
				"class_id": class_id,
				"name": _FighterDB.get_display_name(class_id) if is_discovered else "???",
				"tier": CompendiumManager.get_tier(class_id),
				"portrait_path": Registry.get_class_portrait_path(class_id) if is_discovered else "",
				"portrait_path_m": _paths.get("m", ""),
				"portrait_path_f": _paths.get("f", ""),
				"flavor_text": _FighterDB.get_flavor_text(class_id) if is_discovered else "",
				"abilities": abilities,
				"display_name": _FighterDB.get_display_name(class_id) if is_discovered else "???",
			}
		}
		items.append(item_dict)

	_list_view.set_items(items, items_per_page, grid_columns)


func _build_enemies_tab(discoveries: Dictionary) -> void:
	var discovered_enemies: Dictionary = discoveries.get("enemies", {})
	var all_enemies: Array = Registry.get_all_enemy_ids()

	# Build enemy -> battle scene image mapping from completed battles
	var enemy_battle_images: Dictionary = {}
	var completed_battles: Dictionary = discoveries.get("battles", {})
	for battle_id: String in completed_battles:
		var battle = _BattleDB.create_battle(battle_id)
		if battle and not battle.scene_image.is_empty():
			for enemy: RefCounted in battle.enemies:
				if not enemy_battle_images.has(enemy.class_id):
					enemy_battle_images[enemy.class_id] = battle.scene_image

	var items: Array = []
	for entry: Dictionary in all_enemies:
		var class_id: String = entry["class_id"]
		var story_id: String = entry["story_id"]
		var is_discovered := discovered_enemies.has(class_id)
		var abilities: Array = []
		var flavor_text := ""
		if is_discovered:
			var fighter: RefCounted = _EnemyRouter.create_enemy(class_id)
			if fighter:
				for a: RefCounted in fighter.abilities:
					abilities.append({
						"name": a.ability_name,
						"description": a.get_compendium_description(),
						"mana_cost": a.mana_cost,

					})
				flavor_text = fighter.flavor_text
		var item_dict := {
			"is_discovered": is_discovered,
			"data": {
				"class_id": class_id,
				"name": discovered_enemies[class_id].get("name", class_id) if is_discovered else "???",
				"portrait_path": Registry.get_enemy_portrait_path(class_id) if is_discovered else "",
				"story_id": story_id,
				"abilities": abilities,
				"flavor_text": flavor_text,
				"scene_image": enemy_battle_images.get(class_id, "") if is_discovered else "",
			}
		}
		items.append(item_dict)

	_list_view.set_items(items, items_per_page, grid_columns)


func _build_battles_tab(discoveries: Dictionary) -> void:
	var completed_battles: Dictionary = discoveries.get("battles", {})
	var all_battles: Array = Registry.get_all_battle_ids()

	var items: Array = []
	for battle_id: String in all_battles:
		var is_completed := completed_battles.has(battle_id)
		var scene_image := ""
		var flavor_text := ""
		var enemies_info: Array = []
		if is_completed:
			var battle = _BattleDB.create_battle(battle_id)
			if battle:
				scene_image = battle.scene_image
				flavor_text = battle.pre_battle_text[0] if not battle.pre_battle_text.is_empty() else ""
				var seen_types: Dictionary = {}
				for enemy: RefCounted in battle.enemies:
					if not seen_types.has(enemy.character_type):
						seen_types[enemy.character_type] = true
						enemies_info.append({
							"name": enemy.character_type,
							"portrait_path": Registry.get_enemy_portrait_path(enemy.class_id),
						})

		var item_dict := {
			"is_discovered": is_completed,
			"data": {
				"battle_id": battle_id,
				"name": CompendiumManager.format_battle_name(battle_id) if is_completed else "???",
				"portrait_path": scene_image,
				"scene_image": scene_image,
				"flavor_text": flavor_text,
				"story_id": Registry.guess_story_from_battle_id(battle_id),
				"enemies_info": enemies_info,
			}
		}
		items.append(item_dict)

	_list_view.set_items(items, items_per_page, grid_columns)


func _rewire_focus() -> void:
	var card_path: NodePath = _list_view.get_first_card_path()
	if not card_path.is_empty():
		_classes_btn.focus_neighbor_bottom = card_path
		_enemies_btn.focus_neighbor_bottom = card_path
		_battles_btn.focus_neighbor_bottom = card_path
		_list_view.set_top_neighbor(_enemies_btn)
	_list_view.set_bottom_neighbor(_back_btn)
	_back_btn.focus_neighbor_top = _list_view.get_pagination_target().get_path()


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
	# Defer focus grab so the modal CanvasLayer is fully freed first
	_list_view.grab_card_focus.call_deferred()
