class_name EnemyDBS2Act4

## Story 2 Act IV enemy factory: the Eye's domain.

const FighterData := preload("res://scripts/data/fighter_data.gd")
const EAB := preload("res://scripts/data/story2/enemy_ability_db_s2.gd")
const EH := preload("res://scripts/data/enemy_helpers.gd")


# =============================================================================
# The Eye's servants (level 14)
# =============================================================================

static func create_gaze_stalker(n: String, lvl: int = 14) -> FighterData:
	var f := EH.base(n, "Gaze Stalker", lvl)
	f.health = EH.es(410, 465, 5, 8, lvl, 14); f.max_health = f.health
	f.mana = EH.es(11, 14, 1, 2, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(74, 86, 3, 5, lvl, 14)
	f.physical_defense = EH.es(35, 43, 2, 3, lvl, 14)
	f.magic_attack = EH.es(72, 82, 3, 5, lvl, 14)
	f.magic_defense = EH.es(31, 39, 2, 3, lvl, 14)
	f.speed = EH.es(36, 42, 2, 3, lvl, 14)
	f.crit_chance = 17; f.crit_damage = 3; f.dodge_chance = 21
	f.abilities = [EAB.piercing_gaze_strike(), EAB.focus_break()]
	f.flavor_text = "A swift predator that serves as the Eye's hunting hound. It locks onto its prey with an unblinking stare that shatters concentration."
	return f


static func create_memory_harvester(n: String, lvl: int = 14) -> FighterData:
	var f := EH.base(n, "Memory Harvester", lvl)
	f.health = EH.es(448, 506, 5, 8, lvl, 14); f.max_health = f.health
	f.mana = EH.es(19, 23, 1, 2, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(20, 28, 1, 2, lvl, 14)
	f.physical_defense = EH.es(29, 37, 2, 3, lvl, 14)
	f.magic_attack = EH.es(107, 123, 3, 5, lvl, 14)
	f.magic_defense = EH.es(45, 53, 2, 4, lvl, 14)
	f.speed = EH.es(31, 37, 2, 3, lvl, 14)
	f.crit_chance = 12; f.crit_damage = 3; f.dodge_chance = 16
	f.abilities = [EAB.harvest_thought(), EAB.mass_extraction()]
	f.flavor_text = "A grotesque collector that reaps thoughts like grain. The memories it steals are fed directly to the Eye, fueling its terrible awareness."
	return f


static func create_oblivion_shade(n: String, lvl: int = 14) -> FighterData:
	var f := EH.base(n, "Oblivion Shade", lvl)
	f.health = EH.es(312, 354, 4, 7, lvl, 14); f.max_health = f.health
	f.mana = EH.es(17, 20, 1, 2, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(20, 28, 1, 2, lvl, 14)
	f.physical_defense = EH.es(20, 28, 1, 3, lvl, 14)
	f.magic_attack = EH.es(82, 96, 3, 4, lvl, 14)
	f.magic_defense = EH.es(42, 51, 2, 4, lvl, 14)
	f.speed = EH.es(39, 45, 2, 4, lvl, 14)
	f.crit_chance = 12; f.crit_damage = 3; f.dodge_chance = 20
	f.abilities = [EAB.wave_of_oblivion(), EAB.nihil_bolt()]
	f.flavor_text = "A wraith woven from pure forgetting. Where it passes, all sense of self dissolves, leaving only a hollow ache where identity once lived."
	return f


static func create_thoughtform_knight(n: String, lvl: int = 14) -> FighterData:
	var f := EH.base(n, "Thoughtform Knight", lvl)
	f.health = EH.es(630, 720, 7, 10, lvl, 14); f.max_health = f.health
	f.mana = EH.es(14, 17, 1, 2, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(122, 141, 3, 5, lvl, 14)
	f.physical_defense = EH.es(58, 68, 3, 5, lvl, 14)
	f.magic_attack = EH.es(16, 23, 1, 2, lvl, 14)
	f.magic_defense = EH.es(47, 55, 2, 4, lvl, 14)
	f.speed = EH.es(24, 30, 1, 3, lvl, 14)
	f.crit_chance = 14; f.crit_damage = 3; f.dodge_chance = 20
	f.abilities = [EAB.memory_blade(), EAB.ironclad_will()]
	f.flavor_text = "A warrior conjured from stolen memories of great knights. It fights with borrowed valor and an unshakable conviction that it is real."
	return f


# =============================================================================
# The Eye (level 15 bosses)
# =============================================================================

static func create_the_iris(n: String, lvl: int = 15) -> FighterData:
	var f := EH.base(n, "The Iris", lvl)
	f.health = EH.es(798, 890, 8, 11, lvl, 15); f.max_health = f.health
	f.mana = EH.es(26, 31, 2, 3, lvl, 15); f.max_mana = f.mana
	f.physical_attack = EH.es(27, 36, 1, 3, lvl, 15)
	f.physical_defense = EH.es(58, 69, 3, 5, lvl, 15)
	f.magic_attack = EH.es(139, 160, 4, 7, lvl, 15)
	f.magic_defense = EH.es(73, 83, 3, 5, lvl, 15)
	f.speed = EH.es(33, 39, 2, 3, lvl, 15)
	f.crit_chance = 16; f.crit_damage = 3; f.dodge_chance = 20
	f.abilities = [EAB.prismatic_blast(), EAB.refraction_beam(), EAB.crystalline_ward()]
	f.flavor_text = "The Eye's outer defense, a blazing lens of concentrated perception. Light bends and shatters around it in prismatic fury."
	return f


static func create_the_lidless_eye(n: String, lvl: int = 15) -> FighterData:
	var f := EH.base(n, "The Lidless Eye", lvl)
	f.health = EH.es(1137, 1292, 9, 13, lvl, 15); f.max_health = f.health
	f.mana = EH.es(31, 36, 2, 3, lvl, 15); f.max_mana = f.mana
	f.physical_attack = EH.es(22, 30, 1, 3, lvl, 15)
	f.physical_defense = EH.es(62, 74, 3, 5, lvl, 15)
	f.magic_attack = EH.es(138, 157, 5, 8, lvl, 15)
	f.magic_defense = EH.es(80, 93, 4, 6, lvl, 15)
	f.speed = EH.es(35, 41, 2, 4, lvl, 15)
	f.crit_chance = 17; f.crit_damage = 3; f.dodge_chance = 19
	f.abilities = [EAB.gaze_of_forgetting(), EAB.memory_devour(), EAB.final_blink()]
	f.flavor_text = "The Eye of Oblivion itself, an ancient entity that has consumed countless minds across the ages. To meet its gaze is to forget you ever existed."
	return f
