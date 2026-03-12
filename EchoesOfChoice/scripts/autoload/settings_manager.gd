extends Node

## Global settings persistence. Loads from user://settings.json on startup,
## saves after any change. Emits signals so systems can react in real time.

const SETTINGS_PATH := "user://settings.json"

# -- Signals -----------------------------------------------------------------

signal music_volume_changed(linear: float)
signal master_volume_changed(linear: float)
signal text_speed_changed(delay: float)
signal fullscreen_changed(enabled: bool)
signal combat_pause_changed(seconds: float)
signal font_size_changed(size: int)
signal color_blind_mode_changed(mode: String)
signal screen_reader_changed(enabled: bool)

# -- Defaults ----------------------------------------------------------------

const DEFAULT_MUSIC_VOLUME := 0.8
const DEFAULT_MASTER_VOLUME := 1.0
const DEFAULT_TEXT_SPEED := 0.02
const DEFAULT_FULLSCREEN := true
const DEFAULT_COMBAT_PAUSE := 1.2
const DEFAULT_FONT_SIZE := 18
const DEFAULT_COLOR_BLIND_MODE := "normal"
const DEFAULT_SCREEN_READER := false

# -- State -------------------------------------------------------------------

var music_volume: float = DEFAULT_MUSIC_VOLUME:
	set(v):
		v = clampf(v, 0.0, 1.0)
		if music_volume == v:
			return
		music_volume = v
		music_volume_changed.emit(v)
		_save()

var master_volume: float = DEFAULT_MASTER_VOLUME:
	set(v):
		v = clampf(v, 0.0, 1.0)
		if master_volume == v:
			return
		master_volume = v
		master_volume_changed.emit(v)
		_save()

var text_speed: float = DEFAULT_TEXT_SPEED:
	set(v):
		if text_speed == v:
			return
		text_speed = v
		text_speed_changed.emit(v)
		_save()

var fullscreen: bool = DEFAULT_FULLSCREEN:
	set(v):
		if fullscreen == v:
			return
		fullscreen = v
		fullscreen_changed.emit(v)
		_save()

var combat_pause: float = DEFAULT_COMBAT_PAUSE:
	set(v):
		if combat_pause == v:
			return
		combat_pause = v
		combat_pause_changed.emit(v)
		_save()

var font_size: int = DEFAULT_FONT_SIZE:
	set(v):
		if font_size == v:
			return
		font_size = v
		font_size_changed.emit(v)
		_save()

var color_blind_mode: String = DEFAULT_COLOR_BLIND_MODE:
	set(v):
		if color_blind_mode == v:
			return
		color_blind_mode = v
		color_blind_mode_changed.emit(v)
		_save()

var screen_reader: bool = DEFAULT_SCREEN_READER:
	set(v):
		if screen_reader == v:
			return
		screen_reader = v
		screen_reader_changed.emit(v)
		_save()

# -- Color Blind Palettes ---------------------------------------------------

# Each palette: { hp_high, hp_mid, hp_low, buff, debuff }
const COLOR_PALETTES: Dictionary = {
	"normal": {
		"hp_high": Color(0.2, 0.9, 0.2),
		"hp_mid": Color(0.9, 0.9, 0.2),
		"hp_low": Color(0.9, 0.2, 0.2),
		"buff": Color(0.5, 1.0, 0.5),
		"debuff": Color(1.0, 0.5, 0.5),
	},
	"deuteranopia": {
		"hp_high": Color(0.3, 0.6, 1.0),
		"hp_mid": Color(1.0, 0.8, 0.3),
		"hp_low": Color(1.0, 0.4, 0.3),
		"buff": Color(0.4, 0.7, 1.0),
		"debuff": Color(1.0, 0.6, 0.3),
	},
	"protanopia": {
		"hp_high": Color(0.3, 0.6, 1.0),
		"hp_mid": Color(1.0, 0.85, 0.3),
		"hp_low": Color(0.9, 0.4, 0.6),
		"buff": Color(0.4, 0.7, 1.0),
		"debuff": Color(0.9, 0.5, 0.6),
	},
	"tritanopia": {
		"hp_high": Color(0.3, 0.85, 0.85),
		"hp_mid": Color(0.9, 0.5, 0.7),
		"hp_low": Color(0.9, 0.2, 0.2),
		"buff": Color(0.4, 0.9, 0.9),
		"debuff": Color(0.9, 0.5, 0.6),
	},
}


func get_palette() -> Dictionary:
	return COLOR_PALETTES.get(color_blind_mode, COLOR_PALETTES["normal"])


# -- Lifecycle ---------------------------------------------------------------

func _ready() -> void:
	_load()
	_apply_all()


func reset_defaults() -> void:
	music_volume = DEFAULT_MUSIC_VOLUME
	master_volume = DEFAULT_MASTER_VOLUME
	text_speed = DEFAULT_TEXT_SPEED
	fullscreen = DEFAULT_FULLSCREEN
	combat_pause = DEFAULT_COMBAT_PAUSE
	font_size = DEFAULT_FONT_SIZE
	color_blind_mode = DEFAULT_COLOR_BLIND_MODE
	screen_reader = DEFAULT_SCREEN_READER


# -- Persistence -------------------------------------------------------------

func _load() -> void:
	if not FileAccess.file_exists(SETTINGS_PATH):
		return
	var file := FileAccess.open(SETTINGS_PATH, FileAccess.READ)
	if not file:
		return
	var json := JSON.new()
	if json.parse(file.get_as_text()) != OK:
		return
	file.close()
	var data: Dictionary = json.data
	music_volume = data.get("music_volume", DEFAULT_MUSIC_VOLUME)
	master_volume = data.get("master_volume", DEFAULT_MASTER_VOLUME)
	text_speed = data.get("text_speed", DEFAULT_TEXT_SPEED)
	fullscreen = data.get("fullscreen", DEFAULT_FULLSCREEN)
	combat_pause = data.get("combat_pause", DEFAULT_COMBAT_PAUSE)
	font_size = int(data.get("font_size", DEFAULT_FONT_SIZE))
	color_blind_mode = data.get("color_blind_mode", DEFAULT_COLOR_BLIND_MODE)
	screen_reader = data.get("screen_reader", DEFAULT_SCREEN_READER)


func _save() -> void:
	var data := {
		"music_volume": music_volume,
		"master_volume": master_volume,
		"text_speed": text_speed,
		"fullscreen": fullscreen,
		"combat_pause": combat_pause,
		"font_size": font_size,
		"color_blind_mode": color_blind_mode,
		"screen_reader": screen_reader,
	}
	var file := FileAccess.open(SETTINGS_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data, "\t"))
		file.close()


func _apply_all() -> void:
	# Apply master volume to the Master audio bus
	AudioServer.set_bus_volume_db(0, linear_to_db(maxf(0.0001, master_volume)))
	# Apply music volume
	music_volume_changed.emit(music_volume)
	# Apply fullscreen
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_size(Vector2i(1280, 720))
