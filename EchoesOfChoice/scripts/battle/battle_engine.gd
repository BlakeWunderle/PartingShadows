class_name BattleEngine extends RefCounted

## Port of C# Battle.cs. Pure combat logic, no UI.
## Emits signals for the battle scene to visualize.

const FighterData := preload("res://scripts/data/fighter_data.gd")
const AbilityData := preload("res://scripts/data/ability_data.gd")
const Enums := preload("res://scripts/data/enums.gd")

signal combat_message(text: String)
signal combat_event(target: FighterData, amount: int, event_type: String)
signal fighter_died(fighter: FighterData)
signal battle_won
signal battle_lost

var units: Array = []      ## Player party (alive)
var enemies: Array = []    ## Enemy team (alive)
var dead_units: Array = [] ## Dead party members (revived at end)

var sim_mode: bool = false  ## Skip signal emissions for headless simulation
var sim_stats: Dictionary = {}  ## Per-fighter combat stats (sim mode only)
var _acting_units: Array = []


func start_battle(party: Array, enemy_list: Array) -> void:
	units = party.duplicate()
	enemies = enemy_list.duplicate()
	dead_units.clear()
	for f: FighterData in units:
		f.reset_for_battle()
	for f: FighterData in enemies:
		f.reset_for_battle()


## Start battle without array duplication. Sim mode only: callers must
## pass freshly-created or cloned arrays that will not be reused.
func start_battle_sim(party: Array, enemy_list: Array) -> void:
	units = party
	enemies = enemy_list
	dead_units.clear()
	for f: FighterData in units:
		f.reset_for_battle()
	for f: FighterData in enemies:
		f.reset_for_battle()
	sim_stats.clear()
	for f: FighterData in units:
		sim_stats[f] = {dmg_dealt = 0, dmg_taken = 0, heals = 0, died = false}
	for f: FighterData in enemies:
		sim_stats[f] = {dmg_dealt = 0, dmg_taken = 0, heals = 0, died = false}


## Advance ATB timers by one tick. Returns true if any units can act.
func tick_atb() -> bool:
	for f: FighterData in units:
		f.turn_calculation += f.speed
	for f: FighterData in enemies:
		f.turn_calculation += f.speed
	return _has_acting_units()


## Fast-forward ATB to the exact point where the next actor(s) reach 100.
## Always produces at least one ready actor. Used by the simulation runner
## to skip the many no-op ticks where nobody is ready.
func tick_atb_fast() -> void:
	var min_ticks := 999999
	for f: FighterData in units:
		var remaining := 100 - f.turn_calculation
		if remaining <= 0:
			min_ticks = 0
			break
		var needed := ceili(float(remaining) / float(f.speed))
		if needed < min_ticks:
			min_ticks = needed
	if min_ticks > 0:
		for f: FighterData in enemies:
			var remaining := 100 - f.turn_calculation
			if remaining <= 0:
				min_ticks = 0
				break
			var needed := ceili(float(remaining) / float(f.speed))
			if needed < min_ticks:
				min_ticks = needed
	if min_ticks > 0:
		for f: FighterData in units:
			f.turn_calculation += f.speed * min_ticks
		for f: FighterData in enemies:
			f.turn_calculation += f.speed * min_ticks


## Get all units ready to act, sorted by highest ATB first.
func get_acting_units() -> Array:
	_acting_units.clear()
	for f: FighterData in units:
		if f.turn_calculation >= 100:
			_acting_units.append(f)
	for f: FighterData in enemies:
		if f.turn_calculation >= 100:
			_acting_units.append(f)
	_acting_units.sort_custom(func(a: FighterData, b: FighterData) -> bool:
		return a.turn_calculation > b.turn_calculation)
	return _acting_units


func _has_acting_units() -> bool:
	for f: FighterData in units:
		if f.turn_calculation >= 100:
			return true
	for f: FighterData in enemies:
		if f.turn_calculation >= 100:
			return true
	return false


func reset_turns() -> void:
	for f: FighterData in units:
		if f.turn_calculation >= 100:
			f.turn_calculation -= 100
	for f: FighterData in enemies:
		if f.turn_calculation >= 100:
			f.turn_calculation -= 100


# =============================================================================
# Combat actions
# =============================================================================

