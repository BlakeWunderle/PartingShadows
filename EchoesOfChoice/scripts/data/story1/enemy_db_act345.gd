class_name EnemyDBAct345

## Acts III-V enemy factory (Progression 8-13): city guards, stranger, corruption, final.
## HP buffed +15-23% to compensate for CD 2 minimum / 3rd base ability changes.

const FighterData := preload("res://scripts/data/fighter_data.gd")
const AbilityDB := preload("res://scripts/data/ability_db.gd")
const EAB := preload("res://scripts/data/story1/enemy_ability_db.gd")


static func _es(base_min: int, base_max: int, gmin: int, gmax: int, level: int, base_level: int = 1) -> int:
	var lvl: int = level - base_level
	var lo: int = base_min + lvl * gmin
	var hi: int = base_max + lvl * (gmax - 1)
	if hi <= lo:
		return lo
	return randi_range(lo, hi - 1)

static func _fixed(base_min: int, base_max: int) -> int:
	return randi_range(base_min, base_max - 1)


static func _base(name: String, type: String, lvl: int) -> FighterData:
	var f := FighterData.new()
	f.character_name = name
	f.character_type = type
	f.class_id = type
	f.is_user_controlled = false
	f.level = lvl
	return f


# =============================================================================
# Act III enemies (Progression 8-9)
# =============================================================================

