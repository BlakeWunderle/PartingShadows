class_name EnemyDBS2Act4

## Story 2 Act IV enemy factory: the Eye's domain.

const FighterData := preload("res://scripts/data/fighter_data.gd")
const EABL := preload("res://scripts/data/story2/enemy_ability_db_s2_late.gd")
const EH := preload("res://scripts/data/enemy_helpers.gd")


# =============================================================================
# The Eye's servants (level 14)
# =============================================================================

static func create_gaze_stalker(n: String, lvl: int = 14) -> FighterData:
	var f := EH.base(n, "Gaze Stalker", lvl)
	f.health = EH.es(492, 558, 5, 8, lvl, 14); f.max_health = f.health
	f.mana = EH.es(11, 14, 1, 2, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(76, 89, 3, 5, lvl, 14)
	f.physical_defense = EH.es(38, 46, 2, 3, lvl, 14)
	f.magic_attack = EH.es(74, 85, 3, 5, lvl, 14)
	f.magic_defense = EH.es(33, 42, 2, 3, lvl, 14)
	f.speed = EH.es(39, 45, 2, 3, lvl, 14)
	f.crit_chance = 22; f.crit_damage = 3; f.dodge_chance = 21
	f.abilities = [EABL.piercing_gaze_strike(), EABL.focus_break()]
	f.flavor_text = "A swift predator that serves as the Eye's hunting hound. It locks onto its prey with an unblinking stare that shatters concentration."
	return f


static func create_memory_harvester(n: String, lvl: int = 14) -> FighterData:
	var f := EH.base(n, "Memory Harvester", lvl)
	f.health = EH.es(521, 590, 5, 8, lvl, 14); f.max_health = f.health
	f.mana = EH.es(19, 23, 1, 2, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(20, 28, 1, 2, lvl, 14)
	f.physical_defense = EH.es(31, 40, 2, 3, lvl, 14)
	f.magic_attack = EH.es(108, 124, 3, 5, lvl, 14)
	f.magic_defense = EH.es(49, 57, 2, 4, lvl, 14)
	f.speed = EH.es(33, 40, 2, 3, lvl, 14)
	f.crit_chance = 20; f.crit_damage = 3; f.dodge_chance = 16
	f.abilities = [EABL.harvest_thought(), EABL.mass_extraction()]
	f.flavor_text = "A grotesque collector that reaps thoughts like grain. The memories it steals are fed directly to the Eye, fueling its terrible awareness."
	return f


static func create_oblivion_shade(n: String, lvl: int = 14) -> FighterData:
	var f := EH.base(n, "Oblivion Shade", lvl)
	f.health = EH.es(333, 377, 4, 7, lvl, 14); f.max_health = f.health
	f.mana = EH.es(17, 20, 1, 2, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(20, 28, 1, 2, lvl, 14)
	f.physical_defense = EH.es(21, 30, 1, 3, lvl, 14)
	f.magic_attack = EH.es(103, 120, 3, 4, lvl, 14)
	f.magic_defense = EH.es(45, 54, 2, 4, lvl, 14)
	f.speed = EH.es(41, 48, 2, 4, lvl, 14)
	f.crit_chance = 19; f.crit_damage = 3; f.dodge_chance = 25
	f.abilities = [EABL.wave_of_oblivion(), EABL.nihil_bolt()]
	f.flavor_text = "A wraith woven from pure forgetting. Where it passes, all sense of self dissolves, leaving only a hollow ache where identity once lived."
	return f


static func create_memory_reaper(n: String, lvl: int = 14) -> FighterData:
	var f := EH.base(n, "Memory Reaper", lvl)
	f.health = EH.es(551, 621, 5, 8, lvl, 14); f.max_health = f.health
	f.mana = EH.es(19, 23, 1, 2, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(20, 28, 1, 2, lvl, 14)
	f.physical_defense = EH.es(31, 40, 2, 3, lvl, 14)
	f.magic_attack = EH.es(125, 144, 3, 5, lvl, 14)
	f.magic_defense = EH.es(49, 57, 2, 4, lvl, 14)
	f.speed = EH.es(36, 43, 2, 3, lvl, 14)
	f.crit_chance = 27; f.crit_damage = 3; f.dodge_chance = 22
	f.abilities = [EABL.harvesting_scythe(), EABL.accumulated_toll()]
	f.flavor_text = "A harvester that has gorged on the Eye's overflow of stolen memories. It reaps with terrible efficiency, each thought it claims adding to the Eye's power."
	return f


static func create_void_iris(n: String, lvl: int = 14) -> FighterData:
	var f := EH.base(n, "Void Iris", lvl)
	f.health = EH.es(345, 393, 4, 7, lvl, 14); f.max_health = f.health
	f.mana = EH.es(17, 20, 1, 2, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(20, 28, 1, 2, lvl, 14)
	f.physical_defense = EH.es(21, 30, 1, 3, lvl, 14)
	f.magic_attack = EH.es(102, 119, 3, 4, lvl, 14)
	f.magic_defense = EH.es(45, 54, 2, 4, lvl, 14)
	f.speed = EH.es(44, 51, 2, 4, lvl, 14)
	f.crit_chance = 12; f.crit_damage = 3; f.dodge_chance = 18
	f.abilities = [EABL.void_gaze(), EABL.iris_flash()]
	f.flavor_text = "A fragment of the Eye itself, torn loose and given independent hunger. An iridescent iris ring surrounds a void pupil that swallows light and will alike."
	return f


static func create_thoughtform_knight(n: String, lvl: int = 14) -> FighterData:
	var f := EH.base(n, "Thoughtform Knight", lvl)
	f.health = EH.es(662, 755, 7, 10, lvl, 14); f.max_health = f.health
	f.mana = EH.es(14, 17, 1, 2, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(130, 150, 3, 5, lvl, 14)
	f.physical_defense = EH.es(64, 75, 3, 5, lvl, 14)
	f.magic_attack = EH.es(16, 23, 1, 2, lvl, 14)
	f.magic_defense = EH.es(52, 61, 2, 4, lvl, 14)
	f.speed = EH.es(38, 46, 2, 4, lvl, 14)
	f.crit_chance = 29; f.crit_damage = 3; f.dodge_chance = 25
	f.abilities = [EABL.memory_blade(), EABL.ironclad_will()]
	f.flavor_text = "A warrior conjured from stolen memories of great knights. It fights with borrowed valor and an unshakable conviction that it is real."
	return f


# =============================================================================
# The Eye (level 15 bosses)
# =============================================================================

static func create_the_iris(n: String, lvl: int = 15) -> FighterData:
	var f := EH.base(n, "The Iris", lvl)
	f.health = EH.es(738, 842, 8, 11, lvl, 15); f.max_health = f.health
	f.mana = EH.es(26, 31, 2, 3, lvl, 15); f.max_mana = f.mana
	f.physical_attack = EH.es(27, 36, 1, 3, lvl, 15)
	f.physical_defense = EH.es(61, 72, 3, 5, lvl, 15)
	f.magic_attack = EH.es(140, 160, 4, 7, lvl, 15)
	f.magic_defense = EH.es(77, 87, 3, 5, lvl, 15)
	f.speed = EH.es(33, 39, 1, 3, lvl, 15)
	f.crit_chance = 10; f.crit_damage = 3; f.dodge_chance = 13
	f.abilities = [EABL.prismatic_blast(), EABL.refraction_beam(), EABL.crystalline_ward()]
	f.flavor_text = "The Eye's outer defense, a blazing lens of concentrated perception. Light bends and shatters around it in prismatic fury."
	return f


static func create_the_lidless_eye(n: String, lvl: int = 15) -> FighterData:
	var f := EH.base(n, "The Lidless Eye", lvl)
	f.health = EH.es(1008, 1146, 9, 13, lvl, 15); f.max_health = f.health
	f.mana = EH.es(31, 36, 2, 3, lvl, 15); f.max_mana = f.mana
	f.physical_attack = EH.es(22, 30, 1, 3, lvl, 15)
	f.physical_defense = EH.es(64, 76, 3, 5, lvl, 15)
	f.magic_attack = EH.es(138, 158, 5, 8, lvl, 15)
	f.magic_defense = EH.es(82, 96, 4, 6, lvl, 15)
	f.speed = EH.es(37, 43, 2, 3, lvl, 15)
	f.crit_chance = 15; f.crit_damage = 3; f.dodge_chance = 15
	f.abilities = [EABL.gaze_of_forgetting(), EABL.memory_devour(), EABL.final_blink()]
	f.flavor_text = "The Eye of Oblivion itself, an ancient entity that has consumed countless minds across the ages. To meet its gaze is to forget you ever existed."
	return f
