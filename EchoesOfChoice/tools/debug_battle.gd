extends Node

## Quick-launch a battle for testing UI changes.
## Run via: Godot --path EchoesOfChoice --scene res://tools/debug_battle.tscn

const FighterDB := preload("res://scripts/data/fighter_db.gd")


func _ready() -> void:
	# Build a 3-member party at T0
	var squire := FighterDB.create_player("Squire", "Aldric", "m")
	var mage := FighterDB.create_player("Mage", "Sera", "f")
	var wildling := FighterDB.create_player("Wildling", "Fenn", "m")

	# Level them up a few times so the fight isn't trivially short
	for _i: int in 3:
		FighterDB.level_up(squire)
		FighterDB.level_up(mage)
		FighterDB.level_up(wildling)

	GameState.current_story_id = "story_1"
	GameState.set_party([squire, mage, wildling])
	GameState.advance_to_battle("CityStreetBattle")

	# Jump straight to battle
	SceneManager.change_scene("res://scenes/battle/battle.tscn", 0.0, false)
