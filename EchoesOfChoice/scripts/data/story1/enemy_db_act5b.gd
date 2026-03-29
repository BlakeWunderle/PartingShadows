class_name EnemyDBAct5B

## Story 1 Act V Path B enemy factory: ritual anchors, sanctum collapse, stranger undone.

const FighterData := preload("res://scripts/data/fighter_data.gd")
const EAB := preload("res://scripts/data/story1/enemy_ability_db_act5b.gd")
const EH := preload("res://scripts/data/enemy_helpers.gd")


# =============================================================================
# Ritual Anchor Battle (Prog 12) -- phys tank / magic healer / mixed DPS
# =============================================================================

static func create_sigil_colossus(n: String, lvl: int = 14) -> FighterData:
	var f := EH.base(n, "Sigil Colossus", lvl)
	f.health = EH.es(628, 692, 7, 10, lvl, 14); f.max_health = f.health
	f.mana = EH.es(14, 18, 1, 2, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(83, 91, 4, 6, lvl, 14)
	f.physical_defense = EH.es(50, 59, 3, 5, lvl, 14)
	f.magic_attack = EH.es(14, 19, 0, 2, lvl, 14)
	f.magic_defense = EH.es(41, 48, 2, 4, lvl, 14)
	f.speed = EH.es(37, 44, 1, 3, lvl, 14)
	f.crit_chance = 28; f.crit_damage = 5; f.dodge_chance = 10
	f.abilities = [EAB.sigil_crush(), EAB.anchor_pulse(), EAB.sigil_ward()]
	f.flavor_text = "A massive construct of carved stone and living sigils. It guards the ritual pillars with relentless force."
	return f


static func create_ritual_conduit(n: String, lvl: int = 14) -> FighterData:
	var f := EH.base(n, "Ritual Conduit", lvl)
	f.health = EH.es(441, 499, 7, 10, lvl, 14); f.max_health = f.health
	f.mana = EH.es(24, 29, 2, 3, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(14, 19, 0, 2, lvl, 14)
	f.physical_defense = EH.es(31, 38, 2, 3, lvl, 14)
	f.magic_attack = EH.es(74, 82, 4, 6, lvl, 14)
	f.magic_defense = EH.es(48, 56, 3, 5, lvl, 14)
	f.speed = EH.es(44, 51, 2, 4, lvl, 14)
	f.crit_chance = 19; f.crit_damage = 3; f.dodge_chance = 22
	f.abilities = [EAB.conduit_beam(), EAB.mending_sigil(), EAB.ritual_shield()]
	f.flavor_text = "A crystalline pillar that channels ritual energy. It mends damage to the anchors and shields its allies."
	return f


static func create_void_sentinel(n: String, lvl: int = 14) -> FighterData:
	var f := EH.base(n, "Void Sentinel", lvl)
	f.health = EH.es(531, 594, 8, 11, lvl, 14); f.max_health = f.health
	f.mana = EH.es(18, 22, 2, 3, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(58, 66, 3, 5, lvl, 14)
	f.physical_defense = EH.es(38, 46, 2, 4, lvl, 14)
	f.magic_attack = EH.es(60, 67, 3, 5, lvl, 14)
	f.magic_defense = EH.es(40, 47, 2, 4, lvl, 14)
	f.speed = EH.es(48, 55, 2, 4, lvl, 14)
	f.crit_chance = 29; f.crit_damage = 5; f.dodge_chance = 19
	f.abilities = [EAB.void_slash(), EAB.nullfield()]
	f.flavor_text = "A silent guardian of void energy. Its blade cuts through both armor and magic with equal ease."
	return f


# =============================================================================
# Sanctum Collapse Battle (Prog 13) -- magic burst / fast phys / debuffer
# =============================================================================

static func create_void_horror(n: String, lvl: int = 15) -> FighterData:
	var f := EH.base(n, "Void Horror", lvl)
	f.health = EH.es(438, 492, 6, 9, lvl, 15); f.max_health = f.health
	f.mana = EH.es(26, 31, 2, 3, lvl, 15); f.max_mana = f.mana
	f.physical_attack = EH.es(14, 18, 0, 2, lvl, 15)
	f.physical_defense = EH.es(34, 41, 2, 4, lvl, 15)
	f.magic_attack = EH.es(82, 93, 4, 6, lvl, 15)
	f.magic_defense = EH.es(48, 56, 3, 5, lvl, 15)
	f.speed = EH.es(40, 46, 2, 4, lvl, 15)
	f.crit_chance = 34; f.crit_damage = 4; f.dodge_chance = 26
	f.abilities = [EAB.void_eruption(), EAB.terror_gaze()]
	f.flavor_text = "A howling mass of void energy given terrible form. Its eruptions leave nothing but silence."
	return f


static func create_fractured_shadow(n: String, lvl: int = 15) -> FighterData:
	var f := EH.base(n, "Fractured Shadow", lvl)
	f.health = EH.es(410, 464, 6, 9, lvl, 15); f.max_health = f.health
	f.mana = EH.es(14, 18, 1, 2, lvl, 15); f.max_mana = f.mana
	f.physical_attack = EH.es(78, 88, 3, 5, lvl, 15)
	f.physical_defense = EH.es(28, 35, 2, 3, lvl, 15)
	f.magic_attack = EH.es(14, 18, 0, 2, lvl, 15)
	f.magic_defense = EH.es(31, 38, 2, 3, lvl, 15)
	f.speed = EH.es(50, 58, 3, 5, lvl, 15)
	f.crit_chance = 34; f.crit_damage = 5; f.dodge_chance = 31
	f.abilities = [EAB.shadow_rend(), EAB.flickerstrike(), EAB.speed_siphon()]
	f.flavor_text = "A splintering fragment of the Stranger's essence. It moves faster than sight, striking from every angle."
	return f


static func create_shadow_remnant(n: String, lvl: int = 15) -> FighterData:
	var f := EH.base(n, "Shadow Remnant", lvl)
	f.health = EH.es(400, 452, 5, 8, lvl, 15); f.max_health = f.health
	f.mana = EH.es(22, 27, 2, 3, lvl, 15); f.max_mana = f.mana
	f.physical_attack = EH.es(14, 18, 0, 2, lvl, 15)
	f.physical_defense = EH.es(36, 43, 2, 3, lvl, 15)
	f.magic_attack = EH.es(70, 79, 3, 5, lvl, 15)
	f.magic_defense = EH.es(44, 52, 2, 4, lvl, 15)
	f.speed = EH.es(43, 50, 2, 4, lvl, 15)
	f.crit_chance = 33; f.crit_damage = 4; f.dodge_chance = 24
	f.abilities = [EAB.fading_curse(), EAB.remnant_bolt(), EAB.dissolution()]
	f.flavor_text = "The decaying afterimage of the Stranger's power. It weakens everything it touches, draining strength and resolve."
	return f


# =============================================================================
# Stranger Undone (Prog 13, solo boss -- weaker but faster/crittier)
# =============================================================================

static func create_stranger_undone(n: String, lvl: int = 15) -> FighterData:
	var f := EH.base(n, "Stranger Undone", lvl)
	f.class_id = "StrangerUndone"
	f.health = EH.es(1090, 1194, 12, 18, lvl, 15); f.max_health = f.health
	f.mana = EH.es(42, 48, 3, 4, lvl, 15); f.max_mana = f.mana
	f.physical_attack = EH.es(77, 87, 2, 4, lvl, 15)
	f.physical_defense = EH.es(49, 57, 2, 4, lvl, 15)
	f.magic_attack = EH.es(94, 105, 3, 6, lvl, 15)
	f.magic_defense = EH.es(51, 60, 2, 4, lvl, 15)
	f.speed = EH.es(71, 80, 3, 5, lvl, 15)
	f.crit_chance = 33; f.crit_damage = 6; f.dodge_chance = 26
	f.abilities = [EAB.shadow_remnant_strike(), EAB.void_drain(), EAB.crumbling_shield(), EAB.final_echo(), EAB.desperation()]
	f.flavor_text = "The Stranger, stripped of ritual power, smaller and more human than ever before. Desperate, fast, and unpredictable."
	return f
