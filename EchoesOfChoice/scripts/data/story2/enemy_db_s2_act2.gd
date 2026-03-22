class_name EnemyDBS2Act2

## Story 2 Act II enemy factory: coastal and surface threats.

const FighterData := preload("res://scripts/data/fighter_data.gd")
const EAB := preload("res://scripts/data/story2/enemy_ability_db_s2.gd")


static func _es(base_min: int, base_max: int, gmin: int, gmax: int, level: int, base_level: int = 1) -> int:
	var lvl: int = level - base_level
	var lo: int = base_min + lvl * gmin
	var hi: int = base_max + lvl * (gmax - 1)
	if hi <= lo:
		return lo
	return randi_range(lo, hi - 1)


static func _base(name: String, type: String, lvl: int) -> FighterData:
	var f := FighterData.new()
	f.character_name = name
	f.character_type = type
	f.class_id = type
	f.is_user_controlled = false
	f.level = lvl
	return f


# =============================================================================
# Pre-upgrade enemies (Tier 1, levels 5-6)
# =============================================================================

static func create_driftwood_bandit(n: String, lvl: int = 5) -> FighterData:
	var f := _base(n, "Driftwood Bandit", lvl)
	f.health = _es(150, 175, 4, 7, lvl, 5); f.max_health = f.health
	f.mana = _es(8, 12, 1, 3, lvl, 5); f.max_mana = f.mana
	f.physical_attack = _es(35, 40, 2, 3, lvl, 5)
	f.physical_defense = _es(17, 21, 1, 2, lvl, 5)
	f.magic_attack = _es(4, 7, 0, 1, lvl, 5)
	f.magic_defense = _es(12, 16, 1, 2, lvl, 5)
	f.speed = _es(24, 30, 1, 3, lvl, 5)
	f.crit_chance = 9; f.crit_damage = 2; f.dodge_chance = 6
	f.abilities = [EAB.cutlass_slash(), EAB.pillage_strike()]
	f.flavor_text = "A weathered scavenger who builds weapons from shipwreck debris. Desperate and violent, they prey on anyone who washes ashore."
	return f


static func create_saltrunner_smuggler(n: String, lvl: int = 5) -> FighterData:
	var f := _base(n, "Saltrunner Smuggler", lvl)
	f.health = _es(118, 136, 3, 5, lvl, 5); f.max_health = f.health
	f.mana = _es(10, 14, 1, 3, lvl, 5); f.max_mana = f.mana
	f.physical_attack = _es(29, 35, 2, 3, lvl, 5)
	f.physical_defense = _es(12, 15, 1, 2, lvl, 5)
	f.magic_attack = _es(6, 9, 0, 1, lvl, 5)
	f.magic_defense = _es(12, 15, 1, 2, lvl, 5)
	f.speed = _es(30, 36, 2, 3, lvl, 5)
	f.crit_chance = 7; f.crit_damage = 2; f.dodge_chance = 16
	f.abilities = [EAB.throwing_knife(), EAB.salt_blind()]
	f.flavor_text = "A quick-handed smuggler who runs contraband through the coastal caves. They fight dirty and never hesitate to blind their foes with salt."
	return f


static func create_tide_warden(n: String, lvl: int = 5) -> FighterData:
	var f := _base(n, "Tide Warden", lvl)
	f.health = _es(190, 215, 5, 8, lvl, 5); f.max_health = f.health
	f.mana = _es(10, 14, 1, 3, lvl, 5); f.max_mana = f.mana
	f.physical_attack = _es(31, 38, 2, 3, lvl, 5)
	f.physical_defense = _es(25, 30, 1, 3, lvl, 5)
	f.magic_attack = _es(6, 11, 0, 1, lvl, 5)
	f.magic_defense = _es(17, 21, 1, 2, lvl, 5)
	f.speed = _es(20, 26, 1, 2, lvl, 5)
	f.crit_chance = 7; f.crit_damage = 2; f.dodge_chance = 6
	f.abilities = [EAB.harpoon_thrust(), EAB.brace_formation()]
	f.flavor_text = "A heavily armored sentinel who guards the coastal passages. Their loyalty to the sea is absolute, and their harpoon strikes are precise."
	return f


