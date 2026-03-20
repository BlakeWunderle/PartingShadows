extends Node
## Registers game-specific input actions with keyboard + gamepad bindings.
## Must be the first autoload so actions exist before any scene processes input.
## Supports runtime keyboard remapping; gamepad bindings are always hardcoded.

const ACTION_NAMES: Array[String] = [
	"move_up", "move_down", "move_left", "move_right",
	"confirm", "cancel", "inspect", "pause",
]

const ACTION_DISPLAY_NAMES: Dictionary = {
	"move_up": "Move Up",
	"move_down": "Move Down",
	"move_left": "Move Left",
	"move_right": "Move Right",
	"confirm": "Confirm",
	"cancel": "Cancel",
	"inspect": "Inspect",
	"pause": "Pause",
}

const DEFAULT_KEYBOARD_BINDINGS: Dictionary = {
	"move_up": [KEY_W, KEY_UP],
	"move_down": [KEY_S, KEY_DOWN],
	"move_left": [KEY_A, KEY_LEFT],
	"move_right": [KEY_D, KEY_RIGHT],
	"confirm": [KEY_ENTER, KEY_SPACE, KEY_Z],
	"cancel": [KEY_ESCAPE, KEY_X],
	"inspect": [KEY_TAB],
	"pause": [KEY_ESCAPE],
}

## Hardcoded gamepad bindings (not remappable)
const _GAMEPAD_BINDINGS: Dictionary = {
	"move_up": [{"type": "button", "index": JOY_BUTTON_DPAD_UP},
		{"type": "axis", "axis": JOY_AXIS_LEFT_Y, "value": -1.0}],
	"move_down": [{"type": "button", "index": JOY_BUTTON_DPAD_DOWN},
		{"type": "axis", "axis": JOY_AXIS_LEFT_Y, "value": 1.0}],
	"move_left": [{"type": "button", "index": JOY_BUTTON_DPAD_LEFT},
		{"type": "axis", "axis": JOY_AXIS_LEFT_X, "value": -1.0}],
	"move_right": [{"type": "button", "index": JOY_BUTTON_DPAD_RIGHT},
		{"type": "axis", "axis": JOY_AXIS_LEFT_X, "value": 1.0}],
	"confirm": [{"type": "button", "index": JOY_BUTTON_A}],
	"cancel": [{"type": "button", "index": JOY_BUTTON_B}],
	"inspect": [{"type": "button", "index": JOY_BUTTON_Y}],
	"pause": [{"type": "button", "index": JOY_BUTTON_START}],
}

var keyboard_bindings: Dictionary = {}
## True when a Nintendo controller is detected (A/B face buttons are swapped vs Xbox)
var _nintendo_layout: bool = false


func _ready() -> void:
	keyboard_bindings = DEFAULT_KEYBOARD_BINDINGS.duplicate(true)
	Input.joy_connection_changed.connect(_on_joy_connection_changed)
	_detect_nintendo_layout()
	apply_bindings()
	_log_connected_joypads()


func apply_bindings() -> void:
	for action: String in ACTION_NAMES:
		if InputMap.has_action(action):
			InputMap.action_erase_events(action)
		else:
			InputMap.add_action(action, 0.5)
		# Keyboard bindings (remappable)
		var keys: Array = keyboard_bindings.get(action, [])
		for keycode in keys:
			var ev := InputEventKey.new()
			ev.keycode = int(keycode) as Key
			InputMap.action_add_event(action, ev)
		# Gamepad bindings (hardcoded, with Nintendo A/B swap if needed)
		var pads: Array = _GAMEPAD_BINDINGS.get(action, [])
		for pad: Dictionary in pads:
			if pad["type"] == "button":
				var btn_index: JoyButton = int(pad["index"]) as JoyButton
				if _nintendo_layout:
					if btn_index == JOY_BUTTON_A:
						btn_index = JOY_BUTTON_B
					elif btn_index == JOY_BUTTON_B:
						btn_index = JOY_BUTTON_A
				var ev := InputEventJoypadButton.new()
				ev.button_index = btn_index
				InputMap.action_add_event(action, ev)
			elif pad["type"] == "axis":
				var ev := InputEventJoypadMotion.new()
				ev.axis = int(pad["axis"]) as JoyAxis
				ev.axis_value = pad["value"]
				InputMap.action_add_event(action, ev)
	# Add gamepad buttons to built-in UI actions so Godot controls respond to gamepads
	_add_joypad_to_ui_action("ui_accept", _get_confirm_button())
	_add_joypad_to_ui_action("ui_cancel", _get_cancel_button())


func _detect_nintendo_layout() -> void:
	_nintendo_layout = false
	for device: int in Input.get_connected_joypads():
		var pad_name: String = Input.get_joy_name(device).to_lower()
		if "nintendo" in pad_name or "pro controller" in pad_name or "joy-con" in pad_name:
			_nintendo_layout = true
			GameLog.info("Nintendo controller detected — swapping A/B buttons")
			return


func _get_confirm_button() -> JoyButton:
	return JOY_BUTTON_B if _nintendo_layout else JOY_BUTTON_A


func _get_cancel_button() -> JoyButton:
	return JOY_BUTTON_A if _nintendo_layout else JOY_BUTTON_B


func _add_joypad_to_ui_action(action_name: String, button: JoyButton) -> void:
	if not InputMap.has_action(action_name):
		return
	# Check if already mapped to avoid duplicates
	for existing: InputEvent in InputMap.action_get_events(action_name):
		if existing is InputEventJoypadButton and existing.button_index == button:
			return
	var ev := InputEventJoypadButton.new()
	ev.button_index = button
	InputMap.action_add_event(action_name, ev)


func rebind_action(action_name: String, keycode: Key) -> void:
	keyboard_bindings[action_name] = [keycode]
	apply_bindings()
	SettingsManager.save_key_bindings(keyboard_bindings)


func reset_bindings() -> void:
	keyboard_bindings = DEFAULT_KEYBOARD_BINDINGS.duplicate(true)
	apply_bindings()
	SettingsManager.save_key_bindings(keyboard_bindings)


func get_key_name(action_name: String) -> String:
	var keys: Array = keyboard_bindings.get(action_name, [])
	if keys.is_empty():
		return "None"
	return OS.get_keycode_string(int(keys[0]))


func _log_connected_joypads() -> void:
	var pads: Array[int] = Input.get_connected_joypads()
	if pads.is_empty():
		var msg := "No controllers detected"
		GameLog.info(msg)
		print(msg)
		return
	for device: int in pads:
		var pad_name: String = Input.get_joy_name(device)
		var guid: String = Input.get_joy_guid(device)
		var msg := "Controller %d: %s (GUID: %s)" % [device, pad_name, guid]
		GameLog.info(msg)
		print(msg)


func _on_joy_connection_changed(device: int, connected: bool) -> void:
	var msg: String
	if connected:
		var pad_name: String = Input.get_joy_name(device)
		var guid: String = Input.get_joy_guid(device)
		msg = "Controller %d connected: %s (GUID: %s)" % [device, pad_name, guid]
	else:
		msg = "Controller %d disconnected" % device
	GameLog.info(msg)
	print(msg)
	# Re-detect layout and rebind in case controller type changed
	_detect_nintendo_layout()
	apply_bindings()


func load_bindings(data: Dictionary) -> void:
	## Called by SettingsManager on startup with saved binding data.
	if data.is_empty():
		return
	for action: String in ACTION_NAMES:
		if data.has(action):
			keyboard_bindings[action] = data[action]
	apply_bindings()
