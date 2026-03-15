extends Control

## Generic narrative scene for pre-battle, post-battle, and ending text.
## Reads GameState to determine which text to show and where to go next.
## After post-battle text, handles branch choices and town stop transitions.

const DialoguePanel := preload("res://scripts/ui/dialogue_panel.gd")
const ChoiceMenu := preload("res://scripts/ui/choice_menu.gd")
const ReadyGate := preload("res://scripts/ui/ready_gate.gd")
const VotePanel := preload("res://scripts/ui/vote_panel.gd")
const _StoryDB := preload("res://scripts/data/story_db.gd")

var _dialogue: DialoguePanel
var _choice_menu: ChoiceMenu
var _ready_gate: ReadyGate
var _vote_panel: VotePanel
var _scene_image: TextureRect
var _pending_advance: Callable  ## What to do after all players ready up


func _ready() -> void:
	_build_ui()
	_show_narrative()
	if NetManager.is_multiplayer_active:
		NetManager.player_left.connect(_on_player_left)
		NetManager.session_ended.connect(_on_session_ended)


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

	_choice_menu = ChoiceMenu.new()
	_choice_menu.visible = false
	_choice_menu.choice_selected.connect(_on_branch_selected)
	vbox.add_child(_choice_menu)

	_ready_gate = ReadyGate.new()
	_ready_gate.visible = false
	_ready_gate.all_ready.connect(_on_all_ready)
	vbox.add_child(_ready_gate)

	_vote_panel = VotePanel.new()
	_vote_panel.visible = false
	_vote_panel.vote_resolved.connect(_on_vote_resolved)
	vbox.add_child(_vote_panel)


func _show_narrative() -> void:
	var battle = GameState.current_battle
	var img_path: String = ""
	if GameState.narrative_mode == GameState.NarrativeMode.POST_BATTLE and not battle.post_scene_image.is_empty():
		img_path = battle.post_scene_image
	elif not battle.scene_image.is_empty():
		img_path = battle.scene_image
	if not img_path.is_empty() and ResourceLoader.exists(img_path):
		_scene_image.texture = load(img_path)
	else:
		_scene_image.texture = null
	match GameState.game_phase:
		GameState.GamePhase.NARRATIVE:
			if not battle.music_track.is_empty():
				MusicManager.play_music(battle.music_track)
			else:
				MusicManager.play_context(MusicManager.MusicContext.BATTLE)
			if GameState.narrative_mode == GameState.NarrativeMode.PRE_BATTLE:
				_dialogue.show_text(GameState.current_battle.pre_battle_text)
			else:
				_dialogue.show_text(GameState.current_battle.post_battle_text)
		GameState.GamePhase.ENDING:
			_show_ending()
		_:
			push_error("Narrative: unexpected game_phase %s" % GameState.game_phase)
			_dialogue.show_text(["Something went wrong. Press continue to return to title."])


var _is_defeat: bool = false


func _show_ending() -> void:
	var is_first_completion: bool = false
	_is_defeat = not GameState.game_won
	if GameState.game_won:
		var story: Dictionary = _StoryDB.get_story(GameState.current_story_id)
		var completion_key: String = story.get("completion_unlock", "")
		if not completion_key.is_empty():
			is_first_completion = not UnlockManager.is_unlocked(completion_key)
			UnlockManager.unlock(completion_key)
		MusicManager.play_music("res://assets/audio/music/victory/SHORT Action #5 LOOP.wav")
	else:
		MusicManager.play_music("res://assets/audio/music/game_over/Sad Despair 03.wav")
	var lines: Array[String]
	match GameState.current_story_id:
		"story_2":
			lines = _ending_text_story_2()
		"story_3":
			lines = _ending_text_story_3()
		_:
			lines = _ending_text_story_1()
	if _is_defeat:
		lines.append("")
		lines.append("Battles won: %d" % GameState.battles_won)
	if is_first_completion:
		lines.append_array(_unlock_notification_lines())
	_dialogue.show_text(lines)


