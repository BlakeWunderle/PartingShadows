extends Control

## Battle scene. Connects BattleEngine to visual UI.
## Visual-first layout: scene image background, portrait cards for all fighters,
## minimal action text overlay instead of scrolling combat log.

const BattleEngine := preload("res://scripts/battle/battle_engine.gd")
const ChoiceMenu := preload("res://scripts/ui/choice_menu.gd")
const PortraitCard := preload("res://scripts/ui/portrait_card.gd")
const StatsPanel := preload("res://scripts/ui/stats_panel.gd")
const TipOverlay := preload("res://scripts/ui/tip_overlay.gd")
const WaitingOverlay := preload("res://scripts/ui/waiting_overlay.gd")
const FighterData := preload("res://scripts/data/fighter_data.gd")
const AbilityData := preload("res://scripts/data/ability_data.gd")
const BattleData := preload("res://scripts/data/battle_data.gd")

enum Phase {
	STARTING,
	TICKING_ATB,
	PLAYER_ACTION,
	PLAYER_TARGET_ATTACK,
	PLAYER_ABILITY_SELECT,
	PLAYER_ABILITY_TARGET_ENEMY,
	PLAYER_ABILITY_TARGET_ALLY,
	SHOWING_STATS,
	STATS_PICK,
	AI_ACTING,
	MESSAGE_DELAY,
	BATTLE_END,
}

var COMBAT_PAUSE: float = 1.2  ## Seconds between combat messages

var _engine: BattleEngine
var _phase: Phase = Phase.STARTING
var _current_actor: FighterData
var _selected_ability: AbilityData
var _message_queue: Array[String] = []
var _processing_messages: bool = false
var _escape_hp_pct: float = 0.0  ## Boss escape threshold from BattleData
var _boss_escaped: bool = false
var _battle_stats: Dictionary = {}  ## FighterData -> {damage_dealt, damage_taken, healing_done, kills}
var _auto_battle: bool = false
var _auto_battle_unlocked: bool = false
var _auto_label: Label

signal _player_turn_done
signal _remote_action_received(action: Dictionary)

# Multiplayer state
var _waiting_overlay: WaitingOverlay
var _pending_remote_action: Dictionary = {}

# UI elements -- portrait cards
var _party_cards: Array[PortraitCard] = []
var _enemy_cards: Array[PortraitCard] = []
var _active_card: PortraitCard
var _portrait_cache: Dictionary = {}

# UI elements -- layout
var _scene_image: TextureRect
var _gradient_overlay: TextureRect
var _action_text: RichTextLabel
var _action_menu: ChoiceMenu
var _stats_panel: StatsPanel
var _party_cards_box: HBoxContainer
var _enemy_cards_box: HBoxContainer
var _bottom_panel: VBoxContainer
var _turn_order_label: RichTextLabel
var _turn_queue: Array = []  ## Predicted turn order, depleted as actors act
var _tip_overlay: TipOverlay
var _player_indicator: Label

# Track all fighters (including dead) for card display
var _all_party: Array = []
var _all_enemies: Array = []


func _ready() -> void:
	COMBAT_PAUSE = SettingsManager.combat_pause
	SettingsManager.combat_pause_changed.connect(func(s: float) -> void: COMBAT_PAUSE = s)
	_build_ui()
	_start_battle()