func physical_attack(attacker: FighterData, defender: FighterData) -> void:
	var phys_damage: int = maxi(attacker.physical_attack - defender.physical_defense, 0)
	var mag_damage: int = maxi((attacker.magic_attack - defender.magic_defense) / 2, 0)
	var damage: int = maxi(phys_damage, mag_damage)

	var is_crit: bool = _check_for_critical(attacker)
	if is_crit:
		damage += attacker.crit_damage

	if _check_for_dodge(defender):
		if not sim_mode:
			combat_message.emit("The attack from %s missed" % attacker.character_name)
			combat_event.emit(defender, 0, "miss")
		return

	defender.health -= damage
	if sim_mode:
		sim_stats[attacker].dmg_dealt += damage
		sim_stats[defender].dmg_taken += damage
	else:
		combat_message.emit("%s did %d points of damage to %s." % [
			attacker.character_name, damage, defender.character_name])
		combat_event.emit(defender, damage, "crit" if is_crit else "damage")


func use_ability_on_enemy(attacker: FighterData, defender: FighterData,
		ability: AbilityData, skip_flavor: bool = false) -> void:
	if _check_for_ability_dodge(defender):
		if not sim_mode:
			combat_message.emit("%s dodged %s's ability!" % [
				defender.character_name, attacker.character_name])
			combat_event.emit(defender, 0, "miss")
		return

	if ability.impacted_turns == 0:
		# Instant damage
		var damage: int = _calc_ability_damage(attacker, defender, ability)
		if damage < 0:
			damage = 0
		var is_crit: bool = _check_for_critical(attacker)
		if is_crit:
			damage += attacker.crit_damage

		defender.health -= damage
		if sim_mode:
			sim_stats[attacker].dmg_dealt += damage
			sim_stats[defender].dmg_taken += damage
		else:
			if not skip_flavor:
				combat_message.emit(ability.flavor_text)
			combat_message.emit("%s did %d points of damage to %s." % [
				attacker.character_name, damage, defender.character_name])
			combat_event.emit(defender, damage, "spell_crit" if is_crit else "spell_damage")

		if ability.life_steal_percent > 0.0 and damage > 0:
			var heal_amount: int = int(damage * ability.life_steal_percent)
			attacker.health = mini(attacker.health + heal_amount, attacker.max_health)
			if sim_mode:
				sim_stats[attacker].heals += heal_amount
			else:
				combat_message.emit("%s absorbed %d health." % [
					attacker.character_name, heal_amount])
				combat_event.emit(attacker, heal_amount, "heal")
	else:
		# Over-time effect
		if ability.damage_per_turn > 0:
			defender.modified_stats.append({
				"stat": ability.modified_stat,
				"modifier": 0,
				"turns": ability.impacted_turns,
				"is_negative": true,
				"damage_per_turn": ability.damage_per_turn,
			})
			if not sim_mode:
				if not skip_flavor:
					combat_message.emit(ability.flavor_text)
				combat_message.emit("%s will take %d damage per turn for %d turns." % [
					defender.character_name, ability.damage_per_turn, ability.impacted_turns])
				combat_event.emit(defender, ability.damage_per_turn, "debuff")

		if ability.modifier > 0 and (ability.damage_per_turn == 0 \
				or ability.modified_stat != Enums.StatType.HEALTH):
			defender.modified_stats.append({
				"stat": ability.modified_stat,
				"modifier": ability.modifier,
				"turns": ability.impacted_turns,
				"is_negative": true,
				"damage_per_turn": 0,
			})
			_modify_stats(defender, ability.modified_stat, ability.modifier, true)
			if not sim_mode and ability.damage_per_turn == 0:
				if not skip_flavor:
					combat_message.emit(ability.flavor_text)
				combat_message.emit("%s was hit with this ability." % defender.character_name)
				combat_event.emit(defender, ability.modifier, "debuff")


