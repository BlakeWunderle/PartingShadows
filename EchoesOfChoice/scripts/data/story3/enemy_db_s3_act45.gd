class_name EnemyDBS3Act45

## Story 3 Acts IV-V enemy factory. Cult members and the Threadmaster.
## T2 rebalance: stats scaled to match T2 player power levels.

const FighterData := preload("res://scripts/data/fighter_data.gd")
const EAB := preload("res://scripts/data/story3/enemy_ability_db_s3.gd")
const EH := preload("res://scripts/data/enemy_helpers.gd")


# =============================================================================
# Acts IV-V: Cult members (Progression 14-17)
# Prog 14 (S3_CultUnderbelly): target 48%, 15 level-ups
# Prog 15 (S3_CultCatacombs): target 46%, 16 level-ups
# Prog 16 (S3_CultRitualChamber): target 44%, 17 level-ups
# Prog 17 (S3_DreamNexus): target 42%, 18 level-ups (final boss)
# =============================================================================

# Prog 14 -- mage acolyte (level 15)
static func create_cult_acolyte(n: String, lvl: int = 15) -> FighterData:
	var f := EH.base(n, "Cult Acolyte", lvl)
	f.health = EH.es(582, 669, 5, 8, lvl, 15); f.max_health = f.health
	f.mana = EH.es(19, 23, 1, 2, lvl, 15); f.max_mana = f.mana
	f.physical_attack = EH.es(10, 14, 0, 2, lvl, 15)
	f.physical_defense = EH.es(38, 47, 2, 3, lvl, 15)
	f.magic_attack = EH.es(106, 122, 3, 5, lvl, 15)
	f.magic_defense = EH.es(47, 57, 2, 4, lvl, 15)
	f.speed = EH.es(36, 43, 2, 3, lvl, 15)
	f.crit_chance = 17; f.crit_damage = 3; f.dodge_chance = 34
	f.abilities = [EAB.thread_sear(), EAB.zealots_fervor()]
	f.flavor_text = "A junior member of the Thread cult, burning with fanatical devotion. Their searing thread-magic is crude but powerful, fueled by unshakable belief in the Threadmaster's vision."
	return f


# Prog 14 -- physical enforcer (level 15)
static func create_cult_enforcer(n: String, lvl: int = 15) -> FighterData:
	var f := EH.base(n, "Cult Enforcer", lvl)
	f.health = EH.es(693, 793, 6, 9, lvl, 15); f.max_health = f.health
	f.mana = EH.es(8, 11, 1, 1, lvl, 15); f.max_mana = f.mana
	f.physical_attack = EH.es(110, 126, 3, 5, lvl, 15)
	f.physical_defense = EH.es(53, 61, 2, 4, lvl, 15)
	f.magic_attack = EH.es(8, 12, 0, 1, lvl, 15)
	f.magic_defense = EH.es(43, 51, 2, 3, lvl, 15)
	f.speed = EH.es(30, 36, 2, 3, lvl, 15)
	f.crit_chance = 18; f.crit_damage = 3; f.dodge_chance = 28
	f.abilities = [EAB.thread_laced_fist(), EAB.threaded_sinew()]
	f.flavor_text = "A heavily muscled enforcer whose body is laced with dream-threads that harden like steel beneath the skin. The cult sends them to silence anyone who asks too many questions."
	return f


# Prog 14 -- glass cannon hexer (level 15)
static func create_cult_hexer(n: String, lvl: int = 15) -> FighterData:
	var f := EH.base(n, "Cult Hexer", lvl)
	f.health = EH.es(495, 572, 4, 7, lvl, 15); f.max_health = f.health
	f.mana = EH.es(19, 23, 1, 2, lvl, 15); f.max_mana = f.mana
	f.physical_attack = EH.es(10, 14, 0, 2, lvl, 15)
	f.physical_defense = EH.es(32, 40, 1, 3, lvl, 15)
	f.magic_attack = EH.es(108, 124, 3, 5, lvl, 15)
	f.magic_defense = EH.es(45, 55, 2, 4, lvl, 15)
	f.speed = EH.es(39, 45, 2, 3, lvl, 15)
	f.crit_chance = 18; f.crit_damage = 3; f.dodge_chance = 38
	f.abilities = [EAB.hex_bolt(), EAB.curse()]
	f.flavor_text = "A spellcaster who has traded sanity for power, channeling hexes drawn from the darkest layers of the dream. Their curses linger long after the battle ends."
	return f


# Shared Prog 15 & 16 -- physical guard (level 16)
static func create_thread_guard(n: String, lvl: int = 16) -> FighterData:
	var f := EH.base(n, "Thread Guard", lvl)
	f.health = EH.es(660, 754, 6, 9, lvl, 16); f.max_health = f.health
	f.mana = EH.es(8, 11, 1, 1, lvl, 16); f.max_mana = f.mana
	f.physical_attack = EH.es(111, 127, 3, 5, lvl, 16)
	f.physical_defense = EH.es(55, 64, 2, 4, lvl, 16)
	f.magic_attack = EH.es(8, 12, 0, 1, lvl, 16)
	f.magic_defense = EH.es(44, 53, 2, 3, lvl, 16)
	f.speed = EH.es(26, 32, 1, 2, lvl, 16)
	f.crit_chance = 18; f.crit_damage = 3; f.dodge_chance = 12
	f.abilities = [EAB.threaded_blade(), EAB.woven_shield()]
	f.flavor_text = "An elite warrior who wields a blade wrapped in shimmering dream-thread. Their woven shield can absorb tremendous punishment, making them the cult's frontline defender."
	return f


