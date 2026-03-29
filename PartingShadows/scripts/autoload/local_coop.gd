extends Node

## Local co-op manager. Tracks which device each local player uses,
## gates input so only the active player's controller is accepted,
## and maps party slots to local players.
##
## Mutually exclusive with NetManager.is_multiplayer_active.

## Whether local co-op is active (2+ players on same machine)
var is_active: bool = false
## Number of local players (2 or 3)
var player_count: int = 1
## player_devices[i] = device_id (-1 = keyboard, 0+ = gamepad index)
var player_devices: Array[int] = []
## player_slots[i] = Array[int] of party indices this player controls
var player_slots: Array = []
## Which local player currently has input authority (-1 = no gating, all can act)
var active_player: int = -1


func _input(event: InputEvent) -> void:
	if not is_active or active_player < 0:
		return
	# Always allow pause regardless of active player
	if event.is_action("pause"):
		return
	# Determine the active device
	var active_device: int = player_devices[active_player] if active_player < player_devices.size() else -1
	var should_consume: bool = false
	if active_device == -1:
		# Active player uses keyboard — consume gamepad events
		if event is InputEventJoypadButton or event is InputEventJoypadMotion:
			should_consume = true
	else:
		# Active player uses a gamepad — consume keyboard and other gamepad events
		if event is InputEventKey or event is InputEventMouseButton:
			should_consume = true
		elif (event is InputEventJoypadButton or event is InputEventJoypadMotion) \
				and event.device != active_device:
			should_consume = true
	if should_consume:
		get_viewport().set_input_as_handled()


## Start a local co-op session with the given player count.
func start(count: int) -> void:
	is_active = true
	player_count = count
	player_devices.clear()
	player_slots.clear()
	active_player = -1
	GameLog.info("LocalCoop: Started with %d players" % count)


## End the local co-op session.
func stop() -> void:
	is_active = false
	player_count = 1
	player_devices.clear()
	player_slots.clear()
	active_player = -1


## Assign party slot indices based on player count and party size.
## Call after party is created.
func assign_slots(party_size: int) -> void:
	player_slots.clear()
	if player_count == 2:
		# P0 gets slots 0 and 2 (if exists), P1 gets slot 1
		var p0: Array[int] = [0]
		if party_size > 2:
			p0.append(2)
		player_slots.append(p0)
		player_slots.append([1] as Array[int])
	elif player_count == 3:
		# Each player gets one slot
		player_slots.append([0] as Array[int])
		player_slots.append([1] as Array[int])
		if party_size > 2:
			player_slots.append([2] as Array[int])


## Set which local player has input authority.
func set_active_player(idx: int) -> void:
	active_player = idx


## Clear input gating — any player can act.
func clear_active_player() -> void:
	active_player = -1


## Which local player owns this party slot? Returns -1 if not found.
func get_player_for_slot(party_idx: int) -> int:
	for i: int in player_slots.size():
		if party_idx in player_slots[i]:
			return i
	return -1


## Which local player uses this device? Returns -1 if not found.
func get_player_for_device(device_id: int) -> int:
	return player_devices.find(device_id)


## Display name for a local player.
func get_player_name(idx: int) -> String:
	return "Player %d" % (idx + 1)


## Returns true if this event should be blocked because another player currently
## has input authority. Use at the top of any _input() handler that should
## respect co-op turn gating.
func is_event_gated(event: InputEvent) -> bool:
	if not is_active or active_player < 0:
		return false
	if event.is_action("pause"):
		return false
	var active_device: int = player_devices[active_player] if active_player < player_devices.size() else -1
	if active_device == -1:
		return event is InputEventJoypadButton or event is InputEventJoypadMotion
	if event is InputEventKey or event is InputEventMouseButton:
		return true
	if (event is InputEventJoypadButton or event is InputEventJoypadMotion) \
			and event.device != active_device:
		return true
	return false
