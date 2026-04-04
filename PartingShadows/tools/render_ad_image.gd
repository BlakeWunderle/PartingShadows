extends SceneTree

## Renders a still ad image: shore battle screenshot with in-game title overlay.
## Must run with display server (NOT --headless) since SubViewport needs GPU.
##
## Usage: godot --script res://tools/render_ad_image.gd

const WIDTH: int = 1280
const HEIGHT: int = 720
const BG_PATH: String = "res://tools/shore_battle_bg.png"
const OUTPUT_PATH: String = "res://tools/ad_shore_battle.png"

var _vp: SubViewport
var _frames: int = 0


func _init() -> void:
	_vp = SubViewport.new()
	_vp.size = Vector2i(WIDTH, HEIGHT)
	_vp.transparent_bg = false
	_vp.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	root.add_child(_vp)

	# Background — the battle screenshot (loaded raw, not via Godot import)
	var img := Image.load_from_file(BG_PATH)
	var tex := ImageTexture.create_from_image(img)
	var bg := TextureRect.new()
	bg.texture = tex
	bg.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	bg.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	bg.custom_minimum_size = Vector2(WIDTH, HEIGHT)
	_vp.add_child(bg)

	# Title — positioned in upper area over the sky/rocks
	var title := Label.new()
	title.text = "PARTING SHADOWS"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.set_anchors_preset(Control.PRESET_CENTER_TOP)
	title.anchor_top = 0.08
	title.anchor_bottom = 0.08
	title.grow_horizontal = Control.GROW_DIRECTION_BOTH
	title.add_theme_font_size_override("font_size", 56)
	title.add_theme_constant_override("outline_size", 3)
	title.add_theme_color_override("font_outline_color", Color(0.0, 0.0, 0.0, 1.0))
	title.add_theme_constant_override("shadow_offset_x", 4)
	title.add_theme_constant_override("shadow_offset_y", 4)
	title.add_theme_color_override("font_shadow_color", Color(0.0, 0.0, 0.0, 0.85))
	_vp.add_child(title)



func _process(_delta: float) -> bool:
	_frames += 1
	if _frames < 5:
		return false
	var img: Image = _vp.get_texture().get_image()
	img.save_png(OUTPUT_PATH)
	print("Saved ad image to: %s (%dx%d)" % [OUTPUT_PATH, img.get_width(), img.get_height()])
	quit()
	return true
