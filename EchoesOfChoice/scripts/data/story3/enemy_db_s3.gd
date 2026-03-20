class_name EnemyDBS3

## Story 3 Acts I-II enemy factory. Dream fauna and nightmare entities.

const FighterData := preload("res://scripts/data/fighter_data.gd")
const EAB := preload("res://scripts/data/story3/enemy_ability_db_s3.gd")


static func _es(base_min: int, base_max: int, gmin: int, gmax: int, level: int, base_level: int = 1) -> int:
	var lvl: int = level - base_level
	var lo: int = base_min + lvl * gmin
	var hi: int = base_max + lvl * (gmax - 1)
	if hi <= lo:
		return lo
	return randi_range(lo, hi - 1)


static func _base(name: String, type: String, lvl: int) -> FighterData:
	var f := FighterData.new()
	f.character_name = name
	f.character_type = type
	f.class_id = type
	f.is_user_controlled = false
	f.level = lvl
	return f


# =============================================================================
# Act I: Dream fauna (Progression 0-2)
# =============================================================================

# Prog 0 (+8%)
static func create_dream_wisp(n: String, lvl: int = 1) -> FighterData:
	var f := _base(n, "Dream Wisp", lvl)
	f.health = _es(35, 45, 2, 5, lvl, 1); f.max_health = f.health
	f.mana = _es(11, 16, 1, 3, lvl, 1); f.max_mana = f.mana
	f.physical_attack = _es(9, 13, 0, 2, lvl, 1)
	f.physical_defense = _es(6, 9, 0, 1, lvl, 1)
	f.magic_attack = _es(15, 18, 1, 3, lvl, 1)
	f.magic_defense = _es(10, 14, 1, 2, lvl, 1)
	f.speed = _es(27, 32, 1, 3, lvl, 1)
	f.crit_chance = 6; f.crit_damage = 1; f.dodge_chance = 8
	f.abilities = [EAB.shimmer_bolt(), EAB.daze()]
	f.flavor_text = "A flickering mote of dream-light that drifts through the sleeping mind. Its glow entrances the unwary before striking with bursts of raw thought."
	return f


static func create_phantasm(n: String, lvl: int = 1) -> FighterData:
	var f := _base(n, "Phantasm", lvl)
	f.health = _es(40, 51, 2, 5, lvl, 1); f.max_health = f.health
	f.mana = _es(9, 14, 1, 2, lvl, 1); f.max_mana = f.mana
	f.physical_attack = _es(14, 17, 1, 2, lvl, 1)
	f.physical_defense = _es(7, 10, 0, 1, lvl, 1)
	f.magic_attack = _es(13, 16, 1, 2, lvl, 1)
	f.magic_defense = _es(9, 13, 1, 2, lvl, 1)
	f.speed = _es(25, 31, 1, 3, lvl, 1)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 13
	f.abilities = [EAB.phase_strike(), EAB.unnerve()]
	f.flavor_text = "A translucent figure that flickers between presence and absence. It strikes from angles that should not exist, leaving a cold dread in its wake."
	return f


# Prog 1 MirrorHall enemies
static func create_shade_moth(n: String, lvl: int = 1) -> FighterData:
	var f := _base(n, "Shade Moth", lvl)
	f.health = _es(27, 35, 2, 3, lvl, 1); f.max_health = f.health
	f.mana = _es(7, 11, 1, 2, lvl, 1); f.max_mana = f.mana
	f.physical_attack = _es(11, 14, 1, 2, lvl, 1)
	f.physical_defense = _es(5, 9, 0, 1, lvl, 1)
	f.magic_attack = _es(9, 12, 0, 2, lvl, 1)
	f.magic_defense = _es(7, 10, 0, 1, lvl, 1)
	f.speed = _es(30, 36, 1, 3, lvl, 1)
	f.crit_chance = 10; f.crit_damage = 1; f.dodge_chance = 14
	f.abilities = [EAB.dust_wing(), EAB.flit()]
	f.flavor_text = "A dark-winged insect born from forgotten memories. Its scales scatter a soporific dust that clouds the senses."
	return f


