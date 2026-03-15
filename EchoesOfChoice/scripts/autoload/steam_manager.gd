extends Node
## Initializes the Steamworks API via GodotSteam GDExtension.
## Gracefully handles Steam client not running -- game continues offline.

var is_steam_running: bool = false

func _ready() -> void:
	var init_result: Dictionary = Steam.steamInitEx()
	var status: int = init_result.get("status", -1)
	if status == 0:
		is_steam_running = true
		GameLog.info("SteamManager: Steam initialized (user: %s)" % Steam.getPersonaName())
	else:
		GameLog.info("SteamManager: Steam not available (status %d), continuing offline" % status)


func _process(_delta: float) -> void:
	if is_steam_running:
		Steam.run_callbacks()


# =============================================================================
# Achievements
# =============================================================================

func set_achievement(api_name: String) -> void:
	if not is_steam_running:
		return
	var result: Dictionary = Steam.getAchievement(api_name)
	if result.get("achieved", false):
		return
	Steam.setAchievement(api_name)
	Steam.storeStats()
	GameLog.info("Steam achievement: %s" % api_name)


func clear_achievement(api_name: String) -> void:
	if not is_steam_running:
		return
	Steam.clearAchievement(api_name)
	Steam.storeStats()