func _build_ui() -> void:
	# Scene image -- full screen background
	_scene_image = TextureRect.new()
	_scene_image.set_anchors_preset(Control.PRESET_FULL_RECT)
	_scene_image.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_scene_image.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	_scene_image.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	_scene_image.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_scene_image)

	# Gradient overlay -- fades scene image into dark at bottom
	_gradient_overlay = TextureRect.new()
	_gradient_overlay.set_anchors_preset(Control.PRESET_FULL_RECT)
	_gradient_overlay.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_gradient_overlay.stretch_mode = TextureRect.STRETCH_SCALE
	_gradient_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var grad := GradientTexture2D.new()
	grad.gradient = Gradient.new()
	grad.gradient.set_color(0, Color(0.05, 0.05, 0.08, 0.0))
	grad.gradient.set_color(1, Color(0.05, 0.05, 0.08, 1.0))
	grad.gradient.set_offset(0, 0.3)
	grad.gradient.set_offset(1, 0.7)
	grad.fill_from = Vector2(0.5, 0.0)
	grad.fill_to = Vector2(0.5, 1.0)
	_gradient_overlay.texture = grad
	add_child(_gradient_overlay)

	# UI root -- layered on top of scene image with bottom padding
	var ui_margin := MarginContainer.new()
	ui_margin.set_anchors_preset(Control.PRESET_FULL_RECT)
	ui_margin.add_theme_constant_override("margin_bottom", 16)
	ui_margin.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(ui_margin)

	var ui_root := VBoxContainer.new()
	ui_root.add_theme_constant_override("separation", 4)
	ui_root.size_flags_vertical = Control.SIZE_EXPAND_FILL
	ui_root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	ui_margin.add_child(ui_root)

	# Scene spacer -- pushes UI content to bottom half
	var scene_spacer := Control.new()
	scene_spacer.size_flags_vertical = Control.SIZE_EXPAND_FILL
	scene_spacer.size_flags_stretch_ratio = 3.0
	scene_spacer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	ui_root.add_child(scene_spacer)

	# Turn order bar (fixed height, no resizing)
	_turn_order_label = RichTextLabel.new()
	_turn_order_label.bbcode_enabled = true
	_turn_order_label.fit_content = false
	_turn_order_label.scroll_active = false
	_turn_order_label.add_theme_font_size_override("normal_font_size", 13)
	_turn_order_label.custom_minimum_size = Vector2(0, 22)
	_turn_order_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	ui_root.add_child(_turn_order_label)

	# Portraits row -- party left, enemies right
	var portraits_row := HBoxContainer.new()
	portraits_row.add_theme_constant_override("separation", 0)
	portraits_row.mouse_filter = Control.MOUSE_FILTER_IGNORE

	# Add left margin
	var left_margin := Control.new()
	left_margin.custom_minimum_size = Vector2(16, 0)
	left_margin.mouse_filter = Control.MOUSE_FILTER_IGNORE
	portraits_row.add_child(left_margin)

	_party_cards_box = HBoxContainer.new()
	_party_cards_box.add_theme_constant_override("separation", 8)
	_party_cards_box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	portraits_row.add_child(_party_cards_box)

	var card_spacer := Control.new()
	card_spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	card_spacer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	portraits_row.add_child(card_spacer)

	_enemy_cards_box = HBoxContainer.new()
	_enemy_cards_box.add_theme_constant_override("separation", 8)
	_enemy_cards_box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	portraits_row.add_child(_enemy_cards_box)

	# Add right margin
	var right_margin := Control.new()
	right_margin.custom_minimum_size = Vector2(16, 0)
	right_margin.mouse_filter = Control.MOUSE_FILTER_IGNORE
	portraits_row.add_child(right_margin)

	ui_root.add_child(portraits_row)

	# Bottom area: combat log (left) + action menu (right)
	var bottom_row := HBoxContainer.new()
	bottom_row.size_flags_vertical = Control.SIZE_EXPAND_FILL
	bottom_row.size_flags_stretch_ratio = 1.2
	bottom_row.add_theme_constant_override("separation", 16)
	ui_root.add_child(bottom_row)

	# Left side: persistent combat log
	var log_panel := VBoxContainer.new()
	log_panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	log_panel.size_flags_stretch_ratio = 1.0
	log_panel.add_theme_constant_override("separation", 2)
	bottom_row.add_child(log_panel)

	_action_text = RichTextLabel.new()
	_action_text.bbcode_enabled = true
	_action_text.fit_content = false
	_action_text.scroll_active = true
	_action_text.scroll_following = true
	_action_text.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_action_text.add_theme_font_size_override("normal_font_size", 14)
	_action_text.mouse_filter = Control.MOUSE_FILTER_STOP
	log_panel.add_child(_action_text)

	# Right side: action menu (bottom-aligned so content sits at bottom edge)
	_bottom_panel = VBoxContainer.new()
	_bottom_panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_bottom_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_bottom_panel.size_flags_stretch_ratio = 1.0
	_bottom_panel.alignment = BoxContainer.ALIGNMENT_END
	bottom_row.add_child(_bottom_panel)

	_action_menu = ChoiceMenu.new()
	_action_menu.choice_selected.connect(_on_action_selected)
	_action_menu.visible = false
	_bottom_panel.add_child(_action_menu)

	# Stats panel (overlay, on top of everything)
	_stats_panel = StatsPanel.new()
	_stats_panel.closed.connect(_on_stats_closed)
	_stats_panel.visible = false
	_stats_panel.set_anchors_preset(Control.PRESET_CENTER)
	_stats_panel.grow_horizontal = Control.GROW_DIRECTION_BOTH
	_stats_panel.grow_vertical = Control.GROW_DIRECTION_BOTH
	_stats_panel.custom_minimum_size = Vector2(350, 0)
	add_child(_stats_panel)

	_tip_overlay = TipOverlay.new()
	add_child(_tip_overlay)

	_waiting_overlay = WaitingOverlay.new()
	add_child(_waiting_overlay)

	# Local co-op player indicator
	_player_indicator = Label.new()
	_player_indicator.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_player_indicator.add_theme_font_size_override("font_size", 20)
	_player_indicator.add_theme_color_override("font_color", Color(0.3, 0.9, 0.5))
	_player_indicator.set_anchors_preset(Control.PRESET_CENTER_TOP)
	_player_indicator.grow_horizontal = Control.GROW_DIRECTION_BOTH
	_player_indicator.offset_left = -200
	_player_indicator.offset_right = 200
	_player_indicator.offset_top = 12
	_player_indicator.visible = false
	add_child(_player_indicator)

	# Auto-battle indicator
	_auto_label = Label.new()
	_auto_label.text = "AUTO"
	_auto_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	_auto_label.add_theme_font_size_override("font_size", 18)
	_auto_label.add_theme_color_override("font_color", Color(0.9, 0.8, 0.5))
	_auto_label.set_anchors_preset(Control.PRESET_TOP_RIGHT)
	_auto_label.offset_left = -100
	_auto_label.offset_right = -12
	_auto_label.offset_top = 12
	_auto_label.visible = false
	add_child(_auto_label)


func _is_mp_guest() -> bool:
	return NetManager.is_multiplayer_active and not NetManager.is_host


func _start_battle() -> void:
	_engine = BattleEngine.new()
	_engine.combat_message.connect(_on_combat_message)
	_engine.combat_event.connect(_on_combat_event)
	_engine.fighter_died.connect(_on_fighter_died)
	_engine.battle_won.connect(_on_battle_won)
	_engine.battle_lost.connect(_on_battle_lost)

	if NetManager.is_multiplayer_active and NetManager.is_host:
		NetManager.player_left.connect(_on_peer_left_mid_battle)

	var battle: BattleData = GameState.current_battle
	_escape_hp_pct = battle.escape_hp_pct
	_boss_escaped = false
	if not battle.scene_image.is_empty() and ResourceLoader.exists(battle.scene_image):
		_scene_image.texture = load(battle.scene_image)
	if not battle.music_track.is_empty():
		MusicManager.play_music(battle.music_track)
	else:
		MusicManager.play_context(MusicManager.MusicContext.BATTLE)
	_engine.start_battle(GameState.party, battle.enemies)
	for enemy: FighterData in battle.enemies:
		CompendiumManager.record_enemy(enemy, GameState.current_story_id)
	GameLog.info("Battle started: %s (%d enemies)" % [
		GameState.current_battle_id, battle.enemies.size()])

	_auto_battle = false
	_auto_label.visible = false
	var unlock_key: String = GameState.current_story_id + "_complete"
	_auto_battle_unlocked = UnlockManager.is_unlocked(unlock_key)

	_build_portrait_cards()

	_battle_stats.clear()
	for f: FighterData in _all_party:
		_battle_stats[f] = {"damage_dealt": 0, "damage_taken": 0, "healing_done": 0, "kills": 0}
	_add_log("[color=gold]Battle begins![/color]")
	_compute_turn_order()
	_display_turn_order()

	_tip_overlay.show_tip_once("first_battle",
		"Combat uses an Active Time Battle system. " +
		"Faster characters act more often.\n\n" +
		"On your turn, choose Attack for basic damage, " +
		"use an Ability for special moves (costs MP), " +
		"or check Stats to review your party.\n\n" +
		"Some abilities target all enemies or all allies. " +
		"Buffs and debuffs last several turns.")

	_phase = Phase.TICKING_ATB
	if not _is_mp_guest():
		_tick_loop()
	# Guests wait for RPCs from host to drive the battle


