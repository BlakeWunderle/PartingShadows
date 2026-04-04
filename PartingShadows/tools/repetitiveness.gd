extends SceneTree

## Standalone repetitiveness analysis tool.
## Analyzes consecutive battles for archetype similarity and damage monotony.
## Usage: godot --path PartingShadows --headless --script res://tools/repetitiveness.gd -- [--story N]

const BSDB := preload("res://scripts/tools/battle_stage_db.gd")
const SRpt := preload("res://scripts/tools/sim_repetitiveness.gd")


func _init() -> void:
	var stages := BSDB.get_all_stages()
	var args := OS.get_cmdline_user_args()

	var story_filter := 0
	var i := 0
	while i < args.size():
		match args[i]:
			"--story":
				if i + 1 < args.size():
					story_filter = int(args[i + 1])
					i += 1
			"--help", "-h":
				_print_help()
				quit()
				return
		i += 1

	if story_filter > 0:
		stages = stages.filter(
			func(s: Dictionary) -> bool: return s.get("story", 1) == story_filter)

	SRpt.analyze(stages)
	quit()


static func _print_help() -> void:
	print("Usage: --script res://tools/repetitiveness.gd -- [options]")
	print("")
	print("Options:")
	print("  --story <n>   Filter to story 1, 2, or 3")
	print("  --help, -h    Show this help")
