class_name EnemyAbilityDBS3Act2

## Story 3 expanded Act II + waking investigation enemy abilities.

const AbilityData := preload("res://scripts/data/ability_data.gd")
const Enums := preload("res://scripts/data/enums.gd")
const AbilityDB := preload("res://scripts/data/ability_db.gd")


static func _make(p_name: String, flavor: String, stat: Enums.StatType, mod: int,
		turns: int, on_enemy: bool, cost: int, all: bool = false,
		dot: int = 0, steal: float = 0.0) -> AbilityData:
	return AbilityDB._make(p_name, flavor, stat, mod, turns, on_enemy, cost, all, dot, steal)


# =============================================================================
# Prog 4: Thread-visible dream (S3_DreamThreads)
# =============================================================================

# --- Thread Lurker ---

static func thread_ambush() -> AbilityData:
	return _make("Thread Ambush", "It drops from the woven ceiling without warning.", Enums.StatType.PHYSICAL_ATTACK, 6, 0, true, 2, false, 0, 0.0)

static func web_snare() -> AbilityData:
	return _make("Web Snare", "Sticky threads tangle around the ankles.", Enums.StatType.SPEED, 4, 2, true, 2, false, 0, 0.0)

# --- Dream Sentinel ---

static func sentinel_strike() -> AbilityData:
	return _make("Sentinel Strike", "A heavy blow from something that was standing very still.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 2, false, 0, 0.0)

static func woven_guard() -> AbilityData:
	return _make("Woven Guard", "The sentinel wraps itself in a cocoon of threads.", Enums.StatType.DEFENSE, 4, 2, false, 2, false, 0, 0.0)

# --- Gloom Spinner ---

static func shadow_thread() -> AbilityData:
	return _make("Shadow Thread", "A dark strand cuts through the air like a whip.", Enums.StatType.MAGIC_ATTACK, 5, 0, true, 2, false, 0, 0.0)

static func gloom_web() -> AbilityData:
	return _make("Gloom Web", "A net of darkness settles over everything.", Enums.StatType.DEFENSE, 4, 2, true, 4, true, 0, 0.0)


# =============================================================================
# Prog 5: Drowned Corridor / Shattered Gallery branches
# =============================================================================

# --- Drowned Reverie ---

static func memory_surge() -> AbilityData:
	return _make("Memory Surge", "Someone else's memory crashes into your mind.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 3, false, 0, 0.2)

static func deep_pulse() -> AbilityData:
	return _make("Deep Pulse", "A wave rolls out from beneath the surface.", Enums.StatType.MAGIC_ATTACK, 4, 0, true, 4, true, 0, 0.0)

# --- Riptide Beast ---

static func riptide_slash() -> AbilityData:
	return _make("Riptide Slash", "Claws that move with the current.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func swift_current() -> AbilityData:
	return _make("Swift Current", "The beast rides the flow and accelerates.", Enums.StatType.SPEED, 4, 2, false, 3, false, 0, 0.0)

# --- Depth Crawler ---

static func thread_burn() -> AbilityData:
	return _make("Thread Burn", "The threads beneath the surface brand the skin.", Enums.StatType.MIXED_ATTACK, 0, 3, true, 3, false, 3, 0.0)

static func latch() -> AbilityData:
	return _make("Latch", "It clamps on and does not let go.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 2, false, 0, 0.0)

# --- Fragment Golem ---

static func dream_crush() -> AbilityData:
	return _make("Dream Crush", "A fist assembled from a hundred stolen moments.", Enums.StatType.PHYSICAL_ATTACK, 10, 0, true, 3, false, 0, 0.0)

static func fragment_surge() -> AbilityData:
	return _make("Fragment Surge", "A mass of shards carrying remembered pain slams forward.", Enums.StatType.MIXED_ATTACK, 7, 0, true, 3, false, 0, 0.0)

# --- Portrait Wight ---

static func gilded_veil() -> AbilityData:
	return _make("Gilded Veil", "The wight reaches through its frame, draping an ally in spectral canvas.", Enums.StatType.DEFENSE, 5, 2, false, 3, false, 0, 0.0)

static func faded_gaze() -> AbilityData:
	return _make("Faded Gaze", "Dead eyes behind cracked glass focus, and the weight of forgotten grief strikes.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 3, false, 0, 0.0)

# --- Gallery Shade ---

static func gallery_bolt() -> AbilityData:
	return _make("Gallery Bolt", "A jagged shard of frame and canvas hurled with spectral force.", Enums.StatType.PHYSICAL_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func shatter_ward() -> AbilityData:
	return _make("Shatter Ward", "The shade peels away defenses like old paint.", Enums.StatType.DEFENSE, 4, 2, true, 3, false, 0, 0.0)


# =============================================================================
# Prog 6: Shadow Chase convergence (S3_DreamShadowChase)
# =============================================================================

# --- Shadow Pursuer (boss 5-ability kit) ---

static func phantom_strike() -> AbilityData:
	return _make("Phantom Strike", "A crit-focused lunge from perfect darkness. You never see it coming.", Enums.StatType.PHYSICAL_ATTACK, 9, 0, true, 3, false, 0, 0.0)

static func shadow_shroud() -> AbilityData:
	return _make("Shadow Shroud", "The pursuer melts into its own darkness, blows glancing off the shifting form.", Enums.StatType.DEFENSE, 6, 2, false, 3, false, 0, 0.0)

static func dream_terror() -> AbilityData:
	return _make("Dream Terror", "A pulse of nightmare dread washes over the entire party.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 4, true, 0, 0.0)

static func nightmare_lunge() -> AbilityData:
	return _make("Nightmare Lunge", "A blur-fast assault that tears through both flesh and resolve.", Enums.StatType.MIXED_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func fading_grasp() -> AbilityData:
	return _make("Fading Grasp", "Shadow fingers close around the fastest target, dragging their reflexes into darkness.", Enums.StatType.SPEED, 5, 2, true, 3, false, 0, 0.0)

# --- Dread Tendril (boss 3-ability kit) ---

static func dread_lash() -> AbilityData:
	return _make("Dread Lash", "Tendrils of darkness sweep across the field.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 4, true, 0, 0.0)

static func constrict() -> AbilityData:
	return _make("Constrict", "Tendrils wind around every target at once, squeezing the speed from their limbs.", Enums.StatType.SPEED, 5, 2, true, 4, true, 0, 0.0)

static func thrash() -> AbilityData:
	return _make("Thrash", "Writhing tentacles slam into the nearest target with brute force.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.0)

# --- Faded Voice ---

static func echoed_cry() -> AbilityData:
	return _make("Echoed Cry", "The voice hits like a physical blow, rattling teeth and bone.", Enums.StatType.PHYSICAL_ATTACK, 6, 0, true, 3, false, 0, 0.0)

static func fade() -> AbilityData:
	return _make("Fade", "Everything feels slower, heavier, further away.", Enums.StatType.SPEED, 5, 2, true, 4, true, 0, 0.0)


# =============================================================================
# Prog 9: Waking market confrontation (S3_MarketConfrontation)
# =============================================================================

# --- Market Watcher ---

static func hidden_blade() -> AbilityData:
	return _make("Hidden Blade", "The shopkeeper draws a knife from beneath the counter.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func merchant_guard() -> AbilityData:
	return _make("Merchant Guard", "The shopkeeper spots a gap in the opponent's guard.", Enums.StatType.DEFENSE, 4, 2, true, 3, false, 0, 0.0)

# --- Thread Smith ---

static func hammer_blow() -> AbilityData:
	return _make("Hammer Blow", "The smithing hammer was not meant for iron today.", Enums.StatType.PHYSICAL_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func forge_hardened() -> AbilityData:
	return _make("Forge Fury", "The smith's hammer rings with power, sharpening an ally's strikes.", Enums.StatType.PHYSICAL_ATTACK, 5, 2, false, 3, false, 0, 0.0)

# --- Hex Herbalist ---

static func tainted_salve() -> AbilityData:
	return _make("Tainted Salve", "What was meant to heal now corrodes.", Enums.StatType.MAGIC_ATTACK, 0, 3, true, 3, false, 5, 0.0)

static func numbing_dust() -> AbilityData:
	return _make("Toxic Cloud", "Crushed herbs combust into a cloud of corrosive spores.", Enums.StatType.MAGIC_ATTACK, 5, 0, true, 4, false, 0, 0.0)


# =============================================================================
# Prog 10: Cellar discovery (S3_CellarDiscovery)
# =============================================================================

# --- Cellar Watcher ---

static func bound_strike() -> AbilityData:
	return _make("Bound Strike", "It lunges to the end of its tether and strikes.", Enums.StatType.MIXED_ATTACK, 9, 0, true, 3, false, 0, 0.0)

static func tether_pull() -> AbilityData:
	return _make("Tether Pull", "The threads jerk the target off balance.", Enums.StatType.SPEED, 4, 2, true, 3, false, 0, 0.0)

# --- Thread Construct ---

static func woven_fist() -> AbilityData:
	return _make("Woven Fist", "A fist of physical thread strikes with mechanical force.", Enums.StatType.PHYSICAL_ATTACK, 10, 0, true, 3, false, 0, 0.0)

static func reinforced_threads() -> AbilityData:
	return _make("Reinforced Threads", "Threads unwind the target's protections with mechanical precision.", Enums.StatType.DEFENSE, 5, 2, true, 3, false, 0, 0.0)

# --- Ink Shade ---

static func ink_bolt() -> AbilityData:
	return _make("Ink Bolt", "A jet of liquid shadow burns on contact.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func ink_pool() -> AbilityData:
	return _make("Shadow Bolt", "A concentrated shard of living darkness strikes with surgical precision.", Enums.StatType.MAGIC_ATTACK, 9, 0, true, 3, false, 0, 0.0)
