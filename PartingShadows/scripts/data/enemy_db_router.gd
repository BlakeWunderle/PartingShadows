class_name EnemyDBRouter

## Enemy factory router: maps class_id to the correct story/act enemy factory.
## Follows the same pattern as BattleDB (pure router, no logic of its own).

const FighterData := preload("res://scripts/data/fighter_data.gd")

# Story 1
const S1 := preload("res://scripts/data/story1/enemy_db.gd")
const S1A2 := preload("res://scripts/data/story1/enemy_db_act2.gd")
const S1A345 := preload("res://scripts/data/story1/enemy_db_act345.gd")
const S1A5B := preload("res://scripts/data/story1/enemy_db_act5b.gd")

# Story 2
const S2 := preload("res://scripts/data/story2/enemy_db_s2.gd")
const S2A2 := preload("res://scripts/data/story2/enemy_db_s2_act2.gd")
const S2A3 := preload("res://scripts/data/story2/enemy_db_s2_act3.gd")
const S2A4 := preload("res://scripts/data/story2/enemy_db_s2_act4.gd")
const S2PB := preload("res://scripts/data/story2/enemy_db_s2_pathb.gd")

# Story 3
const S3 := preload("res://scripts/data/story3/enemy_db_s3.gd")
const S3A2 := preload("res://scripts/data/story3/enemy_db_s3_act2.gd")
const S3A3 := preload("res://scripts/data/story3/enemy_db_s3_act3.gd")
const S3A45 := preload("res://scripts/data/story3/enemy_db_s3_act45.gd")
const S3PB := preload("res://scripts/data/story3/enemy_db_s3_pathb.gd")
const S3PC := preload("res://scripts/data/story3/enemy_db_s3_pathc.gd")


