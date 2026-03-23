class_name EnemyAbilityDB

## Enemy-specific abilities. Some enemies also use shared abilities from AbilityDB.

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
	return _make("Trident Thrust", "A powerful three-pronged strike.", Enums.StatType.PHYSICAL_ATTACK, 6, 0, true, 3, false, 0, 0.0)

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
	return _make("Talon Rake", "Razor talons rake the target.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func flintlock() -> AbilityData:
	return _make("Flintlock", "A blast from a sea-worn pistol.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func cannon_barrage() -> AbilityData:
	return _make("Cannon Barrage", "Broadside!", Enums.StatType.PHYSICAL_ATTACK, 8, 0, true, 3, true, 0, 0.0)

static func dragon_breath() -> AbilityData:
	return _make("Dragon Breath", "A gout of searing flame.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 4, false, 0, 0.0)

static func tail_strike() -> AbilityData:
	return _make("Tail Strike", "A heavy tail whip.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func claw() -> AbilityData:
	return _make("Claw", "Sharp claws rake the enemy.", Enums.StatType.PHYSICAL_ATTACK, 4, 0, true, 2, false, 0, 0.0)

static func showstopper() -> AbilityData:
	return _make("Showstopper", "A dazzling magical display.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 3, false, 0, 0.0)

static func circuit_burst() -> AbilityData:
	return _make("Circuit Burst", "An electrical overload.", Enums.StatType.MAGIC_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func seismic_charge() -> AbilityData:
	return _make("Seismic Charge", "The ground erupts.", Enums.StatType.PHYSICAL_ATTACK, 4, 0, true, 4, true, 0, 0.0)

static func hammer_blow() -> AbilityData:
	return _make("Hammer Blow", "A crushing strike.", Enums.StatType.PHYSICAL_ATTACK, 4, 0, true, 2, false, 0, 0.0)

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
	return _make("Devour", "Consume the enemy's essence.", Enums.StatType.MIXED_ATTACK, 7, 0, true, 4, false, 0, 0.0)

static func rend() -> AbilityData:
	return _make("Rend", "Tear at the enemy.", Enums.StatType.PHYSICAL_ATTACK, 6, 0, true, 3, false, 0, 0.0)

static func enemy_blight() -> AbilityData:
	return _make("Blight", "Dark corruption seeps in.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 4, false, 0, 0.0)

static func shadow_strike() -> AbilityData:
	return _make("Shadow Strike", "A blow from the darkness.", Enums.StatType.MIXED_ATTACK, 7, 0, true, 4, false, 0, 0.0)

static func soul_drain() -> AbilityData:
	return _make("Soul Drain", "Rip the life force away.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 4, false, 0, 0.5)

static func sword_strike() -> AbilityData:
	return _make("Sword Strike", "A disciplined sword blow.", Enums.StatType.PHYSICAL_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func decisive_blow() -> AbilityData:
	return _make("Decisive Blow", "A devastating finishing strike.", Enums.StatType.PHYSICAL_ATTACK, 12, 0, true, 3, false, 0, 0.0)

static func arrow_shot() -> AbilityData:
	return _make("Arrow Shot", "A well-aimed arrow.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 2, false, 0, 0.0)

static func volley() -> AbilityData:
	return _make("Volley", "A rain of arrows.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 3, true, 0, 0.0)

static func spark() -> AbilityData:
	return _make("Spark", "A crackling bolt of energy.", Enums.StatType.MAGIC_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func dark_pulse() -> AbilityData:
	return _make("Dark Pulse", "Shadow energy pulses outward.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 4, true, 0, 0.0)

static func drain() -> AbilityData:
	return _make("Drain", "Siphon life from the target.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 3, false, 0, 0.5)

static func shadow_blast() -> AbilityData:
	return _make("Shadow Blast", "A devastating wave of dark energy.", Enums.StatType.MAGIC_ATTACK, 14, 0, true, 4, true, 0, 0.0)

static func siphon() -> AbilityData:
	return _make("Siphon", "Drain power from the target.", Enums.StatType.MAGIC_ATTACK, 12, 0, true, 4, false, 0, 0.5)

static func unmake() -> AbilityData:
	return _make("Unmake", "Unravel the target's very being.", Enums.StatType.MIXED_ATTACK, 18, 0, true, 5, false, 0, 0.0)

static func death_bolt() -> AbilityData:
	return _make("Death Bolt", "A bolt of necrotic energy.", Enums.StatType.MAGIC_ATTACK, 12, 0, true, 3, false, 0, 0.0)

static func soul_cage() -> AbilityData:
	return _make("Soul Cage", "Trap the enemy's soul and drain it.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 4, false, 0, 0.5)

static func infernal_strike() -> AbilityData:
	return _make("Infernal Strike", "Hellfire and steel.", Enums.StatType.MIXED_ATTACK, 7, 0, true, 4, false, 0, 0.0)

static func brimstone() -> AbilityData:
	return _make("Brimstone", "Sulfurous fire from below.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 4, false, 0, 0.0)

static func vine_whip() -> AbilityData:
	return _make("Vine Whip", "A thorny tendril lashes out.", Enums.StatType.PHYSICAL_ATTACK, 9, 0, true, 3, false, 0, 0.0)

static func root_slam() -> AbilityData:
	return _make("Root Slam", "Massive roots erupt from the earth.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, true, 0, 0.0)

static func dark_blade() -> AbilityData:
	return _make("Dark Blade", "A sword wreathed in shadow.", Enums.StatType.MIXED_ATTACK, 12, 0, true, 3, false, 0, 0.0)

static func shadow_bite() -> AbilityData:
	return _make("Shadow Bite", "Jaws of darkness snap shut.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 4, false, 0, 0.0)

static func slam() -> AbilityData:
	return _make("Slam", "A bone-crushing body slam.", Enums.StatType.PHYSICAL_ATTACK, 10, 0, true, 4, false, 0, 0.0)

static func antler_charge() -> AbilityData:
	return _make("Antler Charge", "Massive blighted antlers gore the target.", Enums.StatType.PHYSICAL_ATTACK, 12, 0, true, 3, false, 0, 0.0)

static func whip_crack() -> AbilityData:
	return _make("Whip Crack", "The ringmaster empowers allies.", Enums.StatType.ATTACK, 7, 2, false, 3, false, 0, 0.0)


# =============================================================================
# Damage + DoT abilities
# =============================================================================

static func venomous_bite() -> AbilityData:
	return _make("Venomous Bite", "Fangs drip with poison.", Enums.StatType.PHYSICAL_ATTACK, 8, 3, true, 4, false, 4, 0.0)

static func poison_cloud() -> AbilityData:
	return _make("Poison Cloud", "A toxic mist engulfs all enemies.", Enums.StatType.MIXED_ATTACK, 4, 3, true, 3, true, 5, 0.0)

static func rot_aura() -> AbilityData:
	return _make("Rot Aura", "A wave of decay washes over all enemies.", Enums.StatType.MIXED_ATTACK, 3, 3, true, 3, true, 4, 0.0)


# =============================================================================
# Debuff abilities
# =============================================================================

static func siren_song() -> AbilityData:
	return _make("Siren Song", "An enchanting melody that slows.", Enums.StatType.SPEED, 5, 2, true, 2, false, 0, 0.0)

static func enemy_hex() -> AbilityData:
	return _make("Hex", "A curse that weakens defenses.", Enums.StatType.DEFENSE, 4, 2, true, 2, false, 0, 0.0)

static func bewitch() -> AbilityData:
	return _make("Bewitch", "Daze the enemy's mind.", Enums.StatType.SPEED, 4, 2, true, 2, false, 0, 0.0)

static func pollen() -> AbilityData:
	return _make("Pollen", "Blinding pollen lowers magic resistance.", Enums.StatType.MAGIC_DEFENSE, 3, 2, true, 2, false, 0, 0.0)

static func shriek() -> AbilityData:
	return _make("Shriek", "A piercing scream slows all enemies.", Enums.StatType.SPEED, 4, 2, true, 4, true, 0, 0.0)

static func dirty_trick() -> AbilityData:
	return _make("Dirty Trick", "Throw sand in their eyes.", Enums.StatType.SPEED, 4, 2, true, 2, false, 0, 0.0)

static func riptide() -> AbilityData:
	return _make("Riptide", "Drag the enemy into slow currents.", Enums.StatType.SPEED, 5, 2, true, 3, false, 0, 0.0)

static func center_ring() -> AbilityData:
	return _make("Center Ring", "Force the enemy into the spotlight.", Enums.StatType.DEFENSE, 4, 2, true, 2, false, 0, 0.0)

static func dismantle() -> AbilityData:
	return _make("Dismantle", "Take the enemy apart piece by piece.", Enums.StatType.DEFENSE, 5, 2, true, 3, false, 0, 0.0)

static func mime_trap() -> AbilityData:
	return _make("Mime Trap", "Trapped in an invisible box.", Enums.StatType.SPEED, 4, 2, true, 2, false, 0, 0.0)

static func cadence() -> AbilityData:
	return _make("Cadence", "A rhythm that disrupts timing.", Enums.StatType.SPEED, 4, 2, true, 2, false, 0, 0.0)

static func paralyze() -> AbilityData:
	return _make("Paralyze", "Lock the enemy in place.", Enums.StatType.SPEED, 5, 2, true, 3, false, 0, 0.0)

static func terrify() -> AbilityData:
	return _make("Terrify", "Overwhelm with dread.", Enums.StatType.ATTACK, 4, 2, true, 3, false, 0, 0.0)

static func pin_down() -> AbilityData:
	return _make("Pin Down", "An arrow pins the enemy's cloak.", Enums.StatType.SPEED, 4, 2, true, 3, false, 0, 0.0)

static func dread() -> AbilityData:
	return _make("Dread", "Creeping fear weakens magic.", Enums.StatType.MAGIC_ATTACK, 7, 2, true, 3, false, 0, 0.0)

static func web() -> AbilityData:
	return _make("Web", "Sticky strands slow the target.", Enums.StatType.SPEED, 5, 2, true, 3, false, 0, 0.0)

static func howl_of_dread() -> AbilityData:
	return _make("Howl of Dread", "A howl that saps all enemies' will.", Enums.StatType.ATTACK, 5, 2, true, 3, true, 0, 0.0)


# =============================================================================
# Heal abilities
# =============================================================================

static func regenerate() -> AbilityData:
	return _make("Regenerate", "Flesh knits back together.", Enums.StatType.HEALTH, 15, 0, false, 4, false, 0, 0.0)

static func blessing() -> AbilityData:
	return _make("Blessing", "Divine favor mends wounds.", Enums.StatType.HEALTH, 8, 0, false, 3, false, 0, 0.0)

static func aria() -> AbilityData:
	return _make("Aria", "A healing melody.", Enums.StatType.HEALTH, 8, 0, false, 3, false, 0, 0.0)


# =============================================================================
# Buff abilities
# =============================================================================

static func howl() -> AbilityData:
	return _make("Howl", "A rallying howl speeds all allies.", Enums.StatType.SPEED, 3, 2, false, 3, true, 0, 0.0)

static func scurry() -> AbilityData:
	return _make("Scurry", "Dart and weave to avoid attacks.", Enums.StatType.DODGE_CHANCE, 15, 2, false, 2, false, 0, 0.0)

static func thick_skin() -> AbilityData:
	return _make("Thick Skin", "Toughen up against attacks.", Enums.StatType.DEFENSE, 4, 2, false, 3, false, 0, 0.0)

static func dark_blessing() -> AbilityData:
	return _make("Dark Blessing", "Unholy power shields the body.", Enums.StatType.DEFENSE, 5, 2, false, 3, false, 0, 0.0)

static func war_cry() -> AbilityData:
	return _make("War Cry", "A battle shout empowers allies.", Enums.StatType.ATTACK, 3, 2, false, 3, true, 0, 0.0)

static func bravado() -> AbilityData:
	return _make("Bravado", "Bold confidence boosts attack.", Enums.StatType.ATTACK, 4, 2, false, 2, false, 0, 0.0)

static func overdrive() -> AbilityData:
	return _make("Overdrive", "Push beyond normal limits.", Enums.StatType.SPEED, 7, 2, false, 3, false, 0, 0.0)

static func reinforce() -> AbilityData:
	return _make("Reinforce", "Strengthen defenses.", Enums.StatType.DEFENSE, 5, 2, false, 3, false, 0, 0.0)

static func temper() -> AbilityData:
	return _make("Temper", "Heat-treat weapons for all allies.", Enums.StatType.ATTACK, 5, 2, false, 3, true, 0, 0.0)

static func steel_plating() -> AbilityData:
	return _make("Steel Plating", "Armor up all allies.", Enums.StatType.DEFENSE, 5, 2, false, 3, true, 0, 0.0)

static func shield_wall() -> AbilityData:
	return _make("Shield Wall", "Raise shields against attack.", Enums.StatType.DEFENSE, 4, 2, false, 2, false, 0, 0.0)

static func war_ward() -> AbilityData:
	return _make("War Ward", "A ward against magic.", Enums.StatType.MAGIC_DEFENSE, 4, 2, false, 3, false, 0, 0.0)

static func scale_guard() -> AbilityData:
	return _make("Scale Guard", "Draconic scales harden.", Enums.StatType.DEFENSE, 4, 2, false, 3, false, 0, 0.0)

static func enemy_consecrate() -> AbilityData:
	return _make("Consecrate", "Holy ground strengthens resistance.", Enums.StatType.MAGIC_DEFENSE, 4, 2, false, 3, false, 0, 0.0)

static func pantomime_wall() -> AbilityData:
	return _make("Pantomime Wall", "An invisible barrier.", Enums.StatType.DEFENSE, 5, 2, false, 3, false, 0, 0.0)

static func defensive_formation() -> AbilityData:
	return _make("Defensive Formation", "All allies take a defensive stance.", Enums.StatType.DEFENSE, 4, 2, false, 3, true, 0, 0.0)

static func void_shield() -> AbilityData:
	return _make("Void Shield", "A shield of pure darkness.", Enums.StatType.DEFENSE, 6, 2, false, 4, false, 0, 0.0)

static func dark_veil() -> AbilityData:
	return _make("Dark Veil", "Shadow cloaks the body.", Enums.StatType.DEFENSE, 8, 2, false, 3, false, 0, 0.0)

static func raise_dead() -> AbilityData:
	return _make("Raise Dead", "The dead empower the living.", Enums.StatType.ATTACK, 5, 2, false, 3, true, 0, 0.0)

static func shadow_guard() -> AbilityData:
	return _make("Shadow Guard", "Shadows form a protective barrier.", Enums.StatType.DEFENSE, 6, 2, false, 4, false, 0, 0.0)

static func bark_shield() -> AbilityData:
	return _make("Bark Shield", "Living bark hardens into armor.", Enums.StatType.DEFENSE, 6, 2, false, 4, false, 0, 0.0)

static func firewall() -> AbilityData:
	var mod: int = randi_range(0, 9)
	var cost: int = randi_range(3, 6)
	return _make("Firewall", "A digital barrier. Results vary.", Enums.StatType.DEFENSE, mod, 2, false, cost, false, 0, 0.0)


# =============================================================================
# Creature-themed variants (stat-identical clones with unique flavor)
# =============================================================================

# --- Frost Wyrmling (replaces riptide) ---

static func frost_chains() -> AbilityData:
	return _make("Frost Chains", "Ice crystallizes around the enemy's limbs.", Enums.StatType.SPEED, 5, 2, true, 3, false, 0, 0.0)

# --- Sigil Wretch (replaces spark, ember, enemy_hex) ---

static func sigil_flare() -> AbilityData:
	return _make("Sigil Flare", "A carved rune detonates in blinding light.", Enums.StatType.MAGIC_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func glyph_burn() -> AbilityData:
	return _make("Glyph Burn", "Ancient glyphs sear the target's flesh.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 4, false, 0, 0.0)

static func ward_break() -> AbilityData:
	return _make("Ward Break", "A counter-sigil shatters magical protections.", Enums.StatType.DEFENSE, 4, 2, true, 2, false, 0, 0.0)

# --- Hellion (replaces infernal_strike, shadow_strike, enemy_hex) ---

static func frenzy_slash() -> AbilityData:
	return _make("Frenzy Slash", "Wild, reckless claws tear in every direction.", Enums.StatType.MIXED_ATTACK, 7, 0, true, 4, false, 0, 0.0)

static func chaos_rend() -> AbilityData:
	return _make("Chaos Rend", "Unhinged fury rips through armor and spirit.", Enums.StatType.MIXED_ATTACK, 7, 0, true, 4, false, 0, 0.0)

static func manic_howl() -> AbilityData:
	return _make("Manic Howl", "A deranged scream rattles defenses.", Enums.StatType.DEFENSE, 4, 2, true, 2, false, 0, 0.0)

# --- Fiendling (replaces brimstone, dread, enemy_hex) ---

static func hellspark() -> AbilityData:
	return _make("Hellspark", "A crackling ember from the pit.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 4, false, 0, 0.0)

static func imp_curse() -> AbilityData:
	return _make("Imp Curse", "A spiteful hex saps magical power.", Enums.StatType.MAGIC_ATTACK, 7, 2, true, 3, false, 0, 0.0)

static func fiend_mark() -> AbilityData:
	return _make("Fiend Mark", "A burning brand weakens the target's guard.", Enums.StatType.DEFENSE, 4, 2, true, 2, false, 0, 0.0)

# --- Blight variants (replaces enemy_blight per creature) ---

static func putrid_touch() -> AbilityData:
	return _make("Putrid Touch", "Rotting hands leave festering wounds.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 4, false, 0, 0.0)

static func shadow_rot() -> AbilityData:
	return _make("Shadow Rot", "Darkness seeps in and corrodes from within.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 4, false, 0, 0.0)

static func death_wither() -> AbilityData:
	return _make("Death Wither", "Life withers at the wraith's touch.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 4, false, 0, 0.0)

static func corruption_fang() -> AbilityData:
	return _make("Corruption Fang", "Tainted fangs spread dark corruption.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 4, false, 0, 0.0)

static func blighted_breath() -> AbilityData:
	return _make("Blighted Breath", "A miasma of disease exhales from the stag.", Enums.StatType.MIXED_ATTACK, 6, 0, true, 4, false, 0, 0.0)

# --- Ruffian (replaces haymaker) ---

static func headbutt() -> AbilityData:
	return _make("Headbutt", "A brutal crack of skull against skull.", Enums.StatType.PHYSICAL_ATTACK, 4, 0, true, 2, false, 0, 0.0)

# --- Hound (replaces shared bite) ---

static func snap() -> AbilityData:
	return _make("Snap", "Jaws clamp shut with trained precision.", Enums.StatType.PHYSICAL_ATTACK, 3, 0, true, 2, false, 0, 0.0)

# --- Bandit (replaces slash) ---

static func bushwhack() -> AbilityData:
	return _make("Bushwhack", "A crude swing from the treeline.", Enums.StatType.PHYSICAL_ATTACK, 4, 0, true, 2, false, 0, 0.0)

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
	return _make("Dread Whisper", "A voice from the void saps the will to fight.", Enums.StatType.ATTACK, 5, 2, true, 3, false, 0, 0.0)

# --- Royal Guard (replaces shield_slam) ---

static func bulwark_slam() -> AbilityData:
	return _make("Bulwark Slam", "A heavy royal shield crashes forward.", Enums.StatType.PHYSICAL_ATTACK, 4, 0, true, 2, false, 0, 0.0)

# --- Guard Sergeant (replaces rally) ---

static func battle_command() -> AbilityData:
	return _make("Battle Command", "A barked order quickens allied movements.", Enums.StatType.SPEED, 5, 2, false, 3, true, 0, 0.0)

# --- Fire Wyrmling (replaces roar) ---

static func searing_hiss() -> AbilityData:
	return _make("Searing Hiss", "Superheated breath scorches the air and rattles nerves.", Enums.StatType.ATTACK, 3, 2, true, 2, false, 0, 0.0)

# --- Dragon (full kit, upgraded for late-game) ---

static func cataclysm_breath() -> AbilityData:
	return _make("Cataclysm Breath", "An ancient inferno engulfs everything in its path.", Enums.StatType.MAGIC_ATTACK, 12, 0, true, 3, false, 0, 0.0)

static func rending_talons() -> AbilityData:
	return _make("Rending Talons", "Massive claws tear through armor like parchment.", Enums.StatType.PHYSICAL_ATTACK, 10, 0, true, 4, false, 0, 0.0)

static func draconic_terror() -> AbilityData:
	return _make("Draconic Terror", "The dragon's presence alone crushes the will to fight.", Enums.StatType.ATTACK, 5, 2, true, 3, false, 0, 0.0)

# --- Stranger Final (replaces corruption) ---

static func entropy() -> AbilityData:
	return _make("Entropy", "Reality frays at the Stranger's touch.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 3, false, 0, 0.0)

# --- Boneguard (physical undead for OutpostDefense) ---

static func rusted_cleave() -> AbilityData:
	return _make("Rusted Cleave", "A corroded blade carves through armor.", Enums.StatType.PHYSICAL_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func grave_charge() -> AbilityData:
	return _make("Grave Charge", "The dead soldier lunges with grim purpose.", Enums.StatType.PHYSICAL_ATTACK, 6, 0, true, 3, true, 0, 0.0)

static func deathless_guard() -> AbilityData:
	return _make("Deathless Guard", "Ancient duty hardens crumbling bones.", Enums.StatType.PHYSICAL_DEFENSE, 5, 2, false, 3, false, 0, 0.0)

