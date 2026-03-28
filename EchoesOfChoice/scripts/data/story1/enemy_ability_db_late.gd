class_name EnemyAbilityDBLate

## Acts III-V enemy abilities (city guards, corruption, final battles).

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

static func sword_strike() -> AbilityData:
	return _make("Sword Strike", "A disciplined sword blow.", Enums.StatType.PHYSICAL_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func decisive_blow() -> AbilityData:
	return _make("Decisive Blow", "A devastating finishing strike.", Enums.StatType.PHYSICAL_ATTACK, 12, 0, true, 3, false, 0, 0.0)

static func arrow_shot() -> AbilityData:
	return _make("Arrow Shot", "A well-aimed arrow.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 2, false, 0, 0.0)

static func volley() -> AbilityData:
	return _make("Volley", "A rain of arrows.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 3, true, 0, 0.0)

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

static func shadow_strike() -> AbilityData:
	return _make("Shadow Strike", "A blow from the darkness.", Enums.StatType.MIXED_ATTACK, 7, 0, true, 4, false, 0, 0.0)


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

static func pin_down() -> AbilityData:
	return _make("Pin Down", "An arrow pins the enemy's cloak.", Enums.StatType.SPEED, 4, 2, true, 3, false, 0, 0.0)

static func dread() -> AbilityData:
	return _make("Dread", "Creeping fear weakens magic.", Enums.StatType.MAGIC_ATTACK, 7, 2, true, 3, false, 0, 0.0)

static func web() -> AbilityData:
	return _make("Web", "Sticky strands slow the target.", Enums.StatType.SPEED, 5, 2, true, 3, false, 0, 0.0)

static func howl_of_dread() -> AbilityData:
	return _make("Howl of Dread", "A howl that saps all enemies' will.", Enums.StatType.ATTACK, 5, 2, true, 3, true, 0, 0.0)


# =============================================================================
# Buff abilities
# =============================================================================

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

static func defensive_formation() -> AbilityData:
	return _make("Defensive Formation", "All allies take a defensive stance.", Enums.StatType.DEFENSE, 4, 2, false, 3, true, 0, 0.0)


# =============================================================================
# Creature-themed variants
# =============================================================================

# --- Sigil Wretch ---

static func sigil_flare() -> AbilityData:
	return _make("Sigil Flare", "A carved rune detonates in blinding light.", Enums.StatType.MAGIC_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func glyph_burn() -> AbilityData:
	return _make("Glyph Burn", "Ancient glyphs sear the target's flesh.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 4, false, 0, 0.0)

static func ward_break() -> AbilityData:
	return _make("Ward Break", "A counter-sigil shatters magical protections.", Enums.StatType.DEFENSE, 4, 2, true, 2, false, 0, 0.0)

# --- Hellion ---

static func frenzy_slash() -> AbilityData:
	return _make("Frenzy Slash", "Wild, reckless claws tear in every direction.", Enums.StatType.MIXED_ATTACK, 7, 0, true, 4, false, 0, 0.0)

static func chaos_rend() -> AbilityData:
	return _make("Chaos Rend", "Unhinged fury rips through armor and spirit.", Enums.StatType.MIXED_ATTACK, 7, 0, true, 4, false, 0, 0.0)

static func manic_howl() -> AbilityData:
	return _make("Manic Howl", "A deranged scream rattles defenses.", Enums.StatType.DEFENSE, 4, 2, true, 2, false, 0, 0.0)

# --- Fiendling ---

static func hellspark() -> AbilityData:
	return _make("Hellspark", "A crackling ember from the pit.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 4, false, 0, 0.0)

static func imp_curse() -> AbilityData:
	return _make("Imp Curse", "A spiteful hex saps magical power.", Enums.StatType.MAGIC_ATTACK, 7, 2, true, 3, false, 0, 0.0)

static func fiend_mark() -> AbilityData:
	return _make("Fiend Mark", "A burning brand weakens the target's guard.", Enums.StatType.DEFENSE, 4, 2, true, 2, false, 0, 0.0)

# --- Blight variants ---

static func corruption_fang() -> AbilityData:
	return _make("Corruption Fang", "Tainted fangs spread dark corruption.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 4, false, 0, 0.0)

static func blighted_breath() -> AbilityData:
	return _make("Blighted Breath", "A miasma of disease exhales from the stag.", Enums.StatType.MIXED_ATTACK, 6, 0, true, 4, false, 0, 0.0)

# --- Royal Guard ---

static func bulwark_slam() -> AbilityData:
	return _make("Bulwark Slam", "A heavy royal shield crashes forward.", Enums.StatType.PHYSICAL_ATTACK, 4, 0, true, 2, false, 0, 0.0)

# --- Guard Sergeant ---

static func battle_command() -> AbilityData:
	return _make("Battle Command", "A barked order quickens allied movements.", Enums.StatType.SPEED, 5, 2, false, 3, true, 0, 0.0)

# --- Dragon (full kit, upgraded for late-game) ---

static func cataclysm_breath() -> AbilityData:
	return _make("Cataclysm Breath", "An ancient inferno engulfs everything in its path.", Enums.StatType.MAGIC_ATTACK, 12, 0, true, 3, false, 0, 0.0)

static func rending_talons() -> AbilityData:
	return _make("Rending Talons", "Massive claws tear through armor like parchment.", Enums.StatType.PHYSICAL_ATTACK, 10, 0, true, 4, false, 0, 0.0)

static func draconic_terror() -> AbilityData:
	return _make("Draconic Terror", "The dragon's presence alone crushes the will to fight.", Enums.StatType.ATTACK, 5, 2, true, 3, false, 0, 0.0)

# --- Stranger Final ---

static func entropy() -> AbilityData:
	return _make("Entropy", "Reality frays at the Stranger's touch.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 3, false, 0, 0.0)

# --- Stranger Tower (boss) ---

static func soul_siphon() -> AbilityData:
	return _make("Soul Siphon", "The Stranger reaches into the party's essence and drains their fighting spirit.", Enums.StatType.ATTACK, 5, 2, true, 4, true, 0, 0.0)
