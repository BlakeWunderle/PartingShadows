class_name StoryDB

## Static registry of available stories.
## Each story defines its title, description, first battle, and unlock requirements.

const STORIES: Array[String] = ["story_1", "story_2", "story_3"]


static func get_story(story_id: String) -> Dictionary:
	match story_id:
		"story_1": return _story_1()
		"story_2": return _story_2()
		"story_3": return _story_3()
		_:
			push_error("Unknown story: %s" % story_id)
			return _story_1()


static func get_all_stories() -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	for sid: String in STORIES:
		result.append(get_story(sid))
	return result


static func _story_1() -> Dictionary:
	return {
		"story_id": "story_1",
		"title": "The Stranger's Shadow",
		"description": "A shrouded stranger sends three heroes into the wilds. But nothing is as it seems.",
		"first_battle_id": "CityStreetBattle",
		"unlock_requirement": "",
		"completion_unlock": "story_1_complete",
	}


static func _story_2() -> Dictionary:
	return {
		"story_id": "story_2",
		"title": "Echoes in the Dark",
		"description": "Three strangers wake in a cave with no memory. Something is wrong with this place.",
		"first_battle_id": "S2_CaveAwakening",
		"unlock_requirement": "story_1_complete",
		"completion_unlock": "story_2_complete",
	}


static func _story_3() -> Dictionary:
	return {
		"story_id": "story_3",
		"title": "The Woven Night",
		"description": "Three travelers rest at a quiet inn. Their dreams are not their own.",
		"first_battle_id": "S3_WearyTraveler",
		"unlock_requirement": "story_2_complete",
		"completion_unlock": "story_3_complete",
	}
