extends Node

## Persistent unlock tracking. Survives across saves and sessions.
## Stores completion state in user://unlocks.json.

const UNLOCKS_PATH := "user://unlocks.json"

var _unlocks: Dictionary = {}


func _ready() -> void:
	_load_unlocks()
	_reconcile_achievements()


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
			SteamManager.set_achievement("WANDERER_UNLOCKED")
		"story_2_complete":
			SteamManager.set_achievement("STORY_2_COMPLETE")
		"story_3_complete":
			SteamManager.set_achievement("STORY_3_COMPLETE")
		"story_3_path_a":
			SteamManager.set_achievement("STORY_3_PATH_A")
		"story_3_path_b":
			SteamManager.set_achievement("STORY_3_PATH_B")
		"story_3_path_c":
			SteamManager.set_achievement("STORY_3_PATH_C")
	if is_unlocked("story_1_complete") and is_unlocked("story_2_complete") \
			and is_unlocked("story_3_complete"):
		SteamManager.set_achievement("ALL_STORIES_COMPLETE")
	if is_unlocked("story_3_path_a") and is_unlocked("story_3_path_b") \
			and is_unlocked("story_3_path_c"):
		SteamManager.set_achievement("STORY_3_ALL_PATHS")


func _reconcile_achievements() -> void:
	var key_to_achievement := {
		"story_1_complete": ["STORY_1_COMPLETE", "WANDERER_UNLOCKED"],
		"story_2_complete": ["STORY_2_COMPLETE"],
		"story_3_complete": ["STORY_3_COMPLETE"],
		"story_3_path_a": ["STORY_3_PATH_A"],
		"story_3_path_b": ["STORY_3_PATH_B"],
		"story_3_path_c": ["STORY_3_PATH_C"],
	}
	for key: String in key_to_achievement:
		if is_unlocked(key):
			for achievement: String in key_to_achievement[key]:
				SteamManager.set_achievement(achievement)
	if is_unlocked("story_1_complete") and is_unlocked("story_2_complete") \
			and is_unlocked("story_3_complete"):
		SteamManager.set_achievement("ALL_STORIES_COMPLETE")
	if is_unlocked("story_3_path_a") and is_unlocked("story_3_path_b") \
			and is_unlocked("story_3_path_c"):
		SteamManager.set_achievement("STORY_3_ALL_PATHS")


func _save_unlocks() -> void:
	var json_str: String = JSON.stringify(_unlocks, "\t")
	var file := FileAccess.open(UNLOCKS_PATH, FileAccess.WRITE)
	if file:
		file.store_string(json_str)
		file.close()


func _load_unlocks() -> void:
	var text: String = ""
	if FileAccess.file_exists(UNLOCKS_PATH):
		var file := FileAccess.open(UNLOCKS_PATH, FileAccess.READ)
		if file:
			text = file.get_as_text()
			file.close()
	if text.is_empty():
		return
	var json := JSON.new()
	if json.parse(text) == OK:
		_unlocks = json.data
