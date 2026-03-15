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


func _ready() -> void:
	keyboard_bindings = DEFAULT_KEYBOARD_BINDINGS.duplicate(true)
	apply_bindings()


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
		# Gamepad bindings (hardcoded)
		var pads: Array = _GAMEPAD_BINDINGS.get(action, [])
		for pad: Dictionary in pads:
			if pad["type"] == "button":
				var ev := InputEventJoypadButton.new()
				ev.button_index = int(pad["index"]) as JoyButton
				InputMap.action_add_event(action, ev)
			elif pad["type"] == "axis":
				var ev := InputEventJoypadMotion.new()
				ev.axis = int(pad["axis"]) as JoyAxis
				ev.axis_value = pad["value"]
				InputMap.action_add_event(action, ev)


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


func load_bindings(data: Dictionary) -> void:
	## Called by SettingsManager on startup with saved binding data.
	if data.is_empty():
		return
	for action: String in ACTION_NAMES:
		if data.has(action):
			keyboard_bindings[action] = data[action]
	apply_bindings()
