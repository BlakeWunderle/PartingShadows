class_name EnemyDBS2

## Story 2 enemy factory. Separate from EnemyDB to avoid touching Story 1 balance.

const FighterData := preload("res://scripts/data/fighter_data.gd")
const EAB := preload("res://scripts/data/story2/enemy_ability_db_s2.gd")


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
# Cave creatures (Progression 0)
# =============================================================================

static func create_glow_worm(n: String, lvl: int = 1) -> FighterData:
	var f := _base(n, "Glow Worm", lvl)
	f.health = _es(29, 38, 2, 4, lvl, 1); f.max_health = f.health
	f.mana = _es(5, 8, 1, 2, lvl, 1); f.max_mana = f.mana
	f.physical_attack = _es(9, 12, 0, 2, lvl, 1)
	f.physical_defense = _es(5, 8, 0, 1, lvl, 1)
	f.magic_attack = _es(15, 18, 1, 3, lvl, 1)
	f.magic_defense = _es(9, 12, 1, 2, lvl, 1)
	f.speed = _es(22, 28, 1, 3, lvl, 1)
	f.crit_chance = 8; f.crit_damage = 1; f.dodge_chance = 6
	f.abilities = [EAB.luminous_pulse(), EAB.dazzle()]
	f.flavor_text = "A blind, segmented worm that navigates by bioluminescence. Its pulsing glow disorients prey before it strikes."
	return f


static func create_crystal_spider(n: String, lvl: int = 1) -> FighterData:
	var f := _base(n, "Crystal Spider", lvl)
	f.health = _es(51, 61, 3, 6, lvl, 1); f.max_health = f.health
	f.mana = _es(3, 5, 1, 1, lvl, 1); f.max_mana = f.mana
	f.physical_attack = _es(17, 20, 1, 3, lvl, 1)
	f.physical_defense = _es(10, 13, 1, 2, lvl, 1)
	f.magic_attack = _es(4, 7, 0, 1, lvl, 1)
	f.magic_defense = _es(8, 11, 1, 2, lvl, 1)
	f.speed = _es(20, 26, 1, 2, lvl, 1)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 5
	f.abilities = [EAB.crystal_fang(), EAB.refract()]
	f.flavor_text = "A translucent arachnid with mineral-encrusted legs. Light scatters through its crystalline body, making it hard to track."
	return f


# =============================================================================
# Deep Cavern creatures (Progression 1)
# =============================================================================