func _ending_text_story_1() -> Array[String]:
	if GameState.game_won:
		return [
			"The stranger is gone and with them, the shadow that covered the land.",
			"The sky clears. The city stirs. People emerge from hiding.",
			"It will take time, but the world will heal.",
			"Our heroes stand in the light, bruised and exhausted and alive.",
			"Every choice left an echo, and theirs will ring through the ages.",
			"",
			"Thank you for playing Echoes of Choice.",
		]
	else:
		return [
			"Our heroes fall and the darkness grows a little stronger.",
			"This journey may be over, but every great story deserves another telling.",
		]


func _ending_text_story_2() -> Array[String]:
	if GameState.game_won:
		return [
			"The Eye closes for the last time. The crystallized memories shatter, and light rises from the depths like a thousand lanterns set free.",
			"Across the coast, people stop mid-sentence. A name they forgot. A face they lost. A moment that was taken, returned without explanation.",
			"The old woman in the fishing village remembers the dinner. The blacksmith remembers why the sword was urgent. The barkeep remembers the conversations.",
			"Deep below, in the place where the Eye once watched, the party stands in silence. The machinery is dark. The crystals are empty.",
			"A voice, faint as breath, echoes through the chamber. Sera's voice, carried on the last of the light.",
			"'Thank you.'",
			"They carry her memory with them. Not because they have to. Because they choose to.",
			"",
			"Thank you for playing Echoes of Choice.",
		]
	else:
		return [
			"The Eye remains open. The memories do not return.",
			"In the darkness below the world, something watches. Something waits. Something remembers everything it has taken.",
			"This journey may be over, but every great story deserves another telling.",
		]


func _ending_text_story_3() -> Array[String]:
	if GameState.game_won:
		return [
			"The Loom is broken. The threads dissolve into the morning light, carrying with them every stolen dream, every pilfered night of rest.",
			"Across the town, people wake feeling something they cannot name. A lightness. A clarity. As if a weight they never knew they carried has been lifted.",
			"Where the innkeeper stood, there is nothing. No body, no trace. She was never real. Just another thread in the Loom, a familiar face woven from stolen dreams to lure the weary inside.",
			"The travelers stand in the street as the sun rises. For the first time in days, they are not tired. The weariness is gone, truly gone, and the road ahead feels possible again.",
			"'The Weary Traveler,' one of them reads aloud from the sign, shaking their head. 'She named the inn after what she was doing to people.'",
			"They leave the town behind. Their dreams that night are their own.",
			"",
			"Thank you for playing Echoes of Choice.",
		]
	else:
		return [
			"The Loom holds. The threads tighten. The dream does not end.",
			"Somewhere in a quiet town, a kind face smiles and pours ale for the next weary traveler. She was never real, but no one will ever know.",
			"This journey may be over, but every great story deserves another telling.",
		]


func _unlock_notification_lines() -> Array[String]:
	match GameState.current_story_id:
		"story_1":
			return [
				"",
				"New content unlocked!",
				"A new story awaits: \"Echoes in the Dark.\" Three strangers wake in a cave with no memory.",
				"A new class has emerged: the Wanderer. A wilderness fighter who learned to endure the land's magic.",
			]
		"story_2":
			return [
				"",
				"New content unlocked!",
				"A new story awaits: \"The Woven Night.\" Three travelers rest at a quiet inn. Their dreams are not their own.",
			]
		"story_3":
			return [
				"",
				"New content unlocked!",
				"You have completed all available stories. More adventures may follow.",
			]
		_:
			return []


func _on_text_finished() -> void:
	# In online multiplayer, only the host advances narrative (unless ready gate is active)
	if NetManager.is_multiplayer_active and not NetManager.is_host:
		# Show ready gate for online guests
		_show_ready_gate(_do_advance_text)
		return

	# Local co-op: show ready gate so all local players confirm
	if LocalCoop.is_active:
		_show_ready_gate(_do_advance_text)
		return

	_do_advance_text()