static func create_blighted_gull(n: String, lvl: int = 5) -> FighterData:
	var f := _base(n, "Blighted Gull", lvl)
	f.health = _es(86, 101, 3, 5, lvl, 5); f.max_health = f.health
	f.mana = _es(12, 16, 1, 3, lvl, 5); f.max_mana = f.mana
	f.physical_attack = _es(8, 11, 0, 2, lvl, 5)
	f.physical_defense = _es(9, 12, 0, 1, lvl, 5)
	f.magic_attack = _es(21, 26, 1, 3, lvl, 5)
	f.magic_defense = _es(11, 14, 1, 2, lvl, 5)
	f.speed = _es(32, 38, 2, 3, lvl, 5)
	f.crit_chance = 6; f.crit_damage = 1; f.dodge_chance = 16
	f.abilities = [EAB.peck_frenzy(), EAB.dive_screech()]
	f.flavor_text = "A seabird twisted by the dark influence bleeding from the lighthouse. Its feathers are matted with tar-like corruption."
	return f


static func create_shore_crawler(n: String, lvl: int = 5) -> FighterData:
	var f := _base(n, "Shore Crawler", lvl)
	f.health = _es(137, 158, 4, 7, lvl, 5); f.max_health = f.health
	f.mana = _es(8, 12, 1, 2, lvl, 5); f.max_mana = f.mana
	f.physical_attack = _es(34, 39, 2, 4, lvl, 5)
	f.physical_defense = _es(21, 26, 1, 3, lvl, 5)
	f.magic_attack = _es(4, 7, 0, 1, lvl, 5)
	f.magic_defense = _es(14, 18, 1, 2, lvl, 5)
	f.speed = _es(18, 24, 1, 2, lvl, 5)
	f.crit_chance = 7; f.crit_damage = 2; f.dodge_chance = 6
	f.abilities = [EAB.crushing_claw(), EAB.chitin_shell()]
	f.flavor_text = "A massive crustacean that drags itself along the rocky shore. Its barnacle-encrusted shell can withstand tremendous punishment."
	return f


static func create_warped_hound(n: String, lvl: int = 5) -> FighterData:
	var f := _base(n, "Warped Hound", lvl)
	f.health = _es(112, 131, 3, 5, lvl, 5); f.max_health = f.health
	f.mana = _es(10, 14, 1, 3, lvl, 5); f.max_mana = f.mana
	f.physical_attack = _es(32, 37, 2, 4, lvl, 5)
	f.physical_defense = _es(14, 18, 1, 2, lvl, 5)
	f.magic_attack = _es(6, 9, 0, 1, lvl, 5)
	f.magic_defense = _es(9, 12, 0, 1, lvl, 5)
	f.speed = _es(30, 36, 2, 3, lvl, 5)
	f.crit_chance = 10; f.crit_damage = 2; f.dodge_chance = 13
	f.abilities = [EAB.feral_lunge(), EAB.brackish_howl()]
	f.flavor_text = "A feral dog warped by prolonged exposure to corrupted tidewater. Its body is gaunt and its eyes burn with unnatural hunger."
	return f


# =============================================================================
# Post-upgrade enemies (Tier 2, levels 8-10)
# =============================================================================