func _build_portrait_cards() -> void:
	for card: PortraitCard in _party_cards:
		card.queue_free()
	_party_cards.clear()
	for card: PortraitCard in _enemy_cards:
		card.queue_free()
	_enemy_cards.clear()

	# Snapshot all fighters so we can track dead ones
	_all_party = _engine.units.duplicate()
	_all_enemies = _engine.enemies.duplicate()

	for f: FighterData in _all_party:
		var card := PortraitCard.new()
		_party_cards_box.add_child(card)
		var tex: Texture2D = _get_portrait_texture(f)
		card.setup(f, false, tex)
		_party_cards.append(card)

	for f: FighterData in _all_enemies:
		var card := PortraitCard.new()
		_enemy_cards_box.add_child(card)
		var tex: Texture2D = _get_portrait_texture(f)
		card.setup(f, true, tex)
		_enemy_cards.append(card)


func _refresh_cards() -> void:
	for card: PortraitCard in _party_cards:
		card.update_display(card.get_fighter())
	for card: PortraitCard in _enemy_cards:
		card.update_display(card.get_fighter())


func _add_log(text: String) -> void:
	if _action_text.get_total_character_count() > 0:
		_action_text.append_text("\n")
	_action_text.append_text(text)


func _add_log_separator() -> void:
	_action_text.append_text("\n[color=gray]───────────[/color]")


# =============================================================================
# Main ATB loop
# =============================================================================

func _tick_loop() -> void:
	_phase = Phase.TICKING_ATB
	while true:
		if not _engine.tick_atb():
			continue

		var actors: Array = _engine.get_acting_units()
		for actor: FighterData in actors:
			if actor.health <= 0:
				continue

			_current_actor = actor
			_highlight_active_card(actor)
			# Pop this actor from the display queue
			if not _turn_queue.is_empty() and _turn_queue[0] == actor:
				_turn_queue.pop_front()
			_display_turn_order()

			_engine.reset_modified_stat(actor)
			_engine.tick_cooldowns(actor)
			await _drain_messages()

			if _engine.is_battle_over():
				_end_battle()
				return

			# Turn announcement
			var turn_text: String
			if actor.character_name.ends_with("s"):
				turn_text = "It is %s' turn." % actor.character_name
			else:
				turn_text = "It is %s's turn." % actor.character_name
			_add_log_separator()
			_add_log("[color=yellow]%s[/color]" % turn_text)

			if actor.is_user_controlled:
				_phase = Phase.PLAYER_ACTION
				var actor_party_idx: int = _all_party.find(actor)
				if _auto_battle and not _is_mp_guest():
					# Auto-battle: use AI logic for player fighter
					_execute_auto_turn()
					await _player_turn_done
					if NetManager.is_multiplayer_active:
						_broadcast_state_sync()
				elif LocalCoop.is_active:
					# Local co-op: gate input to the owning player
					var owner: int = LocalCoop.get_player_for_slot(actor_party_idx)
					LocalCoop.set_active_player(owner)
					_player_indicator.text = "%s's turn" % LocalCoop.get_player_name(owner)
					_player_indicator.visible = true
					_show_action_menu(actor)
					await _player_turn_done
					LocalCoop.clear_active_player()
					_player_indicator.visible = false
				elif NetManager.is_multiplayer_active and not NetManager.is_my_fighter(actor_party_idx):
					# Remote player's turn -- request their action via RPC
					var owner_peer: int = NetManager.get_fighter_owner_peer(actor_party_idx)
					var owner_name: String = NetManager.get_fighter_owner_name(actor_party_idx)
					_waiting_overlay.show_waiting(owner_name)
					_rpc_request_action.rpc_id(owner_peer, actor_party_idx)
					NetManager.start_turn_timeout()
					var action: Dictionary = await _remote_action_received
					NetManager.stop_turn_timeout()
					_waiting_overlay.hide_waiting()
					_execute_remote_action(actor, action)
				else:
					_show_action_menu(actor)
					await _player_turn_done
					if NetManager.is_multiplayer_active:
						_broadcast_state_sync()
			else:
				# AI turn -- brief pause so player can read the turn announcement
				_phase = Phase.AI_ACTING
				await get_tree().create_timer(COMBAT_PAUSE * 0.5).timeout
				var is_party: bool = _engine.units.has(actor)
				var targets: Array = _engine.enemies if is_party else _engine.units
				var allies: Array = _engine.units if is_party else _engine.enemies
				_engine.execute_ai_turn(actor, targets, allies)
				if NetManager.is_multiplayer_active:
					_broadcast_state_sync()

			# Post-action (same for player and AI)
			await _drain_messages()
			_refresh_cards()

			# Check boss escape before death, escape triggers at HP threshold
			if _check_boss_escape():
				_end_battle()
				return

			_engine.check_for_death()
			_rebuild_cards_if_needed()
			await _drain_messages()

			if _engine.is_battle_over():
				_end_battle()
				return

			_phase = Phase.TICKING_ATB

		_engine.reset_turns()
		_compute_turn_order()
		_display_turn_order()