func _do_advance_text() -> void:
	match GameState.game_phase:
		GameState.GamePhase.NARRATIVE:
			if GameState.narrative_mode == GameState.NarrativeMode.PRE_BATTLE:
				if GameState.current_battle.enemies.is_empty():
					# No enemies, skip battle, go straight to post-battle text
					GameState.narrative_mode = GameState.NarrativeMode.POST_BATTLE
					_show_narrative()
				else:
					# Go to battle (keep music playing across transition)
					GameState.game_phase = GameState.GamePhase.BATTLE
					if NetManager.is_multiplayer_active:
						_rpc_change_scene.rpc("res://scenes/battle/battle.tscn")
					SceneManager.change_scene("res://scenes/battle/battle.tscn", 0.4, true)
			else:
				# Post-battle: level up first
				GameState.level_up_party()
				# Check for branch choices
				if not GameState.current_battle.choices.is_empty():
					_show_branch_choices()
				else:
					_advance_after_battle()
		GameState.GamePhase.ENDING:
			if _is_defeat:
				_show_defeat_choices()
			else:
				if NetManager.is_multiplayer_active:
					_rpc_change_scene.rpc("res://scenes/title/title.tscn")
				SceneManager.change_scene("res://scenes/title/title.tscn")
		_:
			if NetManager.is_multiplayer_active:
				_rpc_change_scene.rpc("res://scenes/title/title.tscn")
			SceneManager.change_scene("res://scenes/title/title.tscn")


func _show_ready_gate(callback: Callable) -> void:
	_pending_advance = callback
	if LocalCoop.is_active:
		_ready_gate.start_local(LocalCoop.player_count)
	elif NetManager.is_multiplayer_active:
		_ready_gate.start_online(NetManager.get_connected_peer_count())
		# For online: local player is immediately ready
		if NetManager.is_host:
			_ready_gate.mark_ready(0)
			_rpc_narrative_ready.rpc(0)
		else:
			# Find our index among connected peers
			var my_idx: int = _get_peer_index(multiplayer.get_unique_id())
			_ready_gate.mark_ready(my_idx)
			_rpc_narrative_ready.rpc_id(1, my_idx)


func _on_all_ready() -> void:
	if _pending_advance.is_valid():
		_pending_advance.call()
		_pending_advance = Callable()


func _get_peer_index(peer_id: int) -> int:
	var peers: Array[int] = []
	for pid: int in NetManager.peer_names:
		peers.append(pid)
	peers.sort()
	return peers.find(peer_id)


func _show_defeat_choices() -> void:
	_dialogue.visible = false
	var options: Array[Dictionary] = []
	if SaveManager.has_any_save():
		options.append({"label": "Load Last Save"})
	options.append({"label": "Return to Title"})
	_choice_menu.show_choices(options)
	_choice_menu.choice_selected.disconnect(_on_branch_selected)
	_choice_menu.choice_selected.connect(_on_defeat_choice, CONNECT_ONE_SHOT)


func _on_defeat_choice(index: int) -> void:
	_choice_menu.hide_menu()
	_choice_menu.choice_selected.connect(_on_branch_selected)
	var has_saves: bool = SaveManager.has_any_save()
	if has_saves and index == 0:
		# Load last save
		var slot: int = SaveManager.get_last_used_slot()
		if slot < 0:
			if SaveManager.has_autosave():
				slot = SaveManager.AUTOSAVE_SLOT
			else:
				for i: int in SaveManager.MAX_SAVE_SLOTS:
					if SaveManager.has_save(i):
						slot = i
						break
		if slot >= 0 and SaveManager.load_from_slot(slot):
			SceneManager.change_scene("res://scenes/narrative/narrative.tscn")
			return
	SceneManager.change_scene("res://scenes/title/title.tscn")


func _show_branch_choices() -> void:
	_dialogue.visible = false
	var options: Array[Dictionary] = []
	for choice: Dictionary in GameState.current_battle.choices:
		options.append({"label": choice["label"]})

	# Multi-player: use voting panel
	if LocalCoop.is_active:
		_vote_panel.start_local(options, LocalCoop.player_count)
		return
	if NetManager.is_multiplayer_active:
		if NetManager.is_host:
			_vote_panel.start_online(options)
		else:
			_vote_panel.start_online(options)
		return

	# Single player: direct choice
	_choice_menu.show_choices(options)


func _on_branch_selected(index: int) -> void:
	_choice_menu.hide_menu()
	_apply_branch_choice(index)


func _on_vote_resolved(winning_index: int) -> void:
	_apply_branch_choice(winning_index)


func _apply_branch_choice(index: int) -> void:
	var battle_id: String = GameState.current_battle.choices[index]["battle_id"]

	# Broadcast choice to all peers
	if NetManager.is_multiplayer_active:
		_rpc_branch_chosen.rpc(battle_id)

	GameState.advance_with_choice(battle_id)
	_navigate_after_advance()


