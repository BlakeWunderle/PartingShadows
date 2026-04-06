extends Node

## Quick-launch a battle for testing UI changes or marketing screenshots.
## Run via: Godot --path PartingShadows --scene res://tools/debug_battle.tscn
##
## Change BATTLE_ID below to switch which battle loads.
## Options: "S3_CultRitualChamber", "S3_DreamNexus", "CityStreetBattle"

const FighterDB := preload("res://scripts/data/fighter_db.gd")

const BATTLE_ID := "S3_DreamNexus"


func _ready() -> void:
	if BATTLE_ID in ["S3_CultRitualChamber", "S3_DreamNexus"]:
		_launch_endgame_battle()
	else:
		_launch_early_battle()


func _launch_endgame_battle() -> void:
	# T2 party at level ~17 to match S3 endgame enemies
	# Dragoon (physical), Infernalist (fire), Paladin (holy) -- visually distinct
	var fighter1 := FighterDB.create_player("Squire", "Aldric", "m")
	var fighter2 := FighterDB.create_player("Mage", "Sera", "f")
	var fighter3 := FighterDB.create_player("Mage", "Fenn", "m")

	# Level to 4, upgrade T0 -> T1
	for _i: int in 3:
		FighterDB.level_up(fighter1)
		FighterDB.level_up(fighter2)
		FighterDB.level_up(fighter3)
	FighterDB.upgrade_class(fighter1, "Sword")      # Squire -> Duelist
	FighterDB.upgrade_class(fighter2, "RedStone")   # Mage -> Invoker
	FighterDB.upgrade_class(fighter3, "WhiteStone") # Mage -> Acolyte

	# Level to 9, upgrade T1 -> T2
	for _i: int in 5:
		FighterDB.level_up(fighter1)
		FighterDB.level_up(fighter2)
		FighterDB.level_up(fighter3)
	FighterDB.upgrade_class(fighter1, "Spear")      # Duelist -> Dragoon
	FighterDB.upgrade_class(fighter2, "FireStone")  # Invoker -> Infernalist
	FighterDB.upgrade_class(fighter3, "Hammer")     # Acolyte -> Paladin

	# Level to ~17 for endgame
	for _i: int in 8:
		FighterDB.level_up(fighter1)
		FighterDB.level_up(fighter2)
		FighterDB.level_up(fighter3)

	GameState.current_story_id = "story_3"
	GameState.set_party([fighter1, fighter2, fighter3])
	GameState.advance_to_battle(BATTLE_ID)
	SceneManager.change_scene("res://scenes/battle/battle.tscn", 0.0, false)


func _launch_early_battle() -> void:
	# T0 party for early-game battles
	var squire := FighterDB.create_player("Squire", "Aldric", "m")
	var mage := FighterDB.create_player("Mage", "Sera", "f")
	var wildling := FighterDB.create_player("Wildling", "Fenn", "m")

	for _i: int in 3:
		FighterDB.level_up(squire)
		FighterDB.level_up(mage)
		FighterDB.level_up(wildling)

	GameState.current_story_id = "story_1"
	GameState.set_party([squire, mage, wildling])
	GameState.advance_to_battle(BATTLE_ID)
	SceneManager.change_scene("res://scenes/battle/battle.tscn", 0.0, false)
