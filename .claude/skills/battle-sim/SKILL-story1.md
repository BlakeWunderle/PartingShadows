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

## Power Curve (6 Archetypes)

| Archetype | Peak Window | Behavior |
|-----------|-------------|----------|
| **Squire** | Prog 0-2 | Highest win rate at base tier. Tapers to mid-pack by Prog 5+. |
| **Wanderer** | Prog 0-4 | Magic-defense fighter. Strong early, tapers mid-pack by Prog 5+. |
| **Mage** | Prog 3-7 | Ramps after T1. Peaks mid-game. |
| **Entertainer** | Throughout | Consistently strong. Never flagged WEAK. |
| **Tinker** | Prog 8-13 | Weakest early, highest growth. Top performer by endgame. |
| **Wildling** | Prog 2-8 | Competitive mid-game, not dominant at extremes. |

### Fixing Curve Problems

| Problem | Fix | Where | Cascade |
|---------|-----|-------|---------|
| Squire too weak early | Buff base stats | `fighter_db.gd` | Prog 0 |
| Squire too strong late | Reduce T2 growth | `fighter_db_t2.gd` / `t2b.gd` | Prog 8 |
| Wanderer too weak early | Buff base stats | `fighter_db.gd` | Prog 0 |
| Wanderer too strong mid | Reduce T1 growth | `fighter_db_t1.gd` | Prog 3 |
| Mage doesn't spike mid | Buff T1 growth | `fighter_db_t1.gd` | Prog 3 |
| Entertainer flagged WEAK | Buff base or growth | `fighter_db.gd` / `t1` | Affected prog |
| Tinker still weak late | Buff T2 growth | `fighter_db_t2.gd` / `t2b.gd` | Prog 8 |
| Wildling too weak mid | Buff T1 growth | `fighter_db_t1.gd` | Prog 3 |

## Class Band Table

Band = target +/- 15%.

| Prog | Target | Floor | Ceiling |
|------|--------|-------|---------|
| 0 | 85% | 70% | 100% |
| 1 | 83% | 68% | 98% |
| 2 | 78% | 63% | 93% |
| 3 | 83% | 68% | 98% |
| 4 | 81% | 66% | 96% |
| 5 | 79% | 64% | 94% |
| 6 | 77% | 62% | 92% |
| 7 | 75% | 60% | 90% |
| 8 | 80% | 65% | 95% |
| 9 | 78% | 63% | 93% |
| 10 | 75% | 60% | 90% |
| 11 | 72% | 57% | 87% |
| 12 | 69% | 54% | 84% |
| 13 | 65% | 50% | 80% |

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
| OutpostDefenseBattle | 6 | 2x Shade, 2x Wraith | 3v4 |
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
