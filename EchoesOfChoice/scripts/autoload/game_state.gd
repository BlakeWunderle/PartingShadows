extends Node

## Global game state that persists across scene transitions.

const _BattleDB := preload("res://scripts/data/battle_db.gd")
const _FighterDB := preload("res://scripts/data/fighter_db.gd")
const _StoryDB := preload("res://scripts/data/story_db.gd")

enum NarrativeMode { PRE_BATTLE, POST_BATTLE }
enum GamePhase { TITLE, PARTY_CREATION, NARRATIVE, BATTLE, TOWN_STOP, ENDING }

var party: Array = []
var current_battle_id: String = ""
var current_battle: RefCounted  ## BattleData
var previous_battle_id: String = ""
var narrative_mode: NarrativeMode = NarrativeMode.PRE_BATTLE
var game_phase: GamePhase = GamePhase.TITLE
var game_won: bool = false
var battles_won: int = 0
var play_seconds: float = 0.0
var current_story_id: String = "story_1"


func start_new_game(story_id: String = "story_1") -> void:
	GameLog.info("New game started (story: %s)" % story_id)
	party.clear()
	current_story_id = story_id
	current_battle_id = ""
	current_battle = null
	previous_battle_id = ""
	narrative_mode = NarrativeMode.PRE_BATTLE
	game_phase = GamePhase.PARTY_CREATION
	game_won = false
	battles_won = 0
	play_seconds = 0.0


func _process(delta: float) -> void:
	if game_phase != GamePhase.TITLE and game_phase != GamePhase.ENDING \
			and not get_tree().paused:
		play_seconds += delta


func get_playtime_display() -> String:
	var total: int = int(play_seconds)
	var h: int = total / 3600
	var m: int = (total % 3600) / 60
	return "%dh %dm" % [h, m]


func get_first_battle_id() -> String:
	var story: Dictionary = _StoryDB.get_story(current_story_id)
	return story.get("first_battle_id", "CityStreetBattle")


func set_party(fighters: Array) -> void:
	party = fighters


func advance_to_battle(battle_id: String) -> void:
	GameLog.info("Battle: %s" % battle_id)
	previous_battle_id = current_battle_id
	current_battle_id = battle_id
	current_battle = _BattleDB.create_battle(battle_id)
	narrative_mode = NarrativeMode.PRE_BATTLE
	if current_battle.is_town_stop:
		game_phase = GamePhase.TOWN_STOP
	else:
		game_phase = GamePhase.NARRATIVE


func advance_to_post_battle() -> void:
	battles_won += 1
	if battles_won == 1:
		SteamManager.set_achievement("FIRST_VICTORY")
	elif battles_won == 10:
		SteamManager.set_achievement("TEN_VICTORIES")
	elif battles_won == 50:
		SteamManager.set_achievement("FIFTY_VICTORIES")
	narrative_mode = NarrativeMode.POST_BATTLE
	game_phase = GamePhase.NARRATIVE


func level_up_party() -> void:
	for fighter: RefCounted in party:
		_FighterDB.level_up(fighter)


func upgrade_party_member(fighter: RefCounted, item: String) -> bool:
	return _FighterDB.upgrade_class(fighter, item)


func advance_to_next_battle() -> void:
	if current_battle.next_battle_id.is_empty() or current_battle.is_final_battle:
		game_phase = GamePhase.ENDING
		return
	advance_to_battle(current_battle.next_battle_id)


func advance_with_choice(battle_id: String) -> void:
	advance_to_battle(battle_id)


func go_to_ending(won: bool) -> void:
	GameLog.info("Ending: %s" % ("victory" if won else "defeat"))
	game_won = won
	game_phase = GamePhase.ENDING