# =============================================================================
# Cooldown management
# =============================================================================

func _set_cooldown(fighter: FighterData, ability: AbilityData) -> void:
	if ability.cooldown > 0:
		fighter.ability_cooldowns[ability.ability_name] = ability.cooldown


func _is_ability_available(fighter: FighterData, ability: AbilityData) -> bool:
	return ability.mana_cost <= fighter.mana \
		and fighter.ability_cooldowns.get(ability.ability_name, 0) <= 0


# =============================================================================
# Auto-battle
# =============================================================================

func _execute_auto_turn() -> void:
	# Reuse engine AI logic for player fighter
	var targets: Array = _engine.enemies
	var allies: Array = _engine.units
	_engine.execute_ai_turn(_current_actor, targets, allies)
	_player_turn_done.emit()


func _unhandled_input(event: InputEvent) -> void:
	if _auto_battle and event.is_action_pressed("cancel"):
		_auto_battle = false
		_auto_label.visible = false
		get_viewport().set_input_as_handled()


# =============================================================================
# Player action handling
# =============================================================================

func _show_action_menu(actor: FighterData) -> void:
	var has_available: bool = false
	for a: AbilityData in actor.abilities:
		if _is_ability_available(actor, a):
			has_available = true
			break

	var options: Array[Dictionary] = [{"label": "Attack"}]
	if has_available:
		options.append({"label": "Ability"})
	if _auto_battle_unlocked:
		options.append({"label": "Auto"})
	options.append({"label": "Stats"})
	_action_menu.show_choices(options, true)


func _on_action_selected(index: int) -> void:
	_action_menu.hide_menu()

	# Map index accounting for possibly missing Ability/Auto options
	var has_available: bool = false
	for a: AbilityData in _current_actor.abilities:
		if _is_ability_available(_current_actor, a):
			has_available = true
			break

	# Rebuild the same label list used in _show_action_menu to find action by index
	var labels: Array[String] = ["Attack"]
	if has_available:
		labels.append("Ability")
	if _auto_battle_unlocked:
		labels.append("Auto")
	labels.append("Stats")

	var action: String = labels[index] if index < labels.size() else "Stats"

	match action:
		"Attack":
			_phase = Phase.PLAYER_TARGET_ATTACK
			_show_target_menu(_engine.enemies)
		"Ability":
			_phase = Phase.PLAYER_ABILITY_SELECT
			_show_ability_menu()
		"Auto":
			_auto_battle = true
			_auto_label.visible = true
			_execute_auto_turn()
		"Stats":
			_phase = Phase.STATS_PICK
			_show_stats_pick()


func _show_target_menu(fighters: Array) -> void:
	var options: Array[Dictionary] = []
	for f: FighterData in fighters:
		options.append({"label": "%s the %s (HP: %d/%d)" % [
			f.character_name, f.character_type, f.health, f.max_health]})
	options.append({"label": "Back"})
	_action_menu.show_choices(options, true)
	_action_menu.choice_selected.disconnect(_on_action_selected)
	_action_menu.choice_selected.connect(_on_target_selected)


func _on_target_selected(index: int) -> void:
	# Check for Back option
	var fighter_count: int
	match _phase:
		Phase.PLAYER_TARGET_ATTACK, Phase.PLAYER_ABILITY_TARGET_ENEMY:
			fighter_count = _engine.enemies.size()
		Phase.PLAYER_ABILITY_TARGET_ALLY:
			fighter_count = _engine.units.size()
		_:
			fighter_count = 0

	if index >= fighter_count:
		# Back: return to appropriate menu
		_action_menu.choice_selected.disconnect(_on_target_selected)
		_action_menu.choice_selected.connect(_on_action_selected)
		_action_menu.hide_menu()
		if _phase == Phase.PLAYER_TARGET_ATTACK:
			_phase = Phase.PLAYER_ACTION
			_show_action_menu(_current_actor)
		else:
			# Ability target, go back to ability list
			_phase = Phase.PLAYER_ABILITY_SELECT
			_show_ability_menu()
		return

	_action_menu.choice_selected.disconnect(_on_target_selected)
	_action_menu.choice_selected.connect(_on_action_selected)
	_action_menu.hide_menu()

	if _is_mp_guest():
		# Guest: send action to host instead of executing locally
		var action: Dictionary = {}
		match _phase:
			Phase.PLAYER_TARGET_ATTACK:
				action = {"type": "attack", "target_index": index}
			Phase.PLAYER_ABILITY_TARGET_ENEMY:
				action = {"type": "ability_enemy", "ability_name": _selected_ability.ability_name, "target_index": index}
			Phase.PLAYER_ABILITY_TARGET_ALLY:
				action = {"type": "ability_ally", "ability_name": _selected_ability.ability_name, "target_index": index}
		_rpc_submit_action.rpc_id(1, action)
		_player_turn_done.emit()
		return

	match _phase:
		Phase.PLAYER_TARGET_ATTACK:
			var taunter: FighterData = _engine.get_taunt_target(_engine.enemies)
			var target: FighterData
			if taunter:
				target = taunter
				_add_log("%s has taunted your attention!" % taunter.character_name)
			else:
				target = _engine.enemies[index]
			_engine.physical_attack(_current_actor, target)
		Phase.PLAYER_ABILITY_TARGET_ENEMY:
			var taunter: FighterData = _engine.get_taunt_target(_engine.enemies)
			var target: FighterData
			if taunter:
				target = taunter
				_add_log("%s has taunted your attention!" % taunter.character_name)
			else:
				target = _engine.enemies[index]
			_current_actor.mana -= _selected_ability.mana_cost
			_set_cooldown(_current_actor, _selected_ability)
			_engine.use_ability_on_enemy(_current_actor, target, _selected_ability)
		Phase.PLAYER_ABILITY_TARGET_ALLY:
			_current_actor.mana -= _selected_ability.mana_cost
			_set_cooldown(_current_actor, _selected_ability)
			_engine.use_ability_on_teammate(
				_current_actor, _engine.units[index], _selected_ability)

	_player_turn_done.emit()