static func create_sleep_stalker(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Sleep Stalker", lvl)
	f.health = _es(46, 54, 3, 6, lvl, 2); f.max_health = f.health
	f.mana = _es(7, 11, 1, 2, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(20, 24, 1, 3, lvl, 2)
	f.physical_defense = _es(9, 12, 1, 2, lvl, 2)
	f.magic_attack = _es(7, 10, 0, 1, lvl, 2)
	f.magic_defense = _es(8, 11, 0, 1, lvl, 2)
	f.speed = _es(27, 33, 1, 3, lvl, 2)
	f.crit_chance = 13; f.crit_damage = 2; f.dodge_chance = 10
	f.abilities = [EAB.dream_fang(), EAB.shadow_lunge()]
	f.flavor_text = "A gaunt predator that prowls the border between waking and sleep. It hunts by sensing the fear of dreamers who linger too long."
	return f


static func create_mirror_shade(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Mirror Shade", lvl)
	f.health = _es(42, 50, 2, 4, lvl, 2); f.max_health = f.health
	f.mana = _es(9, 13, 1, 2, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(14, 18, 1, 2, lvl, 2)
	f.physical_defense = _es(10, 13, 1, 2, lvl, 2)
	f.magic_attack = _es(14, 18, 1, 2, lvl, 2)
	f.magic_defense = _es(10, 13, 1, 2, lvl, 2)
	f.speed = _es(25, 31, 1, 2, lvl, 2)
	f.crit_chance = 9; f.crit_damage = 1; f.dodge_chance = 8
	f.abilities = [EAB.reflected_strike(), EAB.mimic_stance()]
	f.flavor_text = "A distorted reflection that has stepped free of its mirror. It copies the movements of those it faces, turning their own strength against them."
	return f


# Prog 1 FogGarden enemies
static func create_slumber_beast(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Slumber Beast", lvl)
	f.health = _es(49, 60, 3, 6, lvl, 2); f.max_health = f.health
	f.mana = _es(6, 10, 1, 2, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(17, 21, 1, 3, lvl, 2)
	f.physical_defense = _es(11, 15, 1, 2, lvl, 2)
	f.magic_attack = _es(6, 9, 0, 1, lvl, 2)
	f.magic_defense = _es(8, 11, 1, 2, lvl, 2)
	f.speed = _es(20, 25, 1, 2, lvl, 2)
	f.crit_chance = 5; f.crit_damage = 1; f.dodge_chance = 3
	f.abilities = [EAB.heavy_paw(), EAB.drowsy_roar()]
	f.flavor_text = "A massive creature wrapped in matted fur and the haze of deep sleep. Its roar carries the weight of oblivion, dragging listeners toward unconsciousness."
	return f


static func create_fog_wraith(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Fog Wraith", lvl)
	f.health = _es(33, 42, 2, 4, lvl, 2); f.max_health = f.health
	f.mana = _es(12, 17, 1, 3, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(8, 11, 0, 2, lvl, 2)
	f.physical_defense = _es(6, 9, 0, 1, lvl, 2)
	f.magic_attack = _es(17, 21, 1, 3, lvl, 2)
	f.magic_defense = _es(9, 14, 1, 2, lvl, 2)
	f.speed = _es(24, 29, 1, 3, lvl, 2)
	f.crit_chance = 5; f.crit_damage = 1; f.dodge_chance = 4
	f.abilities = [EAB.mist_tendril(), EAB.chill_fog()]
	f.flavor_text = "A wisp of sentient fog that coils through the dream garden. It chills everything it touches, feeding on the warmth of living thought."
	return f


static func create_thorn_dreamer(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Thorn Dreamer", lvl)
	f.health = _es(45, 54, 3, 5, lvl, 2); f.max_health = f.health
	f.mana = _es(10, 15, 1, 3, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(15, 18, 1, 2, lvl, 2)
	f.physical_defense = _es(9, 12, 1, 2, lvl, 2)
	f.magic_attack = _es(10, 14, 1, 2, lvl, 2)
	f.magic_defense = _es(9, 12, 1, 2, lvl, 2)
	f.speed = _es(22, 27, 1, 2, lvl, 2)
	f.crit_chance = 5; f.crit_damage = 1; f.dodge_chance = 4
	f.abilities = [EAB.briar_lash(), EAB.spore_cloud()]
	f.flavor_text = "A humanoid figure tangled in thorny vines that grow from its own dreaming flesh. It scatters toxic spores drawn from nightmares of wild, choking growth."
	return f


# =============================================================================
# Act II: Nightmare entities (Progression 3-8)
# =============================================================================

# Prog 3 enemies (shared DreamReturn+DreamNightmare)
static func create_nightmare_hound(n: String, lvl: int = 4) -> FighterData:
	var f := _base(n, "Nightmare Hound", lvl)
	f.health = _es(109, 129, 4, 7, lvl, 4); f.max_health = f.health
	f.mana = _es(8, 12, 1, 2, lvl, 4); f.max_mana = f.mana
	f.physical_attack = _es(22, 27, 1, 3, lvl, 4)
	f.physical_defense = _es(13, 16, 1, 2, lvl, 4)
	f.magic_attack = _es(10, 13, 0, 2, lvl, 4)
	f.magic_defense = _es(12, 15, 1, 2, lvl, 4)
	f.speed = _es(29, 34, 1, 3, lvl, 4)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 6
	f.abilities = [EAB.savage_bite(), EAB.howl()]
	f.flavor_text = "A slavering beast shaped from primal terror, with eyes like smoldering coals. Its howl reverberates through the dreamscape and shakes the courage of all who hear it."
	return f


static func create_dream_weaver(n: String, lvl: int = 4) -> FighterData:
	var f := _base(n, "Dream Weaver", lvl)
	f.health = _es(130, 155, 3, 6, lvl, 4); f.max_health = f.health
	f.mana = _es(14, 18, 1, 3, lvl, 4); f.max_mana = f.mana
	f.physical_attack = _es(10, 13, 0, 2, lvl, 4)
	f.physical_defense = _es(12, 15, 1, 2, lvl, 4)
	f.magic_attack = _es(20, 25, 1, 3, lvl, 4)
	f.magic_defense = _es(14, 17, 1, 2, lvl, 4)
	f.speed = _es(26, 31, 1, 2, lvl, 4)
	f.crit_chance = 5; f.crit_damage = 1; f.dodge_chance = 4
	f.abilities = [EAB.thread_bolt(), EAB.woven_ward()]
	f.flavor_text = "A robed figure that pulls shimmering threads from the fabric of dreams. It weaves protective wards and hurls bolts of concentrated dream-stuff at intruders."
	return f


static func create_hollow_echo(n: String, lvl: int = 4) -> FighterData:
	var f := _base(n, "Hollow Echo", lvl)
	f.health = _es(103, 121, 3, 5, lvl, 4); f.max_health = f.health
	f.mana = _es(12, 16, 1, 3, lvl, 4); f.max_mana = f.mana
	f.physical_attack = _es(10, 13, 0, 2, lvl, 4)
	f.physical_defense = _es(11, 14, 1, 2, lvl, 4)
	f.magic_attack = _es(20, 24, 1, 3, lvl, 4)
	f.magic_defense = _es(13, 16, 1, 2, lvl, 4)
	f.speed = _es(26, 31, 1, 2, lvl, 4)
	f.crit_chance = 5; f.crit_damage = 1; f.dodge_chance = 6
	f.abilities = [EAB.echo_drain(), EAB.dissonance()]
	f.flavor_text = "The empty husk of a dreamer who never woke. It repeats fragments of stolen voices and drains vitality from those who listen too closely."
	return f


# Prog 7 Labyrinth enemies (+10%)
static func create_somnolent_serpent(n: String, lvl: int = 8) -> FighterData:
	var f := _base(n, "Somnolent Serpent", lvl)
	f.health = _es(300, 348, 4, 7, lvl, 8); f.max_health = f.health
	f.mana = _es(10, 14, 1, 3, lvl, 8); f.max_mana = f.mana
	f.physical_attack = _es(29, 34, 1, 3, lvl, 8)
	f.physical_defense = _es(19, 23, 1, 2, lvl, 8)
	f.magic_attack = _es(17, 21, 1, 2, lvl, 8)
	f.magic_defense = _es(18, 22, 1, 2, lvl, 8)
	f.speed = _es(31, 36, 1, 3, lvl, 8)
	f.crit_chance = 11; f.crit_damage = 1; f.dodge_chance = 12
	f.abilities = [EAB.venom_coil(), EAB.sleep_fang()]
	f.flavor_text = "A great serpent that glides through the labyrinth of slumber. Its venom induces a sleep within sleep, trapping victims in layers of dream they cannot escape."
	return f


static func create_twilight_stalker(n: String, lvl: int = 8) -> FighterData:
	var f := _base(n, "Twilight Stalker", lvl)
	f.health = _es(286, 334, 4, 7, lvl, 8); f.max_health = f.health
	f.mana = _es(8, 12, 1, 2, lvl, 8); f.max_mana = f.mana
	f.physical_attack = _es(33, 38, 1, 3, lvl, 8)
	f.physical_defense = _es(17, 21, 1, 2, lvl, 8)
	f.magic_attack = _es(14, 17, 0, 2, lvl, 8)
	f.magic_defense = _es(16, 19, 1, 2, lvl, 8)
	f.speed = _es(34, 39, 1, 3, lvl, 8)
	f.crit_chance = 17; f.crit_damage = 2; f.dodge_chance = 15
	f.abilities = [EAB.dusk_blade(), EAB.vanish_strike()]
	f.flavor_text = "A silent hunter cloaked in the half-light between dreams. It vanishes mid-stride and reappears behind its prey with lethal precision."
	return f


static func create_waking_terror(n: String, lvl: int = 8) -> FighterData:
	var f := _base(n, "Waking Terror", lvl)
	f.health = _es(305, 352, 4, 7, lvl, 8); f.max_health = f.health
	f.mana = _es(14, 18, 2, 3, lvl, 8); f.max_mana = f.mana
	f.physical_attack = _es(16, 19, 0, 2, lvl, 8)
	f.physical_defense = _es(18, 22, 1, 2, lvl, 8)
	f.magic_attack = _es(30, 35, 1, 3, lvl, 8)
	f.magic_defense = _es(20, 24, 1, 2, lvl, 8)
	f.speed = _es(29, 34, 1, 2, lvl, 8)
	f.crit_chance = 11; f.crit_damage = 1; f.dodge_chance = 10
	f.abilities = [EAB.scream_blast(), EAB.terror_wave()]
	f.flavor_text = "A towering horror that bleeds into the waking world, born where nightmares press too hard against reality. Its screams carry the force of raw, unfiltered panic."
	return f


# Prog 7 ClockTower enemies (+25%)
static func create_dusk_sentinel(n: String, lvl: int = 8) -> FighterData:
	var f := _base(n, "Dusk Sentinel", lvl)
	f.health = _es(422, 492, 6, 9, lvl, 8); f.max_health = f.health
	f.mana = _es(9, 13, 1, 2, lvl, 8); f.max_mana = f.mana
	f.physical_attack = _es(31, 36, 1, 3, lvl, 8)
	f.physical_defense = _es(25, 30, 1, 3, lvl, 8)
	f.magic_attack = _es(11, 14, 0, 1, lvl, 8)
	f.magic_defense = _es(22, 26, 1, 2, lvl, 8)
	f.speed = _es(28, 33, 1, 2, lvl, 8)
	f.crit_chance = 9; f.crit_damage = 1; f.dodge_chance = 7
	f.abilities = [EAB.shield_bash(), EAB.iron_stance()]
	f.flavor_text = "An armored guardian forged from the dying light of dusk. It stands vigil at the clock tower's threshold, unyielding and tireless in its purpose."
	return f


static func create_clock_specter(n: String, lvl: int = 8) -> FighterData:
	var f := _base(n, "Clock Specter", lvl)
	f.health = _es(338, 393, 4, 7, lvl, 8); f.max_health = f.health
	f.mana = _es(11, 16, 1, 3, lvl, 8); f.max_mana = f.mana
	f.physical_attack = _es(24, 29, 1, 3, lvl, 8)
	f.physical_defense = _es(18, 22, 1, 2, lvl, 8)
	f.magic_attack = _es(27, 32, 1, 3, lvl, 8)
	f.magic_defense = _es(19, 23, 1, 2, lvl, 8)
	f.speed = _es(33, 38, 1, 3, lvl, 8)
	f.crit_chance = 13; f.crit_damage = 1; f.dodge_chance = 13
	f.abilities = [EAB.time_rend(), EAB.stasis_touch()]
	f.flavor_text = "A spectral figure bound to a shattered clock face, its limbs moving in fractured time. It tears at the flow of moments, freezing enemies in temporal stasis."
	return f


# Prog 8 boss (-3%)
static func create_the_nightmare(n: String, lvl: int = 9) -> FighterData:
	var f := _base(n, "The Nightmare", lvl)
	f.health = _es(555, 640, 6, 10, lvl, 9); f.max_health = f.health
	f.mana = _es(21, 25, 2, 4, lvl, 9); f.max_mana = f.mana
	f.physical_attack = _es(38, 43, 2, 3, lvl, 9)
	f.physical_defense = _es(23, 28, 2, 3, lvl, 9)
	f.magic_attack = _es(36, 41, 2, 3, lvl, 9)
	f.magic_defense = _es(23, 28, 2, 3, lvl, 9)
	f.speed = _es(35, 40, 2, 3, lvl, 9)
	f.crit_chance = 13; f.crit_damage = 2; f.dodge_chance = 11
	f.abilities = [EAB.nightmare_crush(), EAB.dream_rend(), EAB.dread_aura()]
	f.flavor_text = "The collective dread of an entire town given form and will. It is the dark heart of the shared dream, a shape that shifts with every fear it consumes."
	return f
