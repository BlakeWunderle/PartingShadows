class_name EnemyAbilityDB

## Acts I-II enemy abilities (city streets, forest, wilderness, shore, branch battles, cemetery).

const AbilityData := preload("res://scripts/data/ability_data.gd")
const Enums := preload("res://scripts/data/enums.gd")
const AbilityDB := preload("res://scripts/data/ability_db.gd")


static func _make(p_name: String, flavor: String, stat: Enums.StatType, mod: int,
		turns: int, on_enemy: bool, cost: int, all: bool = false,
		dot: int = 0, steal: float = 0.0) -> AbilityData:
	return AbilityDB._make(p_name, flavor, stat, mod, turns, on_enemy, cost, all, dot, steal)


# =============================================================================
# Damage abilities
# =============================================================================

static func bite() -> AbilityData:
	return _make("Bite", "Sharp fangs tear into flesh.", Enums.StatType.PHYSICAL_ATTACK, 3, 0, true, 2, false, 0, 0.0)

static func gore() -> AbilityData:
	return _make("Gore", "A vicious thrust of tusks.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func charge() -> AbilityData:
	return _make("Charge", "A headlong rush.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 4, false, 0, 0.0)

static func stab() -> AbilityData:
	return _make("Stab", "A quick jab.", Enums.StatType.PHYSICAL_ATTACK, 2, 0, true, 1, false, 0, 0.0)

static func throw_rock() -> AbilityData:
	return _make("Throw Rock", "Hurl a stone at the enemy.", Enums.StatType.PHYSICAL_ATTACK, 3, 0, true, 2, false, 0, 0.0)

static func tackle() -> AbilityData:
	return _make("Tackle", "Slam bodily into the target.", Enums.StatType.PHYSICAL_ATTACK, 4, 0, true, 3, false, 0, 0.0)

static func ambush() -> AbilityData:
	return _make("Ambush", "Strike from hiding.", Enums.StatType.PHYSICAL_ATTACK, 6, 0, true, 4, false, 0, 0.0)

static func trident_thrust() -> AbilityData:
	return _make("Trident Thrust", "A powerful three-pronged strike crackling with sea magic.", Enums.StatType.MIXED_ATTACK, 6, 0, true, 3, false, 0, 0.0)

static func tidal_splash() -> AbilityData:
	return _make("Tidal Splash", "A wave crashes over all enemies.", Enums.StatType.MAGIC_ATTACK, 5, 0, true, 4, true, 0, 0.0)

static func crush() -> AbilityData:
	return _make("Crush", "Overwhelming brute force.", Enums.StatType.PHYSICAL_ATTACK, 8, 0, true, 4, false, 0, 0.0)

static func bramble() -> AbilityData:
	return _make("Bramble", "Thorny vines lash out.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 3, false, 0, 0.0)

static func lure() -> AbilityData:
	return _make("Lure", "A hypnotic flash of light.", Enums.StatType.MAGIC_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func thorn() -> AbilityData:
	return _make("Thorn", "A barbed spike launches forward.", Enums.StatType.PHYSICAL_ATTACK, 4, 0, true, 2, false, 0, 0.0)

static func cleave() -> AbilityData:
	return _make("Cleave", "A wide slash hits all enemies.", Enums.StatType.PHYSICAL_ATTACK, 4, 0, true, 4, true, 0, 0.0)

static func stomp() -> AbilityData:
	return _make("Stomp", "The ground shakes.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 4, true, 0, 0.0)

static func talon_rake() -> AbilityData:
	return _make("Talon Rake", "Razor talons rake the target in a gust of unnatural wind.", Enums.StatType.MIXED_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func flintlock() -> AbilityData:
	return _make("Flintlock", "A blast from a sea-worn pistol.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func cannon_barrage() -> AbilityData:
	return _make("Cannon Barrage", "Broadside!", Enums.StatType.PHYSICAL_ATTACK, 8, 0, true, 3, true, 0, 0.0)

static func dragon_breath() -> AbilityData:
	return _make("Dragon Breath", "A gout of searing flame.", Enums.StatType.MAGIC_ATTACK, 9, 0, true, 4, false, 0, 0.0)

static func tail_strike() -> AbilityData:
	return _make("Tail Strike", "A heavy tail whip.", Enums.StatType.PHYSICAL_ATTACK, 6, 0, true, 3, false, 0, 0.0)

static func claw() -> AbilityData:
	return _make("Claw", "Sharp claws rake the enemy.", Enums.StatType.PHYSICAL_ATTACK, 4, 0, true, 2, false, 0, 0.0)

static func showstopper() -> AbilityData:
	return _make("Showstopper", "A dazzling magical display.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func circuit_burst() -> AbilityData:
	return _make("Circuit Burst", "An electrical overload.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 3, false, 0, 0.0)

static func seismic_charge() -> AbilityData:
	return _make("Seismic Charge", "The ground erupts.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 4, true, 0, 0.0)

static func hammer_blow() -> AbilityData:
	return _make("Hammer Blow", "A crushing strike.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 2, false, 0, 0.0)

static func rally_strike() -> AbilityData:
	return _make("Rally Strike", "A commanding blow.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func skewer() -> AbilityData:
	return _make("Skewer", "A precise piercing thrust.", Enums.StatType.PHYSICAL_ATTACK, 6, 0, true, 3, false, 0, 0.0)

static func drake_strike() -> AbilityData:
	return _make("Drake Strike", "Draconic fury.", Enums.StatType.MIXED_ATTACK, 6, 0, true, 4, false, 0, 0.0)

static func mace_strike() -> AbilityData:
	return _make("Mace Strike", "A heavy mace blow blessed with divine force.", Enums.StatType.MIXED_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func prop_drop() -> AbilityData:
	return _make("Prop Drop", "Something heavy falls from above.", Enums.StatType.MIXED_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func crescendo() -> AbilityData:
	return _make("Crescendo", "The music builds to a painful peak.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 4, false, 0, 0.0)

static func devour() -> AbilityData:
	return _make("Devour", "Consume the enemy's essence.", Enums.StatType.MIXED_ATTACK, 8, 0, true, 4, false, 0, 0.0)

static func rend() -> AbilityData:
	return _make("Rend", "Tear at the enemy.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func soul_drain() -> AbilityData:
	return _make("Soul Drain", "Rip the life force away.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 4, false, 0, 0.2)

static func whip_crack() -> AbilityData:
	return _make("Whip Crack", "The ringmaster empowers allies.", Enums.StatType.ATTACK, 15, 2, false, 3, false, 0, 0.0)


# =============================================================================
# Debuff abilities
# =============================================================================

static func siren_song() -> AbilityData:
	return _make("Siren Song", "An enchanting melody that slows.", Enums.StatType.SPEED, 8, 2, true, 2, false, 0, 0.0)

static func enemy_hex() -> AbilityData:
	return _make("Hex", "A curse that weakens defenses.", Enums.StatType.DEFENSE, 8, 2, true, 2, false, 0, 0.0)

static func bewitch() -> AbilityData:
	return _make("Bewitch", "Daze the enemy's mind.", Enums.StatType.SPEED, 6, 2, true, 2, false, 0, 0.0)

static func pollen() -> AbilityData:
	return _make("Pollen", "Blinding pollen lowers magic resistance.", Enums.StatType.MAGIC_DEFENSE, 8, 2, true, 2, false, 0, 0.0)

static func shriek() -> AbilityData:
	return _make("Shriek", "A piercing scream slows all enemies.", Enums.StatType.SPEED, 6, 2, true, 4, true, 0, 0.0)

static func dirty_trick() -> AbilityData:
	return _make("Dirty Trick", "Throw sand in their eyes.", Enums.StatType.SPEED, 6, 2, true, 2, false, 0, 0.0)

static func center_ring() -> AbilityData:
	return _make("Center Ring", "Force the enemy into the spotlight.", Enums.StatType.DEFENSE, 8, 2, true, 2, false, 0, 0.0)

static func dismantle() -> AbilityData:
	return _make("Dismantle", "Take the enemy apart piece by piece.", Enums.StatType.DEFENSE, 12, 2, true, 3, false, 0, 0.0)

static func mime_trap() -> AbilityData:
	return _make("Mime Trap", "Trapped in an invisible box.", Enums.StatType.SPEED, 6, 2, true, 2, false, 0, 0.0)

static func cadence() -> AbilityData:
	return _make("Cadence", "A rhythm that disrupts timing.", Enums.StatType.SPEED, 6, 2, true, 2, false, 0, 0.0)

static func paralyze() -> AbilityData:
	return _make("Carrion Strike", "Rotting claws tear through flesh with unnatural hunger.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func terrify() -> AbilityData:
	return _make("Spectral Rend", "The wraith tears through flesh with ghostly claws.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 3, false, 0, 0.0)


# =============================================================================
# Heal abilities
# =============================================================================

static func regenerate() -> AbilityData:
	var a := _make("Regenerate", "Flesh knits back together.", Enums.StatType.HEALTH, 10, 0, false, 4, false, 0, 0.0)
	a.heal_threshold = 0.4
	return a

static func blessing() -> AbilityData:
	var a := _make("Blessing", "Divine favor mends wounds.", Enums.StatType.HEALTH, 5, 0, false, 3, false, 0, 0.0)
	a.heal_threshold = 0.35
	return a

static func aria() -> AbilityData:
	return _make("Aria", "A healing melody.", Enums.StatType.HEALTH, 6, 0, false, 3, false, 0, 0.0)


# =============================================================================
# Buff abilities
# =============================================================================

static func howl() -> AbilityData:
	return _make("Howl", "A rallying howl speeds all allies.", Enums.StatType.SPEED, 5, 2, false, 3, true, 0, 0.0)

static func scurry() -> AbilityData:
	return _make("Scurry", "Dart and weave to avoid attacks.", Enums.StatType.DODGE_CHANCE, 15, 2, false, 2, false, 0, 0.0)

static func thick_skin() -> AbilityData:
	return _make("Thick Skin", "Toughen up against attacks.", Enums.StatType.DEFENSE, 8, 2, false, 3, false, 0, 0.0)

static func dark_blessing() -> AbilityData:
	return _make("Dark Blessing", "Unholy power shields the body.", Enums.StatType.DEFENSE, 10, 2, false, 3, false, 0, 0.0)

static func war_cry() -> AbilityData:
	return _make("War Cry", "A battle shout empowers allies.", Enums.StatType.ATTACK, 7, 2, false, 3, true, 0, 0.0)

static func bravado() -> AbilityData:
	return _make("Bravado", "Bold confidence boosts attack.", Enums.StatType.ATTACK, 9, 2, false, 2, false, 0, 0.0)

static func overdrive() -> AbilityData:
	return _make("Overdrive", "Push beyond normal limits.", Enums.StatType.SPEED, 11, 2, false, 3, false, 0, 0.0)

static func reinforce() -> AbilityData:
	return _make("Overclock", "Push weapon systems beyond normal limits.", Enums.StatType.ATTACK, 11, 2, false, 3, false, 0, 0.0)

static func temper() -> AbilityData:
	return _make("Temper", "Heat-treat weapons for all allies.", Enums.StatType.ATTACK, 11, 2, false, 3, true, 0, 0.0)

static func shield_wall() -> AbilityData:
	return _make("Commander's Strike", "A precise, brutal thrust that breaks through any guard.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func scale_guard() -> AbilityData:
	return _make("Breath Weapon", "Draconian fire erupts from an ancient throat.", Enums.StatType.MAGIC_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func enemy_consecrate() -> AbilityData:
	return _make("Holy Smite", "Divine wrath strikes with blinding force.", Enums.StatType.MAGIC_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func pantomime_wall() -> AbilityData:
	return _make("Deadly Feint", "A performer's trick with a lethal edge.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func firewall() -> AbilityData:
	return _make("Surge Protocol", "Emergency power reroutes into a devastating energy discharge.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 3, false, 0, 0.0)


# =============================================================================
# Creature-themed variants (stat-identical clones with unique flavor)
# =============================================================================

# --- Frost Wyrmling (replaces riptide) ---

static func frost_chains() -> AbilityData:
	return _make("Frost Chains", "Ice crystallizes around the enemy's limbs.", Enums.StatType.SPEED, 8, 2, true, 3, false, 0, 0.0)

# --- Blight variants (replaces enemy_blight per creature) ---

static func putrid_touch() -> AbilityData:
	return _make("Putrid Touch", "Rotting hands leave festering wounds.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 4, false, 0, 0.0)

static func shadow_rot() -> AbilityData:
	return _make("Shadow Rot", "Darkness seeps in and corrodes from within.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 4, false, 0, 0.0)

static func death_wither() -> AbilityData:
	return _make("Death Wither", "Life withers at the wraith's touch.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 4, false, 0, 0.0)

# --- Ruffian (replaces haymaker) ---

static func headbutt() -> AbilityData:
	return _make("Headbutt", "A brutal crack of skull against skull.", Enums.StatType.PHYSICAL_ATTACK, 4, 0, true, 2, false, 0, 0.0)

# --- Thornviper ---

static func fang_strike() -> AbilityData:
	return _make("Fang Strike", "Venom-slicked fangs sink in and the poison does the rest.", Enums.StatType.MIXED_ATTACK, 3, 0, true, 2, false, 0, 0.0)

static func venom() -> AbilityData:
	return _make("Venom", "Poison seeps into the wound, burning from within.", Enums.StatType.HEALTH, 0, 3, true, 3, false, 4, 0.0)

# --- Hound (magic attacker, something unnatural) ---

static func baleful_howl() -> AbilityData:
	return _make("Baleful Howl", "A howl that reverberates through bone and thought alike.", Enums.StatType.MAGIC_ATTACK, 4, 0, true, 2, false, 0, 0.0)

static func shadow_bite() -> AbilityData:
	return _make("Shadow Bite", "Its jaws close on something deeper than flesh.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 3, false, 0, 0.0)

# --- Bandit (replaces slash) ---

static func bushwhack() -> AbilityData:
	return _make("Bushwhack", "A crude swing from the treeline.", Enums.StatType.PHYSICAL_ATTACK, 4, 0, true, 2, false, 0, 0.0)

# --- Harpy ---

static func gale_buffet() -> AbilityData:
	return _make("Gale Buffet", "Wings beat with supernatural force, hurling cutting wind at all enemies.", Enums.StatType.MAGIC_ATTACK, 5, 0, true, 4, true, 0, 0.0)

# --- Troll (replaces smash) ---

static func boulder_fist() -> AbilityData:
	return _make("Boulder Fist", "A stone-hard fist crashes down.", Enums.StatType.PHYSICAL_ATTACK, 4, 0, true, 2, false, 0, 0.0)

# --- Siren (replaces torrent) ---

static func drowning_wave() -> AbilityData:
	return _make("Drowning Wave", "The sea rises at her command.", Enums.StatType.MAGIC_ATTACK, 4, 0, true, 3, false, 0, 0.0)

# --- Shade (replaces shadow_attack, frustrate) ---

static func umbral_lash() -> AbilityData:
	return _make("Umbral Lash", "A tendril of living shadow strikes.", Enums.StatType.MIXED_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func dread_whisper() -> AbilityData:
	return _make("Dread Whisper", "A voice from the void saps the will to fight.", Enums.StatType.ATTACK, 11, 2, true, 3, false, 0, 0.0)

# --- Fire Wyrmling (replaces roar) ---

static func searing_hiss() -> AbilityData:
	return _make("Flame Jet", "A gout of dragonfire scorches everything in its path.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 3, false, 0, 0.0)

# --- Boneguard (physical undead for OutpostDefense) ---

static func rusted_cleave() -> AbilityData:
	return _make("Rusted Cleave", "A corroded blade carves through armor.", Enums.StatType.PHYSICAL_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func grave_charge() -> AbilityData:
	return _make("Grave Charge", "The dead soldier lunges with grim purpose.", Enums.StatType.PHYSICAL_ATTACK, 6, 0, true, 3, true, 0, 0.0)

static func deathless_guard() -> AbilityData:
	return _make("Bone Crush", "Ancient bones grind and snap against the target.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.0)
