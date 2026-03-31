class_name SimRepetitiveness

## Analyzes sequential battles within each story for archetype similarity.
## Flags consecutive fights that feel samey (similar role/subtype/damage/defense
## profiles) and damage/defense type monotony (3+ consecutive same-dominant battles).

const BSDB := preload("res://scripts/tools/battle_stage_db.gd")
const EnemyRoles := preload("res://scripts/data/enemy_roles.gd")

const SIMILARITY_THRESHOLD := 0.80
const MONOTONY_RUN_LENGTH := 3

## All Role + Subtype enum values used as vector dimensions.
const _ROLE_KEYS: Array[int] = [
	Enums.Role.DPS, Enums.Role.FIGHTER, Enums.Role.BURST,
	Enums.Role.TANK, Enums.Role.SUPPORT,
]
const _SUBTYPE_KEYS: Array[int] = [
	Enums.Subtype.GLASS_CANNON, Enums.Subtype.HEALER, Enums.Subtype.BUFFER,
	Enums.Subtype.DEBUFFER, Enums.Subtype.DOT, Enums.Subtype.DRAIN,
	Enums.Subtype.AOE, Enums.Subtype.EVASION, Enums.Subtype.CRIT,
]
const _TYPE_KEYS: Array[int] = [
	Enums.DamageType.PHYSICAL, Enums.DamageType.MAGICAL, Enums.DamageType.MIXED,
]


static func analyze(stages: Array) -> void:
	var by_story := _group_by_story(stages)
	var skeys := by_story.keys()
	skeys.sort()

	print("\n=== Battle Repetitiveness Analysis ===\n")

	for story: int in skeys:
		var story_stages: Array = by_story[story]
		print("--- Story %d (%d stages) ---\n" % [story, story_stages.size()])

		var profiles := _build_profiles(story_stages)
		var playthroughs := _build_playthroughs(profiles)

		var seen_pairs: Dictionary = {}
		var seen_dmg: Dictionary = {}
		var seen_def: Dictionary = {}

		for pt_id: String in playthroughs:
			var pt_profiles: Array = playthroughs[pt_id]
			for pair: Dictionary in _find_similar_pairs(pt_profiles):
				var pkey: String = str(pair.a) + "|" + str(pair.b)
				if not seen_pairs.has(pkey):
					seen_pairs[pkey] = pair
			for m: Dictionary in _find_monotony(pt_profiles, true):
				var mkey: String = ",".join(PackedStringArray(m.battles))
				if not seen_dmg.has(mkey):
					seen_dmg[mkey] = m
			for m: Dictionary in _find_monotony(pt_profiles, false):
				var dkey: String = ",".join(PackedStringArray(m.battles))
				if not seen_def.has(dkey):
					seen_def[dkey] = m

		if seen_pairs.is_empty() and seen_dmg.is_empty() and seen_def.is_empty():
			print("  No repetitiveness issues found.\n")
			continue

		for pair: Dictionary in seen_pairs.values():
			print("  HIGH SIMILARITY (%.0f%%): %s (P%d) -> %s (P%d)" % [
				pair.similarity * 100, pair.a, pair.prog_a, pair.b, pair.prog_b])
			_print_pair_profiles(pair)

		for m: Dictionary in seen_dmg.values():
			print("  DAMAGE MONOTONY (%s, %d consecutive): %s" % [
				m.type_name, m.run_length,
				", ".join(PackedStringArray(m.battles))])

		for m: Dictionary in seen_def.values():
			print("  DEFENSE MONOTONY (%s, %d consecutive): %s" % [
				m.type_name, m.run_length,
				", ".join(PackedStringArray(m.battles))])

		print("")

	print("Thresholds: similarity >= %d%%, monotony run >= %d battles" % [
		int(SIMILARITY_THRESHOLD * 100), MONOTONY_RUN_LENGTH])


# -- Profile building ---------------------------------------------------------

