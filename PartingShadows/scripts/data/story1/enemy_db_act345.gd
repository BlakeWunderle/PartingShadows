class_name EnemyDBAct345

## Acts III-V enemy factory (Progression 8-13): city guards, stranger, corruption, final.

const FighterData := preload("res://scripts/data/fighter_data.gd")
const AbilityDB := preload("res://scripts/data/ability_db.gd")
const EAB := preload("res://scripts/data/story1/enemy_ability_db.gd")
const EABL := preload("res://scripts/data/story1/enemy_ability_db_late.gd")
const EH := preload("res://scripts/data/enemy_helpers.gd")


# =============================================================================
# Act III enemies (Progression 8-9)
# =============================================================================

static func create_royal_guard(n: String, lvl: int = 10) -> FighterData:
	var f := EH.base(n, "Royal Guard", lvl)
	f.health = EH.es(362, 407, 8, 12, lvl, 10); f.max_health = f.health
	f.mana = EH.es(10, 13, 1, 2, lvl, 10); f.max_mana = f.mana
	f.physical_attack = EH.es(46, 53, 3, 5, lvl, 10)
	f.physical_defense = EH.es(33, 38, 3, 4, lvl, 10)
	f.magic_attack = EH.es(5, 9, 0, 2, lvl, 10)
	f.magic_defense = EH.es(31, 38, 2, 3, lvl, 10)
	f.speed = EH.es(38, 43, 2, 3, lvl, 10)
	f.crit_chance = 25; f.crit_damage = 3; f.dodge_chance = 21
	f.abilities = [EABL.bulwark_slam(), EABL.sword_strike(), EABL.defensive_formation()]
	f.flavor_text = "Elite soldiers sworn to the crown. Their discipline and heavy armor make them formidable."
	return f

static func create_guard_sergeant(n: String, lvl: int = 10) -> FighterData:
	var f := EH.base(n, "Guard Sergeant", lvl)
	f.health = EH.es(370, 419, 8, 12, lvl, 10); f.max_health = f.health
	f.mana = EH.es(11, 14, 1, 2, lvl, 10); f.max_mana = f.mana
	f.physical_attack = EH.es(51, 60, 3, 5, lvl, 10)
	f.physical_defense = EH.es(23, 30, 2, 3, lvl, 10)
	f.magic_attack = EH.es(7, 11, 0, 2, lvl, 10)
	f.magic_defense = EH.es(26, 31, 1, 2, lvl, 10)
	f.speed = EH.es(39, 44, 2, 3, lvl, 10)
	f.crit_chance = 28; f.crit_damage = 4; f.dodge_chance = 18
	f.abilities = [EABL.sword_strike(), EABL.battle_command(), EABL.decisive_blow()]
	f.flavor_text = "A hardened officer who leads from the front, rallying guards with sharp commands."
	return f

static func create_guard_archer(n: String, lvl: int = 10) -> FighterData:
	var f := EH.base(n, "Guard Archer", lvl)
	f.health = EH.es(299, 347, 7, 11, lvl, 10); f.max_health = f.health
	f.mana = EH.es(11, 14, 1, 2, lvl, 10); f.max_mana = f.mana
	f.physical_attack = EH.es(47, 53, 3, 5, lvl, 10)
	f.physical_defense = EH.es(17, 23, 1, 3, lvl, 10)
	f.magic_attack = EH.es(5, 9, 0, 2, lvl, 10)
	f.magic_defense = EH.es(24, 31, 1, 3, lvl, 10)
	f.speed = EH.es(42, 47, 3, 4, lvl, 10)
	f.crit_chance = 32; f.crit_damage = 4; f.dodge_chance = 24
	f.abilities = [EABL.arrow_shot(), EABL.volley(), EABL.pin_down()]
	f.flavor_text = "Sharpshooters stationed on the city walls. They pin targets down with precise volleys."
	return f

static func create_stranger(n: String, lvl: int = 11) -> FighterData:
	var f := EH.base(n, "Stranger", lvl)
	f.health = EH.es(851, 946, 16, 22, lvl, 11); f.max_health = f.health
	f.mana = EH.es(30, 35, 2, 3, lvl, 11); f.max_mana = f.mana
	f.physical_attack = EH.es(69, 78, 4, 6, lvl, 11)
	f.physical_defense = EH.es(37, 43, 2, 4, lvl, 11)
	f.magic_attack = EH.es(73, 84, 4, 7, lvl, 11)
	f.magic_defense = EH.es(40, 47, 2, 4, lvl, 11)
	f.speed = EH.es(49, 54, 2, 4, lvl, 11)
	f.crit_chance = 23; f.crit_damage = 4; f.dodge_chance = 18
	f.abilities = [EABL.shadow_strike(), EABL.dark_pulse(), EABL.void_shield(), EABL.drain(), EABL.soul_siphon()]
	f.flavor_text = "A cloaked figure radiating dark power. His true nature remains hidden beneath layers of shadow."
	return f


