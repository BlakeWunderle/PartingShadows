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


# =============================================================================
# Cloud storage
# =============================================================================

func is_cloud_available() -> bool:
	if not is_steam_running:
		return false
	return Steam.isCloudEnabledForAccount() and Steam.isCloudEnabledForApp()


func cloud_exists(filename: String) -> bool:
	if not is_cloud_available():
		return false
	return Steam.fileExists(filename)


func cloud_write(filename: String, content: String) -> bool:
	if not is_cloud_available():
		return false
	var data: PackedByteArray = content.to_utf8_buffer()
	var success: bool = Steam.fileWrite(filename, data)
	if not success:
		GameLog.warn("Steam cloud write failed: %s" % filename)
	return success


func cloud_read(filename: String) -> String:
	if not is_cloud_available():
		return ""
	if not Steam.fileExists(filename):
		return ""
	var size: int = Steam.getFileSize(filename)
	if size <= 0:
		return ""
	var data: Dictionary = Steam.fileRead(filename, size)
	var buffer: PackedByteArray = data.get("buffer", PackedByteArray())
	return buffer.get_string_from_utf8()


func cloud_delete(filename: String) -> void:
	if not is_cloud_available():
		return
	if Steam.fileExists(filename):
		Steam.fileDelete(filename)
