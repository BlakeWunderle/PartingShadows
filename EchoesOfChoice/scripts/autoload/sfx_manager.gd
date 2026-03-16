extends Node

## SFX playback system with single sounds per category, cooldowns, and volume control.
## Uses a round-robin pool of AudioStreamPlayers on the SFX bus.

const AudioLoader = preload("res://scripts/autoload/audio_loader.gd")

enum Category {
	# Combat
	STRIKE,
	IMPACT,
	SPELL,
	SHIMMER,
	BUFF,
	DEBUFF,
	WHOOSH,
	# UI
	UI_SELECT,
	UI_CONFIRM,
	UI_FANFARE,
}

const _SFX_ROOT: String = "res://assets/audio/sfx/"

const CATEGORY_PATHS: Dictionary = {
	Category.STRIKE: "combat/Clean_Strike_Sword_Katana_Dagger/Clean_Strike_Sword_Katana_Dagger_12.wav",
	Category.IMPACT: "combat/Bright_Crisp_Strike_Impact/Bright_Crisp_Strike_Impact_7.wav",
	Category.SPELL: "combat/Spell_Burst_Saber_Clash/Spell_Burst_Saber_Clash_1.wav",
	Category.SHIMMER: "combat/Sparkly_Shimmer_Charged_Particles/Sparkly_Shimmer_Charged_Particles_1.wav",
	Category.BUFF: "combat/Sparkly_Shimmer_Charged_Particles/Sparkly_Shimmer_Charged_Particles_9.wav",
	Category.DEBUFF: "combat/debuff.wav",
	Category.WHOOSH: "combat/Quick_Swish_Swoosh_Whoosh/Quick_Swish_Swoosh_Whoosh_3.wav",
	Category.UI_SELECT: "ui/button_click.wav",
	Category.UI_CONFIRM: "ui/button_click.wav",
	Category.UI_FANFARE: "ui/Exciting Fanfare 05.wav",
}

const POOL_SIZE: int = 8
const DEFAULT_COOLDOWN_MS: float = 80.0

var _players: Array[AudioStreamPlayer] = []
var _play_times: Array[float] = []
var _stream_cache: Dictionary = {}
var _cooldown_timers: Dictionary = {}
var _headless: bool = false


func _ready() -> void:
	if AudioLoader.is_headless():
		_headless = true
		return
	for i: int in POOL_SIZE:
		var player := AudioStreamPlayer.new()
		player.bus = &"SFX"
		add_child(player)
		_players.append(player)
		_play_times.append(0.0)
	SettingsManager.sfx_volume_changed.connect(_on_sfx_volume_changed)
	_apply_volume(SettingsManager.sfx_volume)
	get_tree().node_added.connect(_on_node_added)


func play(category: int, volume: float = 1.0, _pitch_shift: bool = false) -> void:
	if _headless:
		return
	var key: String = "cat:%d" % category
	if not _check_cooldown(key, DEFAULT_COOLDOWN_MS):
		return
	var relative: String = CATEGORY_PATHS.get(category, "")
	if relative.is_empty():
		return
	var player := _get_available_player()
	_play_on_player(player, _SFX_ROOT + relative, volume)


func play_at_path(path: String, volume: float = 1.0) -> void:
	if _headless:
		return
	var player := _get_available_player()
	_play_on_player(player, path, volume)


func stop_all() -> void:
	for player: AudioStreamPlayer in _players:
		player.stop()


func _on_sfx_volume_changed(linear: float) -> void:
	_apply_volume(linear)


func _apply_volume(linear: float) -> void:
	var bus_idx: int = AudioServer.get_bus_index(&"SFX")
	if bus_idx >= 0:
		AudioServer.set_bus_volume_db(bus_idx, linear_to_db(maxf(0.0001, linear)))


# -- Internals ----------------------------------------------------------------

func _get_available_player() -> AudioStreamPlayer:
	for i: int in _players.size():
		if not _players[i].playing:
			return _players[i]
	var oldest_idx: int = 0
	for i: int in range(1, _players.size()):
		if _play_times[i] < _play_times[oldest_idx]:
			oldest_idx = i
	_players[oldest_idx].stop()
	return _players[oldest_idx]


func _load_cached_stream(path: String) -> AudioStream:
	if _stream_cache.has(path):
		return _stream_cache[path]
	var stream: AudioStream = AudioLoader.load_stream(path)
	if stream != null:
		_stream_cache[path] = stream
	return stream


func _play_on_player(player: AudioStreamPlayer, path: String, volume: float) -> void:
	var stream: AudioStream = _load_cached_stream(path)
	if stream == null:
		return
	player.stream = stream
	player.volume_db = linear_to_db(maxf(0.0001, volume))
	player.pitch_scale = 1.0
	player.play()
	var idx: int = _players.find(player)
	if idx >= 0:
		_play_times[idx] = Time.get_ticks_msec()


func _check_cooldown(key: String, cooldown_ms: float) -> bool:
	var now: float = Time.get_ticks_msec()
	var last: float = _cooldown_timers.get(key, 0.0)
	if now - last < cooldown_ms:
		return false
	_cooldown_timers[key] = now
	return true


# -- Auto-wire UI button click sounds -----------------------------------------

func _on_node_added(node: Node) -> void:
	if node is BaseButton:
		node.pressed.connect(_on_button_pressed)


func _on_button_pressed() -> void:
	play(Category.UI_SELECT, 0.6)