func _show_ability_menu() -> void:
	var available: Array[AbilityData] = []
	for a: AbilityData in _current_actor.abilities:
		if _is_ability_available(_current_actor, a):
			available.append(a)

	var options: Array[Dictionary] = []
	for a: AbilityData in available:
		var label: String = "%s (%d MP)" % [a.ability_name, a.mana_cost]
		if a.cooldown > 0:
			label += " [CD %d]" % a.cooldown
		options.append({"label": label, "description": a.get_description()})
	options.append({"label": "Back"})

	_action_menu.show_choices(options, true)
	_action_menu.choice_selected.disconnect(_on_action_selected)
	_action_menu.choice_selected.connect(_on_ability_selected)


func _on_ability_selected(index: int) -> void:
	var available: Array[AbilityData] = []
	for a: AbilityData in _current_actor.abilities:
		if _is_ability_available(_current_actor, a):
			available.append(a)

	# Back option
	if index >= available.size():
		_action_menu.choice_selected.disconnect(_on_ability_selected)
		_action_menu.choice_selected.connect(_on_action_selected)
		_action_menu.hide_menu()
		_phase = Phase.PLAYER_ACTION
		_show_action_menu(_current_actor)
		return

	_action_menu.choice_selected.disconnect(_on_ability_selected)
	_action_menu.choice_selected.connect(_on_action_selected)
	_action_menu.hide_menu()

	_selected_ability = available[index]

	if _selected_ability.target_all:
		if _is_mp_guest():
			# Guest: send AoE action to host
			var action_type: String = "ability_enemy" if _selected_ability.use_on_enemy else "ability_ally"
			_rpc_submit_action.rpc_id(1, {
				"type": action_type,
				"ability_name": _selected_ability.ability_name,
				"target_index": 0,
			})
			_player_turn_done.emit()
			return

		# AoE, no target selection needed
		_current_actor.mana -= _selected_ability.mana_cost
		_set_cooldown(_current_actor, _selected_ability)
		if _selected_ability.use_on_enemy:
			_add_log("%s targets all enemies!" % _current_actor.character_name)
			for enemy: FighterData in _engine.enemies.duplicate():
				_engine.use_ability_on_enemy(_current_actor, enemy, _selected_ability, true)
		else:
			_add_log("%s targets all allies!" % _current_actor.character_name)
			for ally: FighterData in _engine.units.duplicate():
				_engine.use_ability_on_teammate(_current_actor, ally, _selected_ability, true)

		_player_turn_done.emit()
	elif _selected_ability.use_on_enemy:
		_phase = Phase.PLAYER_ABILITY_TARGET_ENEMY
		_show_target_menu(_engine.enemies)
	else:
		_phase = Phase.PLAYER_ABILITY_TARGET_ALLY
		_show_target_menu(_engine.units)


# =============================================================================
# Stats viewing
# =============================================================================

func _show_stats_pick() -> void:
	var options: Array[Dictionary] = []
	for f: FighterData in _engine.units:
		options.append({"label": "%s the %s" % [f.character_name, f.character_type]})
	options.append({"label": "Back"})

	_action_menu.show_choices(options, true)
	if _action_menu.choice_selected.is_connected(_on_action_selected):
		_action_menu.choice_selected.disconnect(_on_action_selected)
	if not _action_menu.choice_selected.is_connected(_on_stats_pick_selected):
		_action_menu.choice_selected.connect(_on_stats_pick_selected)


func _on_stats_pick_selected(index: int) -> void:
	if index >= _engine.units.size():
		# Back
		_action_menu.choice_selected.disconnect(_on_stats_pick_selected)
		_action_menu.choice_selected.connect(_on_action_selected)
		_action_menu.hide_menu()
		_phase = Phase.PLAYER_ACTION
		_show_action_menu(_current_actor)
		return

	_action_menu.hide_menu()
	var fighter: FighterData = _engine.units[index]

	_phase = Phase.SHOWING_STATS
	_stats_panel.show_fighter(fighter)


func _on_stats_closed() -> void:
	_stats_panel.visible = false
	_phase = Phase.STATS_PICK
	_show_stats_pick()


# =============================================================================
# Message queue & delays
# =============================================================================

func _on_combat_message(text: String) -> void:
	_message_queue.append(text)


func _on_combat_event(target: FighterData, amount: int, event_type: String) -> void:
	var card: PortraitCard = _find_card_for_fighter(target)
	if not card:
		return
	# Track battle stats for party members
	if event_type in ["damage", "crit", "spell_damage", "spell_crit"]:
		if _current_actor != null and _battle_stats.has(_current_actor):
			_battle_stats[_current_actor]["damage_dealt"] += amount
		if _battle_stats.has(target):
			_battle_stats[target]["damage_taken"] += amount
	elif event_type == "heal":
		if _current_actor != null and _battle_stats.has(_current_actor):
			_battle_stats[_current_actor]["healing_done"] += amount

	match event_type:
		"damage":
			SFXManager.play(SFXManager.Category.STRIKE)
			card.show_floating_text("-%d" % amount, Color(1.0, 0.3, 0.3))
		"crit":
			SFXManager.play(SFXManager.Category.IMPACT)
			card.show_floating_text("-%d!" % amount, Color(1.0, 0.85, 0.2))
		"spell_damage":
			SFXManager.play(SFXManager.Category.SPELL)
			card.show_floating_text("-%d" % amount, Color(0.6, 0.4, 1.0))
		"spell_crit":
			SFXManager.play(SFXManager.Category.IMPACT)
			card.show_floating_text("-%d!" % amount, Color(1.0, 0.85, 0.2))
		"heal":
			SFXManager.play(SFXManager.Category.SHIMMER)
			card.show_floating_text("+%d" % amount, Color(0.3, 1.0, 0.4))
		"buff":
			SFXManager.play(SFXManager.Category.BUFF)
			card.show_floating_text("BUFF", Color(0.4, 0.8, 1.0))
		"debuff":
			SFXManager.play(SFXManager.Category.DEBUFF)
			card.show_floating_text("DEBUFF", Color(0.8, 0.3, 0.8))
		"miss":
			SFXManager.play(SFXManager.Category.WHOOSH, 0.7)
			card.show_floating_text("MISS", Color(0.7, 0.7, 0.7))


