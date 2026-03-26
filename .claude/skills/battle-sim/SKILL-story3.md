# Story 3 Balance Reference

Story 3 ("The Woven Night") is the hardest story: 75% down to 42% across 18 progressions (Prog 0-17, Prog 2 skipped). T1 transition at Prog 3, T2 at Prog 9. Three branching paths (A/B/C) diverge at Prog 11-14, sharing the same prog targets.

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
- **Structural T1 outliers**: Acolyte 85-90% (magic-defense advantage), Shaman 35-57% (weak offense vs magic enemies). Cannot fix with enemy-only changes.

## Difficulty Gradient

| Prog | Target | Range | Tier | Battles |
|------|--------|-------|------|---------|
| 0 | 75% | 72-78% | Base | S3_DreamMeadow |
| 1 | 73% | 70-76% | Base | S3_DreamMirrorHall, S3_DreamFogGarden |
| 3 | 70% | 67-73% | T1 | S3_DreamReturn |
| 4 | 68% | 65-71% | T1 | S3_DreamThreads |
| 5 | 66% | 63-69% | T1 | S3_DreamDrownedCorridor, S3_DreamShatteredGallery |
| 6 | 64% | 61-67% | T1 | S3_DreamShadowChase |
| 7 | 62% | 59-65% | T1 | S3_DreamLabyrinth, S3_DreamClockTower |
| 8 | 60% | 57-63% | T1 | S3_DreamNightmare *(Act II boss)* |
| 9 | 58% | 55-61% | T2 | S3_MarketConfrontation |
| 10 | 56% | 53-59% | T2 | S3_CellarDiscovery |
| 11 | 54% | 51-57% | T2 | S3_LucidDream / S3_B_InnSearch |
| 12 | 52% | 49-55% | T2 | S3_DreamTemple, S3_DreamVoid / S3_B_CultConfrontation |
| 13 | 50% | 47-53% | T2 | S3_DreamSanctum / S3_B_TunnelBreach |
| 14 | 48% | 45-51% | T2 | S3_CultUnderbelly / S3_B_ThornesWard / S3_C_DreamDescent |
| 15 | 46% | 43-49% | T2 | S3_CultCatacombs / S3_B_LoomHeart / S3_C_CultInterception |
| 16 | 44% | 41-47% | T2 | S3_CultRitualChamber / S3_B_DreamInvasion / S3_C_ThreadmasterLair |
| 17 | 42% | 39-45% | T2 | S3_DreamNexus / S3_B_DreamNexus / S3_C_DreamNexus *(final boss)* |

## Class Band Table

Band width narrows by tier: base +/- 15%, T1 +/- 12.5%, T2 +/- 10%.

| Prog | Tier | Target | Floor | Ceiling |
|------|------|--------|-------|---------|
| 0 | base | 75% | 60% | 90% |
| 1 | base | 73% | 58% | 88% |
| 3 | T1 | 70% | 57.5% | 82.5% |
| 4 | T1 | 68% | 55.5% | 80.5% |
| 5 | T1 | 66% | 53.5% | 78.5% |
| 6 | T1 | 64% | 51.5% | 76.5% |
| 7 | T1 | 62% | 49.5% | 74.5% |
| 8 | T1 | 60% | 47.5% | 72.5% |
| 9 | T2 | 58% | 48% | 68% |
| 10 | T2 | 56% | 46% | 66% |
| 11 | T2 | 54% | 44% | 64% |
| 12 | T2 | 52% | 42% | 62% |
| 13 | T2 | 50% | 40% | 60% |
| 14 | T2 | 48% | 38% | 58% |
| 15 | T2 | 46% | 36% | 56% |
| 16 | T2 | 44% | 34% | 54% |
| 17 | T2 | 42% | 32% | 52% |

## Battle -> Enemy Mapping

### Path A (main path)

