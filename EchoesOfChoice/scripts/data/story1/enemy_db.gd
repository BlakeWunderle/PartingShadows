class_name EnemyDB

## Act I enemy factory (Progression 0-2): city thugs, forest beasts, bandits.

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
# Act I enemies (Progression 0-1)
# =============================================================================

static func create_thug(n: String, lvl: int = 1) -> FighterData:
	var f := _base(n, "Thug", lvl)
	f.health = _es(50, 58, 3, 6, lvl, 1); f.max_health = f.health
	f.mana = _es(2, 5, 1, 2, lvl, 1); f.max_mana = f.mana
	f.physical_attack = _es(15, 18, 1, 3, lvl, 1)
	f.physical_defense = _es(8, 11, 1, 2, lvl, 1)
	f.magic_attack = _es(3, 6, 0, 2, lvl, 1)
	f.magic_defense = _es(9, 12, 1, 2, lvl, 1)
	f.speed = _es(18, 24, 1, 2, lvl, 1)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 3
	f.abilities = [AbilityDB.haymaker()]
	f.flavor_text = "Street toughs who prey on travelers after dark."
	return f

static func create_ruffian(n: String, lvl: int = 1) -> FighterData:
	var f := _base(n, "Ruffian", lvl)
	f.health = _es(47, 56, 3, 5, lvl, 1); f.max_health = f.health
	f.mana = _es(2, 5, 1, 2, lvl, 1); f.max_mana = f.mana
	f.physical_attack = _es(16, 20, 1, 3, lvl, 1)
	f.physical_defense = _es(7, 10, 1, 2, lvl, 1)
	f.magic_attack = _es(2, 5, 0, 1, lvl, 1)
	f.magic_defense = _es(7, 10, 1, 2, lvl, 1)
	f.speed = _es(16, 22, 1, 2, lvl, 1)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 2
	f.abilities = [EAB.headbutt(), AbilityDB.intimidate()]
	f.flavor_text = "Brawlers with more muscle than sense, spoiling for a fight."
	return f

static func create_pickpocket(n: String, lvl: int = 1) -> FighterData:
	var f := _base(n, "Pickpocket", lvl)
	f.health = _es(35, 43, 2, 4, lvl, 1); f.max_health = f.health
	f.mana = _es(3, 5, 1, 2, lvl, 1); f.max_mana = f.mana
	f.physical_attack = _es(13, 16, 1, 3, lvl, 1)
	f.physical_defense = _es(5, 7, 0, 2, lvl, 1)
	f.magic_attack = _es(2, 4, 0, 1, lvl, 1)
	f.magic_defense = _es(6, 9, 0, 2, lvl, 1)
	f.speed = _es(22, 28, 2, 3, lvl, 1)
	f.crit_chance = 9; f.crit_damage = 1; f.dodge_chance = 6
	f.abilities = [AbilityDB.quick_stab(), AbilityDB.pilfer()]
	f.flavor_text = "Nimble thieves who strike fast and vanish into the crowd."
	return f


# =============================================================================
# Act I enemies (Progression 2)
# =============================================================================

static func create_wolf(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Wolf", lvl)
	f.health = _es(55, 65, 3, 6, lvl, 2); f.max_health = f.health
	f.mana = _es(4, 6, 1, 2, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(20, 23, 2, 3, lvl, 2)
	f.physical_defense = _es(7, 10, 1, 2, lvl, 2)
	f.magic_attack = _es(2, 4, 0, 1, lvl, 2)
	f.magic_defense = _es(7, 11, 1, 2, lvl, 2)
	f.speed = _es(24, 30, 2, 3, lvl, 2)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 12
	f.abilities = [EAB.bite(), EAB.howl()]
	f.flavor_text = "Forest predators that hunt in packs, emboldened by moonlight."
	return f

static func create_boar(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Boar", lvl)
	f.health = _es(72, 80, 4, 7, lvl, 2); f.max_health = f.health
	f.mana = _es(4, 6, 1, 2, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(22, 25, 2, 3, lvl, 2)
	f.physical_defense = _es(10, 14, 1, 2, lvl, 2)
	f.magic_attack = _es(2, 4, 0, 1, lvl, 2)
	f.magic_defense = _es(9, 12, 1, 2, lvl, 2)
	f.speed = _es(18, 24, 1, 2, lvl, 2)
	f.crit_chance = 7; f.crit_damage = 2; f.dodge_chance = 3
	f.abilities = [EAB.gore(), EAB.charge()]
	f.flavor_text = "Thick-skinned beasts that charge without warning. Their tusks can shatter bone."
	return f

static func create_goblin(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Goblin", lvl)
	f.health = _es(37, 49, 3, 5, lvl, 2); f.max_health = f.health
	f.mana = _es(4, 6, 1, 2, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(15, 19, 2, 3, lvl, 2)
	f.physical_defense = _es(6, 9, 1, 2, lvl, 2)
	f.magic_attack = _es(3, 6, 0, 2, lvl, 2)
	f.magic_defense = _es(6, 9, 0, 2, lvl, 2)
	f.speed = _es(26, 32, 2, 4, lvl, 2)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 19
	f.abilities = [EAB.stab(), EAB.throw_rock(), EAB.scurry()]
	f.flavor_text = "Small, vicious, and surprisingly quick. What they lack in strength they make up for in cunning."
	return f

static func create_hound(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Hound", lvl)
	f.health = _es(45, 53, 3, 5, lvl, 2); f.max_health = f.health
	f.mana = _es(2, 5, 1, 1, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(17, 21, 2, 3, lvl, 2)
	f.physical_defense = _es(7, 10, 1, 2, lvl, 2)
	f.magic_attack = _es(2, 4, 0, 1, lvl, 2)
	f.magic_defense = _es(6, 9, 0, 2, lvl, 2)
	f.speed = _es(26, 32, 2, 3, lvl, 2)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 11
	f.abilities = [EAB.snap(), EAB.tackle()]
	f.flavor_text = "Wild dogs driven mad by hunger. They snap and lunge with desperate ferocity."
	return f

static func create_bandit(n: String, lvl: int = 3) -> FighterData:
	var f := _base(n, "Bandit", lvl)
	f.health = _es(72, 85, 4, 7, lvl, 3); f.max_health = f.health
	f.mana = _es(5, 7, 1, 2, lvl, 3); f.max_mana = f.mana
	f.physical_attack = _es(23, 28, 2, 3, lvl, 3)
	f.physical_defense = _es(11, 14, 1, 2, lvl, 3)
	f.magic_attack = _es(4, 7, 0, 2, lvl, 3)
	f.magic_defense = _es(9, 13, 1, 2, lvl, 3)
	f.speed = _es(22, 28, 1, 3, lvl, 3)
	f.crit_chance = 12; f.crit_damage = 2; f.dodge_chance = 8
	f.abilities = [EAB.bushwhack(), EAB.ambush()]
	f.flavor_text = "Outlaws who lurk along forest roads, striking from the cover of the trees."
	return f
