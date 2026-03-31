class_name EnemyAbilityDBS2

## Story 2 Acts I-II enemy abilities (cave creatures + coastal/surface).

const AbilityData := preload("res://scripts/data/ability_data.gd")
const Enums := preload("res://scripts/data/enums.gd")
const AbilityDB := preload("res://scripts/data/ability_db.gd")


static func _make(p_name: String, flavor: String, stat: Enums.StatType, mod: int,
		turns: int, on_enemy: bool, cost: int, all: bool = false,
		dot: int = 0, steal: float = 0.0) -> AbilityData:
	return AbilityDB._make(p_name, flavor, stat, mod, turns, on_enemy, cost, all, dot, steal)


# =============================================================================
# Act I: Cave creature abilities
# =============================================================================

# --- Glow Worm ---

static func luminous_pulse() -> AbilityData:
	return _make("Luminous Pulse", "A blinding pulse of bioluminescence.", Enums.StatType.MAGIC_ATTACK, 3, 0, true, 2, false, 0, 0.0)

static func dazzle() -> AbilityData:
	return _make("Dazzle", "A burst of blinding light leaves the target swinging at shadows.", Enums.StatType.ATTACK, 7, 2, true, 3, false, 0, 0.0)

# --- Crystal Spider ---

static func crystal_fang() -> AbilityData:
	return _make("Crystal Fang", "Crystalline mandibles pierce deep.", Enums.StatType.PHYSICAL_ATTACK, 4, 0, true, 2, false, 0, 0.0)

static func refract() -> AbilityData:
	return _make("Refract", "Light bends around the crystal body.", Enums.StatType.DEFENSE, 7, 2, false, 2, false, 0, 0.0)

# --- Shade Crawler ---

static func shadow_lash() -> AbilityData:
	return _make("Shadow Lash", "A tendril of darkness whips forward.", Enums.StatType.MIXED_ATTACK, 4, 0, true, 3, false, 0, 0.0)

static func dissolve() -> AbilityData:
	return _make("Dissolve", "The crawler's form blurs and shifts.", Enums.StatType.DODGE_CHANCE, 10, 2, false, 2, false, 0, 0.0)

# --- Echo Wisp ---

