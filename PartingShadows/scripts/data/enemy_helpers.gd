class_name EnemyHelpers

## Shared stat helpers for enemy factories across all stories.

const FighterData := preload("res://scripts/data/fighter_data.gd")


static func es(base_min: int, base_max: int, gmin: int, gmax: int, level: int, base_level: int = 1) -> int:
	var lvl: int = level - base_level
	var lo: int = base_min + lvl * gmin
	var hi: int = base_max + lvl * (gmax - 1)
	if hi <= lo:
		return lo
	return randi_range(lo, hi - 1)


static func fixed(base_min: int, base_max: int) -> int:
	return randi_range(base_min, base_max - 1)


static func base(enemy_name: String, type: String, lvl: int) -> FighterData:
	var f := FighterData.new()
	f.character_name = enemy_name
	f.character_type = type
	f.class_id = type
	f.is_user_controlled = false
	f.level = lvl
	return f
