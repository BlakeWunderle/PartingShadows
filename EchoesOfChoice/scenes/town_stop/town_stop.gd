extends Control

## Town stop scene. Shows narrative, per-character class upgrades, branch choices.
## Flow: pre_battle_text → per-character upgrade picks → post_battle_text → branch/advance.

const DialoguePanel := preload("res://scripts/ui/dialogue_panel.gd")
const ChoiceMenu := preload("res://scripts/ui/choice_menu.gd")
const TipOverlay := preload("res://scripts/ui/tip_overlay.gd")
const WaitingOverlay := preload("res://scripts/ui/waiting_overlay.gd")
const FighterData := preload("res://scripts/data/fighter_data.gd")

enum TownPhase { INTRO_TEXT, UPGRADING, UPGRADE_REVEAL, OUTRO_TEXT, BRANCH_CHOICE }

var _dialogue: DialoguePanel
var _choice_menu: ChoiceMenu
var _tip_overlay: TipOverlay
var _waiting_overlay: WaitingOverlay
var _upgrade_label: Label
var _scene_image: TextureRect
var _phase: TownPhase = TownPhase.INTRO_TEXT
var _upgrade_index: int = 0  ## Which party member is choosing


func _ready() -> void:
	_build_ui()
	_start_town()


func _build_ui() -> void:
	# Background image (behind everything)
	_scene_image = TextureRect.new()
	_scene_image.set_anchors_preset(Control.PRESET_FULL_RECT)
	_scene_image.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_scene_image.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	_scene_image.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	add_child(_scene_image)

	# Dark overlay for text readability
	var overlay := ColorRect.new()
	overlay.set_anchors_preset(Control.PRESET_FULL_RECT)
	overlay.color = Color(0, 0, 0, 0.55)
	add_child(overlay)

	var margin := MarginContainer.new()
	margin.anchor_left = 0.0
	margin.anchor_top = 0.0
	margin.anchor_right = 1.0
	margin.anchor_bottom = 0.5
	margin.add_theme_constant_override("margin_left", 80)
	margin.add_theme_constant_override("margin_right", 80)
	margin.add_theme_constant_override("margin_top", 60)
	margin.add_theme_constant_override("margin_bottom", 20)
	add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
	margin.add_child(vbox)

	_dialogue = DialoguePanel.new()
	_dialogue.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_dialogue.all_text_finished.connect(_on_text_finished)
	vbox.add_child(_dialogue)

	_upgrade_label = Label.new()
	_upgrade_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_upgrade_label.add_theme_font_size_override("font_size", 20)
	_upgrade_label.visible = false
	vbox.add_child(_upgrade_label)

	_choice_menu = ChoiceMenu.new()
	_choice_menu.visible = false
	_choice_menu.choice_selected.connect(_on_choice_selected)
	vbox.add_child(_choice_menu)

	_tip_overlay = TipOverlay.new()
	add_child(_tip_overlay)

	_waiting_overlay = WaitingOverlay.new()
	add_child(_waiting_overlay)


func _start_town() -> void:
	var battle = GameState.current_battle
	if not battle.scene_image.is_empty() and ResourceLoader.exists(battle.scene_image):
		_scene_image.texture = load(battle.scene_image)
	if not battle.music_track.is_empty():
		MusicManager.play_music(battle.music_track)
	else:
		MusicManager.play_context(MusicManager.MusicContext.TOWN)
	_phase = TownPhase.INTRO_TEXT
	if not battle.pre_battle_text.is_empty():
		_dialogue.show_text(battle.pre_battle_text)
	else:
		_begin_upgrades()


func _on_text_finished() -> void:
	# In multiplayer, only host advances dialogue
	if NetManager.is_multiplayer_active and not NetManager.is_host:
		return

	match _phase:
		TownPhase.INTRO_TEXT:
			if NetManager.is_multiplayer_active:
				_rpc_begin_upgrades.rpc()
			_begin_upgrades()
		TownPhase.UPGRADE_REVEAL:
			_dialogue.visible = false
			_upgrade_index += 1
			if NetManager.is_multiplayer_active:
				_rpc_advance_upgrade.rpc(_upgrade_index)
			_show_next_upgrade()
		TownPhase.OUTRO_TEXT:
			_check_branch_or_advance()