## Create an enemy FighterData by class_id. Returns null if unknown.
static func create_enemy(class_id: String) -> FighterData:
	match class_id:
		# =====================================================================
		# Story 1 - Act I
		# =====================================================================
		"Thug": return S1.create_thug("")
		"Ruffian": return S1.create_ruffian("")
		"Pickpocket": return S1.create_pickpocket("")
		"Wolf": return S1.create_wolf("")
		"Boar": return S1.create_boar("")
		"Thornviper": return S1.create_thornviper("")
		"Goblin": return S1.create_goblin("")
		"Hound": return S1.create_hound("")
		"Bandit": return S1.create_bandit("")

		# =====================================================================
		# Story 1 - Act II
		# =====================================================================
		"Raider": return S1A2.create_raider("")
		"Orc": return S1A2.create_orc("")
		"Troll": return S1A2.create_troll("")
		"Harpy": return S1A2.create_harpy("")
		"Witch": return S1A2.create_witch("")
		"Wisp": return S1A2.create_wisp("")
		"Sprite": return S1A2.create_sprite("")
		"Siren": return S1A2.create_siren("")
		"Merfolk": return S1A2.create_merfolk("")
		"Captain": return S1A2.create_captain("")
		"Pirate": return S1A2.create_pirate("")
		"Fire Wyrmling": return S1A2.create_fire_wyrmling("")
		"Frost Wyrmling": return S1A2.create_frost_wyrmling("")
		"Ringmaster": return S1A2.create_ringmaster("")
		"Harlequin": return S1A2.create_harlequin("")
		"Chanteuse": return S1A2.create_chanteuse("")
		"Android": return S1A2.create_android("")
		"Machinist": return S1A2.create_machinist("")
		"Ironclad": return S1A2.create_ironclad("")
		"Commander": return S1A2.create_commander("")
		"Draconian": return S1A2.create_draconian("")
		"Chaplain": return S1A2.create_chaplain("")
		"Zombie": return S1A2.create_zombie("")
		"Ghoul": return S1A2.create_ghoul("")
		"Shade": return S1A2.create_shade("")
		"Wraith": return S1A2.create_wraith("")

		# =====================================================================
		# Story 1 - Acts III-V
		# =====================================================================
		"Royal Guard": return S1A345.create_royal_guard("")
		"Guard Sergeant": return S1A345.create_guard_sergeant("")
		"Guard Archer": return S1A345.create_guard_archer("")
		"Stranger": return S1A345.create_stranger("")
		"StrangerFinal": return S1A345.create_stranger_final("")
		"Lich": return S1A345.create_lich("")
		"Ghast": return S1A345.create_ghast("")
		"Demon": return S1A345.create_demon("")
		"Corrupted Treant": return S1A345.create_corrupted_treant("")
		"Hellion": return S1A345.create_hellion("")
		"Fiendling": return S1A345.create_fiendling("")
		"Dragon": return S1A345.create_dragon("")
		"Blighted Stag": return S1A345.create_blighted_stag("")
		"Dark Knight": return S1A345.create_dark_knight("")
		"Fell Hound": return S1A345.create_fell_hound("")
		"Sigil Wretch": return S1A345.create_sigil_wretch("")
		"Tunnel Lurker": return S1A345.create_tunnel_lurker("")

		# =====================================================================
		# Story 1 - Act V Path B
		# =====================================================================
		"Sigil Colossus": return S1A5B.create_sigil_colossus("")
		"Ritual Conduit": return S1A5B.create_ritual_conduit("")
		"Void Sentinel": return S1A5B.create_void_sentinel("")
		"Void Horror": return S1A5B.create_void_horror("")
		"Fractured Shadow": return S1A5B.create_fractured_shadow("")
		"Shadow Remnant": return S1A5B.create_shadow_remnant("")
		"StrangerUndone": return S1A5B.create_stranger_undone("")

		# =====================================================================
		# Story 2 - Act I
		# =====================================================================
		"Glow Worm": return S2.create_glow_worm("")
		"Crystal Spider": return S2.create_crystal_spider("")
		"Shade Crawler": return S2.create_shade_crawler("")
		"Echo Wisp": return S2.create_echo_wisp("")
		"Spore Stalker": return S2.create_spore_stalker("")
		"Fungal Hulk": return S2.create_fungal_hulk("")
		"Cap Wisp": return S2.create_cap_wisp("")
		"Cave Eel": return S2.create_cave_eel("")
		"Blind Angler": return S2.create_blind_angler("")
		"Cavern Snapper": return S2.create_cavern_snapper("")
		"Silt Lurker": return S2.create_silt_lurker("")
		"Cave Dweller": return S2.create_cave_dweller("")
		"Tunnel Shaman": return S2.create_tunnel_shaman("")
		"Burrow Scout": return S2.create_burrow_scout("")
		"Cave Maw": return S2.create_cave_maw("")
		"Vein Leech": return S2.create_vein_leech("")
		"Stone Moth": return S2.create_stone_moth("")

		# =====================================================================
		# Story 2 - Act II
		# =====================================================================
		"Driftwood Bandit": return S2A2.create_driftwood_bandit("")
		"Saltrunner Smuggler": return S2A2.create_saltrunner_smuggler("")
		"Tide Warden": return S2A2.create_tide_warden("")
		"Blighted Gull": return S2A2.create_blighted_gull("")
		"Shore Crawler": return S2A2.create_shore_crawler("")
		"Warped Hound": return S2A2.create_warped_hound("")
		"Blackwater Captain": return S2A2.create_blackwater_captain("")
		"Corsair Hexer": return S2A2.create_corsair_hexer("")
		"Abyssal Lurker": return S2A2.create_abyssal_lurker("")
		"Stormwrack Raptor": return S2A2.create_stormwrack_raptor("")
		"Tidecaller Revenant": return S2A2.create_tidecaller_revenant("")
		"Salt Phantom": return S2A2.create_salt_phantom("")
		"Drowned Sailor": return S2A2.create_drowned_sailor("")
		"Depth Horror": return S2A2.create_depth_horror("")

		# =====================================================================
		# Story 2 - Act III
		# =====================================================================
		"Memory Wisp": return S2A3.create_memory_wisp("")
		"Echo Sentinel": return S2A3.create_echo_sentinel("")
		"Thought Eater": return S2A3.create_thought_eater("")
		"Grief Shade": return S2A3.create_grief_shade("")
		"Hollow Watcher": return S2A3.create_hollow_watcher("")
		"Mirror Self": return S2A3.create_mirror_self("")
		"Void Weaver": return S2A3.create_void_weaver("")
		"Mnemonic Golem": return S2A3.create_mnemonic_golem("")
		"The Warden": return S2A3.create_the_warden("")
		"Fractured Protector": return S2A3.create_fractured_protector("")
		"Fading Wisp": return S2A3.create_fading_wisp("")
		"Dim Guardian": return S2A3.create_dim_guardian("")
		"Ward Construct": return S2A3.create_ward_construct("")
		"Null Phantom": return S2A3.create_null_phantom("")
		"Threshold Echo": return S2A3.create_threshold_echo("")
		"Ink Devourer": return S2A3.create_ink_devourer("")
		"Silent Archivist": return S2A3.create_silent_archivist("")
		"Lost Record": return S2A3.create_lost_record("")
		"Maw Codex": return S2A3.create_maw_codex("")
		"Shattered Frame": return S2A3.create_shattered_frame("")
		"Sorrow Shade": return S2A3.create_sorrow_shade("")

		# =====================================================================
		# Story 2 - Act IV
		# =====================================================================
		"Pupil Leech": return S2A4.create_pupil_leech("")
		"Gaze Stalker": return S2A4.create_gaze_stalker("")
		"Memory Harvester": return S2A4.create_memory_harvester("")
		"Oblivion Shade": return S2A4.create_oblivion_shade("")
		"Memory Reaper": return S2A4.create_memory_reaper("")
		"Void Iris": return S2A4.create_void_iris("")
		"Thoughtform Knight": return S2A4.create_thoughtform_knight("")
		"The Iris": return S2A4.create_the_iris("")
		"The Lidless Eye": return S2A4.create_the_lidless_eye("")

		# =====================================================================
		# Story 2 - Path B (Save Sera)
		# =====================================================================
		"Fractured Scholar": return S2PB.create_fractured_scholar("")
		"Archive Sentinel": return S2PB.create_archive_sentinel("")
		"Pipeline Warden": return S2PB.create_pipeline_warden("")
		"Maintenance Drone": return S2PB.create_maintenance_drone("")
		"Resonance Node": return S2PB.create_resonance_node("")
		"Eye's Fist": return S2PB.create_eyes_fist("")
		"Null Sentinel": return S2PB.create_null_sentinel("")
		"Overload Spark": return S2PB.create_overload_spark("")
		"Memory Torrent": return S2PB.create_memory_torrent("")
		"Unleashed Recollection": return S2PB.create_unleashed_recollection("")
		"Rage Fragment": return S2PB.create_rage_fragment("")
		"The Unblinking Eye": return S2PB.create_the_unblinking_eye("")

		# =====================================================================
		# Story 3 - Acts I-II
		# =====================================================================
		"Dream Wisp": return S3.create_dream_wisp("")
		"Phantasm": return S3.create_phantasm("")
		"Shade Moth": return S3.create_shade_moth("")
		"Sleep Stalker": return S3.create_sleep_stalker("")
		"Mirror Shade": return S3.create_mirror_shade("")
		"Slumber Beast": return S3.create_slumber_beast("")
		"Fog Wraith": return S3.create_fog_wraith("")
		"Thorn Dreamer": return S3.create_thorn_dreamer("")
		"Nightmare Hound": return S3.create_nightmare_hound("")
		"Dream Weaver": return S3.create_dream_weaver("")
		"Hollow Echo": return S3.create_hollow_echo("")
		"Somnolent Serpent": return S3.create_somnolent_serpent("")
		"Twilight Stalker": return S3.create_twilight_stalker("")
		"Waking Terror": return S3.create_waking_terror("")
		"Dusk Sentinel": return S3.create_dusk_sentinel("")
		"Clock Specter": return S3.create_clock_specter("")
		"The Nightmare": return S3.create_the_nightmare("")
		"Nightmare Guard": return S3.create_nightmare_guard("")
		"Void Echo": return S3.create_void_echo("")
		"Shattered Hourglass": return S3.create_shattered_hourglass("")

		# =====================================================================
		# Story 3 - Act II expansion
		# =====================================================================
		"Thread Lurker": return S3A2.create_thread_lurker("")
		"Dream Sentinel": return S3A2.create_dream_sentinel("")
		"Gloom Spinner": return S3A2.create_gloom_spinner("")
		"Drowned Reverie": return S3A2.create_drowned_reverie("")
		"Riptide Beast": return S3A2.create_riptide_beast("")
		"Depth Crawler": return S3A2.create_depth_crawler("")
		"Fragment Golem": return S3A2.create_fragment_golem("")
		"Portrait Wight": return S3A2.create_portrait_wight("")
		"Gallery Shade": return S3A2.create_gallery_shade("")
		"Shadow Pursuer": return S3A2.create_shadow_pursuer("")
		"Dread Tendril": return S3A2.create_dread_tendril("")
		"Faded Voice": return S3A2.create_faded_voice("")
		"Market Watcher": return S3A2.create_market_watcher("")
		"Thread Smith": return S3A2.create_thread_smith("")
		"Hex Herbalist": return S3A2.create_hex_herbalist("")
		"Cellar Watcher": return S3A2.create_cellar_watcher("")
		"Thread Construct": return S3A2.create_thread_construct("")
		"Ink Shade": return S3A2.create_ink_shade("")

		# =====================================================================
		# Story 3 - Act III
		# =====================================================================
		"Lucid Phantom": return S3A3.create_lucid_phantom("")
		"Thread Spinner": return S3A3.create_thread_spinner("")
		"Loom Sentinel": return S3A3.create_loom_sentinel("")
		"Cult Shade": return S3A3.create_cult_shade("")
		"Dream Warden": return S3A3.create_dream_warden("")
		"Thought Leech": return S3A3.create_thought_leech("")
		"Void Spinner": return S3A3.create_void_spinner("")
		"Sanctum Guardian": return S3A3.create_sanctum_guardian("")

		# =====================================================================
		# Story 3 - Acts IV-V
		# =====================================================================
		"Cult Acolyte": return S3A45.create_cult_acolyte("")
		"Cult Enforcer": return S3A45.create_cult_enforcer("")
		"Cult Hexer": return S3A45.create_cult_hexer("")
		"Thread Guard": return S3A45.create_thread_guard("")
		"Dream Hound": return S3A45.create_dream_hound("")
		"Cult Ritualist": return S3A45.create_cult_ritualist("")
		"High Weaver": return S3A45.create_high_weaver("")
		"Shadow Fragment": return S3A45.create_shadow_fragment("")
		"The Threadmaster": return S3A45.create_the_threadmaster("")
		"DreadTailor": return S3A45.create_dread_tailor("")
		"NeedleWraith": return S3A45.create_needle_wraith("")
		"LoomCrusher": return S3A45.create_loom_crusher("")
		"Ritual Guardian": return S3A45.create_ritual_guardian("")
		"Thread Stitcher": return S3A45.create_thread_stitcher("")

		# =====================================================================
		# Story 3 - Path B
		# =====================================================================
		"Cellar Sentinel": return S3PB.create_cellar_sentinel("")
		"Bound Stalker": return S3PB.create_bound_stalker("")
		"Thread Disciple": return S3PB.create_thread_disciple("")
		"Thread Warden": return S3PB.create_thread_warden("")
		"Tunnel Sentinel": return S3PB.create_tunnel_sentinel("")
		"Thread Sniper": return S3PB.create_thread_sniper("")
		"Pale Devotee": return S3PB.create_pale_devotee("")
		"Thread Ritualist": return S3PB.create_thread_ritualist("")
		"Passage Guardian": return S3PB.create_passage_guardian("")
		"Warding Shadow": return S3PB.create_warding_shadow("")
		"Shadow Innkeeper": return S3PB.create_shadow_innkeeper("")
		"Astral Weaver": return S3PB.create_astral_weaver("")
		"Loom Tendril": return S3PB.create_loom_tendril("")
		"Cathedral Warden": return S3PB.create_cathedral_warden("")
		"Dream Binder": return S3PB.create_dream_binder("")
		"Thread Anchor": return S3PB.create_thread_anchor("")
		"Lira, the Threadmaster": return S3PB.create_lira_threadmaster("")
		"Tattered Deception": return S3PB.create_tattered_deception("")
		"Dream Bastion": return S3PB.create_dream_bastion("")
		"WeftStalker": return S3PB.create_weft_stalker("")
		"Loom Parasite": return S3PB.create_loom_parasite("")

		# =====================================================================
		# Story 3 - Path C
		# =====================================================================
		"Abyssal Dreamer": return S3PC.create_abyssal_dreamer("")
		"Thread Devourer": return S3PC.create_thread_devourer("")
		"Slumbering Colossus": return S3PC.create_slumbering_colossus("")
		"Dream Priest": return S3PC.create_dream_priest("")
		"Astral Enforcer": return S3PC.create_astral_enforcer("")
		"Oneiric Hexer": return S3PC.create_oneiric_hexer("")
		"Oneiric Guardian": return S3PC.create_oneiric_guardian("")
		"Memory Eater": return S3PC.create_memory_eater("")
		"Nightmare Sentinel": return S3PC.create_nightmare_sentinel("")
		"Anchor Chain": return S3PC.create_anchor_chain("")
		"The Ancient Threadmaster": return S3PC.create_ancient_threadmaster("")
		"Dream Shackle": return S3PC.create_dream_shackle("")
		"Loom Heart": return S3PC.create_loom_heart("")

	return null


## Sample an enemy multiple times to determine stat ranges (min-max).
## Returns a Dictionary with stat name keys, each mapping to {min, max}.
static func get_stat_ranges(class_id: String, samples: int = 50) -> Dictionary:
	var stats := ["max_health", "max_mana", "physical_attack", "physical_defense",
		"magic_attack", "magic_defense", "speed", "crit_chance", "dodge_chance"]
	var mins: Dictionary = {}
	var maxs: Dictionary = {}
	for s: String in stats:
		mins[s] = 99999
		maxs[s] = 0

	for i in samples:
		var f: FighterData = create_enemy(class_id)
		if not f:
			return {}
		for s: String in stats:
			var val: int = f.get(s)
			if val < mins[s]:
				mins[s] = val
			if val > maxs[s]:
				maxs[s] = val

	var result: Dictionary = {}
	for s: String in stats:
		result[s] = {"min": mins[s], "max": maxs[s]}
	return result
