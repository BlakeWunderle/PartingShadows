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
	f.health = EH.es(576, 636, 8, 12, lvl, 14); f.max_health = f.health
	f.mana = EH.es(14, 18, 1, 2, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(82, 91, 4, 6, lvl, 14)
	f.physical_defense = EH.es(50, 59, 3, 5, lvl, 14)
	f.magic_attack = EH.es(14, 19, 0, 2, lvl, 14)
	f.magic_defense = EH.es(41, 48, 2, 4, lvl, 14)
	f.speed = EH.es(34, 41, 1, 3, lvl, 14)
	f.crit_chance = 20; f.crit_damage = 4; f.dodge_chance = 10
	f.abilities = [EAB.sigil_crush(), EAB.anchor_pulse(), EAB.sigil_ward()]
	f.flavor_text = "A massive construct of carved stone and living sigils. It guards the ritual pillars with relentless force."
	return f


static func create_ritual_conduit(n: String, lvl: int = 14) -> FighterData:
	var f := EH.base(n, "Ritual Conduit", lvl)
	f.health = EH.es(408, 462, 7, 10, lvl, 14); f.max_health = f.health
	f.mana = EH.es(24, 29, 2, 3, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(14, 19, 0, 2, lvl, 14)
	f.physical_defense = EH.es(31, 38, 2, 3, lvl, 14)
	f.magic_attack = EH.es(70, 79, 4, 6, lvl, 14)
	f.magic_defense = EH.es(48, 56, 3, 5, lvl, 14)
	f.speed = EH.es(41, 48, 2, 4, lvl, 14)
	f.crit_chance = 18; f.crit_damage = 3; f.dodge_chance = 18
	f.abilities = [EAB.conduit_beam(), EAB.mending_sigil(), EAB.ritual_shield()]
	f.flavor_text = "A crystalline pillar that channels ritual energy. It mends damage to the anchors and shields its allies."
	return f


static func create_void_sentinel(n: String, lvl: int = 14) -> FighterData:
	var f := EH.base(n, "Void Sentinel", lvl)
	f.health = EH.es(492, 550, 8, 11, lvl, 14); f.max_health = f.health
	f.mana = EH.es(18, 22, 2, 3, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(58, 66, 3, 5, lvl, 14)
	f.physical_defense = EH.es(38, 46, 2, 4, lvl, 14)
	f.magic_attack = EH.es(60, 68, 3, 5, lvl, 14)
	f.magic_defense = EH.es(40, 47, 2, 4, lvl, 14)
	f.speed = EH.es(43, 50, 2, 4, lvl, 14)
	f.crit_chance = 24; f.crit_damage = 4; f.dodge_chance = 19
	f.abilities = [EAB.void_slash(), EAB.nullfield()]
	f.flavor_text = "A silent guardian of void energy. Its blade cuts through both armor and magic with equal ease."
	return f


# =============================================================================
# Sanctum Collapse Battle (Prog 13) -- magic burst / fast phys / debuffer
# =============================================================================

static func create_void_horror(n: String, lvl: int = 15) -> FighterData:
	var f := EH.base(n, "Void Horror", lvl)
	f.health = EH.es(425, 475, 7, 10, lvl, 15); f.max_health = f.health
	f.mana = EH.es(26, 31, 2, 3, lvl, 15); f.max_mana = f.mana
	f.physical_attack = EH.es(14, 18, 0, 2, lvl, 15)
	f.physical_defense = EH.es(31, 38, 2, 3, lvl, 15)
	f.magic_attack = EH.es(80, 91, 5, 7, lvl, 15)
	f.magic_defense = EH.es(46, 54, 3, 5, lvl, 15)
	f.speed = EH.es(39, 45, 2, 4, lvl, 15)
	f.crit_chance = 22; f.crit_damage = 4; f.dodge_chance = 16
	f.abilities = [EAB.void_eruption(), EAB.terror_gaze()]
	f.flavor_text = "A howling mass of void energy given terrible form. Its eruptions leave nothing but silence."
	return f


static func create_fractured_shadow(n: String, lvl: int = 15) -> FighterData:
	var f := EH.base(n, "Fractured Shadow", lvl)
	f.health = EH.es(398, 448, 7, 10, lvl, 15); f.max_health = f.health
	f.mana = EH.es(14, 18, 1, 2, lvl, 15); f.max_mana = f.mana
	f.physical_attack = EH.es(77, 87, 4, 6, lvl, 15)
	f.physical_defense = EH.es(27, 33, 2, 3, lvl, 15)
	f.magic_attack = EH.es(14, 18, 0, 2, lvl, 15)
	f.magic_defense = EH.es(31, 38, 2, 3, lvl, 15)
	f.speed = EH.es(51, 59, 3, 5, lvl, 15)
	f.crit_chance = 28; f.crit_damage = 5; f.dodge_chance = 24
	f.abilities = [EAB.shadow_rend(), EAB.flickerstrike(), EAB.speed_siphon()]
	f.flavor_text = "A splintering fragment of the Stranger's essence. It moves faster than sight, striking from every angle."
	return f


static func create_shadow_remnant(n: String, lvl: int = 15) -> FighterData:
	var f := EH.base(n, "Shadow Remnant", lvl)
	f.health = EH.es(387, 436, 7, 10, lvl, 15); f.max_health = f.health
	f.mana = EH.es(22, 27, 2, 3, lvl, 15); f.max_mana = f.mana
	f.physical_attack = EH.es(14, 18, 0, 2, lvl, 15)
	f.physical_defense = EH.es(33, 40, 2, 3, lvl, 15)
	f.magic_attack = EH.es(69, 78, 4, 6, lvl, 15)
	f.magic_defense = EH.es(42, 50, 2, 4, lvl, 15)
	f.speed = EH.es(42, 49, 2, 4, lvl, 15)
	f.crit_chance = 20; f.crit_damage = 4; f.dodge_chance = 20
	f.abilities = [EAB.fading_curse(), EAB.remnant_bolt(), EAB.dissolution()]
	f.flavor_text = "The decaying afterimage of the Stranger's power. It weakens everything it touches, draining strength and resolve."
	return f


# =============================================================================
# Stranger Undone (Prog 13, solo boss -- weaker but faster/crittier)
# =============================================================================

static func create_stranger_undone(n: String, lvl: int = 15) -> FighterData:
	var f := EH.base(n, "Stranger Undone", lvl)
	f.class_id = "StrangerUndone"
	f.health = EH.es(1160, 1265, 14, 19, lvl, 15); f.max_health = f.health
	f.mana = EH.es(38, 44, 3, 4, lvl, 15); f.max_mana = f.mana
	f.physical_attack = EH.es(79, 90, 3, 5, lvl, 15)
	f.physical_defense = EH.es(50, 58, 2, 4, lvl, 15)
	f.magic_attack = EH.es(89, 101, 4, 6, lvl, 15)
	f.magic_defense = EH.es(52, 62, 2, 4, lvl, 15)
	f.speed = EH.es(67, 76, 3, 5, lvl, 15)
	f.crit_chance = 32; f.crit_damage = 6; f.dodge_chance = 24
	f.abilities = [EAB.desperate_strike(), EAB.unraveling(), EAB.last_refuge(), EAB.entropy_spike()]
	f.flavor_text = "The Stranger, stripped of ritual power, smaller and more human than ever before. Desperate, fast, and unpredictable."
	return f