func _begin_upgrades() -> void:
	_phase = TownPhase.UPGRADING
	_upgrade_index = 0
	_dialogue.visible = false
	_tip_overlay.show_tip_once("first_town",
		"Town stops let you upgrade your party. " +
		"Each character can evolve into a specialized class.\n\n" +
		"Tier 0 classes upgrade to Tier 1, " +
		"and Tier 1 upgrades to Tier 2. " +
		"Each upgrade unlocks new abilities and improves stats.\n\n" +
		"Choose wisely. Upgrades are permanent!")
	_show_next_upgrade()


func _show_next_upgrade() -> void:
	_waiting_overlay.hide_waiting()
	# Skip party members with no upgrades available
	while _upgrade_index < GameState.party.size() \
			and GameState.party[_upgrade_index].upgrade_items.is_empty():
		_upgrade_index += 1

	if _upgrade_index >= GameState.party.size():
		_finish_upgrades()
		return

	var fighter: FighterData = GameState.party[_upgrade_index]
	_phase = TownPhase.UPGRADING

	# In multiplayer, check if this character belongs to a remote player
	if NetManager.is_multiplayer_active and not NetManager.is_my_fighter(_upgrade_index):
		var owner_name: String = NetManager.get_fighter_owner_name(_upgrade_index)
		_upgrade_label.visible = false
		_choice_menu.visible = false
		_waiting_overlay.show_waiting(owner_name)
		# Host sends upgrade request to the owning peer
		if NetManager.is_host:
			var owner_peer: int = NetManager.get_fighter_owner_peer(_upgrade_index)
			var items: Array[String] = fighter.upgrade_items.duplicate()
			_rpc_request_upgrade.rpc_id(owner_peer, _upgrade_index, fighter.character_name,
				fighter.character_type, items)
		return

	_upgrade_label.text = "%s the %s. Choose an upgrade:" % [
		fighter.character_name, fighter.character_type]
	_upgrade_label.visible = true

	var options: Array[Dictionary] = []
	for item: String in fighter.upgrade_items:
		options.append({"label": item})
	_choice_menu.show_choices(options)


func _on_choice_selected(index: int) -> void:
	match _phase:
		TownPhase.UPGRADING:
			_on_upgrade_selected(index)
		TownPhase.BRANCH_CHOICE:
			_on_branch_selected(index)


func _on_upgrade_selected(index: int) -> void:
	var fighter: FighterData = GameState.party[_upgrade_index]
	var item: String = fighter.upgrade_items[index]

	# In multiplayer as guest: send choice to host instead of applying locally
	if NetManager.is_multiplayer_active and not NetManager.is_host:
		_rpc_submit_upgrade.rpc_id(1, _upgrade_index, item)
		_choice_menu.hide_menu()
		_upgrade_label.visible = false
		# Wait for host to broadcast the result
		return

	var old_name: String = fighter.character_name
	GameState.upgrade_party_member(fighter, item)
	var new_class: String = fighter.character_type
	GameLog.info("Upgrade: %s -> %s" % [old_name, new_class])

	# Broadcast upgrade result to all peers
	if NetManager.is_multiplayer_active:
		_rpc_upgrade_applied.rpc(_upgrade_index, item, old_name, new_class)

	_choice_menu.hide_menu()
	_upgrade_label.visible = false
	_phase = TownPhase.UPGRADE_REVEAL
	_dialogue.visible = true
	_dialogue.show_text([
		"%s takes the %s..." % [old_name, item],
		"%s is now a %s!" % [old_name, new_class],
	])


func _finish_upgrades() -> void:
	# Level up party after upgrades
	GameState.level_up_party()

	# Show outro text if any
	var battle = GameState.current_battle
	if not battle.post_battle_text.is_empty():
		_phase = TownPhase.OUTRO_TEXT
		_dialogue.visible = true
		_dialogue.show_text(battle.post_battle_text)
	else:
		_check_branch_or_advance()


func _check_branch_or_advance() -> void:
	var battle = GameState.current_battle
	if not battle.choices.is_empty():
		# In multiplayer, only host sees branch choices; guests wait
		if NetManager.is_multiplayer_active and not NetManager.is_host:
			return
		_phase = TownPhase.BRANCH_CHOICE
		_dialogue.visible = false
		_upgrade_label.text = "Choose your path:"
		_upgrade_label.visible = true
		var options: Array[Dictionary] = []
		for choice: Dictionary in battle.choices:
			options.append({"label": choice["label"]})
		_choice_menu.show_choices(options)
	else:
		_advance()


