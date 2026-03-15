class_name FighterPicker extends ColorRect

## Overlay for assigning party fighters to multiplayer peers.
## Host sees live assignment state; guests click Claim to request a slot.
## Used by lobby (Load Save) and pause overlay (Open to Multiplayer).

signal assignment_confirmed(slot_owners: Dictionary)
signal assignment_cancelled

const FighterData := preload("res://scripts/data/fighter_data.gd")

var _party: Array = []  ## Array[FighterData]
var _target_player_count: int = 2
var _slot_owners: Dictionary = {}  ## slot_index (int) -> peer_id (int)

var _cards_hbox: HBoxContainer
var _owner_labels: Array[Label] = []
var _claim_btns: Array[Button] = []
var _confirm_btn: Button
var _cancel_btn: Button
var _title_label: Label


func _init() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	color = Color(0.0, 0.0, 0.0, 0.6)
	mouse_filter = Control.MOUSE_FILTER_STOP


func _ready() -> void:
	_build_ui()


func setup(party: Array, target_player_count: int) -> void:
	_party = party
	_target_player_count = target_player_count
	# Default: host owns all slots
	for i: int in party.size():
		_slot_owners[i] = 1
	_refresh_display()


func _build_ui() -> void:
	var center := CenterContainer.new()
	center.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(center)

	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(600, 0)
	center.add_child(panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 20)
	margin.add_theme_constant_override("margin_top", 16)
	margin.add_theme_constant_override("margin_right", 20)
	margin.add_theme_constant_override("margin_bottom", 16)
	panel.add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 16)
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	margin.add_child(vbox)

	_title_label = Label.new()
	_title_label.text = "ASSIGN FIGHTERS"
	_title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_title_label.add_theme_font_size_override("font_size", 24)
	_title_label.add_theme_color_override("font_color", Color(0.9, 0.8, 0.5))
	vbox.add_child(_title_label)

	var sep := HSeparator.new()
	vbox.add_child(sep)

	_cards_hbox = HBoxContainer.new()
	_cards_hbox.add_theme_constant_override("separation", 16)
	_cards_hbox.alignment = BoxContainer.ALIGNMENT_CENTER
	vbox.add_child(_cards_hbox)

	# Bottom buttons
	var btn_row := HBoxContainer.new()
	btn_row.add_theme_constant_override("separation", 16)
	btn_row.alignment = BoxContainer.ALIGNMENT_CENTER
	vbox.add_child(btn_row)

	_confirm_btn = _make_button("Confirm")
	_confirm_btn.pressed.connect(_on_confirm_pressed)
	btn_row.add_child(_confirm_btn)

	_cancel_btn = _make_button("Cancel")
	_cancel_btn.pressed.connect(_on_cancel_pressed)
	btn_row.add_child(_cancel_btn)


func _refresh_display() -> void:
	# Clear old cards
	for child: Node in _cards_hbox.get_children():
		child.queue_free()
	_owner_labels.clear()
	_claim_btns.clear()

	# Build one card per fighter
	for i: int in _party.size():
		var fighter: FighterData = _party[i]
		var card := VBoxContainer.new()
		card.add_theme_constant_override("separation", 6)
		card.custom_minimum_size = Vector2(160, 0)
		_cards_hbox.add_child(card)

		var name_label := Label.new()
		name_label.text = fighter.character_name
		name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		name_label.add_theme_font_size_override("font_size", 20)
		name_label.add_theme_color_override("font_color", Color(0.9, 0.85, 0.7))
		card.add_child(name_label)

		var class_label := Label.new()
		class_label.text = "%s - Lv %d" % [fighter.character_type, fighter.level]
		class_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		class_label.add_theme_font_size_override("font_size", 16)
		card.add_child(class_label)

		var owner_label := Label.new()
		owner_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		owner_label.add_theme_font_size_override("font_size", 16)
		card.add_child(owner_label)
		_owner_labels.append(owner_label)

		var btn := Button.new()
		btn.custom_minimum_size = Vector2(140, 36)
		btn.focus_mode = Control.FOCUS_ALL
		btn.add_theme_font_size_override("font_size", SettingsManager.font_size)
		btn.pressed.connect(_on_claim_pressed.bind(i))
		card.add_child(btn)
		_claim_btns.append(btn)

	_update_labels()