func use_ability_on_teammate(caster: FighterData, target: FighterData,
		ability: AbilityData, skip_flavor: bool = false) -> void:
	if ability.impacted_turns == 0:
		# Instant heal
		var heal_amount: int
		if ability.modified_stat == Enums.StatType.MIXED_ATTACK:
			heal_amount = ability.modifier + (caster.physical_attack + caster.magic_attack) / 4
		else:
			heal_amount = ability.modifier + caster.magic_attack / 2
		heal_amount = maxi(0, heal_amount)

		target.health += heal_amount
		if target.health > target.max_health:
			target.health = target.max_health

		if sim_mode:
			sim_stats[caster].heals += heal_amount
		else:
			if not skip_flavor:
				combat_message.emit(ability.flavor_text)
			combat_message.emit("%s healed %d points of damage." % [
				target.character_name, heal_amount])
			combat_event.emit(target, heal_amount, "heal")
	else:
		# Buff
		target.modified_stats.append({
			"stat": ability.modified_stat,
			"modifier": ability.modifier,
			"turns": ability.impacted_turns,
			"is_negative": false,
			"damage_per_turn": 0,
		})
		_modify_stats(target, ability.modified_stat, ability.modifier, false)
		if not sim_mode:
			if not skip_flavor:
				combat_message.emit(ability.flavor_text)
			combat_message.emit("%s was impacted by the ability." % target.character_name)
			combat_event.emit(target, ability.modifier, "buff")


func _calc_ability_damage(attacker: FighterData, defender: FighterData,
		ability: AbilityData) -> int:
	match ability.modified_stat:
		Enums.StatType.MAGIC_ATTACK:
			return ability.modifier + attacker.magic_attack - defender.magic_defense
		Enums.StatType.PHYSICAL_ATTACK:
			return ability.modifier + attacker.physical_attack - defender.physical_defense
		Enums.StatType.MIXED_ATTACK:
			return ability.modifier \
				+ (attacker.physical_attack + attacker.magic_attack) / 2 \
				- (defender.physical_defense + defender.magic_defense) / 2
		_:
			return ability.modifier


# =============================================================================
# Stat modification & reset
# =============================================================================

func _modify_stats(fighter: FighterData, stat: Enums.StatType,
		modifier: int, negative: bool) -> void:
	fighter._apply_stat_change(stat, modifier, negative)


func reset_modified_stat(fighter: FighterData) -> void:
	var to_remove: Array[int] = []

	for i: int in fighter.modified_stats.size():
		var mod: Dictionary = fighter.modified_stats[i]

		if mod.get("damage_per_turn", 0) > 0:
			fighter.health -= mod["damage_per_turn"]
			if sim_mode:
				sim_stats[fighter].dmg_taken += mod["damage_per_turn"]
			else:
				combat_message.emit("%s takes %d damage from a lingering effect." % [
					fighter.character_name, mod["damage_per_turn"]])
				combat_event.emit(fighter, mod["damage_per_turn"], "damage")

		if mod["turns"] == 0:
			if mod.get("damage_per_turn", 0) == 0:
				_modify_stats(fighter, mod["stat"], mod["modifier"], not mod["is_negative"])
			to_remove.append(i)
		else:
			mod["turns"] -= 1

	for offset: int in to_remove.size():
		fighter.modified_stats.remove_at(to_remove[offset] - offset)


# =============================================================================
# Death checking
# =============================================================================

func check_for_death() -> void:
	var unit_deaths: Array[int] = []
	var enemy_deaths: Array[int] = []

	for i: int in units.size():
		if units[i].health <= 0:
			if sim_mode:
				sim_stats[units[i]].died = true
			else:
				combat_message.emit("%s the %s has been knocked out." % [
					units[i].character_name, units[i].character_type])
				fighter_died.emit(units[i])
			unit_deaths.append(i)

	for i: int in enemies.size():
		if enemies[i].health <= 0:
			if not sim_mode:
				combat_message.emit("%s the %s has been knocked out." % [
					enemies[i].character_name, enemies[i].character_type])
				fighter_died.emit(enemies[i])
			enemy_deaths.append(i)

	for offset: int in unit_deaths.size():
		var idx: int = unit_deaths[offset] - offset
		dead_units.append(units[idx])
		units.remove_at(idx)

	for offset: int in enemy_deaths.size():
		var idx: int = enemy_deaths[offset] - offset
		enemies.remove_at(idx)


func is_battle_over() -> bool:
	return units.is_empty() or enemies.is_empty()


func did_player_win() -> bool:
	return enemies.is_empty()


func finish_battle() -> void:
	if did_player_win():
		units.append_array(dead_units)
		dead_units.clear()
		if not sim_mode:
			battle_won.emit()
	else:
		if not sim_mode:
			battle_lost.emit()


# =============================================================================
# Cooldown
# =============================================================================