func _find_card_for_fighter(fighter: FighterData) -> PortraitCard:
	for card: PortraitCard in _party_cards:
		if card.get_fighter() == fighter:
			return card
	for card: PortraitCard in _enemy_cards:
		if card.get_fighter() == fighter:
			return card
	return null


func _drain_messages() -> void:
	var pause: float = COMBAT_PAUSE * 0.3 if _auto_battle else COMBAT_PAUSE
	while not _message_queue.is_empty():
		var msg: String = _message_queue.pop_front()
		_add_log(msg)
		_refresh_cards()
		await get_tree().create_timer(pause).timeout
	_refresh_cards()


# =============================================================================
# Battle end
# =============================================================================

func _check_boss_escape() -> bool:
	if _escape_hp_pct <= 0.0:
		return false
	for enemy: FighterData in _engine.enemies:
		if enemy.health > 0 and float(enemy.health) / float(enemy.max_health) <= _escape_hp_pct:
			_boss_escaped = true
			_add_log("[color=yellow]%s staggers back, then vanishes in a flash of dark energy![/color]" % enemy.character_name)
			return true
	return false


func _end_battle() -> void:
	_phase = Phase.BATTLE_END
	_highlight_active_card(null)
	await _drain_messages()

	_engine.finish_battle()

	var won: bool = _boss_escaped or _engine.did_player_win()

	# Broadcast battle end to guests
	if NetManager.is_multiplayer_active and NetManager.is_host:
		_broadcast_state_sync()
		_rpc_battle_ended.rpc(won)

	if won:
		GameLog.info("Battle won: %s" % GameState.current_battle_id)
		if _boss_escaped:
			_add_log("[color=gold]The enemy has fled! Victory is yours... for now.[/color]")
		else:
			_add_log("[color=gold]Victory! The enemies have been vanquished.[/color]")
		SFXManager.play(SFXManager.Category.UI_FANFARE)
		await get_tree().create_timer(1.0).timeout
		await _show_battle_summary()
		GameState.advance_to_post_battle()
		SceneManager.change_scene("res://scenes/narrative/narrative.tscn", 0.4, true)
	else:
		GameLog.info("Battle lost: %s" % GameState.current_battle_id)
		_add_log("[color=red]The party has been defeated...[/color]")
		await get_tree().create_timer(2.0).timeout
		GameState.go_to_ending(false)
		SceneManager.change_scene("res://scenes/narrative/narrative.tscn")


func _show_battle_summary() -> void:
	var overlay := PanelContainer.new()
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.05, 0.08, 0.12, 0.92)
	style.border_color = Color(0.9, 0.8, 0.5, 0.6)
	style.set_border_width_all(2)
	style.set_corner_radius_all(8)
	style.set_content_margin_all(24)
	overlay.add_theme_stylebox_override("panel", style)
	overlay.set_anchors_preset(Control.PRESET_CENTER)
	overlay.offset_left = -220.0
	overlay.offset_top = -160.0
	overlay.offset_right = 220.0
	overlay.offset_bottom = 160.0
	add_child(overlay)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 8)
	overlay.add_child(vbox)

	var title := Label.new()
	title.text = "BATTLE SUMMARY"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 20)
	title.add_theme_color_override("font_color", Color(0.9, 0.8, 0.5))
	vbox.add_child(title)

	var sep := HSeparator.new()
	vbox.add_child(sep)

	for f: FighterData in _all_party:
		var stats: Dictionary = _battle_stats.get(f, {})
		var dmg: int = stats.get("damage_dealt", 0)
		var heal: int = stats.get("healing_done", 0)
		var kills: int = stats.get("kills", 0)
		var line := Label.new()
		line.text = "%s the %s  -  DMG: %d, HEAL: %d, KOs: %d" % [
			f.character_name, f.character_type, dmg, heal, kills]
		line.add_theme_font_size_override("font_size", SettingsManager.font_size)
		vbox.add_child(line)

	var hint := Label.new()
	hint.text = "\nPress any key to continue..."
	hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hint.add_theme_font_size_override("font_size", 14)
	hint.add_theme_color_override("font_color", Color(0.6, 0.6, 0.6))
	vbox.add_child(hint)

	# Wait for confirm input to dismiss
	await get_tree().create_timer(0.5).timeout  # Brief delay to prevent accidental skip
	while not Input.is_action_just_pressed("confirm"):
		await get_tree().process_frame
	overlay.queue_free()


func _on_fighter_died(fighter: FighterData) -> void:
	# Track kills for party members
	if _current_actor != null and _battle_stats.has(_current_actor) \
			and not _all_party.has(fighter):
		_battle_stats[_current_actor]["kills"] += 1


func _on_battle_won() -> void:
	pass  # Handled in _end_battle


func _on_battle_lost() -> void:
	pass  # Handled in _end_battle


func _rebuild_cards_if_needed() -> void:
	# Mark dead fighters' cards as dead (desaturated) instead of hiding
	for card: PortraitCard in _party_cards:
		var fighter: FighterData = card.get_fighter()
		var is_dead: bool = not _engine.units.has(fighter)
		card.set_dead(is_dead)
		card.update_display(fighter)
	for card: PortraitCard in _enemy_cards:
		var fighter: FighterData = card.get_fighter()
		var is_dead: bool = not _engine.enemies.has(fighter)
		card.set_dead(is_dead)
		card.update_display(fighter)