# =============================================================================
# Act IV-V enemies (Progression 10-13)
# =============================================================================

static func create_lich(n: String, lvl: int = 12) -> FighterData:
	var f := EH.base(n, "Lich", lvl)
	f.health = EH.es(399, 449, 8, 12, lvl, 12); f.max_health = f.health
	f.mana = EH.es(26, 31, 2, 3, lvl, 12); f.max_mana = f.mana
	f.physical_attack = EH.es(14, 18, 0, 2, lvl, 12)
	f.physical_defense = EH.es(22, 27, 2, 3, lvl, 12)
	f.magic_attack = EH.es(64, 71, 4, 6, lvl, 12)
	f.magic_defense = EH.es(44, 52, 3, 5, lvl, 12)
	f.speed = EH.es(41, 47, 2, 4, lvl, 12)
	f.crit_chance = 25; f.crit_damage = 4; f.dodge_chance = 21
	f.abilities = [EABL.death_bolt(), EABL.raise_dead(), EABL.soul_cage()]
	f.flavor_text = "An undead sorcerer sustained by stolen souls. Death magic bends to its will."
	return f

static func create_ghast(n: String, lvl: int = 12) -> FighterData:
	var f := EH.base(n, "Ghast", lvl)
	f.health = EH.es(349, 395, 7, 10, lvl, 12); f.max_health = f.health
	f.mana = EH.es(13, 17, 1, 2, lvl, 12); f.max_mana = f.mana
	f.physical_attack = EH.es(60, 66, 3, 5, lvl, 12)
	f.physical_defense = EH.es(37, 43, 2, 4, lvl, 12)
	f.magic_attack = EH.es(18, 24, 1, 2, lvl, 12)
	f.magic_defense = EH.es(22, 27, 1, 3, lvl, 12)
	f.speed = EH.es(34, 41, 2, 3, lvl, 12)
	f.crit_chance = 20; f.crit_damage = 3; f.dodge_chance = 12
	f.abilities = [EABL.slam(), EABL.poison_cloud(), EAB.rend()]
	f.flavor_text = "A bloated horror that reeks of decay. Its poisonous miasma chokes the air around it."
	return f

static func create_demon(n: String, lvl: int = 12) -> FighterData:
	var f := EH.base(n, "Demon", lvl)
	f.health = EH.es(538, 598, 7, 10, lvl, 12); f.max_health = f.health
	f.mana = EH.es(29, 34, 2, 3, lvl, 12); f.max_mana = f.mana
	f.physical_attack = EH.es(24, 30, 1, 3, lvl, 12)
	f.physical_defense = EH.es(28, 34, 2, 4, lvl, 12)
	f.magic_attack = EH.es(69, 79, 5, 7, lvl, 12)
	f.magic_defense = EH.es(46, 52, 2, 4, lvl, 12)
	f.speed = EH.es(41, 47, 2, 4, lvl, 12)
	f.crit_chance = 30; f.crit_damage = 4; f.dodge_chance = 24
	f.abilities = [EABL.brimstone(), EABL.infernal_strike(), EABL.dread()]
	f.flavor_text = "A fiend born from brimstone and fury. Its mere presence fills the air with dread."
	return f

static func create_corrupted_treant(n: String, lvl: int = 12) -> FighterData:
	var f := EH.base(n, "Corrupted Treant", lvl)
	f.health = EH.es(440, 490, 8, 11, lvl, 12); f.max_health = f.health
	f.mana = EH.es(14, 18, 1, 2, lvl, 12); f.max_mana = f.mana
	f.physical_attack = EH.es(55, 62, 4, 6, lvl, 12)
	f.physical_defense = EH.es(49, 55, 3, 5, lvl, 12)
	f.magic_attack = EH.es(16, 22, 1, 2, lvl, 12)
	f.magic_defense = EH.es(30, 36, 2, 4, lvl, 12)
	f.speed = EH.es(33, 39, 1, 3, lvl, 12)
	f.crit_chance = 23; f.crit_damage = 4; f.dodge_chance = 16
	f.abilities = [EABL.vine_whip(), EABL.root_slam(), EABL.bark_shield()]
	f.flavor_text = "Once a guardian of the ancient wood, now twisted by corruption into a weapon of ruin."
	return f

