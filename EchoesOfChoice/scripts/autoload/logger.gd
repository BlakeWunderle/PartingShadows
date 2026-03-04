extends Node

## Playtester log system. Stores recent game events in an in-memory ring buffer.
## Use Logger.info() / Logger.warn() / Logger.error() to record events.
## Use Logger.copy_to_clipboard() from the pause menu to share logs.

enum Level { INFO, WARN, ERROR }

const MAX_ENTRIES: int = 200

var _entries: Array[Dictionary] = []
var _start_time_msec: int = 0


func _ready() -> void:
	_start_time_msec = Time.get_ticks_msec()
	info("Session started")


func info(message: String) -> void:
	_add_entry(Level.INFO, message)


func warn(message: String) -> void:
	_add_entry(Level.WARN, message)
	push_warning(message)


func error(message: String) -> void:
	_add_entry(Level.ERROR, message)
	push_error(message)


func _add_entry(level: Level, message: String) -> void:
	var entry: Dictionary = {
		"time": _elapsed_seconds(),
		"level": level,
		"message": message,
	}
	_entries.append(entry)
	if _entries.size() > MAX_ENTRIES:
		_entries.pop_front()


func _elapsed_seconds() -> float:
	return (Time.get_ticks_msec() - _start_time_msec) / 1000.0


func copy_to_clipboard() -> void:
	DisplayServer.clipboard_set(format_for_clipboard())


func format_for_clipboard() -> String:
	var lines: Array[String] = []
	lines.append("=== Echoes of Choice - Playtest Log ===")
	lines.append("Date: %s" % Time.get_datetime_string_from_system())
	lines.append("Phase: %s" % _phase_name())
	lines.append("Battle: %s" % GameState.current_battle_id)
	lines.append("Party: %s" % _party_summary())
	lines.append("Entries: %d" % _entries.size())
	lines.append("========================================")
	lines.append("")

	for entry: Dictionary in _entries:
		var prefix: String
		match entry["level"]:
			Level.INFO: prefix = "INFO"
			Level.WARN: prefix = "WARN"
			Level.ERROR: prefix = "ERR!"
			_: prefix = "????"
		var timestamp: String = "%.1f" % entry["time"]
		lines.append("[%ss] [%s] %s" % [timestamp, prefix, entry["message"]])

	return "\n".join(lines)


func _phase_name() -> String:
	match GameState.game_phase:
		GameState.GamePhase.TITLE: return "Title"
		GameState.GamePhase.PARTY_CREATION: return "Party Creation"
		GameState.GamePhase.NARRATIVE: return "Narrative"
		GameState.GamePhase.BATTLE: return "Battle"
		GameState.GamePhase.TOWN_STOP: return "Town Stop"
		GameState.GamePhase.ENDING: return "Ending"
		_: return "Unknown"


func _party_summary() -> String:
	if GameState.party.is_empty():
		return "(none)"
	var parts: Array[String] = []
	for fighter: RefCounted in GameState.party:
		parts.append("%s the %s (Lv%d)" % [
			fighter.character_name, fighter.character_type, fighter.level])
	return ", ".join(parts)
