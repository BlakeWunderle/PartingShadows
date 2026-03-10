class_name BattleStageDB

## All battle stages with enemy compositions and balance targets.
## Each stage has a story field (1 or 2) for filtering by story.

const EnemyDB := preload("res://scripts/data/story1/enemy_db.gd")
const EnemyDBAct2 := preload("res://scripts/data/story1/enemy_db_act2.gd")
const EnemyDBAct345 := preload("res://scripts/data/story1/enemy_db_act345.gd")
const EnemyDBS2 := preload("res://scripts/data/story2/enemy_db_s2.gd")
const EnemyDBS2Act2 := preload("res://scripts/data/story2/enemy_db_s2_act2.gd")
const EnemyDBS2Act3 := preload("res://scripts/data/story2/enemy_db_s2_act3.gd")
const EnemyDBS2Act4 := preload("res://scripts/data/story2/enemy_db_s2_act4.gd")
const FighterData := preload("res://scripts/data/fighter_data.gd")


static func get_all_stages() -> Array:
	return [
		# Prog 0: Base classes, no level ups
		_s("CityStreetBattle", 0, "base", 0.90, 0),
		# Prog 1: Base classes, 1 level up
		_s("WolfForestBattle", 1, "base", 0.88, 1),
		# Prog 2: Base classes, 2 level ups
		_s("WaypointDefenseBattle", 2, "base", 0.85, 2),
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
		# Prog 7: Tier 1, 8 total level ups (mirror)
		_s("MirrorBattle", 8, "tier1", 0.75, 7),
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
		# --- Story 2: Echoes in the Dark ---
		# Prog 0: Base classes, no level ups
		_s("S2_CaveAwakening", 0, "base", 0.85, 0, 2),
		# Prog 1: Base classes, 1 level up (branch pair)
		_s("S2_DeepCavern", 1, "base", 0.83, 1, 2),
		_s("S2_FungalHollow", 1, "base", 0.83, 1, 2),
		# Prog 2: Base classes, 2 level ups (branch pair)
		_s("S2_TranquilPool", 2, "base", 0.80, 2, 2),
		_s("S2_TorchChamber", 2, "base", 0.80, 2, 2),
		# Prog 3: Tier 1, 4 level ups (post-merchant upgrade)
		_s("S2_CaveExit", 4, "tier1", 0.76, 3, 2),
		# --- Story 2 Act II: The Shore ---
		# Prog 4: Tier 1, 5 level ups (first surface battle)
		_s("S2_CoastalDescent", 5, "tier1", 0.74, 4, 2),
		# Prog 5: Tier 1, 6 level ups (branch pair)
		_s("S2_FishingVillage", 6, "tier1", 0.72, 5, 2),
		_s("S2_SmugglersBluff", 6, "tier1", 0.72, 5, 2),
		# Prog 6: Tier 2, 8 level ups (post-harbor upgrade, branch pair)
		_s("S2_WreckersCove", 8, "tier2", 0.70, 6, 2),
		_s("S2_CoastalRuins", 8, "tier2", 0.70, 6, 2),
		# Prog 7: Tier 2, 9 level ups (convergence)
		_s("S2_BlackwaterBay", 9, "tier2", 0.68, 7, 2),
		# Prog 8: Tier 2, 10 level ups (Act II boss)
		_s("S2_LighthouseStorm", 10, "tier2", 0.66, 8, 2),
		# --- Story 2 Act III: The Truth ---
		# Prog 9: Tier 2, 11 level ups (beneath the lighthouse)
		_s("S2_BeneathTheLighthouse", 11, "tier2", 0.62, 9, 2),
		# Prog 10: Tier 2, 12 level ups (branch pair)
		_s("S2_MemoryVault", 12, "tier2", 0.60, 10, 2),
		_s("S2_EchoGallery", 12, "tier2", 0.60, 10, 2),
		# Prog 11: Tier 2, 13 level ups (convergence + reveal)
		_s("S2_ShatteredSanctum", 13, "tier2", 0.58, 11, 2),
		# Prog 12: Tier 2, 14 level ups (branch pair)
		_s("S2_GuardiansThreshold", 14, "tier2", 0.55, 12, 2),
		_s("S2_ForgottenArchive", 14, "tier2", 0.55, 12, 2),
		# Prog 13: Tier 2, 15 level ups (Act III boss)
		_s("S2_TheReveal", 15, "tier2", 0.52, 13, 2),
		# --- Story 2 Act IV: The Reckoning ---
		# Prog 14: Tier 2, 16 level ups
		_s("S2_DepthsOfRemembrance", 16, "tier2", 0.50, 14, 2),
		# Prog 15: Tier 2, 17 level ups
		_s("S2_MawOfTheEye", 17, "tier2", 0.48, 15, 2),
		# Prog 16: Tier 2, 18 level ups (Phase 1 boss)
		_s("S2_EyeAwakening", 18, "tier2", 0.45, 16, 2),
		# Prog 17: Tier 2, 19 level ups (final boss)
		_s("S2_EyeOfOblivion", 19, "tier2", 0.42, 17, 2),
	]