static func create_blackwater_captain(n: String, lvl: int = 8) -> FighterData:
	var f := _base(n, "Blackwater Captain", lvl)
	f.health = _es(314, 359, 6, 9, lvl, 8); f.max_health = f.health
	f.mana = _es(14, 18, 1, 3, lvl, 8); f.max_mana = f.mana
	f.physical_attack = _es(53, 61, 3, 5, lvl, 8)
	f.physical_defense = _es(33, 39, 2, 3, lvl, 8)
	f.magic_attack = _es(6, 9, 0, 1, lvl, 8)
	f.magic_defense = _es(22, 27, 1, 2, lvl, 8)
	f.speed = _es(26, 32, 1, 3, lvl, 8)
	f.crit_chance = 20; f.crit_damage = 3; f.dodge_chance = 12
	f.abilities = [EAB.boarding_axe(), EAB.captains_orders()]
	f.flavor_text = "A ruthless pirate captain who commands the Blackwater fleet. Scars and sea salt have hardened both body and will."
	return f


static func create_corsair_hexer(n: String, lvl: int = 8) -> FighterData:
	var f := _base(n, "Corsair Hexer", lvl)
	f.health = _es(237, 269, 5, 7, lvl, 8); f.max_health = f.health
	f.mana = _es(18, 22, 2, 4, lvl, 8); f.max_mana = f.mana
	f.physical_attack = _es(8, 11, 0, 2, lvl, 8)
	f.physical_defense = _es(14, 18, 1, 2, lvl, 8)
	f.magic_attack = _es(49, 56, 3, 5, lvl, 8)
	f.magic_defense = _es(32, 38, 2, 3, lvl, 8)
	f.speed = _es(28, 34, 2, 3, lvl, 8)
	f.crit_chance = 12; f.crit_damage = 2; f.dodge_chance = 16
	f.abilities = [EAB.brine_curse(), EAB.corrode_ward()]
	f.flavor_text = "A sea-witch who sails with the corsair fleet, dealing in curses drawn from the deep. Saltwater itself bends to their hexes."
	return f


static func create_abyssal_lurker(n: String, lvl: int = 9) -> FighterData:
	var f := _base(n, "Abyssal Lurker", lvl)
	f.health = _es(272, 310, 6, 9, lvl, 9); f.max_health = f.health
	f.mana = _es(16, 20, 2, 4, lvl, 9); f.max_mana = f.mana
	f.physical_attack = _es(10, 14, 0, 2, lvl, 9)
	f.physical_defense = _es(29, 35, 2, 3, lvl, 9)
	f.magic_attack = _es(52, 59, 3, 5, lvl, 9)
	f.magic_defense = _es(27, 33, 2, 3, lvl, 9)
	f.speed = _es(24, 30, 1, 3, lvl, 9)
	f.crit_chance = 10; f.crit_damage = 2; f.dodge_chance = 10
	f.abilities = [EAB.depth_pulse(), EAB.tidal_drain()]
	f.flavor_text = "A deep-sea horror that surfaces near the coast when storms roll in. Its form is barely visible, a suggestion of tentacles and teeth in dark water."
	return f


static func create_stormwrack_raptor(n: String, lvl: int = 8) -> FighterData:
	var f := _base(n, "Stormwrack Raptor", lvl)
	f.health = _es(234, 267, 5, 8, lvl, 8); f.max_health = f.health
	f.mana = _es(14, 18, 1, 3, lvl, 8); f.max_mana = f.mana
	f.physical_attack = _es(48, 55, 3, 5, lvl, 8)
	f.physical_defense = _es(19, 24, 1, 2, lvl, 8)
	f.magic_attack = _es(34, 40, 2, 4, lvl, 8)
	f.magic_defense = _es(19, 24, 1, 2, lvl, 8)
	f.speed = _es(36, 42, 2, 4, lvl, 8)
	f.crit_chance = 13; f.crit_damage = 2; f.dodge_chance = 17
	f.abilities = [EAB.lightning_dive(), EAB.static_screech()]
	f.flavor_text = "A massive bird of prey that nests in storm clouds above the coast. Lightning crackles along its wingfeathers as it dives."
	return f


