extends CanvasLayer

var _fader: ColorRect
var _spinner: Control
var _tip_label: Label
var _preload_requests: Dictionary = {}
var _transitioning: bool = false
const _LOAD_TIMEOUT_MSEC: int = 30000

const TIPS: Array[String] = [
	"Each class has unique abilities. Experiment with different party compositions!",
	"Use buffs before big fights to gain an edge.",
	"Healing abilities target allies with the lowest health first.",
	"Debuffs can turn the tide against tough bosses.",
	"Town stops let you upgrade your class. Check the stat preview before choosing!",
	"Your compendium tracks every enemy and class you encounter.",
	"Speed determines turn order. Faster fighters act first.",
	"AoE abilities hit all targets but are often weaker per hit.",
	"Save often! You have three save slots plus autosave.",
	"Critical hits deal bonus damage based on your crit stat.",
	"Dodge chance lets you completely avoid physical attacks.",
	"Tier 2 classes have powerful specialized abilities.",
	"Check the battle summary after each victory to see your party performance.",
	"Different stories offer different enemies and challenges.",
]


func _ready() -> void:
	layer = 100
	_fader = ColorRect.new()
	_fader.color = Color.BLACK
	_fader.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_fader.set_anchors_preset(Control.PRESET_FULL_RECT)
	_fader.modulate.a = 0.0
	add_child(_fader)

	_spinner = _LoadingSpinner.new()
	_spinner.set_anchors_preset(Control.PRESET_CENTER)
	_spinner.offset_left = -20
	_spinner.offset_top = -20
	_spinner.offset_right = 20
	_spinner.offset_bottom = 20
	_spinner.visible = false
	add_child(_spinner)

	_tip_label = Label.new()
	_tip_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_tip_label.set_anchors_preset(Control.PRESET_CENTER)
	_tip_label.offset_left = -250
	_tip_label.offset_right = 250
	_tip_label.offset_top = 50
	_tip_label.offset_bottom = 120
	_tip_label.add_theme_font_size_override("font_size", 16)
	_tip_label.add_theme_color_override("font_color", Color(0.7, 0.7, 0.7, 0.9))
	_tip_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_tip_label.visible = false
	add_child(_tip_label)


func is_transitioning() -> bool:
	return _transitioning


func preload_scene(path: String) -> void:
	if path.is_empty() or _preload_requests.has(path):
		return
	ResourceLoader.load_threaded_request(path, "", false, ResourceLoader.CACHE_MODE_REUSE)
	_preload_requests[path] = true



func change_scene(path: String, fade_duration: float = 0.4, keep_music: bool = false) -> void:
	if _transitioning:
		return
	_transitioning = true
	GameLog.info("Scene: %s" % path)
	_fader.mouse_filter = Control.MOUSE_FILTER_STOP
	if not keep_music:
		MusicManager.stop_music(fade_duration)

	# Kick off threaded load immediately (runs in parallel with fade)
	if not _preload_requests.has(path):
		ResourceLoader.load_threaded_request(path, "", false, ResourceLoader.CACHE_MODE_REUSE)
		_preload_requests[path] = true

	var tween := create_tween()
	tween.tween_property(_fader, "modulate:a", 1.0, fade_duration)
	await tween.finished

	# Show spinner + loading tip
	_spinner.visible = true
	_tip_label.text = TIPS[randi() % TIPS.size()]
	_tip_label.visible = true

	# Wait for threaded load to complete (likely already finished during fade)
	var scene: PackedScene = await _await_threaded_load(path)
	_preload_requests.erase(path)

	_spinner.visible = false
	_tip_label.visible = false

	if scene == null:
		GameLog.error("SceneManager: Failed to load scene '%s', aborting transition" % path)
		var recover := create_tween()
		recover.tween_property(_fader, "modulate:a", 0.0, fade_duration)
		await recover.finished
		_fader.mouse_filter = Control.MOUSE_FILTER_IGNORE
		_transitioning = false
		return

	# Swap scenes manually
	var old_scene := get_tree().current_scene
	if old_scene:
		old_scene.queue_free()
	var new_scene := scene.instantiate()
	get_tree().root.add_child(new_scene)
	get_tree().current_scene = new_scene

	await get_tree().process_frame
	var tween_out := create_tween()
	tween_out.tween_property(_fader, "modulate:a", 0.0, fade_duration)
	await tween_out.finished
	_fader.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_transitioning = false


func _await_threaded_load(path: String) -> PackedScene:
	var start_msec: int = Time.get_ticks_msec()
	while true:
		var status := ResourceLoader.load_threaded_get_status(path)
		match status:
			ResourceLoader.THREAD_LOAD_LOADED:
				return ResourceLoader.load_threaded_get(path) as PackedScene
			ResourceLoader.THREAD_LOAD_IN_PROGRESS:
				if Time.get_ticks_msec() - start_msec > _LOAD_TIMEOUT_MSEC:
					GameLog.error("SceneManager: Threaded load timed out for '%s' after %ds, falling back to sync" % [path, _LOAD_TIMEOUT_MSEC / 1000])
					return load(path) as PackedScene
				await get_tree().process_frame
			_:
				GameLog.error("SceneManager: Threaded load failed for '%s', falling back to sync" % path)
				return load(path) as PackedScene
	return null


# =============================================================================
# Loading spinner (procedural rotating arc)
# =============================================================================

class _LoadingSpinner extends Control:
	var _angle: float = 0.0

	func _process(delta: float) -> void:
		if not visible:
			return
		_angle += delta * 4.0
		queue_redraw()

	func _draw() -> void:
		var center := size / 2.0
		var radius: float = min(size.x, size.y) / 2.0 - 2.0
		var arc_color := Color(0.3, 0.6, 0.65, 0.8)
		var arc_length := TAU * 0.3
		draw_arc(center, radius, _angle, _angle + arc_length, 24, arc_color, 3.0, true)