static func _build_profiles(stages: Array) -> Array:
	var profiles := []
	for s: Dictionary in stages:
		# Use fixed seed per stage for deterministic defense classification
		seed(s.name.hash())
		var enemies: Array = BSDB.create_enemies(s.name)
		var ids: Array[String] = []
		var def_types: Dictionary = {}
		var hp_total := 0.0
		for e in enemies:
			ids.append(e.class_id)
			var dt := EnemyRoles.compute_defense_type(
				float(e.physical_defense), float(e.magic_defense))
			def_types[dt] = def_types.get(dt, 0) + 1
			hp_total += float(e.health)
		var profile := EnemyRoles.get_battle_profile(ids)
		profile["defense_types"] = def_types
		var hp_avg := hp_total / maxf(enemies.size(), 1.0)
		var hp_var := 0.0
		for e in enemies:
			var diff := float(e.health) - hp_avg
			hp_var += diff * diff
		profile["hp_avg"] = hp_avg
		profile["hp_spread"] = sqrt(hp_var / maxf(enemies.size(), 1.0))
		var boss_or_elite := false
		for eid: String in ids:
			var tier := EnemyRoles.get_tier(eid)
			if tier == Enums.EnemyTier.BOSS or tier == Enums.EnemyTier.ELITE:
				boss_or_elite = true
				break
		profiles.append({
			"stage": s,
			"profile": profile,
			"enemy_count": enemies.size(),
			"has_boss_or_elite": boss_or_elite,
		})
	return profiles


# -- Similarity detection ------------------------------------------------------

static func _find_similar_pairs(profiles: Array) -> Array:
	var pairs := []
	for i in range(profiles.size() - 1):
		# Only compare battles at the same progression stage (parallel branches).
		# Consecutive progression stages always get compared.
		var p_a: int = profiles[i].stage.progression_stage
		var p_b: int = profiles[i + 1].stage.progression_stage
		if p_b - p_a > 1:
			continue  # Skip non-adjacent progressions
		if p_a == p_b:
			# Both boss/elite at same prog = alternate paths; player sees only one
			if profiles[i].has_boss_or_elite and profiles[i + 1].has_boss_or_elite:
				continue

		var sim := _cosine_similarity(profiles[i].profile, profiles[i + 1].profile)
		if sim >= SIMILARITY_THRESHOLD:
			pairs.append({
				"a": profiles[i].stage.name,
				"b": profiles[i + 1].stage.name,
				"prog_a": p_a,
				"prog_b": p_b,
				"similarity": sim,
				"profile_a": profiles[i].profile,
				"profile_b": profiles[i + 1].profile,
			})
	return pairs


static func _cosine_similarity(a: Dictionary, b: Dictionary) -> float:
	var vec_a := _to_vector(a)
	var vec_b := _to_vector(b)
	var dot := 0.0
	var mag_a := 0.0
	var mag_b := 0.0
	for idx in vec_a.size():
		dot += vec_a[idx] * vec_b[idx]
		mag_a += vec_a[idx] * vec_a[idx]
		mag_b += vec_b[idx] * vec_b[idx]
	if mag_a == 0.0 or mag_b == 0.0:
		return 0.0
	return dot / (sqrt(mag_a) * sqrt(mag_b))


## Flatten a battle profile into a numeric vector:
## [roles..., subtypes..., damage types..., defense types..., hp_avg, hp_spread].
static func _to_vector(profile: Dictionary) -> Array[float]:
	var vec: Array[float] = []
	var roles: Dictionary = profile.get("roles", {})
	for k: int in _ROLE_KEYS:
		vec.append(float(roles.get(k, 0)))
	var subs: Dictionary = profile.get("subtypes", {})
	for k: int in _SUBTYPE_KEYS:
		vec.append(float(subs.get(k, 0)))
	var dmg: Dictionary = profile.get("damage_types", {})
	for k: int in _TYPE_KEYS:
		vec.append(float(dmg.get(k, 0)))
	var defs: Dictionary = profile.get("defense_types", {})
	for k: int in _TYPE_KEYS:
		vec.append(float(defs.get(k, 0)))
	# Normalized HP stats (divided by 100 to match count magnitudes)
	vec.append(profile.get("hp_avg", 0.0) / 100.0)
	vec.append(profile.get("hp_spread", 0.0) / 100.0)
	return vec


