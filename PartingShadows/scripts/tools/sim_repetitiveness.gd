class_name SimRepetitiveness

## Analyzes sequential battles within each story for archetype similarity.
## Flags consecutive fights that feel samey (similar role/subtype profiles)
## and damage type monotony (3+ consecutive same-dominant-damage battles).

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


static func analyze(stages: Array) -> void:
	var by_story := _group_by_story(stages)
	var skeys := by_story.keys()
	skeys.sort()

	print("\n=== Battle Repetitiveness Analysis ===\n")

	for story: int in skeys:
		var story_stages: Array = by_story[story]
		print("--- Story %d (%d stages) ---\n" % [story, story_stages.size()])

		var profiles := _build_profiles(story_stages)
		var similar_pairs := _find_similar_pairs(profiles)
		var monotony := _find_damage_monotony(profiles)

		if similar_pairs.is_empty() and monotony.is_empty():
			print("  No repetitiveness issues found.\n")
			continue

		for pair: Dictionary in similar_pairs:
			print("  HIGH SIMILARITY (%.0f%%): %s (P%d) -> %s (P%d)" % [
				pair.similarity * 100, pair.a, pair.prog_a, pair.b, pair.prog_b])
			_print_pair_profiles(pair)

		for m: Dictionary in monotony:
			print("  DAMAGE MONOTONY (%s, %d consecutive): %s" % [
				m.damage_type, m.run_length,
				", ".join(PackedStringArray(m.battles))])

		print("")

	print("Thresholds: similarity >= %d%%, monotony run >= %d battles" % [
		int(SIMILARITY_THRESHOLD * 100), MONOTONY_RUN_LENGTH])


# -- Profile building ---------------------------------------------------------

static func _build_profiles(stages: Array) -> Array:
	var profiles := []
	for s: Dictionary in stages:
		var enemies: Array = BSDB.create_enemies(s.name)
		var ids: Array[String] = []
		for e in enemies:
			ids.append(e.class_id)
		var profile := EnemyRoles.get_battle_profile(ids)
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
			# Same prog boss/elite = alternate paths; player sees only one
			if profiles[i].has_boss_or_elite or profiles[i + 1].has_boss_or_elite:
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


## Flatten a battle profile into a numeric vector: [role counts..., subtype counts...].
static func _to_vector(profile: Dictionary) -> Array[float]:
	var vec: Array[float] = []
	var roles: Dictionary = profile.get("roles", {})
	for k: int in _ROLE_KEYS:
		vec.append(float(roles.get(k, 0)))
	var subs: Dictionary = profile.get("subtypes", {})
	for k: int in _SUBTYPE_KEYS:
		vec.append(float(subs.get(k, 0)))
	return vec


# -- Damage monotony -----------------------------------------------------------

static func _find_damage_monotony(profiles: Array) -> Array:
	var issues := []
	if profiles.size() < MONOTONY_RUN_LENGTH:
		return issues

	var run_start := 0
	var run_type := _dominant_damage(profiles[0].profile)

	for i in range(1, profiles.size()):
		# Same prog boss/elite = alternate path; skip without breaking run
		var prev_prog: int = profiles[i - 1].stage.progression_stage
		var curr_prog: int = profiles[i].stage.progression_stage
		if curr_prog == prev_prog:
			if profiles[i].has_boss_or_elite or profiles[i - 1].has_boss_or_elite:
				continue
		var dt := _dominant_damage(profiles[i].profile)
		if dt == run_type:
			continue
		if i - run_start >= MONOTONY_RUN_LENGTH:
			var names := []
			for j in range(run_start, i):
				names.append(profiles[j].stage.name)
			issues.append({
				"damage_type": _damage_name(run_type),
				"run_length": i - run_start,
				"battles": names,
			})
		run_start = i
		run_type = dt

	# Check final run.
	if profiles.size() - run_start >= MONOTONY_RUN_LENGTH:
		var names := []
		for j in range(run_start, profiles.size()):
			names.append(profiles[j].stage.name)
		issues.append({
			"damage_type": _damage_name(run_type),
			"run_length": profiles.size() - run_start,
			"battles": names,
		})
	return issues


## Returns the dominant damage type (highest count) in a battle profile.
static func _dominant_damage(profile: Dictionary) -> Enums.DamageType:
	var dt: Dictionary = profile.get("damage_types", {})
	var best: Enums.DamageType = Enums.DamageType.PHYSICAL
	var best_count := 0
	for key: Enums.DamageType in dt:
		if dt[key] > best_count:
			best = key
			best_count = dt[key]
	return best


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
	print("    %s: roles=[%s] subs=[%s] dmg=[%s]" % [pair.a, a_roles, a_subs, a_dmg])
	print("    %s: roles=[%s] subs=[%s] dmg=[%s]" % [pair.b, b_roles, b_subs, b_dmg])


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
