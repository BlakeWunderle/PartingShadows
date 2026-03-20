extends Node

## Cross-session compendium tracking. Records encountered enemies and player
## classes to user://compendium.json so the player can review what they've seen.

const COMPENDIUM_PATH := "user://compendium.json"

var _seen_enemies: Dictionary = {}  # class_id -> {name, abilities, story_id, timestamp}
var _seen_classes: Dictionary = {}  # class_id -> {display_name, tier, timestamp}
var _battles_completed: Dictionary = {}  # battle_id -> timestamp


func _ready() -> void:
	_load()


func record_enemy(fighter: RefCounted, story_id: String) -> void:
	if _seen_enemies.has(fighter.class_id):
		return
	var ability_names: Array[String] = []
	for a: RefCounted in fighter.abilities:
		ability_names.append(a.ability_name)
	_seen_enemies[fighter.class_id] = {
		"name": fighter.character_type,
		"abilities": ability_names,
		"story_id": story_id,
		"timestamp": Time.get_unix_time_from_system(),
	}
	_save()
	if _seen_enemies.size() >= 50:
		SteamManager.set_achievement("COMPENDIUM_50_ENEMIES")


func record_class(class_id: String, display_name: String) -> void:
	if _seen_classes.has(class_id):
		return
	var tier: int = _get_tier(class_id)
	_seen_classes[class_id] = {
		"display_name": display_name,
		"tier": tier,
		"timestamp": Time.get_unix_time_from_system(),
	}
	_save()
	# Steam achievements for class collection
	if tier == 2:
		SteamManager.set_achievement("CLASS_TIER_2")
	var t0: Array[String] = ["Squire", "Mage", "Entertainer", "Tinker", "Wildling", "Wanderer"]
	var all_t0: bool = true
	for c: String in t0:
		if not _seen_classes.has(c):
			all_t0 = false
			break
	if all_t0:
		SteamManager.set_achievement("ALL_BASE_CLASSES")
	if _seen_classes.size() >= 56:
		SteamManager.set_achievement("ALL_CLASSES")


func mark_battle_complete(battle_id: String) -> void:
	if _battles_completed.has(battle_id):
		return
	_battles_completed[battle_id] = Time.get_unix_time_from_system()
	_save()


func get_seen_enemies() -> Dictionary:
	return _seen_enemies


func get_seen_classes() -> Dictionary:
	return _seen_classes


func get_battles_completed() -> Dictionary:
	return _battles_completed


## Get global discoveries merged from all save slots
func get_global_discoveries() -> Dictionary:
	# For now, return current session data
	# TODO: Implement cross-save merging by loading all save files
	return {
		"enemies": _seen_enemies,
		"classes": _seen_classes,
		"battles": _battles_completed,
	}


## Get discoveries for a specific save slot
func get_save_discoveries(save_slot: int) -> Dictionary:
	# For now, return current session data (assumes we're in that save)
	# TODO: Load specific save file and return its compendium data
	return {
		"enemies": _seen_enemies,
		"classes": _seen_classes,
		"battles": _battles_completed,
	}


func _get_tier(class_id: String) -> int:
	match class_id:
		"Squire", "Mage", "Entertainer", "Tinker", "Wildling", "Wanderer":
			return 0
		"Duelist", "Ranger", "MartialArtist", "Invoker", "Acolyte", \
		"Bard", "Dervish", "Orator", "Artificer", "Cosmologist", "Arithmancer", \
		"Herbalist", "Shaman", "Beastcaller", "Sentinel", "Pathfinder":
			return 1
	return 2


func _load() -> void:
	var text: String = ""
	if FileAccess.file_exists(COMPENDIUM_PATH):
		var file := FileAccess.open(COMPENDIUM_PATH, FileAccess.READ)
		if file:
			text = file.get_as_text()
			file.close()
	if text.is_empty():
		text = SteamManager.cloud_read("compendium.json")
	if text.is_empty():
		return
	var json := JSON.new()
	if json.parse(text) != OK:
		return
	var data: Dictionary = json.data
	_seen_enemies = data.get("enemies", {})
	_seen_classes = data.get("classes", {})
	_battles_completed = data.get("battles", {})


func _save() -> void:
	var data := {
		"enemies": _seen_enemies,
		"classes": _seen_classes,
		"battles": _battles_completed,
	}
	var json_str: String = JSON.stringify(data, "\t")
	var file := FileAccess.open(COMPENDIUM_PATH, FileAccess.WRITE)
	if file:
		file.store_string(json_str)
		file.close()
	SteamManager.cloud_write("compendium.json", json_str)