static func create_hellion(n: String, lvl: int = 17) -> FighterData:
	var f := EH.base(n, "Hellion", lvl)
	f.health = EH.fixed(178, 203); f.max_health = f.health
	f.mana = EH.fixed(20, 24); f.max_mana = f.mana
	f.physical_attack = EH.fixed(40, 44); f.physical_defense = EH.fixed(21, 25)
	f.magic_attack = EH.fixed(34, 39); f.magic_defense = EH.fixed(19, 23)
	f.speed = EH.fixed(37, 43)
	f.crit_chance = 29; f.crit_damage = 4; f.dodge_chance = 18
	f.abilities = [EABL.frenzy_slash(), EABL.chaos_rend(), EABL.manic_howl()]
	f.flavor_text = "Frenzied lesser demons that slash wildly, driven by an insatiable thirst for chaos."
	return f

static func create_fiendling(n: String, lvl: int = 17) -> FighterData:
	var f := EH.base(n, "Fiendling", lvl)
	f.health = EH.fixed(161, 188); f.max_health = f.health
	f.mana = EH.fixed(24, 29); f.max_mana = f.mana
	f.physical_attack = EH.fixed(14, 18); f.physical_defense = EH.fixed(16, 21)
	f.magic_attack = EH.fixed(43, 50); f.magic_defense = EH.fixed(22, 26)
	f.speed = EH.fixed(39, 45)
	f.crit_chance = 27; f.crit_damage = 4; f.dodge_chance = 18
	f.abilities = [EABL.hellspark(), EABL.imp_curse(), EABL.fiend_mark()]
	f.flavor_text = "Impish creatures that hurl sparks and curses with gleeful malice."
	return f

static func create_dragon(n: String, lvl: int = 17) -> FighterData:
	var f := EH.base(n, "Dragon", lvl)
	f.health = EH.fixed(265, 290); f.max_health = f.health
	f.mana = EH.fixed(25, 30); f.max_mana = f.mana
	f.physical_attack = EH.fixed(26, 30); f.physical_defense = EH.fixed(25, 29)
	f.magic_attack = EH.fixed(40, 44); f.magic_defense = EH.fixed(22, 26)
	f.speed = EH.fixed(35, 41)
	f.crit_chance = 30; f.crit_damage = 4; f.dodge_chance = 16
	f.abilities = [EABL.cataclysm_breath(), EABL.rending_talons(), EABL.draconic_terror()]
	f.flavor_text = "An ancient wyrm of devastating power. Its breath reduces armies to ash."
	return f

static func create_blighted_stag(n: String, lvl: int = 17) -> FighterData:
	var f := EH.base(n, "Blighted Stag", lvl)
	f.health = EH.fixed(179, 204); f.max_health = f.health
	f.mana = EH.fixed(17, 20); f.max_mana = f.mana
	f.physical_attack = EH.fixed(36, 41); f.physical_defense = EH.fixed(18, 22)
	f.magic_attack = EH.fixed(18, 22); f.magic_defense = EH.fixed(16, 21)
	f.speed = EH.fixed(39, 45)
	f.crit_chance = 21; f.crit_damage = 4; f.dodge_chance = 17
	f.abilities = [EABL.antler_charge(), EABL.rot_aura(), EABL.blighted_breath()]
	f.flavor_text = "A noble beast warped by corruption. Rot spreads from its hooves with every step."
	return f

