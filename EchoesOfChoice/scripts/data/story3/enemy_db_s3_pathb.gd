class_name EnemyDBS3PathB

## Story 3 Path B enemy factory. All unique types for the investigation path.
## T2 rebalance: stats scaled to match T2 player power levels.

const FighterData := preload("res://scripts/data/fighter_data.gd")
const EAB := preload("res://scripts/data/story3/enemy_ability_db_s3_pathb.gd")


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
# Prog 11: Bound dream creatures guarding the inn cellar (S3_B_InnSearch)
# Target 54%, 12 level-ups
# =============================================================================

static func create_cellar_sentinel(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Cellar Sentinel", lvl)
	f.health = _es(450, 515, 5, 8, lvl, 12); f.max_health = f.health
	f.mana = _es(8, 11, 1, 1, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(73, 84, 3, 5, lvl, 12)
	f.physical_defense = _es(40, 48, 2, 4, lvl, 12)
	f.magic_attack = _es(8, 12, 0, 1, lvl, 12)
	f.magic_defense = _es(33, 39, 2, 3, lvl, 12)
	f.speed = _es(28, 34, 2, 3, lvl, 12)
	f.crit_chance = 14; f.crit_damage = 2; f.dodge_chance = 11
	f.abilities = [EAB.petrified_slam(), EAB.stagnant_chill()]
	f.flavor_text = "A stone-like guardian that has stood watch in the cellar for so long it has calcified into the walls. It attacks with petrifying force and radiates an unnatural cold."
	return f


static func create_bound_stalker(n: String, lvl: int = 12) -> FighterData:
	var f := _base(n, "Bound Stalker", lvl)
	f.health = _es(348, 401, 4, 7, lvl, 12); f.max_health = f.health
	f.mana = _es(8, 11, 1, 1, lvl, 12); f.max_mana = f.mana
	f.physical_attack = _es(70, 81, 3, 5, lvl, 12)
	f.physical_defense = _es(30, 37, 2, 3, lvl, 12)
	f.magic_attack = _es(8, 12, 0, 1, lvl, 12)
	f.magic_defense = _es(29, 34, 2, 3, lvl, 12)
	f.speed = _es(36, 42, 2, 3, lvl, 12)
	f.crit_chance = 16; f.crit_damage = 2; f.dodge_chance = 17
	f.abilities = [EAB.tethered_lunge(), EAB.fraying_bite()]
	f.flavor_text = "A lean creature bound by fraying threads to the cellar's hidden sanctum. It lunges at intruders with desperate speed, its bite unraveling both flesh and resolve."
	return f


# =============================================================================
# Prog 12: Cult members at early strength (S3_B_CultConfrontation)
# Target 52%, 13 level-ups. NOTE: only 2 enemies -- needs strong stats.
# =============================================================================

static func create_thread_disciple(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "Thread Disciple", lvl)
	f.health = _es(520, 598, 5, 8, lvl, 13); f.max_health = f.health
	f.mana = _es(19, 23, 1, 2, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(10, 14, 0, 2, lvl, 13)
	f.physical_defense = _es(36, 43, 2, 3, lvl, 13)
	f.magic_attack = _es(91, 105, 3, 5, lvl, 13)
	f.magic_defense = _es(42, 50, 2, 4, lvl, 13)
	f.speed = _es(34, 40, 2, 3, lvl, 13)
	f.crit_chance = 16; f.crit_damage = 3; f.dodge_chance = 15
	f.abilities = [EAB.unstable_channeling(), EAB.siphon_faith()]
	f.flavor_text = "A young cultist whose devotion outpaces their skill. Their channeling is unstable and volatile, but their faith in the Thread grants them power beyond their training."
	return f


static func create_thread_warden(n: String, lvl: int = 13) -> FighterData:
	var f := _base(n, "Thread Warden", lvl)
	f.health = _es(620, 710, 6, 9, lvl, 13); f.max_health = f.health
	f.mana = _es(8, 11, 1, 1, lvl, 13); f.max_mana = f.mana
	f.physical_attack = _es(96, 111, 3, 5, lvl, 13)
	f.physical_defense = _es(50, 58, 2, 4, lvl, 13)
	f.magic_attack = _es(8, 12, 0, 1, lvl, 13)
	f.magic_defense = _es(40, 48, 2, 3, lvl, 13)
	f.speed = _es(28, 34, 2, 3, lvl, 13)
	f.crit_chance = 16; f.crit_damage = 3; f.dodge_chance = 8
	f.abilities = [EAB.shielding_blow(), EAB.guardians_oath()]
	f.flavor_text = "A seasoned warrior sworn to protect the Thread cult's sanctum. Bound by an oath woven into their very being, they fight with unwavering purpose and crushing strength."
	return f


# =============================================================================
# Prog 13: Tunnel breach outer guard (S3_B_TunnelBreach)
# Target 50%, 14 level-ups
# =============================================================================

static func create_tunnel_sentinel(n: String, lvl: int = 14) -> FighterData:
	var f := _base(n, "Tunnel Sentinel", lvl)
	f.health = _es(570, 652, 6, 9, lvl, 14); f.max_health = f.health
	f.mana = _es(8, 11, 1, 1, lvl, 14); f.max_mana = f.mana
	f.physical_attack = _es(92, 106, 3, 5, lvl, 14)
	f.physical_defense = _es(48, 56, 2, 4, lvl, 14)
	f.magic_attack = _es(8, 12, 0, 1, lvl, 14)
	f.magic_defense = _es(40, 48, 2, 3, lvl, 14)
	f.speed = _es(28, 34, 2, 3, lvl, 14)
	f.crit_chance = 15; f.crit_damage = 3; f.dodge_chance = 9
	f.abilities = [EAB.chokepoint_crush(), EAB.passage_block()]
	f.flavor_text = "A massive guard stationed at the tunnel's narrowest point. It uses the confined space to devastating effect, crushing those who try to force their way through."
	return f


static func create_thread_sniper(n: String, lvl: int = 14) -> FighterData:
	var f := _base(n, "Thread Sniper", lvl)
	f.health = _es(420, 484, 5, 8, lvl, 14); f.max_health = f.health
	f.mana = _es(18, 22, 1, 2, lvl, 14); f.max_mana = f.mana
	f.physical_attack = _es(10, 14, 0, 2, lvl, 14)
	f.physical_defense = _es(30, 37, 2, 3, lvl, 14)
	f.magic_attack = _es(88, 101, 3, 5, lvl, 14)
	f.magic_defense = _es(40, 48, 2, 4, lvl, 14)
	f.speed = _es(36, 42, 2, 3, lvl, 14)
	f.crit_chance = 16; f.crit_damage = 3; f.dodge_chance = 21
	f.abilities = [EAB.piercing_thread(), EAB.expose_weakness()]
	f.flavor_text = "A cult marksman who fires needles of hardened dream-thread from the shadows. Each piercing shot reveals weaknesses in the target's defenses for allies to exploit."
	return f


static func create_pale_devotee(n: String, lvl: int = 14) -> FighterData:
	var f := _base(n, "Pale Devotee", lvl)
	f.health = _es(460, 530, 5, 8, lvl, 14); f.max_health = f.health
	f.mana = _es(18, 22, 1, 2, lvl, 14); f.max_mana = f.mana
	f.physical_attack = _es(10, 14, 0, 2, lvl, 14)
	f.physical_defense = _es(34, 42, 2, 3, lvl, 14)
	f.magic_attack = _es(84, 97, 3, 5, lvl, 14)
	f.magic_defense = _es(42, 50, 2, 4, lvl, 14)
	f.speed = _es(32, 38, 2, 3, lvl, 14)
	f.crit_chance = 14; f.crit_damage = 2; f.dodge_chance = 15
	f.abilities = [EAB.burning_devotion(), EAB.martyrs_gift()]
	f.flavor_text = "A pale, gaunt cultist who has given everything to the Thread. Their devotion burns like a fever, and in death they offer their remaining life-force as a gift to their allies."
	return f


# =============================================================================
# Prog 14: Thorne's ward in the passages (S3_B_ThornesWard)
# Target 48%, 15 level-ups
# =============================================================================

static func create_thread_ritualist(n: String, lvl: int = 14) -> FighterData:
	var f := _base(n, "Thread Ritualist", lvl)
	f.health = _es(528, 608, 5, 8, lvl, 14); f.max_health = f.health
	f.mana = _es(19, 23, 1, 2, lvl, 14); f.max_mana = f.mana
	f.physical_attack = _es(10, 14, 0, 2, lvl, 14)
	f.physical_defense = _es(40, 49, 2, 4, lvl, 14)
	f.magic_attack = _es(97, 111, 3, 5, lvl, 14)
	f.magic_defense = _es(46, 55, 2, 4, lvl, 14)
	f.speed = _es(36, 42, 2, 3, lvl, 14)
	f.crit_chance = 16; f.crit_damage = 3; f.dodge_chance = 24
	f.abilities = [EAB.binding_rite(), EAB.enervation_chant()]
	f.flavor_text = "A ritualist who maintains Thorne's protective ward through constant chanting. Their binding rites sap the strength of intruders while reinforcing the dream's barriers."
	return f


static func create_passage_guardian(n: String, lvl: int = 14) -> FighterData:
	var f := _base(n, "Passage Guardian", lvl)
	f.health = _es(625, 716, 6, 9, lvl, 14); f.max_health = f.health
	f.mana = _es(8, 11, 1, 1, lvl, 14); f.max_mana = f.mana
	f.physical_attack = _es(99, 114, 3, 5, lvl, 14)
	f.physical_defense = _es(53, 61, 2, 4, lvl, 14)
	f.magic_attack = _es(8, 12, 0, 1, lvl, 14)
	f.magic_defense = _es(44, 53, 2, 3, lvl, 14)
	f.speed = _es(30, 36, 2, 3, lvl, 14)
	f.crit_chance = 15; f.crit_damage = 3; f.dodge_chance = 17
	f.abilities = [EAB.champions_cleave(), EAB.loom_aegis()]
	f.flavor_text = "A champion of the hidden passages, clad in armor woven from the loom itself. Their cleaving strikes and impenetrable aegis make them the cult's most formidable gatekeeper."
	return f


static func create_warding_shadow(n: String, lvl: int = 14) -> FighterData:
	var f := _base(n, "Warding Shadow", lvl)
	f.health = _es(464, 533, 4, 7, lvl, 14); f.max_health = f.health
	f.mana = _es(18, 22, 1, 2, lvl, 14); f.max_mana = f.mana
	f.physical_attack = _es(10, 14, 0, 2, lvl, 14)
	f.physical_defense = _es(34, 41, 2, 3, lvl, 14)
	f.magic_attack = _es(93, 106, 3, 5, lvl, 14)
	f.magic_defense = _es(42, 51, 2, 4, lvl, 14)
	f.speed = _es(36, 42, 2, 3, lvl, 14)
	f.crit_chance = 14; f.crit_damage = 2; f.dodge_chance = 24
	f.abilities = [EAB.flickering_grasp(), EAB.shadow_veil()]
	f.flavor_text = "A flickering shade that guards the passages with elusive, ghost-like movements. It cloaks itself in shadow and reaches through the veil to grasp at the living."
	return f


# =============================================================================
# Prog 15: Shadow Innkeeper and Aldric projection (S3_B_LoomHeart)
# Target 46%, 16 level-ups
# =============================================================================

static func create_shadow_innkeeper(n: String, lvl: int = 15) -> FighterData:
	var f := _base(n, "Shadow Innkeeper", lvl)
	f.health = _es(540, 620, 6, 9, lvl, 15); f.max_health = f.health
	f.mana = _es(19, 23, 1, 2, lvl, 15); f.max_mana = f.mana
	f.physical_attack = _es(83, 95, 3, 5, lvl, 15)
	f.physical_defense = _es(44, 52, 2, 4, lvl, 15)
	f.magic_attack = _es(83, 95, 3, 5, lvl, 15)
	f.magic_defense = _es(44, 52, 2, 4, lvl, 15)
	f.speed = _es(34, 40, 2, 3, lvl, 15)
	f.crit_chance = 16; f.crit_damage = 3; f.dodge_chance = 13
	f.abilities = [EAB.borrowed_face(), EAB.thread_drain()]
	f.flavor_text = "The innkeeper's shadow given terrible purpose, wearing a stolen face that shifts between hospitality and menace. It drains life through threads hidden beneath a veneer of warmth."
	return f


static func create_astral_weaver(n: String, lvl: int = 15) -> FighterData:
	var f := _base(n, "Astral Weaver", lvl)
	f.health = _es(460, 530, 5, 8, lvl, 15); f.max_health = f.health
	f.mana = _es(20, 24, 1, 2, lvl, 15); f.max_mana = f.mana
	f.physical_attack = _es(10, 14, 0, 2, lvl, 15)
	f.physical_defense = _es(36, 43, 2, 3, lvl, 15)
	f.magic_attack = _es(97, 111, 3, 5, lvl, 15)
	f.magic_defense = _es(46, 54, 2, 4, lvl, 15)
	f.speed = _es(36, 42, 2, 3, lvl, 15)
	f.crit_chance = 16; f.crit_damage = 3; f.dodge_chance = 16
	f.abilities = [EAB.astral_barrage(), EAB.cosmic_unraveling()]
	f.flavor_text = "A weaver who has touched the astral plane beyond the dream and returned with terrible knowledge. Their barrages of cosmic energy unravel the fabric of reality itself."
	return f


static func create_loom_tendril(n: String, lvl: int = 15) -> FighterData:
	var f := _base(n, "Loom Tendril", lvl)
	f.health = _es(420, 484, 5, 8, lvl, 15); f.max_health = f.health
	f.mana = _es(17, 20, 1, 2, lvl, 15); f.max_mana = f.mana
	f.physical_attack = _es(10, 14, 0, 2, lvl, 15)
	f.physical_defense = _es(32, 39, 2, 3, lvl, 15)
	f.magic_attack = _es(91, 108, 3, 5, lvl, 15)
	f.magic_defense = _es(40, 48, 2, 4, lvl, 15)
	f.speed = _es(34, 40, 2, 3, lvl, 15)
	f.crit_chance = 15; f.crit_damage = 2; f.dodge_chance = 12
	f.abilities = [EAB.siphon_pulse(), EAB.constricting_weave()]
	f.flavor_text = "A living extension of the great loom, a tendril of woven dream-stuff that lashes out at those who approach. It siphons energy and constricts with suffocating pressure."
	return f


# =============================================================================
# Prog 16: Lira's dream cathedral guardians (S3_B_DreamInvasion)
# Target 44%, 17 level-ups
# =============================================================================

static func create_cathedral_warden(n: String, lvl: int = 16) -> FighterData:
	var f := _base(n, "Cathedral Warden", lvl)
	f.health = _es(672, 768, 6, 9, lvl, 16); f.max_health = f.health
	f.mana = _es(18, 22, 1, 2, lvl, 16); f.max_mana = f.mana
	f.physical_attack = _es(102, 118, 3, 5, lvl, 16)
	f.physical_defense = _es(53, 62, 2, 4, lvl, 16)
	f.magic_attack = _es(102, 118, 3, 5, lvl, 16)
	f.magic_defense = _es(53, 62, 2, 4, lvl, 16)
	f.speed = _es(35, 42, 2, 3, lvl, 16)
	f.crit_chance = 16; f.crit_damage = 3; f.dodge_chance = 36
	f.abilities = [EAB.consecrated_strike(), EAB.cathedrals_blessing()]
	f.flavor_text = "A guardian consecrated to Lira's dream cathedral, sworn to protect the sacred space where the Thread cult weaves its deepest designs. It fights with holy zeal and unyielding faith."
	return f


static func create_dream_binder(n: String, lvl: int = 16) -> FighterData:
	var f := _base(n, "Dream Binder", lvl)
	f.health = _es(564, 650, 5, 8, lvl, 16); f.max_health = f.health
	f.mana = _es(19, 23, 1, 2, lvl, 16); f.max_mana = f.mana
	f.physical_attack = _es(10, 14, 0, 2, lvl, 16)
	f.physical_defense = _es(40, 47, 2, 3, lvl, 16)
	f.magic_attack = _es(111, 129, 3, 6, lvl, 16)
	f.magic_defense = _es(51, 59, 2, 4, lvl, 16)
	f.speed = _es(40, 46, 2, 3, lvl, 16)
	f.crit_chance = 16; f.crit_damage = 3; f.dodge_chance = 39
	f.abilities = [EAB.binding_chains(), EAB.dreamlock()]
	f.flavor_text = "A specialist in containment, weaving chains of dream-thread that lock the mind in place. Those caught in its dreamlock cannot flee, attack, or even think of escape."
	return f


static func create_thread_anchor(n: String, lvl: int = 16) -> FighterData:
	var f := _base(n, "Thread Anchor", lvl)
	f.health = _es(624, 718, 5, 8, lvl, 16); f.max_health = f.health
	f.mana = _es(17, 20, 1, 2, lvl, 16); f.max_mana = f.mana
	f.physical_attack = _es(10, 14, 0, 2, lvl, 16)
	f.physical_defense = _es(46, 55, 2, 4, lvl, 16)
	f.magic_attack = _es(100, 115, 3, 5, lvl, 16)
	f.magic_defense = _es(53, 62, 2, 4, lvl, 16)
	f.speed = _es(33, 40, 2, 3, lvl, 16)
	f.crit_chance = 14; f.crit_damage = 2; f.dodge_chance = 30
	f.abilities = [EAB.anchor_pulse(), EAB.fortifying_thread()]
	f.flavor_text = "A massive knot of condensed dream-thread that anchors the cathedral to the waking world. It pulses with stabilizing energy and fortifies all nearby cult forces."
	return f


# =============================================================================
# Prog 17: Lira boss and minions (S3_B_DreamNexus)
# Target 42%, 18 level-ups (final boss)
# =============================================================================

static func create_lira_threadmaster(n: String, lvl: int = 18) -> FighterData:
	var f := _base(n, "Lira, the Threadmaster", lvl)
	f.health = _es(780, 880, 8, 12, lvl, 18); f.max_health = f.health
	f.mana = _es(25, 30, 2, 3, lvl, 18); f.max_mana = f.mana
	f.physical_attack = _es(92, 106, 3, 5, lvl, 18)
	f.physical_defense = _es(50, 58, 2, 4, lvl, 18)
	f.magic_attack = _es(112, 128, 4, 6, lvl, 18)
	f.magic_defense = _es(52, 60, 2, 4, lvl, 18)
	f.speed = _es(36, 42, 3, 4, lvl, 18)
	f.crit_chance = 18; f.crit_damage = 4; f.dodge_chance = 21
	f.abilities = [EAB.thread_puppetry(), EAB.dreamers_harvest(), EAB.liras_loom()]
	f.flavor_text = "Lira revealed as the true Threadmaster, her gentle demeanor shed to expose the master weaver beneath. She commands the loom with absolute authority, puppeting dreams and harvesting the sleeping minds of an entire town."
	return f


static func create_tattered_deception(n: String, lvl: int = 18) -> FighterData:
	var f := _base(n, "Tattered Deception", lvl)
	f.health = _es(440, 506, 5, 8, lvl, 18); f.max_health = f.health
	f.mana = _es(18, 22, 1, 2, lvl, 18); f.max_mana = f.mana
	f.physical_attack = _es(10, 14, 0, 2, lvl, 18)
	f.physical_defense = _es(34, 42, 2, 3, lvl, 18)
	f.magic_attack = _es(97, 112, 3, 6, lvl, 18)
	f.magic_defense = _es(44, 52, 2, 4, lvl, 18)
	f.speed = _es(38, 44, 3, 4, lvl, 18)
	f.crit_chance = 18; f.crit_damage = 3; f.dodge_chance = 28
	f.abilities = [EAB.mirrored_assault(), EAB.unraveling_touch()]
	f.flavor_text = "A conjured illusion woven from stolen faces and borrowed memories. It mimics the party's own tactics with uncanny precision, unraveling defenses with every touch."
	return f


static func create_dream_bastion(n: String, lvl: int = 18) -> FighterData:
	var f := _base(n, "Dream Bastion", lvl)
	f.health = _es(560, 642, 6, 9, lvl, 18); f.max_health = f.health
	f.mana = _es(8, 11, 1, 1, lvl, 18); f.max_mana = f.mana
	f.physical_attack = _es(107, 123, 3, 5, lvl, 18)
	f.physical_defense = _es(54, 62, 2, 4, lvl, 18)
	f.magic_attack = _es(8, 12, 0, 1, lvl, 18)
	f.magic_defense = _es(46, 54, 2, 4, lvl, 18)
	f.speed = _es(28, 34, 2, 3, lvl, 18)
	f.crit_chance = 16; f.crit_damage = 3; f.dodge_chance = 11
	f.abilities = [EAB.bastion_slam(), EAB.nexus_shield()]
	f.flavor_text = "A fortress of solidified dream-thread that guards the nexus of Lira's power. It absorbs punishment meant for its master and retaliates with devastating force."
	return f