func tick_cooldowns(fighter: FighterData) -> void:
	var expired: Array[String] = []
	for ability_name: String in fighter.ability_cooldowns:
		fighter.ability_cooldowns[ability_name] -= 1
		if fighter.ability_cooldowns[ability_name] <= 0:
			expired.append(ability_name)
	for ability_name: String in expired:
		fighter.ability_cooldowns.erase(ability_name)


func _set_cooldown(fighter: FighterData, ability: AbilityData) -> void:
	if ability.cooldown > 0:
		fighter.ability_cooldowns[ability.ability_name] = ability.cooldown


# =============================================================================
# Crit & dodge
# =============================================================================

func _check_for_critical(fighter: FighterData) -> bool:
	return randi_range(1, 100) <= fighter.crit_chance


func _check_for_dodge(fighter: FighterData) -> bool:
	return randi_range(1, 100) <= fighter.dodge_chance


func _check_for_ability_dodge(fighter: FighterData) -> bool:
	return randi_range(1, 100) <= fighter.dodge_chance / 2


# =============================================================================
# Taunt
# =============================================================================

func get_taunt_target(targets: Array) -> FighterData:
	for t: FighterData in targets:
		if t.health > 0 and _has_modifier(t, Enums.StatType.TAUNT, false):
			return t
	return null


func _has_modifier(fighter: FighterData, stat: Enums.StatType,
		is_negative: bool) -> bool:
	for mod: Dictionary in fighter.modified_stats:
		if mod["stat"] == stat and mod["is_negative"] == is_negative:
			return true
	return false


# =============================================================================
# AI: port of C# ExecuteAITurn
# =============================================================================

func execute_ai_turn(unit: FighterData, targets: Array,
		allies: Array) -> void:
	if targets.is_empty():
		return
	var affordable: Array[AbilityData] = []
	var heal_abilities: Array[AbilityData] = []
	var buff_abilities: Array[AbilityData] = []
	var offensive_abilities: Array[AbilityData] = []
	var taunt_ability: AbilityData = null
	var has_aoe_buff: bool = false

	for a: AbilityData in unit.abilities:
		if a.mana_cost > unit.mana:
			continue
		if unit.ability_cooldowns.get(a.ability_name, 0) > 0:
			continue
		affordable.append(a)

		if a.use_on_enemy:
			offensive_abilities.append(a)
		elif a.impacted_turns == 0:
			heal_abilities.append(a)
		elif a.modified_stat == Enums.StatType.TAUNT:
			taunt_ability = a
		else:
			buff_abilities.append(a)
			if a.target_all:
				has_aoe_buff = true

	var total_attack: float = unit.magic_attack + unit.physical_attack
	var magic_ratio: float = unit.magic_attack / total_attack if total_attack > 0 else 0.5

	# Priority 1: Heal a wounded ally
	if not heal_abilities.is_empty():
		var wounded: FighterData = null
		for ally: FighterData in allies:
			if ally.health > 0 and ally.health < ally.max_health * 0.5:
				if wounded == null or ally.health < wounded.health:
					wounded = ally
		if wounded != null:
			var heal: AbilityData = _weighted_pick(heal_abilities)
			unit.mana -= heal.mana_cost
			_set_cooldown(unit, heal)
			if heal.target_all:
				if not sim_mode:
					combat_message.emit(heal.flavor_text)
				for ally: FighterData in allies:
					if ally.health > 0:
						use_ability_on_teammate(unit, ally, heal, true)
			else:
				use_ability_on_teammate(unit, wounded, heal)
			return

	# Priority 1.5: Taunt if defensive unit
	if taunt_ability != null and not _has_modifier(unit, Enums.StatType.TAUNT, false):
		var def_total: float = unit.physical_defense + unit.magic_defense
		var off_total: float = unit.physical_attack + unit.magic_attack
		var tank_ratio: float = def_total / (def_total + off_total)
		var taunt_chance: float = tank_ratio * (targets.size() / 3.0)
		if randf() < taunt_chance:
			unit.mana -= taunt_ability.mana_cost
			_set_cooldown(unit, taunt_ability)
			use_ability_on_teammate(unit, unit, taunt_ability)
			return

	# Priority 2: Small chance to buff allies
	if not buff_abilities.is_empty():
		var buff_roll: int = randi_range(0, 4)
		var try_buff: bool = buff_roll == 0 or (buff_roll <= 1 and has_aoe_buff)
		if try_buff:
			var buff: AbilityData = _weighted_pick(buff_abilities)
			if buff.target_all:
				var any_unbuffed: bool = false
				for ally: FighterData in allies:
					if ally.health > 0 and not _has_modifier(ally, buff.modified_stat, false):
						any_unbuffed = true
						break
				if any_unbuffed:
					unit.mana -= buff.mana_cost
					_set_cooldown(unit, buff)
					if not sim_mode:
						combat_message.emit(buff.flavor_text)
					for ally: FighterData in allies:
						if ally.health > 0:
							use_ability_on_teammate(unit, ally, buff, true)
					return
			else:
				var buff_target: FighterData = null
				var best_total: int = -1
				for ally: FighterData in allies:
					if ally.health > 0:
						var t: int = ally.physical_attack + ally.magic_attack
						if t > best_total:
							best_total = t
							buff_target = ally
				if buff_target != null and not _has_modifier(buff_target, buff.modified_stat, false):
					unit.mana -= buff.mana_cost
					_set_cooldown(unit, buff)
					use_ability_on_teammate(unit, buff_target, buff)
					return

	# Priority 3: Offensive ability vs physical attack
	var ability_chance: float = magic_ratio
	if magic_ratio < 0.4 and not offensive_abilities.is_empty():
		for a: AbilityData in offensive_abilities:
			if a.modified_stat == Enums.StatType.PHYSICAL_ATTACK \
					or a.modified_stat == Enums.StatType.MIXED_ATTACK:
				ability_chance = 0.4
				break

	var use_ability: bool = not offensive_abilities.is_empty() and randf() < ability_chance

	if use_ability:
		var ability: AbilityData = _choose_offensive_ability(
			unit, offensive_abilities, magic_ratio)
		unit.mana -= ability.mana_cost
		_set_cooldown(unit, ability)
		if ability.target_all:
			if not sim_mode:
				combat_message.emit(ability.flavor_text)
			for target: FighterData in targets:
				use_ability_on_enemy(unit, target, ability, true)
		else:
			var target: FighterData = _choose_target(unit, targets, magic_ratio)
			use_ability_on_enemy(unit, target, ability)
	else:
		var target: FighterData = _choose_target(unit, targets, magic_ratio)
		physical_attack(unit, target)


