class_name BattleStageDB

## Battle stages with enemy compositions and balance targets.
## Story 1 stages live here; Story 2/3 are delegated to BattleStageDBs2s3.

const EnemyDB := preload("res://scripts/data/story1/enemy_db.gd")
const EnemyDBAct2 := preload("res://scripts/data/story1/enemy_db_act2.gd")
const EnemyDBAct345 := preload("res://scripts/data/story1/enemy_db_act345.gd")
const EnemyDBAct5B := preload("res://scripts/data/story1/enemy_db_act5b.gd")
const S2S3 := preload("res://scripts/tools/battle_stage_db_s2s3.gd")
const FighterData := preload("res://scripts/data/fighter_data.gd")


static func get_all_stages() -> Array:
	var stages := _get_story1_stages()
	stages.append_array(S2S3.get_story2_stages())
	stages.append_array(S2S3.get_story3_stages())
	return stages


static func get_story_stages(story: int) -> Array:
	return get_all_stages().filter(
		func(s: Dictionary) -> bool: return s.story == story)


static func _get_story1_stages() -> Array:
	return [
		# Prog 0: Base classes, no level ups (targets adjusted for 6th T0 class Wanderer)
		_s("CityStreetBattle", 0, "base", 0.85, 0),
		# Prog 1: Base classes, 1 level up
		_s("WolfForestBattle", 1, "base", 0.83, 1),
		# Prog 2: Base classes, 2 level ups
		_s("WaypointDefenseBattle", 2, "base", 0.78, 2),
		# Prog 3: Tier 1, 4 total level ups
		_s("HighlandBattle", 4, "tier1", 0.83, 3),
		_s("DeepForestBattle", 4, "tier1", 0.83, 3),
		_s("ShoreBattle", 4, "tier1", 0.83, 3),
		# Prog 4: Tier 1, 5 total level ups
		_s("MountainPassBattle", 5, "tier1", 0.81, 4),
		_s("CaveBattle", 5, "tier1", 0.81, 4),
		_s("BeachBattle", 5, "tier1", 0.81, 4),
		# Prog 5: Tier 1, 6 total level ups
		_s("CircusBattle", 6, "tier1", 0.79, 5),
		_s("LabBattle", 6, "tier1", 0.79, 5),
		_s("ArmyBattle", 6, "tier1", 0.79, 5),
		_s("CemeteryBattle", 6, "tier1", 0.79, 5),
		# Prog 6: Tier 1, 7 total level ups
		_s("OutpostDefenseBattle", 7, "tier1", 0.77, 6),
		# Prog 8: Tier 2, 10 total level ups
		_s("ReturnToCityStreetBattle", 10, "tier2", 0.80, 8),
		# Prog 9: Tier 2, 11 total level ups
		_s("StrangerTowerBattle", 11, "tier2", 0.78, 9),
		# Prog 10: Tier 2, 12 total level ups
		_s("CorruptedCityBattle", 12, "tier2", 0.75, 10),
		_s("CorruptedWildsBattle", 12, "tier2", 0.75, 10),
		# Prog 11: Tier 2, 13 total level ups (underground pursuit)
		_s("DepthsBattle", 13, "tier2", 0.72, 11),
		# Prog 12: Tier 2, 14 total level ups (last guardian)
		_s("GateBattle", 14, "tier2", 0.69, 12),
		# Prog 13: Tier 2, 15 total level ups (final boss)
		_s("StrangerFinalBattle", 15, "tier2", 0.65, 13),
		# Path B: Sever the Ritual (branches from GateBattle)
		_s("RitualAnchorBattle", 14, "tier2", 0.69, 12),
		_s("SanctumCollapseBattle", 15, "tier2", 0.67, 13),
		_s("StrangerUndoneBattle", 15, "tier2", 0.65, 13),
	]


static func _s(n: String, lu: int, tier: String, target: float,
		prog: int, story: int = 1) -> Dictionary:
	return {
		"name": n, "level_ups": lu, "tier": tier,
		"target_win_rate": target, "progression_stage": prog,
		"story": story,
	}


# =============================================================================
# Enemy factories -- Story 1 stages + delegation to S2S3 for others
# =============================================================================

