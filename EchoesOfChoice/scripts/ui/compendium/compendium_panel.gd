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
var _back_btn: Button
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

	# Re-wire cross-component focus after cards are rebuilt
	_rewire_focus()


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
					"description": a.get_compendium_description(),
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
				"flavor_text": _FighterDB.get_flavor_text(class_id) if is_discovered else "",
				"abilities": abilities,
				"display_name": _FighterDB.get_display_name(class_id) if is_discovered else "???",
			}
		}
		items.append(item_dict)

	_list_view.set_items(items, items_per_page, grid_columns)


func _build_enemies_tab(discoveries: Dictionary) -> void:
	var discovered_enemies: Dictionary = discoveries.get("enemies", {})
	var all_enemies: Array = _get_all_enemy_ids()

	# Build enemy -> battle scene image mapping from completed battles
	var enemy_battle_images: Dictionary = {}
	var completed_battles: Dictionary = discoveries.get("battles", {})
	for battle_id: String in completed_battles:
		var battle := _BattleDB.create_battle(battle_id)
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
						"cooldown": a.cooldown,
					})
				flavor_text = fighter.flavor_text
		var item_dict := {
			"is_discovered": is_discovered,
			"data": {
				"class_id": class_id,
				"name": discovered_enemies[class_id].get("name", class_id) if is_discovered else "???",
				"portrait_path": _get_enemy_portrait_path(class_id) if is_discovered else "",
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
	var all_battles: Array = _get_all_battle_ids()

	var items: Array = []
	for battle_id: String in all_battles:
		var is_completed := completed_battles.has(battle_id)
		var scene_image := ""
		var flavor_text := ""
		var enemies_info: Array = []
		if is_completed:
			var battle := _BattleDB.create_battle(battle_id)
			if battle:
				scene_image = battle.scene_image
				flavor_text = battle.pre_battle_text[0] if not battle.pre_battle_text.is_empty() else ""
				var seen_types: Dictionary = {}
				for enemy: RefCounted in battle.enemies:
					if not seen_types.has(enemy.character_type):
						seen_types[enemy.character_type] = true
						enemies_info.append({
							"name": enemy.character_type,
							"portrait_path": _get_enemy_portrait_path(enemy.class_id),
						})

		var item_dict := {
			"is_discovered": is_completed,
			"data": {
				"battle_id": battle_id,
				"name": CompendiumManager.format_battle_name(battle_id) if is_completed else "???",
				"portrait_path": scene_image,
				"scene_image": scene_image,
				"flavor_text": flavor_text,
				"story_id": _guess_story_from_battle_id(battle_id),
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


## Get all enemy IDs with story assignment, in story/act progression order.
func _get_all_enemy_ids() -> Array:
	var s1 := "story_1"
	var s2 := "story_2"
	var s3 := "story_3"
	return [
		# Story 1 - Act I
		{"class_id": "Thug", "story_id": s1},
		{"class_id": "Ruffian", "story_id": s1},
		{"class_id": "Pickpocket", "story_id": s1},
		{"class_id": "Wolf", "story_id": s1},
		{"class_id": "Boar", "story_id": s1},
		{"class_id": "Goblin", "story_id": s1},
		{"class_id": "Hound", "story_id": s1},
		{"class_id": "Bandit", "story_id": s1},
		# Story 1 - Act II
		{"class_id": "Raider", "story_id": s1},
		{"class_id": "Orc", "story_id": s1},
		{"class_id": "Troll", "story_id": s1},
		{"class_id": "Harpy", "story_id": s1},
		{"class_id": "Witch", "story_id": s1},
		{"class_id": "Wisp", "story_id": s1},
		{"class_id": "Sprite", "story_id": s1},
		{"class_id": "Siren", "story_id": s1},
		{"class_id": "Merfolk", "story_id": s1},
		{"class_id": "Captain", "story_id": s1},
		{"class_id": "Pirate", "story_id": s1},
		{"class_id": "Fire Wyrmling", "story_id": s1},
		{"class_id": "Frost Wyrmling", "story_id": s1},
		{"class_id": "Ringmaster", "story_id": s1},
		{"class_id": "Harlequin", "story_id": s1},
		{"class_id": "Chanteuse", "story_id": s1},
		{"class_id": "Android", "story_id": s1},
		{"class_id": "Machinist", "story_id": s1},
		{"class_id": "Ironclad", "story_id": s1},
		{"class_id": "Commander", "story_id": s1},
		{"class_id": "Draconian", "story_id": s1},
		{"class_id": "Chaplain", "story_id": s1},
		{"class_id": "Zombie", "story_id": s1},
		{"class_id": "Ghoul", "story_id": s1},
		{"class_id": "Shade", "story_id": s1},
		{"class_id": "Wraith", "story_id": s1},
		# Story 1 - Acts III-V
		{"class_id": "Royal Guard", "story_id": s1},
		{"class_id": "Guard Sergeant", "story_id": s1},
		{"class_id": "Guard Archer", "story_id": s1},
		{"class_id": "Stranger", "story_id": s1},
		{"class_id": "StrangerFinal", "story_id": s1},
		{"class_id": "Lich", "story_id": s1},
		{"class_id": "Ghast", "story_id": s1},
		{"class_id": "Demon", "story_id": s1},
		{"class_id": "Corrupted Treant", "story_id": s1},
		{"class_id": "Hellion", "story_id": s1},
		{"class_id": "Fiendling", "story_id": s1},
		{"class_id": "Dragon", "story_id": s1},
		{"class_id": "Blighted Stag", "story_id": s1},
		{"class_id": "Dark Knight", "story_id": s1},
		{"class_id": "Fell Hound", "story_id": s1},
		{"class_id": "Sigil Wretch", "story_id": s1},
		{"class_id": "Tunnel Lurker", "story_id": s1},
		# Story 2 - Act I
		{"class_id": "Glow Worm", "story_id": s2},
		{"class_id": "Crystal Spider", "story_id": s2},
		{"class_id": "Shade Crawler", "story_id": s2},
		{"class_id": "Echo Wisp", "story_id": s2},
		{"class_id": "Spore Stalker", "story_id": s2},
		{"class_id": "Fungal Hulk", "story_id": s2},
		{"class_id": "Cap Wisp", "story_id": s2},
		{"class_id": "Cave Eel", "story_id": s2},
		{"class_id": "Blind Angler", "story_id": s2},
		{"class_id": "Pale Crayfish", "story_id": s2},
		{"class_id": "Cave Dweller", "story_id": s2},
		{"class_id": "Tunnel Shaman", "story_id": s2},
		{"class_id": "Burrow Scout", "story_id": s2},
		{"class_id": "Cave Maw", "story_id": s2},
		{"class_id": "Vein Leech", "story_id": s2},
		{"class_id": "Stone Moth", "story_id": s2},
		# Story 2 - Act II
		{"class_id": "Driftwood Bandit", "story_id": s2},
		{"class_id": "Saltrunner Smuggler", "story_id": s2},
		{"class_id": "Tide Warden", "story_id": s2},
		{"class_id": "Blighted Gull", "story_id": s2},
		{"class_id": "Shore Crawler", "story_id": s2},
		{"class_id": "Warped Hound", "story_id": s2},
		{"class_id": "Blackwater Captain", "story_id": s2},
		{"class_id": "Corsair Hexer", "story_id": s2},
		{"class_id": "Abyssal Lurker", "story_id": s2},
		{"class_id": "Stormwrack Raptor", "story_id": s2},
		{"class_id": "Tidecaller Revenant", "story_id": s2},
		{"class_id": "Salt Phantom", "story_id": s2},
		{"class_id": "Drowned Sailor", "story_id": s2},
		{"class_id": "Depth Horror", "story_id": s2},
		# Story 2 - Act III
		{"class_id": "Memory Wisp", "story_id": s2},
		{"class_id": "Echo Sentinel", "story_id": s2},
		{"class_id": "Thought Eater", "story_id": s2},
		{"class_id": "Grief Shade", "story_id": s2},
		{"class_id": "Hollow Watcher", "story_id": s2},
		{"class_id": "Mirror Self", "story_id": s2},
		{"class_id": "Void Weaver", "story_id": s2},
		{"class_id": "Mnemonic Golem", "story_id": s2},
		{"class_id": "The Warden", "story_id": s2},
		{"class_id": "Fractured Protector", "story_id": s2},
		{"class_id": "Fading Wisp", "story_id": s2},
		{"class_id": "Dim Guardian", "story_id": s2},
		{"class_id": "Ward Construct", "story_id": s2},
		{"class_id": "Null Phantom", "story_id": s2},
		{"class_id": "Threshold Echo", "story_id": s2},
		{"class_id": "Archive Keeper", "story_id": s2},
		{"class_id": "Silent Archivist", "story_id": s2},
		{"class_id": "Lost Record", "story_id": s2},
		{"class_id": "Faded Page", "story_id": s2},
		# Story 2 - Act IV
		{"class_id": "Gaze Stalker", "story_id": s2},
		{"class_id": "Memory Harvester", "story_id": s2},
		{"class_id": "Oblivion Shade", "story_id": s2},
		{"class_id": "Thoughtform Knight", "story_id": s2},
		{"class_id": "The Iris", "story_id": s2},
		{"class_id": "The Lidless Eye", "story_id": s2},
		# Story 3 - Acts I-II
		{"class_id": "Dream Wisp", "story_id": s3},
		{"class_id": "Phantasm", "story_id": s3},
		{"class_id": "Shade Moth", "story_id": s3},
		{"class_id": "Sleep Stalker", "story_id": s3},
		{"class_id": "Mirror Shade", "story_id": s3},
		{"class_id": "Slumber Beast", "story_id": s3},
		{"class_id": "Fog Wraith", "story_id": s3},
		{"class_id": "Thorn Dreamer", "story_id": s3},
		{"class_id": "Nightmare Hound", "story_id": s3},
		{"class_id": "Dream Weaver", "story_id": s3},
		{"class_id": "Hollow Echo", "story_id": s3},
		{"class_id": "Somnolent Serpent", "story_id": s3},
		{"class_id": "Twilight Stalker", "story_id": s3},
		{"class_id": "Waking Terror", "story_id": s3},
		{"class_id": "Dusk Sentinel", "story_id": s3},
		{"class_id": "Clock Specter", "story_id": s3},
		{"class_id": "The Nightmare", "story_id": s3},
		# Story 3 - Act II expansion
		{"class_id": "Thread Lurker", "story_id": s3},
		{"class_id": "Dream Sentinel", "story_id": s3},
		{"class_id": "Gloom Spinner", "story_id": s3},
		{"class_id": "Drowned Reverie", "story_id": s3},
		{"class_id": "Riptide Beast", "story_id": s3},
		{"class_id": "Depth Crawler", "story_id": s3},
		{"class_id": "Fragment Golem", "story_id": s3},
		{"class_id": "Gallery Shade", "story_id": s3},
		{"class_id": "Shadow Pursuer", "story_id": s3},
		{"class_id": "Dread Tendril", "story_id": s3},
		{"class_id": "Faded Voice", "story_id": s3},
		{"class_id": "Market Watcher", "story_id": s3},
		{"class_id": "Thread Smith", "story_id": s3},
		{"class_id": "Hex Herbalist", "story_id": s3},
		{"class_id": "Cellar Watcher", "story_id": s3},
		{"class_id": "Thread Construct", "story_id": s3},
		{"class_id": "Ink Shade", "story_id": s3},
		# Story 3 - Act III
		{"class_id": "Lucid Phantom", "story_id": s3},
		{"class_id": "Thread Spinner", "story_id": s3},
		{"class_id": "Loom Sentinel", "story_id": s3},
		{"class_id": "Cult Shade", "story_id": s3},
		{"class_id": "Dream Warden", "story_id": s3},
		{"class_id": "Thought Leech", "story_id": s3},
		{"class_id": "Void Spinner", "story_id": s3},
		{"class_id": "Sanctum Guardian", "story_id": s3},
		# Story 3 - Acts IV-V
		{"class_id": "Cult Acolyte", "story_id": s3},
		{"class_id": "Cult Enforcer", "story_id": s3},
		{"class_id": "Cult Hexer", "story_id": s3},
		{"class_id": "Thread Guard", "story_id": s3},
		{"class_id": "Dream Hound", "story_id": s3},
		{"class_id": "Cult Ritualist", "story_id": s3},
		{"class_id": "High Weaver", "story_id": s3},
		{"class_id": "Shadow Fragment", "story_id": s3},
		{"class_id": "The Threadmaster", "story_id": s3},
		# Story 3 - Path B
		{"class_id": "Cellar Sentinel", "story_id": s3},
		{"class_id": "Bound Stalker", "story_id": s3},
		{"class_id": "Thread Disciple", "story_id": s3},
		{"class_id": "Thread Warden", "story_id": s3},
		{"class_id": "Tunnel Sentinel", "story_id": s3},
		{"class_id": "Thread Sniper", "story_id": s3},
		{"class_id": "Pale Devotee", "story_id": s3},
		{"class_id": "Thread Ritualist", "story_id": s3},
		{"class_id": "Passage Guardian", "story_id": s3},
		{"class_id": "Warding Shadow", "story_id": s3},
		{"class_id": "Shadow Innkeeper", "story_id": s3},
		{"class_id": "Astral Weaver", "story_id": s3},
		{"class_id": "Loom Tendril", "story_id": s3},
		{"class_id": "Cathedral Warden", "story_id": s3},
		{"class_id": "Dream Binder", "story_id": s3},
		{"class_id": "Thread Anchor", "story_id": s3},
		{"class_id": "Lira, the Threadmaster", "story_id": s3},
		{"class_id": "Tattered Deception", "story_id": s3},
		{"class_id": "Dream Bastion", "story_id": s3},
		# Story 3 - Path C
		{"class_id": "Abyssal Dreamer", "story_id": s3},
		{"class_id": "Thread Devourer", "story_id": s3},
		{"class_id": "Slumbering Colossus", "story_id": s3},
		{"class_id": "Dream Priest", "story_id": s3},
		{"class_id": "Astral Enforcer", "story_id": s3},
		{"class_id": "Oneiric Hexer", "story_id": s3},
		{"class_id": "Memory Eater", "story_id": s3},
		{"class_id": "Nightmare Sentinel", "story_id": s3},
		{"class_id": "Anchor Chain", "story_id": s3},
		{"class_id": "The Ancient Threadmaster", "story_id": s3},
		{"class_id": "Dream Shackle", "story_id": s3},
		{"class_id": "Loom Heart", "story_id": s3},
	]


## Get all battle IDs in story/act progression order.
func _get_all_battle_ids() -> Array:
	return [
		# Story 1 - Act I
		"CityStreetBattle", "WolfForestBattle", "WaypointDefenseBattle",
		# Story 1 - Act II
		"HighlandBattle", "DeepForestBattle", "ShoreBattle", "MountainPassBattle",
		"CaveBattle", "BeachBattle", "WildernessOutpost", "CircusBattle",
		"LabBattle", "ArmyBattle", "CemeteryBattle", "OutpostDefenseBattle", "MirrorBattle",
		# Story 1 - Act III
		"ReturnToCityStreetBattle", "StrangerTowerBattle",
		# Story 1 - Acts IV-V
		"CorruptedCityBattle", "CorruptedWildsBattle",
		"DepthsBattle", "GateBattle", "StrangerFinalBattle",
		# Story 2 - Act I
		"S2_CaveAwakening", "S2_DeepCavern", "S2_FungalHollow",
		"S2_TranquilPool", "S2_TorchChamber", "S2_CaveExit",
		# Story 2 - Act II
		"S2_CoastalDescent", "S2_FishingVillage", "S2_SmugglersBluff",
		"S2_WreckersCove", "S2_CoastalRuins",
		"S2_BlackwaterBay", "S2_LighthouseStorm",
		# Story 2 - Act III
		"S2_BeneathTheLighthouse", "S2_MemoryVault", "S2_EchoGallery",
		"S2_ShatteredSanctum", "S2_GuardiansThreshold",
		"S2_ForgottenArchive", "S2_TheReveal",
		# Story 2 - Act IV
		"S2_DepthsOfRemembrance", "S2_MawOfTheEye",
		"S2_EyeAwakening", "S2_EyeOfOblivion",
		# Story 3 - Acts I-II
		"S3_DreamMeadow", "S3_DreamMirrorHall",
		"S3_DreamFogGarden", "S3_DreamReturn",
		"S3_DreamLabyrinth", "S3_DreamClockTower", "S3_DreamNightmare",
		# Story 3 - Act II expansion
		"S3_DreamThreads", "S3_DreamDrownedCorridor",
		"S3_DreamShatteredGallery", "S3_DreamShadowChase",
		"S3_MarketConfrontation", "S3_CellarDiscovery",
		# Story 3 - Act III
		"S3_LucidDream", "S3_DreamTemple",
		"S3_DreamVoid", "S3_DreamSanctum",
		# Story 3 - Acts IV-V
		"S3_CultUnderbelly", "S3_CultCatacombs",
		"S3_CultRitualChamber", "S3_DreamNexus",
		# Story 3 - Path B
		"S3_B_InnSearch", "S3_B_CultConfrontation",
		"S3_B_TunnelBreach", "S3_B_ThornesWard", "S3_B_LoomHeart",
		"S3_B_DreamInvasion", "S3_B_DreamNexus",
		# Story 3 - Path C
		"S3_C_DreamDescent",
		"S3_C_CultInterception", "S3_C_ThreadmasterLair", "S3_C_DreamNexus",
	]


func _get_class_portrait_path(class_id: String) -> String:
	var display_name: String = _FighterDB.get_display_name(class_id)
	return "res://assets/art/portraits/classes/%s_m.png" % _to_portrait_key(display_name)


func _get_enemy_portrait_path(class_id: String) -> String:
	return "res://assets/art/portraits/enemies/%s.png" % _to_portrait_key(class_id)


## Convert a name to a portrait filename key (snake_case, no punctuation).
## "Fire Wyrmling" -> "fire_wyrmling", "StrangerFinal" -> "stranger_final",
## "Lira, the Threadmaster" -> "lira_the_threadmaster"
static func _to_portrait_key(name_str: String) -> String:
	var clean := name_str.replace(",", "").replace("'", "")
	# Insert space before uppercase letters in PascalCase words
	var spaced := ""
	for i in clean.length():
		var c := clean[i]
		if i > 0 and c >= "A" and c <= "Z" and clean[i - 1] != " ":
			spaced += " "
		spaced += c
	return spaced.to_lower().strip_edges().replace("  ", " ").replace(" ", "_")


func _guess_story_from_battle_id(battle_id: String) -> String:
	if battle_id.begins_with("S2_"):
		return "story_2"
	elif battle_id.begins_with("S3_"):
		return "story_3"
	return "story_1"