func _compute_turn_order() -> void:
	## Predict the next several turns by simulating ATB ticks forward.
	_turn_queue.clear()

	var all_fighters: Array = []
	for f: FighterData in _engine.units:
		all_fighters.append(f)
	for f: FighterData in _engine.enemies:
		all_fighters.append(f)

	if all_fighters.is_empty():
		return

	# Snapshot current ATB values
	var atb: Dictionary = {}
	for f: FighterData in all_fighters:
		atb[f] = f.turn_calculation

	var show_count: int = mini(8, all_fighters.size() * 2)

	while _turn_queue.size() < show_count:
		# Tick until someone reaches 100
		var ready: Array = []
		for _i: int in 200:  # safety limit
			for f: FighterData in all_fighters:
				atb[f] += f.speed
			ready.clear()
			for f: FighterData in all_fighters:
				if atb[f] >= 100:
					ready.append(f)
			if not ready.is_empty():
				break

		if ready.is_empty():
			break

		# Sort by highest ATB (same as get_acting_units)
		ready.sort_custom(func(a: FighterData, b: FighterData) -> bool:
			return atb[a] > atb[b])

		for f: FighterData in ready:
			atb[f] -= 100
			_turn_queue.append(f)


func _display_turn_order() -> void:
	## Render the turn queue. Current actor in green, allies cyan, enemies salmon.
	var parts: Array[String] = []

	# Current actor first (green)
	if _current_actor != null:
		parts.append("[color=lime]%s[/color]" % _current_actor.character_name)

	# Remaining queue
	for f: FighterData in _turn_queue:
		if _engine.units.has(f):
			parts.append("[color=cyan]%s[/color]" % f.character_name)
		else:
			parts.append("[color=salmon]%s[/color]" % f.character_name)

	_turn_order_label.clear()
	_turn_order_label.append_text(
		"[color=gray]Turn Order:[/color]  " + "  >  ".join(parts))


# =============================================================================
# Portrait cards
# =============================================================================

func _get_portrait_texture(fighter: FighterData) -> Texture2D:
	var key: String
	if fighter.is_user_controlled:
		key = fighter.character_type + "_" + fighter.portrait_variant
	else:
		key = fighter.class_id if not fighter.class_id.is_empty() else fighter.character_type
	if _portrait_cache.has(key):
		return _portrait_cache[key]

	var path: String
	if fighter.is_user_controlled:
		var slug: String = fighter.character_type.to_lower().replace(" ", "_")
		path = "res://assets/art/portraits/classes/%s_%s.png" % [slug, fighter.portrait_variant]
	else:
		var slug: String = key.to_snake_case()
		path = "res://assets/art/portraits/enemies/%s.png" % slug

	var tex: Texture2D = null
	if ResourceLoader.exists(path):
		tex = load(path) as Texture2D

	_portrait_cache[key] = tex
	return tex


func _highlight_active_card(fighter: FighterData) -> void:
	# Deactivate previous
	if _active_card:
		_active_card.set_active(false)
		_active_card = null

	if fighter == null:
		return

	# Find the card for this fighter
	for card: PortraitCard in _party_cards:
		if card.get_fighter() == fighter:
			card.set_active(true)
			_active_card = card
			return
	for card: PortraitCard in _enemy_cards:
		if card.get_fighter() == fighter:
			card.set_active(true)
			_active_card = card
			return


# =============================================================================
# Multiplayer RPCs & helpers
# =============================================================================

## Host executes a remote player's action on the engine.
func _execute_remote_action(actor: FighterData, action: Dictionary) -> void:
	var action_type: String = action.get("type", "attack")
	var target_index: int = action.get("target_index", 0)

	match action_type:
		"attack":
			var taunter: FighterData = _engine.get_taunt_target(_engine.enemies)
			var target: FighterData
			if taunter:
				target = taunter
			elif target_index < _engine.enemies.size():
				target = _engine.enemies[target_index]
			else:
				target = _engine.enemies[0]
			_engine.physical_attack(actor, target)

		"ability_enemy":
			var ability: AbilityData = _find_ability(actor, action.get("ability_name", ""))
			if ability == null:
				_engine.physical_attack(actor, _engine.enemies[0])
				return
			actor.mana -= ability.mana_cost
			_set_cooldown(actor, ability)
			if ability.target_all:
				for enemy: FighterData in _engine.enemies.duplicate():
					_engine.use_ability_on_enemy(actor, enemy, ability, true)
			else:
				var taunter: FighterData = _engine.get_taunt_target(_engine.enemies)
				var target: FighterData
				if taunter:
					target = taunter
				elif target_index < _engine.enemies.size():
					target = _engine.enemies[target_index]
				else:
					target = _engine.enemies[0]
				_engine.use_ability_on_enemy(actor, target, ability)

		"ability_ally":
			var ability: AbilityData = _find_ability(actor, action.get("ability_name", ""))
			if ability == null:
				return
			actor.mana -= ability.mana_cost
			_set_cooldown(actor, ability)
			if ability.target_all:
				for ally: FighterData in _engine.units.duplicate():
					_engine.use_ability_on_teammate(actor, ally, ability, true)
			else:
				if target_index < _engine.units.size():
					_engine.use_ability_on_teammate(actor, _engine.units[target_index], ability)


func _find_ability(actor: FighterData, ability_name: String) -> AbilityData:
	for a: AbilityData in actor.abilities:
		if a.ability_name == ability_name:
			return a
	return null


