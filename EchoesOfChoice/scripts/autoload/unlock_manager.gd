extends Node

## Persistent unlock tracking. Survives across saves and sessions.
## Stores completion state in user://unlocks.json.

const UNLOCKS_PATH := "user://unlocks.json"

var _unlocks: Dictionary = {}


func _ready() -> void:
	_load_unlocks()


func is_unlocked(key: String) -> bool:
	if key.is_empty():
		return true
	return _unlocks.get(key, false)


func unlock(key: String) -> void:
	if key.is_empty():
		return
	if _unlocks.get(key, false):
		return
	_unlocks[key] = true
	GameLog.info("Unlocked: %s" % key)
	_save_unlocks()


func _save_unlocks() -> void:
	var file := FileAccess.open(UNLOCKS_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(_unlocks, "\t"))
		file.close()


func _load_unlocks() -> void:
	if not FileAccess.file_exists(UNLOCKS_PATH):
		return
	var file := FileAccess.open(UNLOCKS_PATH, FileAccess.READ)
	if not file:
		return
	var json := JSON.new()
	if json.parse(file.get_as_text()) == OK:
		_unlocks = json.data
	file.close()