func _on_branch_selected(index: int) -> void:
	_choice_menu.hide_menu()
	_upgrade_label.visible = false
	var battle_id: String = GameState.current_battle.choices[index]["battle_id"]
	if NetManager.is_multiplayer_active:
		_rpc_branch_chosen.rpc(battle_id)
	GameState.advance_with_choice(battle_id)
	_go_to_next()


func _advance() -> void:
	GameState.advance_to_next_battle()
	if NetManager.is_multiplayer_active and NetManager.is_host:
		_rpc_advance_next.rpc(GameState.current_battle_id)
	_go_to_next()


func _go_to_next() -> void:
	var scene_path: String = "res://scenes/narrative/narrative.tscn"
	match GameState.game_phase:
		GameState.GamePhase.ENDING:
			GameState.game_won = true
		_:
			pass
	if NetManager.is_multiplayer_active and NetManager.is_host:
		_rpc_change_scene.rpc(scene_path)
	SceneManager.change_scene(scene_path)


# =============================================================================
# Multiplayer RPCs
# =============================================================================

## Host -> All: Begin upgrade phase (after intro text finishes).
@rpc("authority", "call_remote", "reliable")
func _rpc_begin_upgrades() -> void:
	_begin_upgrades()


## Host -> All: Advance to next upgrade index.
@rpc("authority", "call_remote", "reliable")
func _rpc_advance_upgrade(new_index: int) -> void:
	_dialogue.visible = false
	_upgrade_index = new_index
	_show_next_upgrade()


## Host -> Guest: Request the owning player to choose an upgrade.
@rpc("authority", "call_remote", "reliable")
func _rpc_request_upgrade(party_index: int, char_name: String, char_class: String,
		items: Array) -> void:
	_upgrade_index = party_index
	_phase = TownPhase.UPGRADING
	_waiting_overlay.hide_waiting()
	_upgrade_label.text = "%s the %s. Choose an upgrade:" % [char_name, char_class]
	_upgrade_label.visible = true
	var options: Array[Dictionary] = []
	for item: String in items:
		options.append({"label": item})
	_choice_menu.show_choices(options)


## Guest -> Host: Submit chosen upgrade item.
@rpc("any_peer", "call_remote", "reliable")
func _rpc_submit_upgrade(party_index: int, item: String) -> void:
	if not NetManager.is_host:
		return
	var fighter: FighterData = GameState.party[party_index]
	var old_name: String = fighter.character_name
	GameState.upgrade_party_member(fighter, item)
	var new_class: String = fighter.character_type
	GameLog.info("Upgrade: %s -> %s (remote)" % [old_name, new_class])
	_rpc_upgrade_applied.rpc(party_index, item, old_name, new_class)
	_waiting_overlay.hide_waiting()
	_choice_menu.hide_menu()
	_upgrade_label.visible = false
	_phase = TownPhase.UPGRADE_REVEAL
	_dialogue.visible = true
	_dialogue.show_text([
		"%s takes the %s..." % [old_name, item],
		"%s is now a %s!" % [old_name, new_class],
	])


## Host -> All: Broadcast upgrade result so all peers update their party.
@rpc("authority", "call_remote", "reliable")
func _rpc_upgrade_applied(party_index: int, item: String, old_name: String,
		new_class: String) -> void:
	var fighter: FighterData = GameState.party[party_index]
	GameState.upgrade_party_member(fighter, item)
	GameLog.info("Upgrade (sync): %s -> %s" % [old_name, new_class])
	_waiting_overlay.hide_waiting()
	_choice_menu.hide_menu()
	_upgrade_label.visible = false
	_phase = TownPhase.UPGRADE_REVEAL
	_dialogue.visible = true
	_dialogue.show_text([
		"%s takes the %s..." % [old_name, item],
		"%s is now a %s!" % [old_name, new_class],
	])


## Host -> All: Branch choice made by host.
@rpc("authority", "call_remote", "reliable")
func _rpc_branch_chosen(battle_id: String) -> void:
	GameState.advance_with_choice(battle_id)
	_go_to_next()


## Host -> All: Advance to next battle (no branch).
@rpc("authority", "call_remote", "reliable")
func _rpc_advance_next(battle_id: String) -> void:
	if not battle_id.is_empty():
		GameState.advance_to_battle(battle_id)


## Host -> All: Change scene on all peers.
@rpc("authority", "call_remote", "reliable")
func _rpc_change_scene(scene_path: String) -> void:
	SceneManager.change_scene(scene_path)