static func create_shade_crawler(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Shade Crawler", lvl)
	f.health = _es(50, 60, 3, 5, lvl, 2); f.max_health = f.health
	f.mana = _es(4, 7, 1, 2, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(15, 19, 1, 3, lvl, 2)
	f.physical_defense = _es(9, 12, 1, 2, lvl, 2)
	f.magic_attack = _es(13, 16, 1, 2, lvl, 2)
	f.magic_defense = _es(9, 12, 1, 2, lvl, 2)
	f.speed = _es(25, 31, 2, 3, lvl, 2)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 11
	f.abilities = [EAB.shadow_lash(), EAB.dissolve()]
	f.flavor_text = "A flat, many-legged predator that clings to cavern ceilings. It drops silently onto its prey from the darkness above."
	return f


static func create_echo_wisp(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Echo Wisp", lvl)
	f.health = _es(37, 45, 2, 4, lvl, 2); f.max_health = f.health
	f.mana = _es(7, 9, 1, 2, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(7, 10, 0, 1, lvl, 2)
	f.physical_defense = _es(6, 9, 0, 1, lvl, 2)
	f.magic_attack = _es(17, 21, 1, 3, lvl, 2)
	f.magic_defense = _es(11, 14, 1, 2, lvl, 2)
	f.speed = _es(27, 33, 2, 3, lvl, 2)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 13
	f.abilities = [EAB.resonance(), EAB.distortion()]
	f.flavor_text = "A flickering orb of sound made visible. It mimics voices of the lost, luring travelers deeper into the caverns."
	return f


# =============================================================================
# Fungal Hollow creatures (Progression 1, alt branch)
# =============================================================================

static func create_spore_stalker(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Spore Stalker", lvl)
	f.health = _es(41, 49, 2, 4, lvl, 2); f.max_health = f.health
	f.mana = _es(5, 8, 1, 2, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(15, 18, 1, 3, lvl, 2)
	f.physical_defense = _es(7, 10, 0, 1, lvl, 2)
	f.magic_attack = _es(11, 15, 1, 2, lvl, 2)
	f.magic_defense = _es(7, 10, 0, 1, lvl, 2)
	f.speed = _es(27, 33, 2, 3, lvl, 2)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 15
	f.abilities = [EAB.toxic_dart(), EAB.spore_burst()]
	f.flavor_text = "A gaunt, fungus-riddled creature that moves with unsettling precision. Poisonous barbs line its elongated limbs."
	return f


static func create_fungal_hulk(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Fungal Hulk", lvl)
	f.health = _es(62, 73, 4, 6, lvl, 2); f.max_health = f.health
	f.mana = _es(4, 7, 1, 1, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(17, 21, 1, 3, lvl, 2)
	f.physical_defense = _es(11, 15, 1, 2, lvl, 2)
	f.magic_attack = _es(5, 8, 0, 1, lvl, 2)
	f.magic_defense = _es(9, 12, 1, 2, lvl, 2)
	f.speed = _es(17, 21, 1, 2, lvl, 2)
	f.crit_chance = 5; f.crit_damage = 1; f.dodge_chance = 1
	f.abilities = [EAB.fungal_slam(), EAB.mycelium_shield()]
	f.flavor_text = "A massive creature overgrown with shelf mushrooms and hardened mycelia. Each thundering step shakes loose clouds of spores."
	return f


static func create_cap_wisp(n: String, lvl: int = 2) -> FighterData:
	var f := _base(n, "Cap Wisp", lvl)
	f.health = _es(35, 43, 2, 4, lvl, 2); f.max_health = f.health
	f.mana = _es(8, 10, 1, 2, lvl, 2); f.max_mana = f.mana
	f.physical_attack = _es(7, 10, 0, 1, lvl, 2)
	f.physical_defense = _es(6, 9, 0, 1, lvl, 2)
	f.magic_attack = _es(17, 21, 1, 3, lvl, 2)
	f.magic_defense = _es(11, 14, 1, 2, lvl, 2)
	f.speed = _es(25, 31, 2, 3, lvl, 2)
	f.crit_chance = 8; f.crit_damage = 1; f.dodge_chance = 13
	f.abilities = [EAB.hallucinate(), EAB.phantasmal_haze()]
	f.flavor_text = "A drifting mushroom cap wreathed in hallucinogenic mist. Those who breathe its spores see things that were never there."
	return f


# =============================================================================
# Tranquil Pool creatures (Progression 2, alt branch)
# =============================================================================

static func create_cave_eel(n: String, lvl: int = 3) -> FighterData:
	var f := _base(n, "Cave Eel", lvl)
	f.health = _es(41, 49, 2, 4, lvl, 3); f.max_health = f.health
	f.mana = _es(6, 8, 1, 2, lvl, 3); f.max_mana = f.mana
	f.physical_attack = _es(19, 22, 1, 3, lvl, 3)
	f.physical_defense = _es(6, 9, 0, 1, lvl, 3)
	f.magic_attack = _es(16, 19, 1, 2, lvl, 3)
	f.magic_defense = _es(9, 12, 1, 2, lvl, 3)
	f.speed = _es(29, 35, 2, 3, lvl, 3)
	f.crit_chance = 10; f.crit_damage = 1; f.dodge_chance = 12
	f.abilities = [EAB.jolt(), EAB.arc_flash()]
	f.flavor_text = "A sinuous, eyeless fish that slithers through subterranean pools. Bioelectric organs along its flanks discharge painful jolts."
	return f


static func create_blind_angler(n: String, lvl: int = 3) -> FighterData:
	var f := _base(n, "Blind Angler", lvl)
	f.health = _es(52, 63, 3, 5, lvl, 3); f.max_health = f.health
	f.mana = _es(6, 8, 1, 2, lvl, 3); f.max_mana = f.mana
	f.physical_attack = _es(9, 11, 0, 2, lvl, 3)
	f.physical_defense = _es(8, 11, 1, 2, lvl, 3)
	f.magic_attack = _es(17, 21, 1, 3, lvl, 3)
	f.magic_defense = _es(10, 14, 1, 2, lvl, 3)
	f.speed = _es(20, 26, 1, 2, lvl, 3)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 8
	f.abilities = [EAB.lure_light(), EAB.abyssal_gaze()]
	f.flavor_text = "A deep-water predator that dangles a glowing lure from its head. Its blank, milky eyes conceal a piercing psychic awareness."
	return f


static func create_pale_crayfish(n: String, lvl: int = 3) -> FighterData:
	var f := _base(n, "Pale Crayfish", lvl)
	f.health = _es(78, 91, 4, 6, lvl, 3); f.max_health = f.health
	f.mana = _es(4, 7, 1, 1, lvl, 3); f.max_mana = f.mana
	f.physical_attack = _es(21, 25, 2, 3, lvl, 3)
	f.physical_defense = _es(14, 18, 1, 3, lvl, 3)
	f.magic_attack = _es(4, 7, 0, 1, lvl, 3)
	f.magic_defense = _es(10, 14, 1, 2, lvl, 3)
	f.speed = _es(14, 20, 1, 2, lvl, 3)
	f.crit_chance = 6; f.crit_damage = 1; f.dodge_chance = 4
	f.abilities = [EAB.pincer_crush(), EAB.shell_up()]
	f.flavor_text = "An albino crustacean the size of a hound, armored in thick calcified plates. Its claws can shear through stone."
	return f


# =============================================================================
# Torch Chamber dwellers (Progression 2, alt branch)
# =============================================================================

static func create_cave_dweller(n: String, lvl: int = 3) -> FighterData:
	var f := _base(n, "Cave Dweller", lvl)
	f.health = _es(61, 76, 3, 5, lvl, 3); f.max_health = f.health
	f.mana = _es(4, 7, 1, 1, lvl, 3); f.max_mana = f.mana
	f.physical_attack = _es(19, 23, 2, 3, lvl, 3)
	f.physical_defense = _es(12, 16, 1, 2, lvl, 3)
	f.magic_attack = _es(6, 9, 0, 1, lvl, 3)
	f.magic_defense = _es(8, 11, 1, 2, lvl, 3)
	f.speed = _es(20, 26, 1, 2, lvl, 3)
	f.crit_chance = 7; f.crit_damage = 1; f.dodge_chance = 7
	f.abilities = [EAB.crude_axe(), EAB.rock_toss()]
	f.flavor_text = "A hunched, pale humanoid adapted to perpetual darkness. It fashions crude weapons from bone and stone."
	return f


static func create_tunnel_shaman(n: String, lvl: int = 3) -> FighterData:
	var f := _base(n, "Tunnel Shaman", lvl)
	f.health = _es(50, 59, 2, 4, lvl, 3); f.max_health = f.health
	f.mana = _es(9, 11, 1, 2, lvl, 3); f.max_mana = f.mana
	f.physical_attack = _es(7, 10, 0, 1, lvl, 3)
	f.physical_defense = _es(8, 11, 0, 2, lvl, 3)
	f.magic_attack = _es(18, 22, 1, 3, lvl, 3)
	f.magic_defense = _es(13, 17, 1, 2, lvl, 3)
	f.speed = _es(23, 29, 1, 2, lvl, 3)
	f.crit_chance = 8; f.crit_damage = 1; f.dodge_chance = 11
	f.abilities = [EAB.hex_flame(), EAB.ward_bones()]
	f.flavor_text = "An elder cave dweller draped in carved bone fetishes. It channels the strange energies that seep through the deep rock."
	return f


static func create_burrow_scout(n: String, lvl: int = 3) -> FighterData:
	var f := _base(n, "Burrow Scout", lvl)
	f.health = _es(44, 52, 2, 4, lvl, 3); f.max_health = f.health
	f.mana = _es(5, 8, 1, 1, lvl, 3); f.max_mana = f.mana
	f.physical_attack = _es(17, 21, 1, 3, lvl, 3)
	f.physical_defense = _es(7, 10, 0, 1, lvl, 3)
	f.magic_attack = _es(5, 8, 0, 1, lvl, 3)
	f.magic_defense = _es(7, 10, 0, 1, lvl, 3)
	f.speed = _es(29, 35, 2, 3, lvl, 3)
	f.crit_chance = 11; f.crit_damage = 2; f.dodge_chance = 22
	f.abilities = [EAB.dart_strike(), EAB.smoke_bomb()]
	f.flavor_text = "A wiry, quick-footed cave dweller that patrols the outer tunnels. It strikes from the shadows and vanishes before retaliation."
	return f


# =============================================================================
# Cave Exit creatures (Progression 3, post-T1 upgrade)
# =============================================================================

static func create_cave_maw(n: String, lvl: int = 5) -> FighterData:
	var f := _base(n, "Cave Maw", lvl)
	f.health = _es(132, 152, 5, 8, lvl, 3); f.max_health = f.health
	f.mana = _es(5, 8, 1, 2, lvl, 3); f.max_mana = f.mana
	f.physical_attack = _es(24, 28, 2, 3, lvl, 3)
	f.physical_defense = _es(15, 19, 1, 3, lvl, 3)
	f.magic_attack = _es(5, 8, 0, 2, lvl, 3)
	f.magic_defense = _es(11, 15, 1, 2, lvl, 3)
	f.speed = _es(19, 25, 1, 2, lvl, 3)
	f.crit_chance = 14; f.crit_damage = 2; f.dodge_chance = 10
	f.abilities = [EAB.gnash(), EAB.swallow(), EAB.tremor()]
	f.flavor_text = "A gargantuan lamprey-like beast that lurks near the cave exit. Its circular jaws can swallow a person whole."
	return f


static func create_vein_leech(n: String, lvl: int = 5) -> FighterData:
	var f := _base(n, "Vein Leech", lvl)
	f.health = _es(90, 105, 3, 5, lvl, 3); f.max_health = f.health
	f.mana = _es(4, 7, 1, 2, lvl, 3); f.max_mana = f.mana
	f.physical_attack = _es(23, 27, 2, 3, lvl, 3)
	f.physical_defense = _es(9, 12, 1, 2, lvl, 3)
	f.magic_attack = _es(6, 9, 0, 2, lvl, 3)
	f.magic_defense = _es(8, 11, 1, 2, lvl, 3)
	f.speed = _es(24, 30, 1, 3, lvl, 3)
	f.crit_chance = 14; f.crit_damage = 2; f.dodge_chance = 14
	f.abilities = [EAB.latch(), EAB.siphon_glow()]
	f.flavor_text = "A bloated parasitic worm that clings to mineral veins. It drains both blood and the faint luminescence from living things."
	return f


static func create_stone_moth(n: String, lvl: int = 5) -> FighterData:
	var f := _base(n, "Stone Moth", lvl)
	f.health = _es(70, 80, 2, 4, lvl, 3); f.max_health = f.health
	f.mana = _es(7, 9, 1, 2, lvl, 3); f.max_mana = f.mana
	f.physical_attack = _es(9, 12, 0, 2, lvl, 3)
	f.physical_defense = _es(7, 10, 0, 1, lvl, 3)
	f.magic_attack = _es(22, 26, 1, 3, lvl, 3)
	f.magic_defense = _es(13, 17, 1, 2, lvl, 3)
	f.speed = _es(27, 33, 2, 3, lvl, 3)
	f.crit_chance = 10; f.crit_damage = 1; f.dodge_chance = 21
	f.abilities = [EAB.petrify_pulse(), EAB.wing_dust()]
	f.flavor_text = "A large moth with wings of calcite and granite dust. Its petrifying scales turn flesh to stone on contact."
	return f