static func get_story_stages(story: int) -> Array:
	return get_all_stages().filter(
		func(s: Dictionary) -> bool: return s.story == story)


static func _s(n: String, lu: int, tier: String, target: float,
		prog: int, story: int = 1) -> Dictionary:
	return {
		"name": n, "level_ups": lu, "tier": tier,
		"target_win_rate": target, "progression_stage": prog,
		"story": story,
	}


# =============================================================================
# Enemy factories, one per stage
# =============================================================================

static func create_enemies(stage_name: String, party: Array = []) -> Array:
	match stage_name:
		"CityStreetBattle":
			return [EnemyDB.create_thug("Alexander"),
				EnemyDB.create_ruffian("Jenna"),
				EnemyDB.create_pickpocket("Ella")]
		"WolfForestBattle":
			return [EnemyDB.create_wolf("Greyfang"),
				EnemyDB.create_boar("Tusker")]
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
				EnemyDBAct2.create_wraith("Revenant"),
				EnemyDBAct2.create_shade("Penumbra"),
				EnemyDBAct2.create_wraith("Specter")]
		"MirrorBattle":
			return _mirror_enemies(party)
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
		# Story 2
		"S2_CaveAwakening":
			return [EnemyDBS2.create_glow_worm("Luminara"),
				EnemyDBS2.create_glow_worm("Flicker"),
				EnemyDBS2.create_crystal_spider("Prism")]
		"S2_DeepCavern":
			return [EnemyDBS2.create_shade_crawler("Umbral"),
				EnemyDBS2.create_shade_crawler("Murk"),
				EnemyDBS2.create_echo_wisp("Resonance")]
		"S2_FungalHollow":
			return [EnemyDBS2.create_spore_stalker("Creeper"),
				EnemyDBS2.create_fungal_hulk("Mossback"),
				EnemyDBS2.create_cap_wisp("Drifter")]
		"S2_TranquilPool":
			return [EnemyDBS2.create_cave_eel("Voltfin"),
				EnemyDBS2.create_blind_angler("The Lure"),
				EnemyDBS2.create_pale_crayfish("Old Shell")]
		"S2_TorchChamber":
			return [EnemyDBS2.create_cave_dweller("Grimjaw"),
				EnemyDBS2.create_tunnel_shaman("Ember Eye"),
				EnemyDBS2.create_burrow_scout("Quickfoot")]
		"S2_CaveExit":
			return [EnemyDBS2.create_cave_maw("The Threshold", 5),
				EnemyDBS2.create_vein_leech("Gnawer", 5),
				EnemyDBS2.create_stone_moth("Dustwing", 5)]
		# Story 2 Act II
		"S2_CoastalDescent":
			return [EnemyDBS2Act2.create_blighted_gull("Blackwing"),
				EnemyDBS2Act2.create_shore_crawler("Ironshell"),
				EnemyDBS2Act2.create_warped_hound("Brine")]
		"S2_FishingVillage":
			return [EnemyDBS2Act2.create_driftwood_bandit("Scarhand"),
				EnemyDBS2Act2.create_driftwood_bandit("Rust"),
				EnemyDBS2Act2.create_saltrunner_smuggler("Quicksilver")]
		"S2_SmugglersBluff":
			return [EnemyDBS2Act2.create_saltrunner_smuggler("Duskrunner"),
				EnemyDBS2Act2.create_tide_warden("Breakwater"),
				EnemyDBS2Act2.create_driftwood_bandit("Splinter")]
		"S2_WreckersCove":
			return [EnemyDBS2Act2.create_blackwater_captain("Captain Korr"),
				EnemyDBS2Act2.create_corsair_hexer("Saltweave"),
				EnemyDBS2Act2.create_driftwood_bandit("Barnacle")]
		"S2_CoastalRuins":
			return [EnemyDBS2Act2.create_abyssal_lurker("Depthcrawl"),
				EnemyDBS2Act2.create_stormwrack_raptor("Voltwing"),
				EnemyDBS2Act2.create_blighted_gull("Shriek")]
		"S2_BlackwaterBay":
			return [EnemyDBS2Act2.create_drowned_sailor("The Drowned"),
				EnemyDBS2Act2.create_drowned_sailor("The Forgotten"),
				EnemyDBS2Act2.create_depth_horror("Undertow")]
		"S2_LighthouseStorm":
			return [EnemyDBS2Act2.create_tidecaller_revenant("The Keeper"),
				EnemyDBS2Act2.create_salt_phantom("The Watcher")]
		# Story 2 Act III
		"S2_BeneathTheLighthouse":
			return [EnemyDBS2Act3.create_fading_wisp("Glimmer"),
				EnemyDBS2Act3.create_fading_wisp("Shimmer"),
				EnemyDBS2Act3.create_dim_guardian("Resonance")]
		"S2_MemoryVault":
			return [EnemyDBS2Act3.create_thought_eater("Gnaw"),
				EnemyDBS2Act3.create_memory_wisp("Shimmer"),
				EnemyDBS2Act3.create_echo_sentinel("Vigil")]
		"S2_EchoGallery":
			return [EnemyDBS2Act3.create_hollow_watcher("Flicker"),
				EnemyDBS2Act3.create_grief_shade("Reverb"),
				EnemyDBS2Act3.create_memory_wisp("Whisper")]
		"S2_ShatteredSanctum":
			return [EnemyDBS2Act3.create_mirror_self("Reflection"),
				EnemyDBS2Act3.create_void_weaver("Unmaker"),
				EnemyDBS2Act3.create_grief_shade("Mourning")]
		"S2_GuardiansThreshold":
			return [EnemyDBS2Act3.create_ward_construct("Remembrance"),
				EnemyDBS2Act3.create_null_phantom("Erasure"),
				EnemyDBS2Act3.create_threshold_echo("Echo")]
		"S2_ForgottenArchive":
			return [EnemyDBS2Act3.create_archive_keeper("Archivist"),
				EnemyDBS2Act3.create_silent_archivist("Cataloger"),
				EnemyDBS2Act3.create_lost_record("Lost Entry"),
				EnemyDBS2Act3.create_faded_page("Faded Page")]
		"S2_TheReveal":
			return [EnemyDBS2Act3.create_the_warden("The Warden"),
				EnemyDBS2Act3.create_fractured_protector("Sera")]
		# Story 2 Act IV
		"S2_DepthsOfRemembrance":
			return [EnemyDBS2Act4.create_gaze_stalker("Lidwatch"),
				EnemyDBS2Act4.create_gaze_stalker("Duskpupil"),
				EnemyDBS2Act4.create_memory_harvester("The Gleaner")]
		"S2_MawOfTheEye":
			return [EnemyDBS2Act4.create_thoughtform_knight("Oathbound"),
				EnemyDBS2Act4.create_oblivion_shade("The Hollow"),
				EnemyDBS2Act4.create_memory_harvester("The Reaper")]
		"S2_EyeAwakening":
			return [EnemyDBS2Act4.create_the_iris("The Iris"),
				EnemyDBS2Act4.create_oblivion_shade("Nullsight")]
		"S2_EyeOfOblivion":
			return [EnemyDBS2Act4.create_the_lidless_eye("The Lidless Eye")]
		_:
			push_error("Unknown stage: %s" % stage_name)
			return []


static func _mirror_enemies(party: Array) -> Array:
	var enemies := []
	for f: FighterData in party:
		var c := f.clone()
		c.character_name = "Shadow " + f.character_name
		c.is_user_controlled = false
		c.health = int(c.health * 0.99); c.max_health = c.health
		c.physical_attack = int(c.physical_attack * 0.99)
		c.magic_attack = int(c.magic_attack * 0.99)
		c.speed = int(c.speed * 0.97)
		enemies.append(c)
	return enemies