static func resonance() -> AbilityData:
	return _make("Resonance", "Sound warps into a concussive blast.", Enums.StatType.MAGIC_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func distortion() -> AbilityData:
	return _make("Distortion", "Reality warps, slowing all enemies.", Enums.StatType.SPEED, 6, 2, true, 4, true, 0, 0.0)

# --- Cave Maw ---

static func gnash() -> AbilityData:
	return _make("Gnash", "Rows of stone teeth grind together.", Enums.StatType.PHYSICAL_ATTACK, 6, 0, true, 3, false, 0, 0.0)

static func swallow() -> AbilityData:
	return _make("Swallow", "The maw tries to consume its prey.", Enums.StatType.PHYSICAL_ATTACK, 8, 0, true, 4, false, 0, 0.0)

static func tremor() -> AbilityData:
	return _make("Tremor", "The cave shakes violently.", Enums.StatType.PHYSICAL_ATTACK, 4, 0, true, 4, true, 0, 0.0)

# --- Vein Leech ---

static func latch() -> AbilityData:
	return _make("Latch", "Barbed tendrils dig into flesh and drain.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 3, false, 0, 0.2)

static func siphon_glow() -> AbilityData:
	return _make("Siphon Glow", "Stolen light weakens the target's defenses.", Enums.StatType.DEFENSE, 7, 2, true, 2, false, 0, 0.0)

# --- Stone Moth ---

static func wing_dust() -> AbilityData:
	return _make("Wing Dust", "A cloud of mineral dust slows reflexes.", Enums.StatType.SPEED, 6, 2, true, 3, true, 0, 0.0)

static func petrify_pulse() -> AbilityData:
	return _make("Petrify Pulse", "A flash of stone-grey light.", Enums.StatType.MAGIC_ATTACK, 5, 0, true, 3, false, 0, 0.0)

# --- Spore Stalker ---

static func toxic_dart() -> AbilityData:
	return _make("Toxic Dart", "A barb dripping with fungal venom.", Enums.StatType.PHYSICAL_ATTACK, 4, 0, true, 3, false, 0, 0.0)

static func spore_burst() -> AbilityData:
	return _make("Spore Burst", "A cloud of toxic spores settles over the target.", Enums.StatType.HEALTH, 0, 3, true, 3, false, 3, 0.0)

# --- Fungal Hulk ---

static func fungal_slam() -> AbilityData:
	return _make("Fungal Slam", "A massive fungal limb crashes down.", Enums.StatType.PHYSICAL_ATTACK, 6, 0, true, 3, false, 0, 0.0)

static func mycelium_shield() -> AbilityData:
	return _make("Mycelium Shield", "Fibrous growth hardens into armor.", Enums.StatType.DEFENSE, 10, 2, false, 3, false, 0, 0.0)

# --- Cap Wisp ---

static func hallucinate() -> AbilityData:
	return _make("Hallucinate", "Spores cloud the mind with visions.", Enums.StatType.MAGIC_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func phantasmal_haze() -> AbilityData:
	return _make("Phantasmal Haze", "Hallucinogenic spores cloud the senses, making every target seem to multiply.", Enums.StatType.ATTACK, 9, 2, true, 4, true, 0, 0.0)

# --- Cave Eel ---

static func jolt() -> AbilityData:
	return _make("Jolt", "An electric snap from the darkness.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func arc_flash() -> AbilityData:
	return _make("Arc Flash", "Electricity arcs through the water.", Enums.StatType.MAGIC_ATTACK, 4, 0, true, 3, true, 0, 0.0)

# --- Blind Angler ---

static func lure_light() -> AbilityData:
	return _make("Lure Light", "A hypnotic glow draws the unwary close.", Enums.StatType.MAGIC_ATTACK, 5, 0, true, 3, false, 0, 0.0)

static func abyssal_gaze() -> AbilityData:
	return _make("Abyssal Gaze", "Empty eyes strip away defenses.", Enums.StatType.DEFENSE, 10, 2, true, 3, false, 0, 0.0)

# --- Cavern Snapper ---

static func jaw_clamp() -> AbilityData:
	return _make("Jaw Clamp", "Stone-hard jaws lock shut with bone-crushing force.", Enums.StatType.PHYSICAL_ATTACK, 6, 0, true, 3, false, 0, 0.0)

static func stone_shell() -> AbilityData:
	return _make("Stone Shell", "The snapper withdraws into its mineral-encrusted carapace.", Enums.StatType.DEFENSE, 10, 2, false, 2, false, 0, 0.0)

# --- Silt Lurker ---

static func ambush_bite() -> AbilityData:
	return _make("Ambush Bite", "Jaws erupt from the murk before the prey can react.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func murky_retreat() -> AbilityData:
	return _make("Murky Retreat", "The lurker slips back into clouded water, nearly invisible.", Enums.StatType.DODGE_CHANCE, 14, 2, false, 2, false, 0, 0.0)

# --- Cave Dweller ---

static func crude_axe() -> AbilityData:
	return _make("Crude Axe", "A rough-hewn axe swings with brute force.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 2, false, 0, 0.0)

static func rock_toss() -> AbilityData:
	return _make("Rock Toss", "Stones rain down from the darkness.", Enums.StatType.PHYSICAL_ATTACK, 4, 0, true, 3, true, 0, 0.0)

# --- Tunnel Shaman ---

static func hex_flame() -> AbilityData:
	return _make("Hex Flame", "Cursed fire leaps from painted fingers.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 3, false, 0, 0.0)

static func ward_bones() -> AbilityData:
	return _make("Ward Bones", "Bone totems flare with protective light.", Enums.StatType.MAGIC_DEFENSE, 10, 2, false, 3, true, 0, 0.0)

# --- Burrow Scout ---

static func dart_strike() -> AbilityData:
	return _make("Dart Strike", "A quick jab from the shadows.", Enums.StatType.PHYSICAL_ATTACK, 4, 0, true, 2, false, 0, 0.0)

static func smoke_bomb() -> AbilityData:
	return _make("Smoke Bomb", "Acrid smoke obscures the scout's movements.", Enums.StatType.DODGE_CHANCE, 12, 2, false, 2, false, 0, 0.0)


# =============================================================================
# Act II: Coastal/surface abilities
# =============================================================================

# --- Driftwood Bandit ---

static func cutlass_slash() -> AbilityData:
	return _make("Cutlass Slash", "A rusted blade bites deep.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 2, false, 0, 0.0)

static func pillage_strike() -> AbilityData:
	return _make("Pillage Strike", "Take what you can, give nothing back.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.2)

# --- Saltrunner Smuggler ---

static func throwing_knife() -> AbilityData:
	return _make("Throwing Knife", "A glint of steel from the shadows.", Enums.StatType.PHYSICAL_ATTACK, 4, 0, true, 2, false, 0, 0.0)

static func salt_blind() -> AbilityData:
	return _make("Salt Blind", "Coarse salt thrown in the eyes.", Enums.StatType.SPEED, 8, 2, true, 3, false, 0, 0.0)

# --- Tide Warden ---

static func harpoon_thrust() -> AbilityData:
	return _make("Harpoon Thrust", "A barbed spear punches through armor.", Enums.StatType.PHYSICAL_ATTACK, 6, 0, true, 3, false, 0, 0.0)

static func brace_formation() -> AbilityData:
	return _make("Net Throw", "A weighted net snares and punishes the enemy.", Enums.StatType.PHYSICAL_ATTACK, 6, 0, true, 3, false, 0, 0.0)

# --- Tideside Channeler ---

static func tidewater_bolt() -> AbilityData:
	return _make("Tidewater Bolt", "Corrupted seawater surges forward in a crackling arc.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func tainted_spray() -> AbilityData:
	return _make("Tainted Spray", "A mist of brackish water clings to skin, burning slowly.", Enums.StatType.HEALTH, 0, 3, true, 3, false, 3, 0.0)

# --- Reef Shaman ---

static func coral_blast() -> AbilityData:
	return _make("Coral Blast", "Shards of living coral burst from an outstretched hand.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 3, false, 0, 0.0)

static func coral_barrage() -> AbilityData:
	return _make("Coral Barrage", "A volley of razor-sharp coral fragments rakes across the battlefield.", Enums.StatType.MAGIC_ATTACK, 3, 0, true, 4, true, 0, 0.0)

# --- Bilge Rat ---

static func filthy_shiv() -> AbilityData:
	return _make("Filthy Shiv", "A jagged blade caked in grime finds its mark.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 2, false, 0, 0.0)

static func festering_wound() -> AbilityData:
	return _make("Festering Wound", "The cut festers, poison seeping deeper with every heartbeat.", Enums.StatType.HEALTH, 0, 3, true, 3, false, 3, 0.0)

# --- Blighted Gull ---

static func peck_frenzy() -> AbilityData:
	return _make("Peck Frenzy", "A flurry of razor-sharp pecks.", Enums.StatType.PHYSICAL_ATTACK, 4, 0, true, 2, false, 0, 0.0)

static func dive_screech() -> AbilityData:
	return _make("Dive Screech", "Black wings blot out the sky.", Enums.StatType.MAGIC_ATTACK, 4, 0, true, 3, true, 0, 0.0)

# --- Shore Crawler ---

static func crushing_claw() -> AbilityData:
	return _make("Crushing Claw", "Armored pincers close with terrible force.", Enums.StatType.PHYSICAL_ATTACK, 7, 0, true, 3, false, 0, 0.0)

static func chitin_shell() -> AbilityData:
	return _make("Chitin Shell", "The creature withdraws into hardened shell.", Enums.StatType.DEFENSE, 10, 2, false, 3, false, 0, 0.0)

# --- Warped Hound ---

static func feral_lunge() -> AbilityData:
	return _make("Feral Lunge", "A wild leap ends in tearing teeth.", Enums.StatType.PHYSICAL_ATTACK, 5, 0, true, 2, false, 0, 0.0)

static func brackish_howl() -> AbilityData:
	return _make("Brackish Howl", "A howl that echoes wrong, sapping courage.", Enums.StatType.ATTACK, 9, 2, true, 4, true, 0, 0.0)

# --- Blackwater Captain ---

static func boarding_axe() -> AbilityData:
	return _make("Boarding Axe", "A heavy axe blow from a seasoned fighter.", Enums.StatType.PHYSICAL_ATTACK, 9, 0, true, 4, false, 0, 0.0)

static func captains_orders() -> AbilityData:
	return _make("Captain's Orders", "The captain rallies the crew.", Enums.StatType.ATTACK, 11, 2, false, 4, true, 0, 0.0)

# --- Corsair Hexer ---

static func brine_curse() -> AbilityData:
	return _make("Brine Curse", "Saltwater burns from the inside.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 4, false, 0, 0.0)

static func corrode_ward() -> AbilityData:
	return _make("Corrode Ward", "Magic eats through magical protections.", Enums.StatType.MAGIC_DEFENSE, 13, 2, true, 3, false, 0, 0.0)

# --- Abyssal Lurker ---

static func depth_pulse() -> AbilityData:
	return _make("Depth Pulse", "A shockwave from the ocean floor.", Enums.StatType.MAGIC_ATTACK, 11, 0, true, 4, false, 0, 0.0)

static func tidal_drain() -> AbilityData:
	return _make("Tidal Drain", "The sea takes back what it gave.", Enums.StatType.MAGIC_ATTACK, 7, 0, true, 4, false, 0, 0.2)

# --- Stormwrack Raptor ---

static func lightning_dive() -> AbilityData:
	return _make("Lightning Dive", "Thunder and talons strike as one.", Enums.StatType.MIXED_ATTACK, 10, 0, true, 4, false, 0, 0.0)

static func static_screech() -> AbilityData:
	return _make("Static Screech", "Lightning crackles along nerve endings.", Enums.StatType.SPEED, 8, 2, true, 3, true, 0, 0.0)

# --- Tidecaller Revenant ---

static func storm_surge() -> AbilityData:
	return _make("Storm Surge", "The sea rises in impossible fury.", Enums.StatType.MAGIC_ATTACK, 10, 0, true, 3, true, 0, 0.0)

static func drowning_grasp() -> AbilityData:
	return _make("Drowning Grasp", "Spectral hands pull you under.", Enums.StatType.MAGIC_ATTACK, 8, 0, true, 4, false, 0, 0.2)

static func mist_veil() -> AbilityData:
	return _make("Mist Veil", "Sea fog wraps around the form.", Enums.StatType.DODGE_CHANCE, 15, 2, false, 3, false, 0, 0.0)

# --- Salt Phantom ---

static func spectral_chill() -> AbilityData:
	return _make("Spectral Chill", "Cold beyond cold seeps into bones.", Enums.StatType.MAGIC_ATTACK, 6, 0, true, 3, false, 0, 0.0)

static func memory_fog() -> AbilityData:
	return _make("Memory Fog", "A mist that erodes the will to fight.", Enums.StatType.ATTACK, 11, 2, true, 3, true, 0, 0.0)

# --- Drowned Sailor ---

static func spectral_cutlass() -> AbilityData:
	return _make("Spectral Cutlass", "A ghostly blade, still sharp despite centuries beneath the waves.", Enums.StatType.MIXED_ATTACK, 8, 0, true, 3, false, 0, 0.0)

static func waterlogged_grasp() -> AbilityData:
	return _make("Waterlogged Grasp", "Cold, dead hands clamp down. Water fills the lungs where there should be air.", Enums.StatType.HEALTH, 5, 3, true, 4, false, 3, 0.0)

# --- Depth Horror ---

static func tentacle_crush() -> AbilityData:
	return _make("Tentacle Crush", "Barbed appendages coil around flesh and squeeze until bones creak.", Enums.StatType.MIXED_ATTACK, 10, 0, true, 4, false, 0, 0.2)

static func abyssal_terror() -> AbilityData:
	return _make("Abyssal Terror", "The full horror of the deep reveals itself. All courage drains away.", Enums.StatType.DEFENSE, 10, 2, true, 3, true, 0, 0.0)