# Prog 15 -- fast agile hound (level 16)
static func create_dream_hound(n: String, lvl: int = 16) -> FighterData:
	var f := EH.base(n, "Dream Hound", lvl)
	f.health = EH.es(494, 569, 5, 8, lvl, 16); f.max_health = f.health
	f.mana = EH.es(8, 11, 1, 1, lvl, 16); f.max_mana = f.mana
	f.physical_attack = EH.es(102, 118, 3, 5, lvl, 16)
	f.physical_defense = EH.es(38, 45, 2, 3, lvl, 16)
	f.magic_attack = EH.es(8, 12, 0, 1, lvl, 16)
	f.magic_defense = EH.es(36, 43, 2, 3, lvl, 16)
	f.speed = EH.es(40, 46, 3, 4, lvl, 16)
	f.crit_chance = 17; f.crit_damage = 3; f.dodge_chance = 18
	f.abilities = [EAB.feral_bite(), EAB.dream_howl()]
	f.flavor_text = "A sleek beast bred in the cult's dream kennels, trained to hunt by scent of thought. It is blindingly fast and attacks with savage, coordinated ferocity."
	return f


# Prog 16 -- mage ritualist (level 17)
static func create_cult_ritualist(n: String, lvl: int = 17) -> FighterData:
	var f := EH.base(n, "Cult Ritualist", lvl)
	f.health = EH.es(571, 657, 5, 8, lvl, 17); f.max_health = f.health
	f.mana = EH.es(20, 24, 1, 2, lvl, 17); f.max_mana = f.mana
	f.physical_attack = EH.es(10, 14, 0, 2, lvl, 17)
	f.physical_defense = EH.es(44, 54, 2, 4, lvl, 17)
	f.magic_attack = EH.es(107, 123, 3, 6, lvl, 17)
	f.magic_defense = EH.es(56, 64, 2, 4, lvl, 17)
	f.speed = EH.es(36, 42, 2, 3, lvl, 17)
	f.crit_chance = 18; f.crit_damage = 3; f.dodge_chance = 22
	f.abilities = [EAB.thread_lash(), EAB.ritual_chant()]
	f.flavor_text = "A senior cultist who leads the binding rituals at the heart of the Thread cult's operations. Their chants strengthen the weave and lash at any who would disrupt the ceremony."
	return f


# Prog 16 -- mage glass cannon (level 17)
static func create_high_weaver(n: String, lvl: int = 17) -> FighterData:
	var f := EH.base(n, "High Weaver", lvl)
	f.health = EH.es(506, 583, 5, 8, lvl, 17); f.max_health = f.health
	f.mana = EH.es(22, 25, 2, 3, lvl, 17); f.max_mana = f.mana
	f.physical_attack = EH.es(10, 14, 0, 2, lvl, 17)
	f.physical_defense = EH.es(38, 46, 2, 3, lvl, 17)
	f.magic_attack = EH.es(111, 128, 3, 6, lvl, 17)
	f.magic_defense = EH.es(54, 62, 2, 4, lvl, 17)
	f.speed = EH.es(38, 44, 2, 3, lvl, 17)
	f.crit_chance = 19; f.crit_damage = 3; f.dodge_chance = 25
	f.abilities = [EAB.loom_blast(), EAB.unweave()]
	f.flavor_text = "One of the Threadmaster's inner circle, a master of the loom's destructive potential. They can unweave the protections of their enemies with a gesture and blast them with raw dream-force."
	return f


# Prog 17 boss minion -- fast magic DPS (level 18)
static func create_shadow_fragment(n: String, lvl: int = 18) -> FighterData:
	var f := EH.base(n, "Shadow Fragment", lvl)
	f.health = EH.es(453, 521, 5, 8, lvl, 18); f.max_health = f.health
	f.mana = EH.es(18, 22, 1, 2, lvl, 18); f.max_mana = f.mana
	f.physical_attack = EH.es(10, 14, 0, 2, lvl, 18)
	f.physical_defense = EH.es(36, 44, 2, 3, lvl, 18)
	f.magic_attack = EH.es(99, 114, 3, 6, lvl, 18)
	f.magic_defense = EH.es(46, 55, 2, 4, lvl, 18)
	f.speed = EH.es(38, 44, 3, 4, lvl, 18)
	f.crit_chance = 20; f.crit_damage = 3; f.dodge_chance = 29
	f.abilities = [EAB.shadow_lash(), EAB.consume_light()]
	f.flavor_text = "A splinter of the Threadmaster's own shadow, given independent will. It devours light and hope in equal measure, weakening enemies before the final confrontation."
	return f


# Prog 17 boss -- The Threadmaster (level 18)
static func create_the_threadmaster(n: String, lvl: int = 18) -> FighterData:
	var f := EH.base(n, "The Threadmaster", lvl)
	f.health = EH.es(802, 906, 8, 12, lvl, 18); f.max_health = f.health
	f.mana = EH.es(25, 30, 2, 3, lvl, 18); f.max_mana = f.mana
	f.physical_attack = EH.es(93, 108, 3, 5, lvl, 18)
	f.physical_defense = EH.es(53, 61, 2, 4, lvl, 18)
	f.magic_attack = EH.es(114, 130, 4, 6, lvl, 18)
	f.magic_defense = EH.es(55, 63, 2, 4, lvl, 18)
	f.speed = EH.es(36, 42, 3, 4, lvl, 18)
	f.crit_chance = 20; f.crit_damage = 4; f.dodge_chance = 22
	f.abilities = [EAB.dream_shatter(), EAB.loom_collapse(), EAB.thread_of_oblivion()]
	f.flavor_text = "The architect of the Woven Night, a figure who has spent a lifetime learning to reshape reality through the fabric of dreams. To face them is to challenge the dreaming world itself."
	return f