# -- Monotony detection --------------------------------------------------------

## Finds runs of 3+ consecutive battles with the same dominant type.
## When is_damage is true, checks damage types; otherwise defense types.
## For defense: battles with multiple defense types (diversity) break any run
## and are excluded from runs -- only homogeneous battles contribute.
static func _find_monotony(profiles: Array, is_damage: bool) -> Array:
	var issues := []
	if profiles.size() < MONOTONY_RUN_LENGTH:
		return issues

	var run_start := -1
	var run_type: Enums.DamageType = Enums.DamageType.MIXED
	# Initialize from first battle (skip if diverse for defense)
	if not is_damage and _has_defense_diversity(profiles[0].profile):
		run_start = -1
	else:
		run_start = 0
		run_type = _dominant_type(profiles[0].profile, is_damage)

	for i in range(1, profiles.size()):
		# Same prog boss/elite = alternate path; skip without breaking run
		var prev_prog: int = profiles[i - 1].stage.progression_stage
		var curr_prog: int = profiles[i].stage.progression_stage
		if curr_prog == prev_prog:
			if profiles[i].has_boss_or_elite and profiles[i - 1].has_boss_or_elite:
				continue
		# For defense: diverse battles break and are excluded from monotony runs
		if not is_damage and _has_defense_diversity(profiles[i].profile):
			if run_start >= 0 and i - run_start >= MONOTONY_RUN_LENGTH:
				var names := []
				for j in range(run_start, i):
					names.append(profiles[j].stage.name)
				issues.append({
					"type_name": _damage_name(run_type),
					"run_length": i - run_start,
					"battles": names,
				})
			run_start = -1  # No active run
			continue
		var dt := _dominant_type(profiles[i].profile, is_damage)
		if run_start >= 0 and dt == run_type:
			continue
		# Type changed or no active run -- report previous run if long enough
		if run_start >= 0 and i - run_start >= MONOTONY_RUN_LENGTH:
			var names := []
			for j in range(run_start, i):
				names.append(profiles[j].stage.name)
			issues.append({
				"type_name": _damage_name(run_type),
				"run_length": i - run_start,
				"battles": names,
			})
		run_start = i
		run_type = dt

	# Check final run.
	if run_start >= 0 and profiles.size() - run_start >= MONOTONY_RUN_LENGTH:
		var names := []
		for j in range(run_start, profiles.size()):
			names.append(profiles[j].stage.name)
		issues.append({
			"type_name": _damage_name(run_type),
			"run_length": profiles.size() - run_start,
			"battles": names,
		})
	return issues


## Returns the dominant damage or defense type (highest count) in a battle profile.
static func _dominant_type(profile: Dictionary, is_damage: bool) -> Enums.DamageType:
	var key := "damage_types" if is_damage else "defense_types"
	var dt: Dictionary = profile.get(key, {})
	var best: Enums.DamageType = Enums.DamageType.PHYSICAL if is_damage else Enums.DamageType.MIXED
	var best_count := 0
	for k: Enums.DamageType in dt:
		if dt[k] > best_count:
			best = k
			best_count = dt[k]
	return best


## Returns true if a battle has defense diversity (multiple defense types present).
## A battle with [PHYS:1, MAG:1, MIXED:2] is diverse -- the player must adapt targeting.
static func _has_defense_diversity(profile: Dictionary) -> bool:
	var dt: Dictionary = profile.get("defense_types", {})
	return dt.size() > 1


static func _damage_name(dt: Enums.DamageType) -> String:
	match dt:
		Enums.DamageType.PHYSICAL: return "PHYSICAL"
		Enums.DamageType.MAGICAL: return "MAGICAL"
		Enums.DamageType.MIXED: return "MIXED"
	return "UNKNOWN"


# -- Display helpers -----------------------------------------------------------

