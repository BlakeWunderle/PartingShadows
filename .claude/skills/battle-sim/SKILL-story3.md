# Story 3 Balance Reference

Story 3 ("The Woven Night") is the hardest story: 75% down to 50% across 13 progressions. No tier bumps. T1 transition at Prog 3, T2 at Prog 6. Prog 2 is skipped (no battle at that progression).

## Constraint Rule

**Stories 1 and 2 balance are LOCKED.** When balancing Story 3, ONLY modify:

- **Story 3 enemies**: stats/abilities in `enemy_db_s3*.gd` / `enemy_ability_db_s3*.gd`
- **No player class changes** -- all 6 class trees are shared and locked.

## Cascade Scope

| Change Type | Affects | Restart From |
|-------------|---------|-------------|
| S3 enemy stat ranges | The S3 battle using that enemy | Re-sim that battle |
| S3 enemy ability Modifier | All S3 battles with enemies using it | Earliest S3 battle using it |

No cross-story validation needed since no player classes can change.

## Power Curve -- Post-Combat-Rework

| Archetype | T0 Avg | Behavior |
|-----------|--------|----------|
| **Tinker** | 81.7% | Leads T0 overall. Mixed attack profile bypasses dream enemy defenses. |
| **Squire** | 81.4% | Strong but volatile. Dominates MirrorHall (92%) but average elsewhere. |
| **Wanderer** | 78.2% | High magic defense counters dream magic. Dominates DreamMeadow (92.5%). |
| **Wildling** | 75.9% | Mid-pack, consistent across battles. |
| **Mage** | 70.4% | Below mid. Struggles in MirrorHall (60.1%). MP sustain issues persist. |
| **Entertainer** | 67.0% | Weakest in S3 T0. Low attack = poor MP-on-hit sustain vs dream enemies. |

### S3-Specific Notes

- Dream enemies are magic-heavy, giving Wanderer a natural advantage (high MDEF)
- Physical classes still strong due to Block/Rest sustain not needing mana
- Entertainer consistently underperforms here; enemy PDEF adjustments can help narrow the Squire gap without worsening Entertainer

## Difficulty Gradient

| Prog | Target | Range | Tier | Battles |
|------|--------|-------|------|---------|
| 0 | 75% | 72-78% | Base | S3_DreamMeadow |
| 1 | 73% | 70-76% | Base | S3_DreamMirrorHall, S3_DreamFogGarden |
| 3 | 70% | 67-73% | T1 | S3_DreamReturn |
| 4 | 68% | 65-71% | T1 | S3_DreamLabyrinth, S3_DreamClockTower |
| 5 | 65% | 62-68% | T1 | S3_DreamNightmare |
| 6 | 62% | 59-65% | T2 | S3_LucidDream |
| 7 | 60% | 57-63% | T2 | S3_DreamTemple, S3_DreamVoid |
| 8 | 58% | 55-61% | T2 | S3_DreamSanctum |
| 9 | 56% | 53-59% | T2 | S3_CultUnderbelly |
| 10 | 54% | 51-57% | T2 | S3_CultCatacombs |
| 11 | 52% | 49-55% | T2 | S3_CultRitualChamber |
| 12 | 50% | 47-53% | T2 | S3_DreamNexus |

## Class Band Table

Band width narrows by tier: base +/- 15%, T1 +/- 12.5%, T2 +/- 10%.

| Prog | Tier | Target | Floor | Ceiling |
|------|------|--------|-------|---------|
| 0 | base | 75% | 60% | 90% |
| 1 | base | 73% | 58% | 88% |
| 3 | T1 | 70% | 57.5% | 82.5% |
| 4 | T1 | 68% | 55.5% | 80.5% |
| 5 | T1 | 65% | 52.5% | 77.5% |
| 6 | T2 | 62% | 52% | 72% |
| 7 | T2 | 60% | 50% | 70% |
| 8 | T2 | 58% | 48% | 68% |
| 9 | T2 | 56% | 46% | 66% |
| 10 | T2 | 54% | 44% | 64% |
| 11 | T2 | 52% | 42% | 62% |
| 12 | T2 | 50% | 40% | 60% |

## Battle -> Enemy Mapping

| Battle | Prog | Enemies | Format |
|--------|------|---------|--------|
| S3_DreamMeadow | 0 | 2x DreamWisp, Phantasm | 3v3 |
| S3_DreamMirrorHall | 1 | MirrorShade, SleepStalker, ShadeMoth | 3v3 |
| S3_DreamFogGarden | 1 | FogWraith, ThornDreamer, SlumberBeast | 3v3 |
| S3_DreamReturn | 3 | NightmareHound, DreamWeaver, HollowEcho | 3v3 |
| S3_DreamLabyrinth | 4 | TwilightStalker, WakingTerror, SomnolentSerpent | 3v3 |
| S3_DreamClockTower | 4 | 2x ClockSpecter, DuskSentinel | 3v3 |
| S3_DreamNightmare | 5 | TheNightmare, NightmareHound, HollowEcho | 3v3 (boss) |
| S3_LucidDream | 6 | LucidPhantom, ThreadSpinner, CultShade | 3v3 |
| S3_DreamTemple | 7 | DreamWarden, ThoughtLeech, LoomSentinel | 3v3 |
| S3_DreamVoid | 7 | VoidSpinner, LucidPhantom, ThreadSpinner | 3v3 |
| S3_DreamSanctum | 8 | SanctumGuardian, CultShade, DreamWarden | 3v3 (boss) |
| S3_CultUnderbelly | 9 | CultAcolyte, CultEnforcer, CultHexer | 3v3 |
| S3_CultCatacombs | 10 | ThreadGuard, 2x DreamHound | 3v3 |
| S3_CultRitualChamber | 11 | CultRitualist, HighWeaver, ThreadGuard | 3v3 |
| S3_DreamNexus | 12 | TheThreadmaster, 2x ShadowFragment | 3v3 (final boss) |

## Key Files

| File | Purpose |
|------|---------|
| `scripts/data/story3/enemy_db_s3.gd` | Acts I-II enemy factories |
| `scripts/data/story3/enemy_db_s3_act2.gd` | Act II expansion enemies |
| `scripts/data/story3/enemy_db_s3_act3.gd` | Act III enemy factories |
| `scripts/data/story3/enemy_db_s3_act45.gd` | Acts IV-V enemy factories |
| `scripts/data/story3/enemy_db_s3_pathb.gd` | Path B enemy factories |
| `scripts/data/story3/enemy_db_s3_pathc.gd` | Path C enemy factories |
| `scripts/data/story3/enemy_ability_db_s3.gd` | Enemy abilities |
| `scripts/data/story3/enemy_ability_db_s3_act2.gd` | Act II expansion abilities |
| `scripts/data/story3/enemy_ability_db_s3_pathb.gd` | Path B abilities |
| `scripts/data/story3/enemy_ability_db_s3_pathc.gd` | Path C abilities |