static func create_royal_guard(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "Royal Guard", lvl)
	f.health = _es(295, 335, 8, 12, lvl, 10); f.max_health = f.health
	f.mana = _es(16, 22, 2, 4, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(41, 48, 3, 5, lvl, 10)
	f.physical_defense = _es(30, 35, 3, 4, lvl, 10)
	f.magic_attack = _es(5, 9, 0, 2, lvl, 10)
	f.magic_defense = _es(29, 35, 2, 3, lvl, 10)
	f.speed = _es(30, 36, 2, 3, lvl, 10)
	f.crit_chance = 22; f.crit_damage = 3; f.dodge_chance = 21
	f.abilities = [EAB.bulwark_slam(), EAB.sword_strike(), EAB.defensive_formation()]
	f.flavor_text = "Elite soldiers sworn to the crown. Their discipline and heavy armor make them formidable."
	return f

static func create_guard_sergeant(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "Guard Sergeant", lvl)
	f.health = _es(305, 348, 8, 12, lvl, 10); f.max_health = f.health
	f.mana = _es(18, 24, 2, 4, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(44, 52, 3, 5, lvl, 10)
	f.physical_defense = _es(22, 28, 2, 3, lvl, 10)
	f.magic_attack = _es(7, 11, 0, 2, lvl, 10)
	f.magic_defense = _es(25, 29, 1, 2, lvl, 10)
	f.speed = _es(31, 37, 2, 3, lvl, 10)
	f.crit_chance = 26; f.crit_damage = 4; f.dodge_chance = 18
	f.abilities = [EAB.sword_strike(), EAB.battle_command(), EAB.decisive_blow()]
	f.flavor_text = "A hardened officer who leads from the front, rallying guards with sharp commands."
	return f

static func create_guard_archer(n: String, lvl: int = 10) -> FighterData:
	var f := _base(n, "Guard Archer", lvl)
	f.health = _es(257, 296, 6, 10, lvl, 10); f.max_health = f.health
	f.mana = _es(18, 24, 2, 4, lvl, 10); f.max_mana = f.mana
	f.physical_attack = _es(42, 49, 3, 5, lvl, 10)
	f.physical_defense = _es(16, 22, 1, 3, lvl, 10)
	f.magic_attack = _es(5, 9, 0, 2, lvl, 10)
	f.magic_defense = _es(23, 29, 1, 3, lvl, 10)
	f.speed = _es(34, 40, 3, 4, lvl, 10)
	f.crit_chance = 27; f.crit_damage = 4; f.dodge_chance = 22
	f.abilities = [EAB.arrow_shot(), EAB.volley(), EAB.pin_down()]
	f.flavor_text = "Sharpshooters stationed on the city walls. They pin targets down with precise volleys."
	return f

static func create_stranger(n: String, lvl: int = 11) -> FighterData:
	var f := _base(n, "Stranger", lvl)
	f.health = _es(757, 842, 16, 22, lvl, 11); f.max_health = f.health
	f.mana = _es(50, 58, 3, 5, lvl, 11); f.max_mana = f.mana
	f.physical_attack = _es(59, 68, 4, 6, lvl, 11)
	f.physical_defense = _es(34, 40, 2, 4, lvl, 11)
	f.magic_attack = _es(64, 74, 4, 7, lvl, 11)
	f.magic_defense = _es(37, 44, 2, 4, lvl, 11)
	f.speed = _es(41, 47, 2, 4, lvl, 11)
	f.crit_chance = 24; f.crit_damage = 4; f.dodge_chance = 21
	f.abilities = [EAB.shadow_strike(), EAB.dark_pulse(), EAB.void_shield(), EAB.drain()]
	f.flavor_text = "A cloaked figure radiating dark power. His true nature remains hidden beneath layers of shadow."
	return f


# =============================================================================
# Act IV-V enemies (Progression 10-13)
# =============================================================================

static func create_lich(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Lich", lvl)
	f.health = _es(342, 385, 8, 12, lvl, 12); f.max_health = f.health
	f.mana = _es(44, 52, 3, 5, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(14, 18, 0, 2, lvl, 12)
	f.physical_defense = _es(23, 29, 2, 3, lvl, 12)
	f.magic_attack = _es(55, 63, 4, 6, lvl, 12)
	f.magic_defense = _es(39, 47, 3, 5, lvl, 12)
	f.speed = _es(37, 43, 2, 4, lvl, 12)
	f.crit_chance = 24; f.crit_damage = 5; f.dodge_chance = 21
	f.abilities = [EAB.death_bolt(), EAB.raise_dead(), EAB.soul_cage()]
	f.flavor_text = "An undead sorcerer sustained by stolen souls. Death magic bends to its will."
	return f

static func create_ghast(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Ghast", lvl)
	f.health = _es(299, 339, 7, 10, lvl, 12); f.max_health = f.health
	f.mana = _es(22, 28, 2, 4, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(53, 60, 3, 5, lvl, 12)
	f.physical_defense = _es(32, 37, 2, 4, lvl, 12)
	f.magic_attack = _es(18, 24, 1, 2, lvl, 12)
	f.magic_defense = _es(24, 30, 1, 3, lvl, 12)
	f.speed = _es(31, 37, 2, 3, lvl, 12)
	f.crit_chance = 18; f.crit_damage = 4; f.dodge_chance = 12
	f.abilities = [EAB.slam(), EAB.poison_cloud(), EAB.rend()]
	f.flavor_text = "A bloated horror that reeks of decay. Its poisonous miasma chokes the air around it."
	return f

static func create_demon(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Demon", lvl)
	f.health = _es(462, 514, 8, 12, lvl, 12); f.max_health = f.health
	f.mana = _es(48, 56, 3, 5, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(24, 30, 1, 3, lvl, 12)
	f.physical_defense = _es(30, 36, 2, 4, lvl, 12)
	f.magic_attack = _es(62, 71, 4, 6, lvl, 12)
	f.magic_defense = _es(38, 44, 2, 4, lvl, 12)
	f.speed = _es(36, 42, 2, 4, lvl, 12)
	f.crit_chance = 22; f.crit_damage = 4; f.dodge_chance = 19
	f.abilities = [EAB.brimstone(), EAB.infernal_strike(), EAB.dread()]
	f.flavor_text = "A fiend born from brimstone and fury. Its mere presence fills the air with dread."
	return f

static func create_corrupted_treant(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Corrupted Treant", lvl)
	f.health = _es(378, 421, 8, 12, lvl, 12); f.max_health = f.health
	f.mana = _es(24, 30, 2, 4, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(49, 56, 3, 5, lvl, 12)
	f.physical_defense = _es(39, 45, 3, 5, lvl, 12)
	f.magic_attack = _es(16, 22, 1, 2, lvl, 12)
	f.magic_defense = _es(35, 40, 2, 4, lvl, 12)
	f.speed = _es(29, 35, 1, 3, lvl, 12)
	f.crit_chance = 18; f.crit_damage = 4; f.dodge_chance = 14
	f.abilities = [EAB.vine_whip(), EAB.root_slam(), EAB.bark_shield()]
	f.flavor_text = "Once a guardian of the ancient wood, now twisted by corruption into a weapon of ruin."
	return f

static func create_hellion(n: String, lvl: int = 17) -> FighterData:
	var f := _base(n, "Hellion", lvl)
	f.health = _fixed(178, 203); f.max_health = f.health
	f.mana = _fixed(34, 40); f.max_mana = f.mana
	f.physical_attack = _fixed(40, 44); f.physical_defense = _fixed(21, 25)
	f.magic_attack = _fixed(34, 39); f.magic_defense = _fixed(19, 23)
	f.speed = _fixed(37, 43)
	f.crit_chance = 29; f.crit_damage = 4; f.dodge_chance = 18
	f.abilities = [EAB.frenzy_slash(), EAB.chaos_rend(), EAB.manic_howl()]
	f.flavor_text = "Frenzied lesser demons that slash wildly, driven by an insatiable thirst for chaos."
	return f

static func create_fiendling(n: String, lvl: int = 17) -> FighterData:
	var f := _base(n, "Fiendling", lvl)
	f.health = _fixed(161, 188); f.max_health = f.health
	f.mana = _fixed(40, 48); f.max_mana = f.mana
	f.physical_attack = _fixed(14, 18); f.physical_defense = _fixed(16, 21)
	f.magic_attack = _fixed(43, 50); f.magic_defense = _fixed(22, 26)
	f.speed = _fixed(39, 45)
	f.crit_chance = 27; f.crit_damage = 4; f.dodge_chance = 18
	f.abilities = [EAB.hellspark(), EAB.imp_curse(), EAB.fiend_mark()]
	f.flavor_text = "Impish creatures that hurl sparks and curses with gleeful malice."
	return f

static func create_dragon(n: String, lvl: int = 17) -> FighterData:
	var f := _base(n, "Dragon", lvl)
	f.health = _fixed(265, 290); f.max_health = f.health
	f.mana = _fixed(42, 50); f.max_mana = f.mana
	f.physical_attack = _fixed(26, 30); f.physical_defense = _fixed(25, 29)
	f.magic_attack = _fixed(40, 44); f.magic_defense = _fixed(22, 26)
	f.speed = _fixed(35, 41)
	f.crit_chance = 30; f.crit_damage = 4; f.dodge_chance = 16
	f.abilities = [EAB.cataclysm_breath(), EAB.rending_talons(), EAB.draconic_terror()]
	f.flavor_text = "An ancient wyrm of devastating power. Its breath reduces armies to ash."
	return f

static func create_blighted_stag(n: String, lvl: int = 17) -> FighterData:
	var f := _base(n, "Blighted Stag", lvl)
	f.health = _fixed(179, 204); f.max_health = f.health
	f.mana = _fixed(28, 34); f.max_mana = f.mana
	f.physical_attack = _fixed(36, 41); f.physical_defense = _fixed(18, 22)
	f.magic_attack = _fixed(18, 22); f.magic_defense = _fixed(16, 21)
	f.speed = _fixed(39, 45)
	f.crit_chance = 21; f.crit_damage = 4; f.dodge_chance = 17
	f.abilities = [EAB.antler_charge(), EAB.rot_aura(), EAB.blighted_breath()]
	f.flavor_text = "A noble beast warped by corruption. Rot spreads from its hooves with every step."
	return f

static func create_dark_knight(n: String, lvl: int = 14) -> FighterData:
	var f := _base(n, "Dark Knight", lvl)
	f.health = _es(443, 491, 8, 12, lvl, 14); f.max_health = f.health
	f.mana = _es(30, 38, 3, 5, lvl, 14); f.max_mana = f.mana
	f.physical_attack = _es(66, 73, 4, 6, lvl, 14)
	f.physical_defense = _es(37, 45, 3, 5, lvl, 14)
	f.magic_attack = _es(35, 43, 2, 4, lvl, 14)
	f.magic_defense = _es(36, 43, 2, 4, lvl, 14)
	f.speed = _es(38, 44, 2, 4, lvl, 14)
	f.crit_chance = 27; f.crit_damage = 5; f.dodge_chance = 21
	f.abilities = [EAB.dark_blade(), EAB.shadow_guard(), EAB.cleave()]
	f.flavor_text = "A fallen champion clad in shadowed plate. Dark magic courses through every strike of his blade."
	return f

static func create_fell_hound(n: String, lvl: int = 14) -> FighterData:
	var f := _base(n, "Fell Hound", lvl)
	f.health = _es(371, 415, 7, 10, lvl, 14); f.max_health = f.health
	f.mana = _es(30, 38, 3, 5, lvl, 14); f.max_mana = f.mana
	f.physical_attack = _es(23, 28, 1, 3, lvl, 14)
	f.physical_defense = _es(26, 31, 2, 3, lvl, 14)
	f.magic_attack = _es(56, 63, 3, 5, lvl, 14)
	f.magic_defense = _es(34, 39, 2, 4, lvl, 14)
	f.speed = _es(43, 49, 3, 5, lvl, 14)
	f.crit_chance = 24; f.crit_damage = 4; f.dodge_chance = 23
	f.abilities = [EAB.shadow_bite(), EAB.howl_of_dread(), EAB.corruption_fang()]
	f.flavor_text = "Spectral hounds that hunt in packs across the corrupted wastes. Their howls freeze the blood."
	return f

static func create_sigil_wretch(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "Sigil Wretch", lvl)
	f.health = _es(340, 380, 7, 10, lvl, 13); f.max_health = f.health
	f.mana = _es(40, 48, 3, 5, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(13, 16, 0, 2, lvl, 13)
	f.physical_defense = _es(24, 30, 1, 3, lvl, 13)
	f.magic_attack = _es(60, 69, 5, 7, lvl, 13)
	f.magic_defense = _es(36, 42, 2, 4, lvl, 13)
	f.speed = _es(41, 47, 3, 5, lvl, 13)
	f.crit_chance = 25; f.crit_damage = 4; f.dodge_chance = 21
	f.abilities = [EAB.sigil_flare(), EAB.glyph_burn(), EAB.ward_break()]
	f.flavor_text = "Twisted creatures bound to arcane sigils. They detonate glyphs of searing light at will."
	return f

static func create_tunnel_lurker(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "Tunnel Lurker", lvl)
	f.health = _es(435, 475, 10, 14, lvl, 13); f.max_health = f.health
	f.mana = _es(26, 32, 2, 4, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(64, 72, 5, 7, lvl, 13)
	f.physical_defense = _es(33, 39, 2, 4, lvl, 13)
	f.magic_attack = _es(14, 20, 1, 2, lvl, 13)
	f.magic_defense = _es(35, 41, 2, 3, lvl, 13)
	f.speed = _es(38, 44, 3, 5, lvl, 13)
	f.crit_chance = 25; f.crit_damage = 4; f.dodge_chance = 19
	f.abilities = [EAB.venomous_bite(), EAB.web(), EAB.poison_cloud()]
	f.flavor_text = "Massive burrowing predators that ambush from below, ensnaring prey in venomous webs."
	return f

static func create_stranger_final(n: String, lvl: int = 15) -> FighterData:
	var f := _base(n, "Stranger", lvl)
	f.class_id = "StrangerFinal"
	f.health = _es(1085, 1190, 17, 23, lvl, 15); f.max_health = f.health
	f.mana = _es(70, 80, 5, 7, lvl, 15); f.max_mana = f.mana
	f.physical_attack = _es(74, 83, 4, 6, lvl, 15)
	f.physical_defense = _es(51, 57, 3, 5, lvl, 15)
	f.magic_attack = _es(85, 94, 5, 7, lvl, 15)
	f.magic_defense = _es(54, 60, 3, 5, lvl, 15)
	f.speed = _es(55, 62, 3, 5, lvl, 15)
	f.crit_chance = 27; f.crit_damage = 5; f.dodge_chance = 20
	f.abilities = [EAB.shadow_blast(), EAB.siphon(), EAB.dark_veil(), EAB.unmake(), EAB.entropy()]
	f.flavor_text = "The Stranger revealed in full, terrible power. Reality itself bends around him as he prepares to unmake everything."
	return f