static func create_dark_knight(n: String, lvl: int = 14) -> FighterData:
	var f := EH.base(n, "Dark Knight", lvl)
	f.health = EH.es(503, 556, 7, 10, lvl, 14); f.max_health = f.health
	f.mana = EH.es(18, 23, 2, 3, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(75, 83, 4, 6, lvl, 14)
	f.physical_defense = EH.es(38, 47, 3, 5, lvl, 14)
	f.magic_attack = EH.es(38, 47, 2, 4, lvl, 14)
	f.magic_defense = EH.es(38, 46, 2, 4, lvl, 14)
	f.speed = EH.es(45, 52, 2, 4, lvl, 14)
	f.crit_chance = 31; f.crit_damage = 5; f.dodge_chance = 23
	f.abilities = [EABL.dark_blade(), EABL.shadow_guard(), EAB.cleave()]
	f.flavor_text = "A fallen champion clad in shadowed plate. Dark magic courses through every strike of his blade."
	return f

static func create_fell_hound(n: String, lvl: int = 14) -> FighterData:
	var f := EH.base(n, "Fell Hound", lvl)
	f.health = EH.es(421, 471, 6, 9, lvl, 14); f.max_health = f.health
	f.mana = EH.es(18, 23, 2, 3, lvl, 14); f.max_mana = f.mana
	f.physical_attack = EH.es(22, 27, 1, 3, lvl, 14)
	f.physical_defense = EH.es(26, 32, 2, 3, lvl, 14)
	f.magic_attack = EH.es(63, 71, 3, 5, lvl, 14)
	f.magic_defense = EH.es(36, 42, 2, 4, lvl, 14)
	f.speed = EH.es(50, 56, 3, 5, lvl, 14)
	f.crit_chance = 29; f.crit_damage = 4; f.dodge_chance = 23
	f.abilities = [EABL.shadow_bite(), EABL.howl_of_dread(), EABL.corruption_fang()]
	f.flavor_text = "Spectral hounds that hunt in packs across the corrupted wastes. Their howls freeze the blood."
	return f

static func create_sigil_wretch(n: String, lvl: int = 13) -> FighterData:
	var f := EH.base(n, "Sigil Wretch", lvl)
	f.health = EH.es(394, 438, 7, 10, lvl, 13); f.max_health = f.health
	f.mana = EH.es(24, 29, 2, 3, lvl, 13); f.max_mana = f.mana
	f.physical_attack = EH.es(13, 16, 0, 2, lvl, 13)
	f.physical_defense = EH.es(26, 33, 1, 3, lvl, 13)
	f.magic_attack = EH.es(71, 81, 5, 7, lvl, 13)
	f.magic_defense = EH.es(39, 45, 2, 4, lvl, 13)
	f.speed = EH.es(48, 55, 3, 5, lvl, 13)
	f.crit_chance = 37; f.crit_damage = 4; f.dodge_chance = 30
	f.abilities = [EABL.sigil_flare(), EABL.glyph_burn(), EABL.ward_break()]
	f.flavor_text = "Twisted creatures bound to arcane sigils. They detonate glyphs of searing light at will."
	return f

static func create_tunnel_lurker(n: String, lvl: int = 13) -> FighterData:
	var f := EH.base(n, "Tunnel Lurker", lvl)
	f.health = EH.es(493, 539, 10, 14, lvl, 13); f.max_health = f.health
	f.mana = EH.es(18, 21, 1, 2, lvl, 13); f.max_mana = f.mana
	f.physical_attack = EH.es(76, 85, 5, 7, lvl, 13)
	f.physical_defense = EH.es(36, 42, 2, 4, lvl, 13)
	f.magic_attack = EH.es(14, 20, 1, 2, lvl, 13)
	f.magic_defense = EH.es(38, 44, 2, 3, lvl, 13)
	f.speed = EH.es(45, 52, 3, 5, lvl, 13)
	f.crit_chance = 38; f.crit_damage = 4; f.dodge_chance = 27
	f.abilities = [EABL.venomous_bite(), EABL.web(), EABL.poison_cloud()]
	f.flavor_text = "Massive burrowing predators that ambush from below, ensnaring prey in venomous webs."
	return f

static func create_stranger_final(n: String, lvl: int = 15) -> FighterData:
	var f := EH.base(n, "Stranger", lvl)
	f.class_id = "StrangerFinal"
	f.health = EH.es(1300, 1430, 17, 23, lvl, 15); f.max_health = f.health
	f.mana = EH.es(45, 51, 3, 4, lvl, 15); f.max_mana = f.mana
	f.physical_attack = EH.es(83, 93, 3, 5, lvl, 15)
	f.physical_defense = EH.es(55, 62, 3, 5, lvl, 15)
	f.magic_attack = EH.es(91, 101, 4, 6, lvl, 15)
	f.magic_defense = EH.es(58, 65, 3, 5, lvl, 15)
	f.speed = EH.es(64, 71, 3, 5, lvl, 15)
	f.crit_chance = 31; f.crit_damage = 5; f.dodge_chance = 24
	f.abilities = [EABL.shadow_blast(), EABL.siphon(), EABL.dark_veil(), EABL.unmake(), EABL.entropy()]
	f.flavor_text = "The Stranger revealed in full, terrible power. Reality itself bends around him as he prepares to unmake everything."
	return f
