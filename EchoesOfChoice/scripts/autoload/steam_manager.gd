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