func _choose_target(unit: FighterData, targets: Array,
		magic_ratio: float) -> FighterData:
	var taunter: FighterData = get_taunt_target(targets)
	if taunter != null:
		return taunter

	var pick_lowest: bool = magic_ratio > 0.6 \
		or (magic_ratio >= 0.4 and randf() < 0.6)
	return _find_min_health(targets) if pick_lowest else _find_max_health(targets)


func _find_min_health(targets: Array) -> FighterData:
	if targets.is_empty():
		return null
	var best: FighterData = targets[0]
	for i: int in range(1, targets.size()):
		if targets[i].health < best.health:
			best = targets[i]
	return best


func _find_max_health(targets: Array) -> FighterData:
	if targets.is_empty():
		return null
	var best: FighterData = targets[0]
	for i: int in range(1, targets.size()):
		if targets[i].health > best.health:
			best = targets[i]
	return best


func _weighted_pick(abilities: Array[AbilityData]) -> AbilityData:
	## Pick an ability weighted by cooldown (higher CD = stronger = preferred).
	var total: float = 0.0
	for a: AbilityData in abilities:
		total += 1.0 + a.cooldown
	var roll: float = randf() * total
	for a: AbilityData in abilities:
		roll -= 1.0 + a.cooldown
		if roll <= 0.0:
			return a
	return abilities[abilities.size() - 1]


func _choose_offensive_ability(unit: FighterData,
		offensive_abilities: Array[AbilityData], magic_ratio: float) -> AbilityData:
	var preferred: Enums.StatType = Enums.StatType.MAGIC_ATTACK \
		if magic_ratio > 0.5 else Enums.StatType.PHYSICAL_ATTACK
	var preferred_list: Array[AbilityData] = []

	for a: AbilityData in offensive_abilities:
		if a.modified_stat == preferred or a.modified_stat == Enums.StatType.MIXED_ATTACK:
			preferred_list.append(a)

	if not preferred_list.is_empty():
		return _weighted_pick(preferred_list)
	return _weighted_pick(offensive_abilities)
