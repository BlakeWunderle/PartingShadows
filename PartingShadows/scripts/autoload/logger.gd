extends Node

## Playtester log system. Stores recent game events in an in-memory ring buffer.
## Use GameLog.info() / GameLog.warn() / GameLog.error() to record events.
## Use GameLog.copy_to_clipboard() from the pause menu to share logs.

enum Level { INFO, WARN, ERROR }

const MAX_ENTRIES: int = 200

const LOG_PATH := "user://game.log"

var _entries: Array[Dictionary] = []
var _start_time_msec: int = 0
var _log_file: FileAccess


func _ready() -> void:
	_start_time_msec = Time.get_ticks_msec()
	_log_file = FileAccess.open(LOG_PATH, FileAccess.WRITE)
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
	var timestamp: float = _elapsed_seconds()
	var entry: Dictionary = {
		"time": timestamp,
		"level": level,
		"message": message,
	}
	_entries.append(entry)
	if _entries.size() > MAX_ENTRIES:
		_entries.pop_front()
	if _log_file:
		var prefix: String = ["INFO", "WARN", "ERR!"][level]
		_log_file.store_line("[%.1fs] [%s] %s" % [timestamp, prefix, message])
		_log_file.flush()


func _elapsed_seconds() -> float:
	return (Time.get_ticks_msec() - _start_time_msec) / 1000.0


func copy_to_clipboard(header_lines: Array[String] = []) -> void:
	DisplayServer.clipboard_set(format_for_clipboard(header_lines))


func format_for_clipboard(header_lines: Array[String] = []) -> String:
	var lines: Array[String] = []
	lines.append("=== Parting Shadows - Playtest Log ===")
	lines.append("Date: %s" % Time.get_datetime_string_from_system())
	for h: String in header_lines:
		lines.append(h)
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