func _update_labels() -> void:
	var my_id: int = multiplayer.get_unique_id() if NetManager.is_multiplayer_active else 1
	for i: int in _party.size():
		var owner_peer: int = _slot_owners.get(i, 1)
		var owner_name: String = NetManager.peer_names.get(owner_peer, "Host")
		if owner_peer == 1:
			owner_name = NetManager.peer_names.get(1, "Host")
		if i < _owner_labels.size():
			_owner_labels[i].text = owner_name
			_owner_labels[i].add_theme_color_override("font_color",
				Color(0.3, 0.9, 0.5) if owner_peer == my_id else Color(0.7, 0.8, 0.85))

		if i < _claim_btns.size():
			if owner_peer == my_id:
				_claim_btns[i].text = "Release"
				_claim_btns[i].disabled = owner_peer == 1 and NetManager.is_host
			else:
				_claim_btns[i].text = "Claim"
				_claim_btns[i].disabled = owner_peer != 1  # Can only claim from host

	# Confirm only enabled when all non-host peers have at least one slot
	_confirm_btn.visible = NetManager.is_host
	_confirm_btn.disabled = not _is_valid_assignment()

	# Focus first available claim button
	for btn: Button in _claim_btns:
		if not btn.disabled:
			btn.grab_focus()
			break


func _is_valid_assignment() -> bool:
	# Every connected non-host peer must own at least one slot
	var peer_has_slot: Dictionary = {}
	for slot_idx: int in _slot_owners:
		var peer_id: int = _slot_owners[slot_idx]
		peer_has_slot[peer_id] = true
	for peer_id: int in NetManager.peer_names:
		if peer_id == 1:
			continue
		if not peer_has_slot.has(peer_id):
			return false
	return true


func _on_claim_pressed(slot_index: int) -> void:
	if NetManager.is_host:
		# Host toggles: release slot back to host, or do nothing
		var owner: int = _slot_owners.get(slot_index, 1)
		if owner != 1:
			_slot_owners[slot_index] = 1
			_rpc_sync_assignments.rpc(_slot_owners)
			_update_labels()
	else:
		_rpc_request_claim.rpc_id(1, slot_index)


func _on_confirm_pressed() -> void:
	if not NetManager.is_host:
		return
	_apply_assignments()
	assignment_confirmed.emit(_slot_owners)


func _on_cancel_pressed() -> void:
	assignment_cancelled.emit()


func _apply_assignments() -> void:
	NetManager.peer_slots.clear()
	for slot_idx: int in _slot_owners:
		var peer_id: int = _slot_owners[slot_idx]
		if not NetManager.peer_slots.has(peer_id):
			NetManager.peer_slots[peer_id] = []
		NetManager.peer_slots[peer_id].append(slot_idx)
	var my_id: int = multiplayer.get_unique_id()
	NetManager.my_slots = NetManager.peer_slots.get(my_id, [])
	for i: int in _party.size():
		_party[i].owner_peer_id = _slot_owners.get(i, 1)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		_on_cancel_pressed()


# =============================================================================
# RPCs
# =============================================================================

## Guest -> Host: Request to claim a fighter slot.
@rpc("any_peer", "call_remote", "reliable")
func _rpc_request_claim(slot_index: int) -> void:
	if not NetManager.is_host:
		return
	var sender: int = multiplayer.get_remote_sender_id()
	# Release any slot this peer previously held
	for i: int in _slot_owners.size():
		if _slot_owners.get(i, 1) == sender:
			_slot_owners[i] = 1
	# Assign requested slot
	_slot_owners[slot_index] = sender
	_rpc_sync_assignments.rpc(_slot_owners)
	_update_labels()


## Host -> All: Broadcast updated slot assignments.
@rpc("authority", "call_local", "reliable")
func _rpc_sync_assignments(owners: Dictionary) -> void:
	_slot_owners = owners
	_update_labels()
