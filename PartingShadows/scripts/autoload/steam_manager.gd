extends Node
## Initializes the Steamworks API via GodotSteam GDExtension.
## Gracefully handles Steam client not running -- game continues offline.

var is_steam_running: bool = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	var init_result: Dictionary = Steam.steamInitEx()
	var status: int = init_result.get("status", -1)
	if status == 0:
		is_steam_running = true
		Steam.join_requested.connect(_on_join_requested)
		Steam.overlay_toggled.connect(_on_overlay_toggled)
		GameLog.info("SteamManager: Steam initialized (user: %s)" % Steam.getPersonaName())
	else:
		GameLog.info("SteamManager: Steam not available (status %d), continuing offline" % status)


var _was_focused: bool = true

func _process(_delta: float) -> void:
	if is_steam_running:
		Steam.run_callbacks()
	var focused: bool = DisplayServer.window_is_focused()
	if focused != _was_focused:
		_was_focused = focused
		_on_focus_changed(focused)


func _on_focus_changed(has_focus: bool) -> void:
	if NetManager.is_multiplayer_active:
		return
	if not has_focus:
		if GameState.game_phase in [
				GameState.GamePhase.PARTY_CREATION,
				GameState.GamePhase.NARRATIVE,
				GameState.GamePhase.BATTLE,
				GameState.GamePhase.TOWN_STOP]:
			get_tree().paused = true
			GameLog.info("SteamManager: paused (focus lost)")
	else:
		if PauseOverlay._panel and not PauseOverlay._panel.visible:
			get_tree().paused = false
			GameLog.info("SteamManager: resumed (focus gained)")


# =============================================================================
# Overlay invite handler
# =============================================================================

## Fires when the user accepts a "Join Game" invite from the Steam overlay
## while the game is already running. Navigate to the lobby and auto-connect.
func _on_join_requested(lobby_id: int, _steam_id: int) -> void:
	GameLog.info("SteamManager: join_requested for lobby %d" % lobby_id)
	if NetManager.is_multiplayer_active:
		NetManager.leave_session()
	NetManager.pending_join_lobby_id = lobby_id
	SceneManager.change_scene("res://scenes/lobby/lobby.tscn")


## Pause via GodotSteam overlay callback (known to not fire in some versions).
func _on_overlay_toggled(is_active: bool) -> void:
	_on_focus_changed(not is_active)


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


# =============================================================================
# Rich presence
# =============================================================================

func set_presence(key: String, value: String) -> void:
	if not is_steam_running:
		return
	Steam.setRichPresence(key, value)


func clear_presence() -> void:
	if not is_steam_running:
		return
	Steam.clearRichPresence()
