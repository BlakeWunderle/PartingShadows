class_name EnemyRoles

## Combat role, subtype, damage type, and threat tier metadata for all enemies.
## Auto-inferred from abilities/stats, with manual boss/elite/underling overrides.

const R := Enums.Role
const S := Enums.Subtype
const D := Enums.DamageType
const T := Enums.EnemyTier

## Each entry: { "roles": Array, "subtypes": Array, "damage": DamageType, "tier": EnemyTier }
## Only non-default fields need to be present. Defaults: roles=[FIGHTER], subtypes=[], damage=PHYSICAL, tier=STANDARD
const _DATA: Dictionary = {
	# ==========================================================================
	# Story 1 - Act I
	# ==========================================================================
	"Thug": {},
	"Ruffian": { "s": [S.DEBUFFER] },
	"Pickpocket": { "s": [S.DEBUFFER] },
	"Wolf": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER] },
	"Boar": {},
	"Thornviper": { "s": [S.DOT, S.GLASS_CANNON], "d": D.MIXED },
	"Goblin": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER] },
	"Hound": { "d": D.MAGICAL },
	"Bandit": {},

	# ==========================================================================
	# Story 1 - Act II
	# ==========================================================================
	"Raider": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER, S.AOE, S.CRIT] },
	"Orc": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER, S.CRIT] },
	"Troll": { "r": [R.SUPPORT, R.TANK, R.FIGHTER], "s": [S.HEALER, S.AOE], "t": T.LEADER },
	"Harpy": { "s": [S.DEBUFFER, S.AOE, S.EVASION], "d": D.MIXED },
	"Witch": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER, S.DEBUFFER, S.GLASS_CANNON], "d": D.MAGICAL },
	"Wisp": { "s": [S.DEBUFFER, S.GLASS_CANNON], "d": D.MAGICAL },
	"Sprite": { "s": [S.DEBUFFER, S.GLASS_CANNON] },
	"Siren": { "s": [S.DEBUFFER, S.GLASS_CANNON], "d": D.MAGICAL },
	"Merfolk": { "s": [S.AOE, S.GLASS_CANNON], "d": D.MIXED },
	"Captain": { "r": [R.SUPPORT, R.TANK, R.FIGHTER], "s": [S.BUFFER, S.AOE, S.CRIT, S.EVASION], "t": T.LEADER },
	"Pirate": { "s": [S.DEBUFFER, S.EVASION, S.CRIT] },
	"Fire Wyrmling": { "d": D.MAGICAL },
	"Frost Wyrmling": { "s": [S.DEBUFFER] },
	"Ringmaster": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER, S.DEBUFFER, S.GLASS_CANNON, S.EVASION], "d": D.MIXED, "t": T.LEADER },
	"Harlequin": { "s": [S.DEBUFFER, S.GLASS_CANNON], "d": D.MAGICAL },
	"Chanteuse": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.HEALER, S.DEBUFFER, S.GLASS_CANNON, S.CRIT], "d": D.MAGICAL },
	"Android": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER, S.GLASS_CANNON], "d": D.MIXED },
	"Machinist": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER, S.DEBUFFER, S.AOE, S.GLASS_CANNON], "d": D.MIXED },
	"Ironclad": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER, S.AOE] },
	"Commander": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER], "t": T.LEADER },
	"Draconian": { "s": [S.GLASS_CANNON], "d": D.MIXED },
	"Chaplain": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.HEALER], "d": D.MAGICAL },
	"Zombie": { "s": [S.GLASS_CANNON, S.EVASION] },
	"Ghoul": { "s": [S.EVASION], "d": D.MIXED },
	"Shade": { "s": [S.DEBUFFER, S.GLASS_CANNON, S.EVASION], "d": D.MAGICAL },
	"Wraith": { "s": [S.DRAIN, S.EVASION], "d": D.MAGICAL },

	# ==========================================================================
	# Story 1 - Acts III-V
	# ==========================================================================
	"Royal Guard": { "r": [R.TANK, R.FIGHTER], "s": [S.CRIT, S.EVASION] },
	"Guard Sergeant": { "r": [R.SUPPORT, R.TANK, R.FIGHTER], "s": [S.BUFFER, S.CRIT, S.EVASION] },
	"Guard Archer": { "s": [S.DEBUFFER, S.AOE, S.CRIT, S.EVASION] },
	"Stranger": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER, S.DEBUFFER, S.DRAIN, S.AOE, S.CRIT, S.EVASION], "d": D.MAGICAL, "t": T.BOSS },
	"StrangerFinal": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER, S.DRAIN, S.AOE, S.CRIT, S.EVASION], "d": D.MAGICAL, "t": T.BOSS },
	"Lich": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER, S.DRAIN, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Ghast": { "s": [S.DOT, S.AOE, S.CRIT] },
	"Demon": { "s": [S.DEBUFFER, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Corrupted Treant": { "r": [R.TANK, R.FIGHTER], "s": [S.AOE, S.CRIT] },
	"Hellion": { "s": [S.DEBUFFER, S.GLASS_CANNON, S.CRIT] },
	"Fiendling": { "s": [S.DEBUFFER, S.CRIT], "d": D.MAGICAL },
	"Dragon": { "s": [S.DEBUFFER, S.CRIT], "d": D.MAGICAL, "t": T.LEADER },
	"Blighted Stag": { "s": [S.DOT, S.AOE, S.CRIT] },
	"Dark Knight": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER, S.AOE, S.CRIT, S.EVASION], "t": T.LEADER },
	"Fell Hound": { "s": [S.DEBUFFER, S.AOE, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Sigil Wretch": { "r": [R.TANK, R.FIGHTER], "s": [S.DEBUFFER, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Tunnel Lurker": { "r": [R.TANK, R.FIGHTER], "s": [S.DEBUFFER, S.DOT, S.AOE, S.CRIT, S.EVASION] },

	# ==========================================================================
	# Story 1 - Act V Path B
	# ==========================================================================
	"Sigil Colossus": { "r": [R.SUPPORT, R.TANK, R.FIGHTER], "s": [S.BUFFER, S.AOE, S.CRIT, S.EVASION] },
	"Ritual Conduit": { "r": [R.SUPPORT, R.TANK, R.FIGHTER], "s": [S.BUFFER, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Void Sentinel": { "s": [S.DEBUFFER, S.AOE, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Void Horror": { "r": [R.TANK, R.FIGHTER], "s": [S.DEBUFFER, S.AOE, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Fractured Shadow": { "s": [S.DEBUFFER, S.CRIT, S.EVASION] },
	"Shadow Remnant": { "r": [R.TANK, R.FIGHTER], "s": [S.DEBUFFER, S.AOE, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"StrangerUndone": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER, S.DRAIN, S.AOE, S.CRIT, S.EVASION], "d": D.MIXED, "t": T.BOSS },

	# ==========================================================================
	# Story 2 - Act I
	# ==========================================================================
	"Glow Worm": { "s": [S.DEBUFFER], "d": D.MAGICAL },
	"Crystal Spider": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER] },
	"Shade Crawler": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER, S.GLASS_CANNON], "d": D.MIXED },
	"Cavern Snapper": { "r": [R.TANK, R.FIGHTER] },
	"Echo Wisp": { "s": [S.DEBUFFER, S.AOE], "d": D.MAGICAL },
	"Spore Stalker": { "s": [S.DOT], "d": D.MIXED },
	"Fungal Hulk": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER] },
	"Cap Wisp": { "s": [S.DEBUFFER, S.AOE], "d": D.MAGICAL },
	"Cave Eel": { "s": [S.AOE, S.GLASS_CANNON], "d": D.MIXED },
	"Blind Angler": { "s": [S.DEBUFFER], "d": D.MAGICAL },
	"Silt Lurker": { "s": [S.GLASS_CANNON] },
	"Cave Dweller": { "s": [S.AOE] },
	"Tunnel Shaman": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER], "d": D.MAGICAL },
	"Burrow Scout": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER, S.EVASION] },
	"Cave Maw": { "s": [S.AOE] },
	"Vein Leech": { "s": [S.DEBUFFER, S.DRAIN, S.GLASS_CANNON] },
	"Stone Moth": { "s": [S.DEBUFFER, S.AOE, S.GLASS_CANNON], "d": D.MAGICAL },

	# ==========================================================================
	# Story 2 - Act II
	# ==========================================================================
	"Driftwood Bandit": { "s": [S.DRAIN, S.CRIT, S.EVASION] },
	"Saltrunner Smuggler": { "s": [S.DEBUFFER, S.CRIT, S.EVASION] },
	"Tide Warden": { "r": [R.TANK, R.FIGHTER], "s": [S.CRIT, S.EVASION] },
	"Blighted Gull": { "s": [S.AOE, S.EVASION], "d": D.MAGICAL },
	"Shore Crawler": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER, S.CRIT] },
	"Warped Hound": { "s": [S.DEBUFFER, S.AOE, S.CRIT, S.EVASION] },
	"Tideside Channeler": { "s": [S.DOT, S.GLASS_CANNON], "d": D.MAGICAL },
	"Reef Shaman": { "s": [S.GLASS_CANNON, S.AOE], "d": D.MAGICAL },
	"Bilge Rat": { "s": [S.DOT] },
	"Blackwater Captain": { "r": [R.SUPPORT, R.TANK, R.FIGHTER], "s": [S.BUFFER, S.CRIT, S.EVASION], "t": T.LEADER },
	"Corsair Hexer": { "r": [R.TANK, R.FIGHTER], "s": [S.DEBUFFER, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Abyssal Lurker": { "r": [R.TANK, R.FIGHTER], "s": [S.DRAIN, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Stormwrack Raptor": { "s": [S.DEBUFFER, S.AOE, S.CRIT, S.EVASION] },
	"Tidecaller Revenant": { "r": [R.SUPPORT, R.TANK, R.FIGHTER], "s": [S.BUFFER, S.DRAIN, S.AOE, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Salt Phantom": { "r": [R.TANK, R.FIGHTER], "s": [S.DEBUFFER, S.AOE, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Drowned Sailor": { "s": [S.DEBUFFER, S.DOT, S.CRIT, S.EVASION], "d": D.MIXED },
	"Depth Horror": { "s": [S.DEBUFFER, S.DRAIN, S.AOE, S.CRIT, S.EVASION], "d": D.MAGICAL },

	# ==========================================================================
	# Story 2 - Act III
	# ==========================================================================
	"Echo Sentinel": { "r": [R.SUPPORT, R.TANK, R.FIGHTER], "s": [S.BUFFER, S.CRIT, S.EVASION] },
	"Thought Eater": { "s": [S.DRAIN, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Grief Shade": { "r": [R.DPS], "s": [S.AOE, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Hollow Watcher": { "r": [R.TANK, R.FIGHTER], "s": [S.DEBUFFER, S.CRIT, S.EVASION] },
	"Mirror Self": { "r": [R.DPS], "s": [S.CRIT, S.EVASION] },
	"Void Weaver": { "r": [R.DPS], "s": [S.DEBUFFER, S.AOE, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Mnemonic Golem": { "r": [R.SUPPORT, R.TANK, R.FIGHTER], "s": [S.BUFFER, S.CRIT, S.EVASION], "t": T.LEADER },
	"The Warden": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER, S.DEBUFFER, S.AOE, S.CRIT, S.EVASION], "d": D.MAGICAL, "t": T.BOSS },
	"Fractured Protector": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.HEALER, S.DEBUFFER, S.DRAIN, S.AOE, S.CRIT, S.EVASION], "d": D.MIXED, "t": T.UNDERLING },
	"Fading Wisp": { "s": [S.DEBUFFER, S.AOE, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Dim Guardian": { "r": [R.SUPPORT, R.TANK, R.FIGHTER], "s": [S.BUFFER, S.CRIT, S.EVASION] },
	"Ward Construct": { "r": [R.SUPPORT, R.TANK, R.FIGHTER], "s": [S.BUFFER, S.CRIT, S.EVASION] },
	"Null Phantom": { "r": [R.TANK, R.FIGHTER], "s": [S.DEBUFFER, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Threshold Echo": { "s": [S.DEBUFFER, S.GLASS_CANNON, S.CRIT, S.EVASION], "d": D.MIXED },
	"Ink Devourer": { "r": [R.DPS], "s": [S.DRAIN, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Silent Archivist": { "r": [R.SUPPORT], "s": [S.DEBUFFER, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Lost Record": { "s": [S.DEBUFFER, S.DOT, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Maw Codex": { "r": [R.DPS], "s": [S.AOE, S.CRIT, S.EVASION] },
	"Shattered Frame": { "r": [R.DPS], "s": [S.DEBUFFER, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Sorrow Shade": { "r": [R.DPS], "s": [S.CRIT, S.EVASION], "d": D.MAGICAL },

	# ==========================================================================
	# Story 2 - Act IV
	# ==========================================================================
	"Pupil Leech": { "r": [R.TANK, R.FIGHTER], "s": [S.DOT, S.DRAIN, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Gaze Stalker": { "r": [R.BURST], "s": [S.DEBUFFER, S.CRIT, S.EVASION], "d": D.MIXED },
	"Memory Harvester": { "r": [R.DPS], "s": [S.DRAIN, S.AOE, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Oblivion Shade": { "r": [R.DPS], "s": [S.DEBUFFER, S.AOE, S.GLASS_CANNON, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Memory Reaper": { "r": [R.DPS], "s": [S.DOT, S.AOE, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Void Iris": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.HEALER, S.BUFFER, S.DEBUFFER, S.AOE, S.CRIT, S.EVASION], "d": D.MAGICAL, "t": T.UNDERLING },
	"Thoughtform Knight": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER, S.CRIT, S.EVASION] },
	"The Iris": { "r": [R.SUPPORT, R.TANK, R.FIGHTER], "s": [S.BUFFER, S.DEBUFFER, S.AOE, S.CRIT, S.EVASION], "d": D.MAGICAL, "t": T.BOSS },
	"The Lidless Eye": { "r": [R.BURST], "s": [S.DOT, S.AOE, S.CRIT, S.EVASION], "d": D.PHYSICAL, "t": T.BOSS },

	# ==========================================================================
	# Story 2 - Path B
	# ==========================================================================
	"Fractured Scholar": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER, S.DRAIN, S.CRIT, S.EVASION] },
	"Archive Sentinel": { "r": [R.TANK, R.FIGHTER], "s": [S.DEBUFFER, S.CRIT, S.EVASION] },
	"Pipeline Warden": { "r": [R.DPS], "s": [S.AOE, S.CRIT, S.EVASION] },
	"Maintenance Drone": { "r": [R.DPS], "s": [S.CRIT, S.EVASION], "d": D.MIXED },
	"Resonance Node": { "r": [R.DPS], "s": [S.DEBUFFER, S.AOE, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Eye's Fist": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER, S.CRIT, S.EVASION], "t": T.LEADER },
	"Null Sentinel": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Overload Spark": { "r": [R.BURST], "s": [S.DEBUFFER, S.AOE, S.CRIT, S.EVASION], "d": D.MIXED },
	"Memory Torrent": { "r": [R.DPS], "s": [S.AOE, S.GLASS_CANNON, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Unleashed Recollection": { "s": [S.DEBUFFER, S.CRIT, S.EVASION] },
	"Rage Fragment": { "r": [R.BURST], "s": [S.AOE, S.GLASS_CANNON, S.CRIT, S.EVASION], "d": D.MIXED },
	"The Unblinking Eye": { "s": [S.DEBUFFER, S.DRAIN, S.AOE, S.CRIT, S.EVASION], "d": D.MAGICAL, "t": T.BOSS },

	# ==========================================================================
	# Story 3 - Acts I-II
	# ==========================================================================
	"Dream Wisp": { "s": [S.DEBUFFER], "d": D.MIXED },
	"Phantasm": { "s": [S.DEBUFFER], "d": D.MIXED },
	"Shade Moth": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER], "d": D.MIXED },
	"Sleep Stalker": {},
	"Mirror Shade": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER], "d": D.MIXED },
	"Slumber Beast": { "s": [S.DEBUFFER, S.AOE] },
	"Fog Wraith": { "s": [S.AOE], "d": D.MAGICAL },
	"Thorn Dreamer": { "s": [S.DEBUFFER, S.DOT, S.AOE], "d": D.MIXED },
	"Nightmare Hound": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER] },
	"Dream Weaver": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER], "d": D.MAGICAL },
	"Hollow Echo": { "s": [S.DEBUFFER, S.DRAIN, S.GLASS_CANNON] },
	"Somnolent Serpent": { "s": [S.DEBUFFER, S.DOT, S.CRIT] },
	"Twilight Stalker": { "s": [S.CRIT] },
	"Waking Terror": { "r": [R.TANK, R.FIGHTER], "s": [S.AOE, S.CRIT], "d": D.MAGICAL },
	"Dusk Sentinel": { "s": [S.AOE, S.CRIT] },
	"Clock Specter": { "s": [S.AOE, S.CRIT], "d": D.MIXED },
	"The Nightmare": { "s": [S.DEBUFFER, S.AOE, S.CRIT], "d": D.MIXED, "t": T.BOSS },
	"Nightmare Guard": { "s": [S.GLASS_CANNON, S.AOE] },
	"Void Echo": { "s": [S.GLASS_CANNON, S.AOE, S.CRIT], "d": D.MAGICAL },
	"Shattered Hourglass": { "s": [S.DOT, S.DRAIN], "d": D.MAGICAL },

	# ==========================================================================
	# Story 3 - Act II expansion
	# ==========================================================================
	"Thread Lurker": { "s": [S.DEBUFFER, S.CRIT, S.EVASION] },
	"Dream Sentinel": { "r": [R.SUPPORT, R.TANK, R.FIGHTER], "s": [S.BUFFER] },
	"Gloom Spinner": { "s": [S.DEBUFFER, S.AOE], "d": D.MAGICAL },
	"Drowned Reverie": { "s": [S.DRAIN, S.AOE], "d": D.MAGICAL },
	"Riptide Beast": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER] },
	"Depth Crawler": { "s": [S.DOT], "d": D.MIXED },
	"Fragment Golem": { "r": [R.TANK, R.FIGHTER], "s": [S.CRIT] },
	"Portrait Wight": { "r": [R.SUPPORT, R.TANK], "s": [S.BUFFER], "d": D.MAGICAL },
	"Gallery Shade": { "s": [S.DEBUFFER, S.CRIT] },
	"Shadow Pursuer": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER, S.DEBUFFER, S.AOE, S.CRIT, S.EVASION] },
	"Dread Tendril": { "s": [S.DEBUFFER, S.AOE, S.CRIT], "d": D.MAGICAL },
	"Faded Voice": { "s": [S.DEBUFFER, S.AOE, S.CRIT, S.EVASION] },
	"Market Watcher": { "r": [R.TANK, R.FIGHTER], "s": [S.DEBUFFER], "t": T.LEADER },
	"Thread Smith": { "r": [R.SUPPORT, R.FIGHTER], "s": [S.BUFFER] },
	"Hex Herbalist": { "s": [S.DOT], "d": D.MAGICAL },
	"Cellar Watcher": { "s": [S.DEBUFFER, S.CRIT], "d": D.MIXED },
	"Thread Construct": { "r": [R.TANK, R.FIGHTER], "s": [S.DEBUFFER, S.CRIT] },
	"Ink Shade": { "d": D.MAGICAL },

	# ==========================================================================
	# Story 3 - Act III
	# ==========================================================================
	"Lucid Phantom": { "d": D.MAGICAL },
	"Thread Spinner": { "r": [R.SUPPORT, R.TANK, R.FIGHTER], "s": [S.BUFFER, S.DEBUFFER], "d": D.MAGICAL },
	"Loom Sentinel": { "r": [R.TANK, R.FIGHTER] },
	"Cult Shade": { "s": [S.DEBUFFER], "d": D.MAGICAL },
	"Dream Warden": { "s": [S.DEBUFFER, S.CRIT], "d": D.MAGICAL },
	"Thought Leech": { "r": [R.SUPPORT], "s": [S.DEBUFFER, S.DRAIN, S.AOE], "d": D.MAGICAL },
	"Void Spinner": { "s": [S.DEBUFFER, S.AOE], "d": D.MAGICAL },
	"Sanctum Guardian": { "s": [S.DEBUFFER, S.AOE, S.CRIT], "d": D.MIXED, "t": T.BOSS },

	# ==========================================================================
	# Story 3 - Acts IV-V
	# ==========================================================================
	"Cult Acolyte": { "r": [R.DPS], "s": [S.EVASION], "d": D.MIXED },
	"Cult Enforcer": { "r": [R.TANK, R.FIGHTER], "s": [S.DEBUFFER, S.DRAIN, S.AOE, S.EVASION] },
	"Cult Hexer": { "s": [S.DEBUFFER, S.EVASION], "d": D.MAGICAL },
	"Thread Guard": { "s": [S.DEBUFFER, S.AOE] },
	"Dream Hound": { "s": [S.DEBUFFER, S.AOE] },
	"Cult Ritualist": { "s": [S.DEBUFFER, S.AOE], "d": D.MAGICAL },
	"High Weaver": { "s": [S.DEBUFFER, S.EVASION], "d": D.MAGICAL },
	"Shadow Fragment": { "s": [S.DEBUFFER, S.AOE, S.CRIT, S.EVASION], "d": D.MAGICAL, "t": T.UNDERLING },
	"The Threadmaster": { "s": [S.DEBUFFER, S.DRAIN, S.AOE, S.CRIT, S.EVASION], "d": D.PHYSICAL, "t": T.BOSS },
	"DreadTailor": { "r": [R.DPS], "s": [S.AOE] },
	"NeedleWraith": { "r": [R.DPS], "s": [S.GLASS_CANNON, S.AOE] },
	"LoomCrusher": { "r": [R.TANK, R.FIGHTER] },
	"Ritual Guardian": { "r": [R.TANK, R.FIGHTER], "s": [S.DEBUFFER, S.AOE] },
	"Thread Stitcher": { "r": [R.DPS], "s": [S.DOT], "d": D.MAGICAL },

	# ==========================================================================
	# Story 3 - Path B
	# ==========================================================================
	"Cellar Sentinel": { "r": [R.TANK, R.FIGHTER], "s": [S.DEBUFFER, S.AOE], "d": D.MIXED },
	"Bound Stalker": { "s": [S.DOT] },
	"Thread Disciple": { "s": [S.DRAIN], "d": D.MIXED },
	"Thread Warden": { "r": [R.TANK, R.FIGHTER] },
	"Tunnel Sentinel": { "s": [S.DEBUFFER, S.AOE] },
	"Thread Sniper": { "s": [S.DEBUFFER], "d": D.MAGICAL },
	"Pale Devotee": { "r": [R.SUPPORT], "s": [S.DEBUFFER, S.DOT, S.AOE], "d": D.MAGICAL },
	"Thread Ritualist": { "s": [S.DEBUFFER, S.AOE], "d": D.MIXED },
	"Passage Guardian": { "r": [R.TANK, R.FIGHTER], "s": [S.DEBUFFER] },
	"Warding Shadow": { "r": [R.SUPPORT], "s": [S.DEBUFFER], "d": D.MAGICAL },
	"Shadow Innkeeper": { "s": [S.DRAIN, S.CRIT], "d": D.MIXED },
	"Astral Weaver": { "r": [R.SUPPORT], "s": [S.DEBUFFER, S.AOE, S.CRIT], "d": D.MAGICAL },
	"Loom Tendril": { "s": [S.DEBUFFER, S.DOT, S.DRAIN, S.CRIT], "d": D.MAGICAL },
	"Cathedral Warden": { "r": [R.DPS], "s": [S.AOE, S.CRIT, S.EVASION], "d": D.MIXED },
	"Dream Binder": { "s": [S.DEBUFFER, S.DOT, S.AOE, S.EVASION], "d": D.MAGICAL },
	"Thread Anchor": { "r": [R.TANK, R.FIGHTER], "s": [S.DEBUFFER, S.AOE, S.EVASION], "d": D.MIXED },
	"Lira, the Threadmaster": { "s": [S.DEBUFFER, S.DRAIN, S.AOE, S.EVASION], "d": D.MIXED, "t": T.BOSS },
	"Tattered Deception": { "s": [S.DEBUFFER, S.EVASION], "d": D.MIXED, "t": T.UNDERLING },
	"Dream Bastion": { "r": [R.TANK, R.FIGHTER], "s": [S.AOE], "d": D.MIXED, "t": T.UNDERLING },
	"WeftStalker": { "s": [S.DEBUFFER, S.AOE, S.CRIT, S.EVASION], "d": D.MIXED },
	"Loom Parasite": { "s": [S.DOT, S.DRAIN] },

	# ==========================================================================
	# Story 3 - Path C
	# ==========================================================================
	"Abyssal Dreamer": { "s": [S.DEBUFFER, S.AOE], "d": D.MAGICAL },
	"Thread Devourer": { "s": [S.DEBUFFER, S.DRAIN] },
	"Slumbering Colossus": { "r": [R.TANK, R.FIGHTER], "s": [S.DEBUFFER, S.AOE] },
	"Dream Priest": { "s": [S.DEBUFFER, S.AOE, S.CRIT], "d": D.MAGICAL },
	"Astral Enforcer": { "r": [R.DPS], "s": [S.CRIT] },
	"Oneiric Hexer": { "r": [R.SUPPORT], "s": [S.DEBUFFER, S.AOE, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Oneiric Guardian": { "r": [R.TANK, R.FIGHTER], "s": [S.DRAIN] },
	"Memory Eater": { "s": [S.DEBUFFER, S.DRAIN, S.AOE, S.CRIT, S.EVASION], "d": D.MAGICAL },
	"Nightmare Sentinel": { "r": [R.TANK, R.FIGHTER], "s": [S.DEBUFFER, S.AOE, S.CRIT, S.EVASION] },
	"Anchor Chain": { "r": [R.SUPPORT], "s": [S.DEBUFFER, S.CRIT], "d": D.MIXED },
	"The Ancient Threadmaster": { "s": [S.DEBUFFER, S.DRAIN, S.AOE, S.CRIT, S.EVASION], "d": D.MIXED, "t": T.BOSS },
	"Dream Shackle": { "s": [S.DEBUFFER, S.AOE, S.CRIT, S.EVASION], "d": D.MAGICAL, "t": T.UNDERLING },
	"Loom Heart": { "r": [R.TANK, R.FIGHTER], "s": [S.DEBUFFER, S.AOE], "d": D.MAGICAL, "t": T.UNDERLING },
}


# =============================================================================
# Public API
# =============================================================================

static func get_roles(enemy_id: String) -> Array:
	if _DATA.has(enemy_id):
		return _DATA[enemy_id].get("r", [R.FIGHTER])
	return [R.FIGHTER]


static func get_subtypes(enemy_id: String) -> Array:
	if _DATA.has(enemy_id):
		return _DATA[enemy_id].get("s", [])
	return []


static func get_damage_type(enemy_id: String) -> Enums.DamageType:
	if _DATA.has(enemy_id):
		return _DATA[enemy_id].get("d", D.PHYSICAL)
	return D.PHYSICAL


static func get_tier(enemy_id: String) -> Enums.EnemyTier:
	if _DATA.has(enemy_id):
		return _DATA[enemy_id].get("t", T.STANDARD)
	return T.STANDARD


static func is_boss(enemy_id: String) -> bool:
	return get_tier(enemy_id) == T.BOSS


## Compute defense type from physical and magic defense stats.
## Uses 60/40 rule: >60% in one stat = that type, otherwise MIXED.
static func compute_defense_type(phys_def: float, mag_def: float) -> Enums.DamageType:
	var total := phys_def + mag_def
	if total == 0.0:
		return D.MIXED
	if phys_def / total > 0.6:
		return D.PHYSICAL
	if phys_def / total < 0.4:
		return D.MAGICAL
	return D.MIXED


## Aggregate role/subtype/damage/tier profile for a battle's enemy group.
static func get_battle_profile(enemy_ids: Array) -> Dictionary:
	var role_counts := {}
	var subtype_counts := {}
	var damage_counts := {}
	var tier_counts := {}
	for eid: String in enemy_ids:
		for role: Enums.Role in get_roles(eid):
			role_counts[role] = role_counts.get(role, 0) + 1
		for sub: Enums.Subtype in get_subtypes(eid):
			subtype_counts[sub] = subtype_counts.get(sub, 0) + 1
		var dt: Enums.DamageType = get_damage_type(eid)
		damage_counts[dt] = damage_counts.get(dt, 0) + 1
		var tier: Enums.EnemyTier = get_tier(eid)
		tier_counts[tier] = tier_counts.get(tier, 0) + 1
	return {
		"roles": role_counts,
		"subtypes": subtype_counts,
		"damage_types": damage_counts,
		"tiers": tier_counts,
	}
