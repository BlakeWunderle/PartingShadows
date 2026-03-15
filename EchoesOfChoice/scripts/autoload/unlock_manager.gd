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
	# Steam achievements for story completion
	match key:
		"story_1_complete":
			SteamManager.set_achievement("STORY_1_COMPLETE")
		"story_2_complete":
			SteamManager.set_achievement("STORY_2_COMPLETE")
		"story_3_complete":
			SteamManager.set_achievement("STORY_3_COMPLETE")
	if is_unlocked("story_1_complete") and is_unlocked("story_2_complete") \
			and is_unlocked("story_3_complete"):
		SteamManager.set_achievement("ALL_STORIES_COMPLETE")


func _save_unlocks() -> void:
	var json_str: String = JSON.stringify(_unlocks, "\t")
	var file := FileAccess.open(UNLOCKS_PATH, FileAccess.WRITE)
	if file:
		file.store_string(json_str)
		file.close()
	SteamManager.cloud_write("unlocks.json", json_str)


func _load_unlocks() -> void:
	var text: String = ""
	if FileAccess.file_exists(UNLOCKS_PATH):
		var file := FileAccess.open(UNLOCKS_PATH, FileAccess.READ)
		if file:
			text = file.get_as_text()
			file.close()
	if text.is_empty():
		text = SteamManager.cloud_read("unlocks.json")
	if text.is_empty():
		return
	var json := JSON.new()
	if json.parse(text) == OK:
		_unlocks = json.data