| Battle | Prog | Enemies | Format |
|--------|------|---------|--------|
| S3_DreamMeadow | 0 | 2x DreamWisp, Phantasm | 3v3 |
| S3_DreamMirrorHall | 1 | MirrorShade, SleepStalker, ShadeMoth | 3v3 |
| S3_DreamFogGarden | 1 | FogWraith, ThornDreamer, SlumberBeast | 3v3 |
| S3_DreamReturn | 3 | NightmareHound, DreamWeaver, HollowEcho | 3v3 |
| S3_DreamThreads | 4 | ThreadLurker, DreamSentinel, GloomSpinner | 3v3 |
| S3_DreamDrownedCorridor | 5 | DrownedReverie, RiptideBeast, DepthCrawler | 3v3 |
| S3_DreamShatteredGallery | 5 | FragmentGolem, MemoryWisp, GalleryShade | 3v3 |
| S3_DreamShadowChase | 6 | ShadowPursuer, DreadTendril, FadedVoice | 3v3 |
| S3_DreamLabyrinth | 7 | TwilightStalker, WakingTerror, SomnolentSerpent | 3v3 |
| S3_DreamClockTower | 7 | 2x ClockSpecter, DuskSentinel | 3v3 |
| S3_DreamNightmare | 8 | TheNightmare, NightmareGuard, VoidEcho | 3v3 (boss) |
| S3_MarketConfrontation | 9 | MarketWatcher, ThreadSmith, HexHerbalist | 3v3 |
| S3_CellarDiscovery | 10 | CellarWatcher, ThreadConstruct, InkShade | 3v3 |
| S3_LucidDream | 11 | LucidPhantom, ThreadSpinner, CultShade | 3v3 |
| S3_DreamTemple | 12 | DreamWarden, ThoughtLeech, LoomSentinel | 3v3 |
| S3_DreamVoid | 12 | VoidSpinner, LucidPhantom, ThreadSpinner | 3v3 |
| S3_DreamSanctum | 13 | SanctumGuardian, CultShade, DreamWarden | 3v3 (boss) |
| S3_CultUnderbelly | 14 | CultAcolyte, CultEnforcer, CultHexer | 3v3 |
| S3_CultCatacombs | 15 | ThreadGuard, 2x DreamHound | 3v3 |
| S3_CultRitualChamber | 16 | CultRitualist, HighWeaver, ThreadGuard | 3v3 |
| S3_DreamNexus | 17 | TheThreadmaster, 2x ShadowFragment | 3v3 (final boss) |

### Path B (suspicion route, branches at Prog 11)

| Battle | Prog | Enemies | Format |
|--------|------|---------|--------|
| S3_B_InnSearch | 11 | CellarSentinel, 2x BoundStalker | 3v3 |
| S3_B_CultConfrontation | 12 | ThreadDisciple, ThreadWarden | 3v2 |
| S3_B_TunnelBreach | 13 | TunnelSentinel, ThreadSniper, PaleDevotee | 3v3 |
| S3_B_ThornesWard | 14 | ThreadRitualist, PassageGuardian, WardingShadow | 3v3 |
| S3_B_LoomHeart | 15 | ShadowInnkeeper, AstralWeaver, LoomTendril | 3v3 |
| S3_B_DreamInvasion | 16 | CathedralWarden, DreamBinder, ThreadAnchor | 3v3 |
| S3_B_DreamNexus | 17 | Lira (Threadmaster), TatteredDeception, DreamBastion | 3v3 (final boss) |

### Path C (Lira's confession route, branches at Prog 14)

| Battle | Prog | Enemies | Format |
|--------|------|---------|--------|
| S3_C_DreamDescent | 14 | AbyssalDreamer, ThreadDevourer, SlumberingColossus | 3v3 |
| S3_C_CultInterception | 15 | DreamPriest, AstralEnforcer, OneiricHexer | 3v3 |
| S3_C_ThreadmasterLair | 16 | NightmareSentinel, MemoryEater, AnchorChain | 3v3 |
| S3_C_DreamNexus | 17 | AncientThreadmaster, DreamShackle, LoomHeart | 3v3 (final boss) |

## Key Files

| File | Purpose |
|------|---------|
| `scripts/data/story3/enemy_db_s3.gd` | Acts I-II enemy factories (Prog 0-1, 3, 7-8) |
| `scripts/data/story3/enemy_db_s3_act2.gd` | Act II expansion enemies (Prog 4-6, 9-10) |
| `scripts/data/story3/enemy_db_s3_act3.gd` | Act III enemy factories (Prog 11-13) |
| `scripts/data/story3/enemy_db_s3_act45.gd` | Acts IV-V enemy factories (Prog 14-17) |
| `scripts/data/story3/enemy_db_s3_pathb.gd` | Path B enemy factories (Prog 11-17) |
| `scripts/data/story3/enemy_db_s3_pathc.gd` | Path C enemy factories (Prog 14-17) |
| `scripts/data/story3/enemy_ability_db_s3.gd` | Enemy abilities (Acts I-II) |
| `scripts/data/story3/enemy_ability_db_s3_act2.gd` | Act II expansion abilities |
| `scripts/data/story3/enemy_ability_db_s3_pathb.gd` | Path B abilities |
| `scripts/data/story3/enemy_ability_db_s3_pathc.gd` | Path C abilities |
