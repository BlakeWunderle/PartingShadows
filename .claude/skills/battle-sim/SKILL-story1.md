# Story 1 Balance Reference

Story 1 has 14 progressions (Prog 0-13), 22 battle stages, and uses all 6 base class archetypes.

## Cascade Scope

| Change Type | Affects | Restart From |
|-------------|---------|-------------|
| Enemy stat ranges in `enemy_db.gd` | The battle using that enemy | Re-sim that battle |
| Enemy ability Modifier | All battles with enemies using that ability | Earliest battle using that ability |
| Player base stats (Squire/Mage/Entertainer/Tinker/Wildling/Wanderer) | ALL stages | Prog 0 |
| Player Tier 1 growth rates | Prog 3+ (Tier 1 and later) | Prog 3 |
| Player Tier 2 growth rates | Prog 8+ (Tier 2 only) | Prog 8 |
| Ability Modifier changes | All stages using that ability | Earliest stage with a class that has the ability |

## Difficulty Gradient

| Prog | Target | Range | Tier | Battles |
|------|--------|-------|------|---------|
| 0 | 85% | 82-88% | Base | CityStreetBattle |
| 1 | 83% | 80-86% | Base | WolfForestBattle |
| 2 | 78% | 75-81% | Base | WaypointDefenseBattle |
| 3 | 83% | 80-86% | T1 | HighlandBattle, DeepForestBattle, ShoreBattle |
| 4 | 81% | 78-84% | T1 | MountainPassBattle, CaveBattle, BeachBattle |
| 5 | 79% | 76-82% | T1 | CircusBattle, LabBattle, ArmyBattle, CemeteryBattle |
| 6 | 77% | 74-80% | T1 | OutpostDefenseBattle |
| 7 | 75% | 72-78% | T1 | MirrorBattle |
| 8 | 80% | 77-83% | T2 | ReturnToCityStreetBattle |
| 9 | 78% | 75-81% | T2 | StrangerTowerBattle |
| 10 | 75% | 72-78% | T2 | CorruptedCityBattle, CorruptedWildsBattle |
| 11 | 72% | 69-75% | T2 | DepthsBattle |
| 12 | 69% | 66-72% | T2 | GateBattle |
| 13 | 65% | 62-68% | T2 | StrangerFinalBattle |

## Power Curve (6 Archetypes) -- Post-Combat-Rework

| Archetype | T0 Avg | Behavior |
|-----------|--------|----------|
| **Squire** | 95.1% | Dominates T0. Basic attacks + Block/Rest = no mana needed. Tapers once enemies get tougher. |
| **Wildling** | 90.3% | Strong T0, benefits from physical sustain loop. |
| **Tinker** | 86.4% | Consistently strong across all stories and tiers. |
| **Entertainer** | 81.9% | Mid-pack. Reliable but never top. |
| **Mage** | 75.0% | Weak at T0. Low physical attack = minimal MP-on-hit. Relies on mana for abilities but caps reduced. Ramps after T1. |
| **Wanderer** | 73.7% | Weak-to-mid at T0 in S1 despite magic defense. Strong in S3 vs dream magic enemies (92.5% DreamMeadow). Story-dependent. |

### Key Rework Effects

- MP-on-hit (`magic_attack / 7`) heavily favors physical classes at T0 since Mage/Entertainer have low physical attack
- Block + Rest sustain loop means physical classes rarely need mana abilities to win
- Mage improves significantly at T1+ when mana pools and ability modifiers scale up
- Enemy PDEF is the primary lever for closing Squire/physical class gaps without hurting casters

## Class Band Table

Band width narrows by tier: base +/- 15%, T1 +/- 12.5%, T2 +/- 10%.

| Prog | Tier | Target | Floor | Ceiling |
|------|------|--------|-------|---------|
| 0 | base | 85% | 70% | 100% |
| 1 | base | 83% | 68% | 98% |
| 2 | base | 78% | 63% | 93% |
| 3 | T1 | 83% | 70.5% | 95.5% |
| 4 | T1 | 81% | 68.5% | 93.5% |
| 5 | T1 | 79% | 66.5% | 91.5% |
| 6 | T1 | 77% | 64.5% | 89.5% |
| 7 | T1 | 75% | 62.5% | 87.5% |
| 8 | T2 | 80% | 70% | 90% |
| 9 | T2 | 78% | 68% | 88% |
| 10 | T2 | 75% | 65% | 85% |
| 11 | T2 | 72% | 62% | 82% |
| 12 | T2 | 69% | 59% | 79% |
| 13 | T2 | 65% | 55% | 75% |

## Battle -> Enemy Mapping

| Battle | Prog | Enemies | Format |
|--------|------|---------|--------|
| CityStreetBattle | 0 | Thug, Ruffian, Pickpocket | 3v3 |
| WolfForestBattle | 1 | Wolf, Boar | 3v2 |
| WaypointDefenseBattle | 2 | Bandit, Goblin, Hound | 3v3 |
| HighlandBattle | 3 | 2x Raider, Orc | 3v3 |
| DeepForestBattle | 3 | Witch, Wisp, Sprite | 3v3 |
| ShoreBattle | 3 | Siren, 2x Merfolk | 3v3 |
| MountainPassBattle | 4 | Troll, 2x Harpy | 3v3 |
| CaveBattle | 4 | 2x FireWyrmling, FrostWyrmling | 3v3 |
| BeachBattle | 4 | Captain, 2x Pirate | 3v3 |
| CircusBattle | 5 | Harlequin, Chanteuse, Ringmaster | 3v3 |
| LabBattle | 5 | Android, Machinist, Ironclad | 3v3 |
| ArmyBattle | 5 | Commander, Draconian, Chaplain | 3v3 |
| CemeteryBattle | 5 | 2x Zombie, Ghoul | 3v3 |
| OutpostDefenseBattle | 6 | Shade, Wraith, Boneguard | 3v3 |
| MirrorBattle | 7 | Shadow clones (98% stat copies) | 3vN |
| ReturnToCityStreetBattle | 8 | RoyalGuard, GuardSergeant, 2x GuardArcher | 3v4 |
| StrangerTowerBattle | 9 | Stranger | 3v1 (boss) |
| CorruptedCityBattle | 10 | 2x Lich, 2x Ghast | 3v4 |
| CorruptedWildsBattle | 10 | 2x Demon, 2x CorruptedTreant | 3v4 |
| DepthsBattle | 11 | SigilWretch, 2x TunnelLurker | 3v3 |
| GateBattle | 12 | 2x DarkKnight, 2x FellHound | 3v4 |
| StrangerFinalBattle | 13 | StrangerFinal | 3v1 (boss) |

## Key Files

| File | Purpose |
|------|---------|
| `scripts/data/story1/enemy_db.gd` | Act I enemy factories |
| `scripts/data/story1/enemy_db_act2.gd` | Act II enemy factories |
| `scripts/data/story1/enemy_db_act345.gd` | Acts III-V enemy factories |
| `scripts/data/story1/enemy_ability_db.gd` | Enemy abilities |
| `scripts/data/story1/battle_db_act1.gd` | Act I battle configs |
| `scripts/data/story1/battle_db_act2.gd` | Act II battle configs |
| `scripts/data/story1/battle_db_act3.gd` | Act III battle configs |
| `scripts/data/story1/battle_db_act45.gd` | Acts IV-V battle configs |