static func _print_pair_profiles(pair: Dictionary) -> void:
	var a_roles := _format_counts(pair.profile_a.get("roles", {}), "role")
	var b_roles := _format_counts(pair.profile_b.get("roles", {}), "role")
	var a_subs := _format_counts(pair.profile_a.get("subtypes", {}), "subtype")
	var b_subs := _format_counts(pair.profile_b.get("subtypes", {}), "subtype")
	var a_dmg := _format_counts(pair.profile_a.get("damage_types", {}), "damage")
	var b_dmg := _format_counts(pair.profile_b.get("damage_types", {}), "damage")
	var a_def := _format_counts(pair.profile_a.get("defense_types", {}), "damage")
	var b_def := _format_counts(pair.profile_b.get("defense_types", {}), "damage")
	var a_hp := "avg=%.0f spread=%.0f" % [pair.profile_a.get("hp_avg", 0), pair.profile_a.get("hp_spread", 0)]
	var b_hp := "avg=%.0f spread=%.0f" % [pair.profile_b.get("hp_avg", 0), pair.profile_b.get("hp_spread", 0)]
	print("    %s: roles=[%s] subs=[%s] dmg=[%s] def=[%s] hp=[%s]" % [
		pair.a, a_roles, a_subs, a_dmg, a_def, a_hp])
	print("    %s: roles=[%s] subs=[%s] dmg=[%s] def=[%s] hp=[%s]" % [
		pair.b, b_roles, b_subs, b_dmg, b_def, b_hp])


static func _format_counts(counts: Dictionary, kind: String) -> String:
	var parts := PackedStringArray()
	for key in counts:
		var label: String
		match kind:
			"role": label = _role_name(key)
			"subtype": label = _subtype_name(key)
			"damage": label = _damage_name(key)
			_: label = str(key)
		parts.append("%s:%d" % [label, counts[key]])
	return ", ".join(parts)


static func _role_name(r: Enums.Role) -> String:
	match r:
		Enums.Role.DPS: return "DPS"
		Enums.Role.FIGHTER: return "FIGHTER"
		Enums.Role.BURST: return "BURST"
		Enums.Role.TANK: return "TANK"
		Enums.Role.SUPPORT: return "SUPPORT"
	return "?"


static func _subtype_name(s: Enums.Subtype) -> String:
	match s:
		Enums.Subtype.GLASS_CANNON: return "GLASS_CANNON"
		Enums.Subtype.HEALER: return "HEALER"
		Enums.Subtype.BUFFER: return "BUFFER"
		Enums.Subtype.DEBUFFER: return "DEBUFFER"
		Enums.Subtype.DOT: return "DOT"
		Enums.Subtype.DRAIN: return "DRAIN"
		Enums.Subtype.AOE: return "AOE"
		Enums.Subtype.EVASION: return "EVASION"
		Enums.Subtype.CRIT: return "CRIT"
	return "?"


# -- Path-aware playthrough builder -------------------------------------------

## Build per-playthrough profile sequences from path-tagged stages.
## Path tags: "" = shared by all, "a"/"b"/"c" = exclusive, "ac" = shared by a+c.
## Each playthrough includes all shared ("") stages plus stages whose path
## contains that playthrough's letter.
static func _build_playthroughs(profiles: Array) -> Dictionary:
	var pt_ids: Dictionary = {}
	for p: Dictionary in profiles:
		var path: String = p.stage.get("path", "")
		if path.is_empty():
			continue
		for ch_idx: int in range(path.length()):
			var ch: String = path.substr(ch_idx, 1)
			pt_ids[ch] = true
	if pt_ids.is_empty():
		return {"a": profiles}
	var result: Dictionary = {}
	for pt_id: String in pt_ids:
		var filtered: Array = []
		for p: Dictionary in profiles:
			var path: String = p.stage.get("path", "")
			if path.is_empty() or path.contains(pt_id):
				filtered.append(p)
		result[pt_id] = filtered
	return result


# -- Utilities -----------------------------------------------------------------

static func _group_by_story(stages: Array) -> Dictionary:
	var result := {}
	for s: Dictionary in stages:
		var story: int = s.get("story", 1)
		if not result.has(story):
			result[story] = []
		result[story].append(s)
	for key: int in result:
		result[key].sort_custom(func(a: Dictionary, b: Dictionary) -> bool:
			if a.progression_stage != b.progression_stage:
				return a.progression_stage < b.progression_stage
			return a.name < b.name)
	return result