static func create_enemies(stage_name: String) -> Array:
	match stage_name:
		"CityStreetBattle":
			return [EnemyDB.create_thug("Alexander"),
				EnemyDB.create_ruffian("Jenna"),
				EnemyDB.create_pickpocket("Ella")]
		"WolfForestBattle":
			return [EnemyDB.create_wolf("Greyfang"),
				EnemyDB.create_boar("Tusker"),
				EnemyDB.create_thornviper("Needlefang")]
		"WaypointDefenseBattle":
			return [EnemyDB.create_bandit("Riggs"),
				EnemyDB.create_goblin("Snitch"),
				EnemyDB.create_hound("Fang")]
		"HighlandBattle":
			return [EnemyDBAct2.create_raider("Wulfric"),
				EnemyDBAct2.create_raider("Bjorn"),
				EnemyDBAct2.create_orc("Grath")]
		"DeepForestBattle":
			return [EnemyDBAct2.create_witch("Morwen"),
				EnemyDBAct2.create_wisp("Flicker"),
				EnemyDBAct2.create_sprite("Briar")]
		"ShoreBattle":
			return [EnemyDBAct2.create_siren("Lorelei"),
				EnemyDBAct2.create_merfolk("Thalassa"),
				EnemyDBAct2.create_merfolk("Nereus")]
		"MountainPassBattle":
			return [EnemyDBAct2.create_troll("Grendal"),
				EnemyDBAct2.create_harpy("Screecher"),
				EnemyDBAct2.create_harpy("Shrieker")]
		"CaveBattle":
			return [EnemyDBAct2.create_fire_wyrmling("Raysses"),
				EnemyDBAct2.create_frost_wyrmling("Sythara"),
				EnemyDBAct2.create_fire_wyrmling("Cindrak")]
		"BeachBattle":
			return [EnemyDBAct2.create_captain("Greybeard"),
				EnemyDBAct2.create_pirate("Flint"),
				EnemyDBAct2.create_pirate("Bonny")]
		"CircusBattle":
			return [EnemyDBAct2.create_harlequin("Louis"),
				EnemyDBAct2.create_chanteuse("Erembour"),
				EnemyDBAct2.create_ringmaster("Gaspard")]
		"LabBattle":
			return [EnemyDBAct2.create_android("Deus"),
				EnemyDBAct2.create_machinist("Ananiah"),
				EnemyDBAct2.create_ironclad("Acrid")]
		"ArmyBattle":
			return [EnemyDBAct2.create_commander("Varro"),
				EnemyDBAct2.create_draconian("Theron"),
				EnemyDBAct2.create_chaplain("Cristole")]
		"CemeteryBattle":
			return [EnemyDBAct2.create_zombie("Mort"),
				EnemyDBAct2.create_ghoul("Rave"),
				EnemyDBAct2.create_zombie("Dredge")]
		"OutpostDefenseBattle":
			return [EnemyDBAct2.create_shade("Umbra"),
				EnemyDBAct2.create_wraith("Specter"),
				EnemyDBAct2.create_boneguard("Osseus")]
		"ReturnToCityStreetBattle":
			return [EnemyDBAct345.create_royal_guard("Aldric"),
				EnemyDBAct345.create_guard_sergeant("Brennan"),
				EnemyDBAct345.create_guard_archer("Tamsin"),
				EnemyDBAct345.create_guard_archer("Corwin")]
		"StrangerTowerBattle":
			return [EnemyDBAct345.create_stranger("The Stranger")]
		"CorruptedCityBattle":
			return [EnemyDBAct345.create_lich("Mortuus"),
				EnemyDBAct345.create_ghast("Putrefax"),
				EnemyDBAct345.create_ghast("Bloatus"),
				EnemyDBAct345.create_lich("Necrus")]
		"CorruptedWildsBattle":
			return [EnemyDBAct345.create_demon("Bael"),
				EnemyDBAct345.create_corrupted_treant("Rothollow"),
				EnemyDBAct345.create_corrupted_treant("Blightsnarl"),
				EnemyDBAct345.create_demon("Moloch")]
		"GateBattle":
			return [EnemyDBAct345.create_dark_knight("Ser Malachar"),
				EnemyDBAct345.create_fell_hound("Duskfang"),
				EnemyDBAct345.create_fell_hound("Gloomjaw"),
				EnemyDBAct345.create_dark_knight("Ser Dravus")]
		"DepthsBattle":
			return [EnemyDBAct345.create_sigil_wretch("Skritch"),
				EnemyDBAct345.create_tunnel_lurker("Silkfang"),
				EnemyDBAct345.create_tunnel_lurker("Webweaver")]
		"StrangerFinalBattle":
			return [EnemyDBAct345.create_stranger_final("The Stranger")]
		"RitualAnchorBattle":
			return [EnemyDBAct5B.create_sigil_colossus("Pillarguard"),
				EnemyDBAct5B.create_ritual_conduit("The Conduit"),
				EnemyDBAct5B.create_void_sentinel("Nullblade")]
		"SanctumCollapseBattle":
			return [EnemyDBAct5B.create_void_horror("The Hollow"),
				EnemyDBAct5B.create_fractured_shadow("Splinter"),
				EnemyDBAct5B.create_shadow_remnant("Fadelight")]
		"StrangerUndoneBattle":
			return [EnemyDBAct5B.create_stranger_undone("The Stranger")]
		_:
			var result := S2S3.create_enemies(stage_name)
			if result.is_empty():
				push_error("Unknown stage: %s" % stage_name)
			return result