func _navigate_after_advance() -> void:
	match GameState.game_phase:
		GameState.GamePhase.TOWN_STOP:
			if NetManager.is_multiplayer_active and NetManager.is_host:
				_rpc_change_scene.rpc("res://scenes/town_stop/town_stop.tscn")
			SceneManager.change_scene("res://scenes/town_stop/town_stop.tscn")
		GameState.GamePhase.ENDING:
			GameState.game_won = true
			_dialogue.visible = true
			_show_ending()
		_:
			_dialogue.visible = true
			_show_narrative()


func _advance_after_battle() -> void:
	if NetManager.is_multiplayer_active and NetManager.is_host:
		SaveManager.auto_save()
	elif not NetManager.is_multiplayer_active:
		SaveManager.auto_save()
	GameState.advance_to_next_battle()

	if NetManager.is_multiplayer_active and NetManager.is_host:
		# Broadcast the next battle to all peers
		_rpc_advance_to_battle.rpc(GameState.current_battle_id)

	match GameState.game_phase:
		GameState.GamePhase.ENDING:
			GameState.game_won = true
			_show_ending()
		GameState.GamePhase.TOWN_STOP:
			if NetManager.is_multiplayer_active and NetManager.is_host:
				_rpc_change_scene.rpc("res://scenes/town_stop/town_stop.tscn")
			SceneManager.change_scene("res://scenes/town_stop/town_stop.tscn")
		_:
			_show_narrative()


# =============================================================================
# Multiplayer disconnect
# =============================================================================

func _on_player_left(_peer_id: int, player_name: String) -> void:
	if not NetManager.is_host:
		return
	GameLog.info("Narrative: %s disconnected, ending session" % player_name)
	SaveManager.auto_save()
	NetManager.leave_session()
	SceneManager.change_scene("res://scenes/title/title.tscn")


func _on_session_ended(reason: String) -> void:
	GameLog.info("Narrative: Session ended (%s)" % reason)
	_choice_menu.hide_menu()
	_dialogue.visible = true
	_dialogue.show_text([reason])
	await get_tree().create_timer(2.5).timeout
	SceneManager.change_scene("res://scenes/title/title.tscn")


# =============================================================================
# Multiplayer RPCs
# =============================================================================

## Host -> All: Change scene on all peers.
@rpc("authority", "call_remote", "reliable")
func _rpc_change_scene(scene_path: String) -> void:
	SceneManager.change_scene(scene_path, 0.4, true)


## Host -> All: Branch choice made by host.
@rpc("authority", "call_remote", "reliable")
func _rpc_branch_chosen(battle_id: String) -> void:
	GameState.advance_with_choice(battle_id)
	_navigate_after_advance()


## Host -> All: Advance to next battle.
@rpc("authority", "call_remote", "reliable")
func _rpc_advance_to_battle(battle_id: String) -> void:
	if not battle_id.is_empty():
		GameState.advance_to_battle(battle_id)


## Any -> Host (or Host -> All): Player is ready to advance narrative.
@rpc("any_peer", "call_remote", "reliable")
func _rpc_narrative_ready(player_index: int) -> void:
	_ready_gate.mark_ready(player_index)
	# Host rebroadcasts to all peers so everyone sees the ready state
	if NetManager.is_host:
		_rpc_narrative_ready_broadcast.rpc(player_index)


## Host -> All: Broadcast a player's ready state.
@rpc("authority", "call_remote", "reliable")
func _rpc_narrative_ready_broadcast(player_index: int) -> void:
	_ready_gate.mark_ready(player_index)


## Any -> Host: Cast a vote for a branch choice.
@rpc("any_peer", "call_remote", "reliable")
func _rpc_cast_vote(player_index: int, choice_index: int) -> void:
	_vote_panel.receive_vote(player_index, choice_index)
	if NetManager.is_host:
		_rpc_vote_broadcast.rpc(player_index, choice_index)


## Host -> All: Broadcast a vote.
@rpc("authority", "call_remote", "reliable")
func _rpc_vote_broadcast(player_index: int, choice_index: int) -> void:
	_vote_panel.receive_vote(player_index, choice_index)