## Host broadcasts full fighter state to all peers after each action.
func _broadcast_state_sync() -> void:
	if not NetManager.is_host:
		return

	# Serialize all fighters
	var party_state: Array[Dictionary] = []
	for f: FighterData in _all_party:
		party_state.append(_serialize_fighter_combat(f))
	var enemy_state: Array[Dictionary] = []
	for f: FighterData in _all_enemies:
		enemy_state.append(_serialize_fighter_combat(f))

	# Alive indices
	var alive_party: Array[int] = []
	for f: FighterData in _engine.units:
		var idx: int = _all_party.find(f)
		if idx >= 0:
			alive_party.append(idx)
	var alive_enemies: Array[int] = []
	for f: FighterData in _engine.enemies:
		var idx: int = _all_enemies.find(f)
		if idx >= 0:
			alive_enemies.append(idx)

	# Combat log messages accumulated since last sync
	var log_lines: Array[String] = _message_queue.duplicate()

	_rpc_state_sync.rpc(party_state, enemy_state, alive_party, alive_enemies, log_lines)


func _serialize_fighter_combat(f: FighterData) -> Dictionary:
	return {
		"hp": f.health,
		"max_hp": f.max_health,
		"mp": f.mana,
		"max_mp": f.max_mana,
		"atb": f.turn_calculation,
		"phys_atk": f.physical_attack,
		"phys_def": f.physical_defense,
		"mag_atk": f.magic_attack,
		"mag_def": f.magic_defense,
		"speed": f.speed,
		"crit": f.crit_chance,
		"dodge": f.dodge_chance,
		"cooldowns": f.ability_cooldowns.duplicate(),
	}


func _apply_fighter_combat(f: FighterData, data: Dictionary) -> void:
	f.health = data.get("hp", f.health)
	f.max_health = data.get("max_hp", f.max_health)
	f.mana = data.get("mp", f.mana)
	f.max_mana = data.get("max_mp", f.max_mana)
	f.turn_calculation = data.get("atb", f.turn_calculation)
	f.physical_attack = data.get("phys_atk", f.physical_attack)
	f.physical_defense = data.get("phys_def", f.physical_defense)
	f.magic_attack = data.get("mag_atk", f.magic_attack)
	f.magic_defense = data.get("mag_def", f.magic_defense)
	f.speed = data.get("speed", f.speed)
	f.crit_chance = data.get("crit", f.crit_chance)
	f.dodge_chance = data.get("dodge", f.dodge_chance)
	var cd = data.get("cooldowns", {})
	f.ability_cooldowns = cd.duplicate() if cd is Dictionary else {}


## Host -> All: Full state sync after each action.
@rpc("authority", "call_remote", "reliable")
func _rpc_state_sync(
	party_state: Array,
	enemy_state: Array,
	alive_party: Array,
	alive_enemies: Array,
	log_lines: Array,
) -> void:
	# Apply combat state to local fighter instances
	for i: int in mini(party_state.size(), _all_party.size()):
		_apply_fighter_combat(_all_party[i], party_state[i])
	for i: int in mini(enemy_state.size(), _all_enemies.size()):
		_apply_fighter_combat(_all_enemies[i], enemy_state[i])

	# Update alive/dead status on engine arrays
	_engine.units.clear()
	for idx: int in alive_party:
		if idx < _all_party.size():
			_engine.units.append(_all_party[idx])
	_engine.enemies.clear()
	for idx: int in alive_enemies:
		if idx < _all_enemies.size():
			_engine.enemies.append(_all_enemies[idx])

	# Display combat log messages
	for line: String in log_lines:
		_add_log(line)

	# Refresh cards
	_rebuild_cards_if_needed()
	_refresh_cards()


## Host -> Specific Peer: Request player action for their character.
@rpc("authority", "call_remote", "reliable")
func _rpc_request_action(actor_party_idx: int) -> void:
	# Guest receives: show action menu for this character
	if actor_party_idx < 0 or actor_party_idx >= _all_party.size():
		return
	var actor: FighterData = _all_party[actor_party_idx]
	_current_actor = actor
	_highlight_active_card(actor)

	# Turn announcement
	var turn_text: String
	if actor.character_name.ends_with("s"):
		turn_text = "It is %s' turn." % actor.character_name
	else:
		turn_text = "It is %s's turn." % actor.character_name
	_add_log_separator()
	_add_log("[color=yellow]%s[/color]" % turn_text)

	_phase = Phase.PLAYER_ACTION
	_show_action_menu(actor)
	await _player_turn_done
	# Action completed -- send it to host
	# (action dict was built by the modified _on_target_selected / _on_ability_selected)


## Guest -> Host: Submit chosen action.
@rpc("any_peer", "call_remote", "reliable")
func _rpc_submit_action(action: Dictionary) -> void:
	if not NetManager.is_host:
		return
	_remote_action_received.emit(action)


## Host -> All: Battle ended.
@rpc("authority", "call_remote", "reliable")
func _rpc_battle_ended(won: bool) -> void:
	_phase = Phase.BATTLE_END
	_highlight_active_card(null)
	if won:
		_add_log("[color=gold]Victory! The enemies have been vanquished.[/color]")
	else:
		_add_log("[color=red]The party has been defeated...[/color]")
	await get_tree().create_timer(2.0).timeout
	if won:
		GameState.advance_to_post_battle()
		SceneManager.change_scene("res://scenes/narrative/narrative.tscn", 0.4, true)
	else:
		GameState.go_to_ending(false)
		SceneManager.change_scene("res://scenes/narrative/narrative.tscn")


## Host -> All: Combat log line (for real-time log display).
@rpc("authority", "call_remote", "reliable")
func _rpc_combat_log(text: String) -> void:
	_add_log(text)


## Handle peer disconnect during battle. If we're awaiting their action, emit
## a fallback attack so the tick loop can continue.
func _on_peer_left_mid_battle(_peer_id: int, player_name: String) -> void:
	_add_log("[color=yellow]%s disconnected. AI will take over.[/color]" % player_name)
	# If we're waiting for a remote action, unblock the tick loop
	if _phase == Phase.PLAYER_ACTION and _waiting_overlay.visible:
		_remote_action_received.emit({"type": "attack", "target_index": 0})