static func create_tidecaller_revenant(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "Tidecaller Revenant", lvl)
	f.health = _es(407, 458, 8, 11, lvl, 10); f.max_health = f.health
	f.mana = _es(24, 28, 2, 4, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(10, 14, 0, 2, lvl, 10)
	f.physical_defense = _es(30, 36, 2, 3, lvl, 10)
	f.magic_attack = _es(68, 77, 4, 6, lvl, 10)
	f.magic_defense = _es(42, 49, 3, 5, lvl, 10)
	f.speed = _es(30, 36, 2, 3, lvl, 10)
	f.crit_chance = 13; f.crit_damage = 2; f.dodge_chance = 14
	f.abilities = [EAB.storm_surge(), EAB.drowning_grasp(), EAB.mist_veil()]
	f.flavor_text = "The restless spirit of a drowned tidecaller, still commanding the waves in death. Storm and sea answer its hollow voice."
	return f


static func create_salt_phantom(n: String, lvl: int = 9) -> FighterData:
	var f := _base(n, "Salt Phantom", lvl)
	f.health = _es(260, 298, 5, 8, lvl, 9); f.max_health = f.health
	f.mana = _es(16, 20, 2, 4, lvl, 9); f.max_mana = f.mana
	f.physical_attack = _es(8, 11, 0, 2, lvl, 9)
	f.physical_defense = _es(17, 22, 1, 2, lvl, 9)
	f.magic_attack = _es(56, 64, 3, 5, lvl, 9)
	f.magic_defense = _es(31, 38, 2, 4, lvl, 9)
	f.speed = _es(32, 38, 2, 3, lvl, 9)
	f.crit_chance = 9; f.crit_damage = 2; f.dodge_chance = 20
	f.abilities = [EAB.spectral_chill(), EAB.memory_fog()]
	f.flavor_text = "A translucent specter formed from crystallized sea salt and lost grief. It drifts through fog, erasing the memories of those it touches."
	return f


# =============================================================================
# P7: Blackwater Bay (unique enemies)
# Mixed ghost-fighters with DoT and AoE defense shred
# =============================================================================

static func create_drowned_sailor(n: String, lvl: int = 9) -> FighterData:
	var f := _base(n, "Drowned Sailor", lvl)
	f.health = _es(265, 302, 5, 8, lvl, 9); f.max_health = f.health
	f.mana = _es(16, 20, 2, 4, lvl, 9); f.max_mana = f.mana
	f.physical_attack = _es(41, 48, 2, 3, lvl, 9)
	f.physical_defense = _es(19, 24, 1, 2, lvl, 9)
	f.magic_attack = _es(45, 52, 2, 4, lvl, 9)
	f.magic_defense = _es(31, 38, 2, 4, lvl, 9)
	f.speed = _es(33, 39, 2, 3, lvl, 9)
	f.crit_chance = 12; f.crit_damage = 2; f.dodge_chance = 14
	f.abilities = [EAB.spectral_cutlass(), EAB.waterlogged_grasp()]
	f.flavor_text = "The waterlogged ghost of a sailor claimed by the bay. It fights with the remembered motions of a life spent at sea."
	return f


static func create_depth_horror(n: String, lvl: int = 9) -> FighterData:
	var f := _base(n, "Depth Horror", lvl)
	f.health = _es(285, 326, 6, 9, lvl, 9); f.max_health = f.health
	f.mana = _es(17, 21, 2, 4, lvl, 9); f.max_mana = f.mana
	f.physical_attack = _es(31, 38, 2, 3, lvl, 9)
	f.physical_defense = _es(30, 36, 2, 3, lvl, 9)
	f.magic_attack = _es(55, 63, 3, 5, lvl, 9)
	f.magic_defense = _es(28, 34, 2, 3, lvl, 9)
	f.speed = _es(28, 34, 2, 3, lvl, 9)
	f.crit_chance = 9; f.crit_damage = 2; f.dodge_chance = 8
	f.abilities = [EAB.tentacle_crush(), EAB.abyssal_terror()]
	f.flavor_text = "An ancient thing from the ocean floor, drawn to the surface by the Eye's growing influence. Its mere presence fills the mind with dread."
	return f
