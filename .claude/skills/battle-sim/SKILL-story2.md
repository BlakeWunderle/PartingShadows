# Story 2 Balance Reference

Story 2 has 18 progressions (Prog 0-17), 24 battle stages (+5 Path B). 85% down to 55% (-2pp/prog with breathers at tier transitions). T1 transition at Prog 3, T2 at Prog 6.

## Constraint Rule

**Story 1 balance is LOCKED.** When balancing Story 2, ONLY modify:

- **Story 2 enemies**: stats/abilities in `enemy_db_s2*.gd`, compositions in `battle_db_s2*.gd`
- **Wanderer tree**: stats/abilities in `fighter_db.gd` (Wanderer), `fighter_db_t1.gd` (Sentinel, Pathfinder), `fighter_db_t2.gd` (Bulwark, Aegis), `fighter_db_t2b.gd` (Trailblazer, Survivalist), `ability_db.gd` (wild_strike, natures_ward), `ability_db_player.gd` (Wanderer abilities)

**Do NOT modify** Squire, Mage, Entertainer, Tinker, or Wildling class trees.

## Cascade Scope

| Change Type | Affects | Restart From |
|-------------|---------|-------------|
| S2 enemy stat ranges | The S2 battle using that enemy | Re-sim that battle |
| S2 enemy ability Modifier | All S2 battles with enemies using it | Earliest S2 battle using it |
| Wanderer base stats (T0) | ALL stages (both stories) | S2 Prog 0 + re-validate S1 |
| Wanderer T1 growth | S2 Prog 3+ | S2 Prog 3 + re-validate S1 Prog 3+ |
| Wanderer T2 growth | S2 Prog 8+ | S2 Prog 8 + re-validate S1 Prog 8+ |
| Wanderer ability Modifier | All stages with Wanderer classes | Earliest affected + re-validate S1 |

**Cross-story validation**: After ANY Wanderer tree change, re-validate Story 1. If S1 breaks, revert and compensate with S2 enemy adjustments.

## Power Curve -- Post-Combat-Rework

| Archetype | T0 Avg | Behavior | Tunable? |
|-----------|--------|----------|----------|
| **Tinker** | 80.2% | Leads T0 in caves. Benefits from mixed attack profile vs high-PDEF cave enemies. | LOCKED |
| **Wanderer** | 77.4% | Strong T0 thanks to magic defense vs cave magic. Volatile per-battle. | **YES** |
| **Wildling** | 77.5% | Mid-pack, consistent. | LOCKED |
| **Squire** | 76.3% | Mid-pack in S2. Cave enemies counter physical with high PDEF. | LOCKED |
| **Mage** | 75.2% | Mid-pack. Cave enemies are magic-heavy so Mage offense is decent here. | LOCKED |
| **Entertainer** | 71.9% | Weakest in S2 T0. Low physical and magic attack hurts MP sustain. | LOCKED |

### S2-Specific Notes

- Cave enemies have high PDEF, which naturally counters Squire dominance seen in S1
- This creates the tightest T0 spreads across all stories (good)
- Tinker leads due to mixed attack profile bypassing PDEF stacking

## Difficulty Gradient

| Prog | Target | Range | Tier | Battles |
|------|--------|-------|------|---------|
| 0 | 85% | 82-88% | Base | S2_CaveAwakening |
| 1 | 83% | 80-86% | Base | S2_DeepCavern, S2_FungalHollow |
| 2 | 81% | 78-84% | Base | S2_TranquilPool, S2_TorchChamber |
| 3 | 81% | 78-84% | T1 | S2_CaveExit *(T1 breather)* |
| 4 | 79% | 76-82% | T1 | S2_CoastalDescent |
| 5 | 77% | 74-80% | T1 | S2_FishingVillage, S2_SmugglersBluff |
| 6 | 77% | 74-80% | T2 | S2_WreckersCove, S2_CoastalRuins *(T2 breather)* |
| 7 | 75% | 72-78% | T2 | S2_BlackwaterBay |
| 8 | 73% | 70-76% | T2 | S2_LighthouseStorm |
| 9 | 71% | 68-74% | T2 | S2_BeneathTheLighthouse |
| 10 | 69% | 66-72% | T2 | S2_MemoryVault, S2_EchoGallery |
| 11 | 67% | 64-70% | T2 | S2_ShatteredSanctum |
| 12 | 65% | 62-68% | T2 | S2_GuardiansThreshold, S2_ForgottenArchive |
| 13 | 63% | 60-66% | T2 | S2_TheReveal, S2_B_ArchiveAwakening (Path B) |
| 14 | 61% | 58-64% | T2 | S2_DepthsOfRemembrance, S2_B_LighthouseCore (Path B) |
| 15 | 59% | 56-62% | T2 | S2_MawOfTheEye, S2_B_ResonanceChamber (Path B) |
| 16 | 57% | 54-60% | T2 | S2_EyeAwakening, S2_B_MemoryFlood (Path B) |
| 17 | 55% | 52-58% | T2 | S2_EyeOfOblivion, S2_B_EyeUnblinking (Path B) |

## Class Band Table

Band width narrows by tier: base +/- 15%, T1 +/- 12.5%, T2 +/- 10%.

| Prog | Tier | Target | Floor | Ceiling |
|------|------|--------|-------|---------|
| 0 | base | 85% | 70% | 100% |
| 1 | base | 83% | 68% | 98% |
| 2 | base | 81% | 66% | 96% |
| 3 | T1 | 81% | 68.5% | 93.5% |
| 4 | T1 | 79% | 66.5% | 91.5% |
| 5 | T1 | 77% | 64.5% | 89.5% |
| 6 | T2 | 77% | 67% | 87% |
| 7 | T2 | 75% | 65% | 85% |
| 8 | T2 | 73% | 63% | 83% |
| 9 | T2 | 71% | 61% | 81% |
| 10 | T2 | 69% | 59% | 79% |
| 11 | T2 | 67% | 57% | 77% |
| 12 | T2 | 65% | 55% | 75% |
| 13 | T2 | 63% | 53% | 73% |
| 14 | T2 | 61% | 51% | 71% |
| 15 | T2 | 59% | 49% | 69% |
| 16 | T2 | 57% | 47% | 67% |
| 17 | T2 | 55% | 45% | 65% |

## Battle -> Enemy Mapping

| Battle | Prog | Enemies | Format |
|--------|------|---------|--------|
| S2_CaveAwakening | 0 | 2x GlowWorm, CrystalSpider | 3v3 |
| S2_DeepCavern | 1 | 2x ShadeCrawler, EchoWisp | 3v3 |
| S2_FungalHollow | 1 | SporeStalker, FungalHulk, CapWisp | 3v3 |
| S2_TranquilPool | 2 | CaveEel, BlindAngler, PaleCrayfish | 3v3 |
| S2_TorchChamber | 2 | CaveDweller, TunnelShaman, BurrowScout | 3v3 |
| S2_CaveExit | 3 | CaveMaw, VeinLeech, StoneMoth | 3v3 |
| S2_CoastalDescent | 4 | BlightedGull, ShoreCrawler, WarpedHound | 3v3 |
| S2_FishingVillage | 5 | 2x DriftwoodBandit, SaltrunnerSmuggler | 3v3 |
| S2_SmugglersBluff | 5 | SaltrunnerSmuggler, TideWarden, DriftwoodBandit | 3v3 |
| S2_WreckersCove | 6 | BlackwaterCaptain, CorsairHexer, DriftwoodBandit | 3v3 |
| S2_CoastalRuins | 6 | AbyssalLurker, StormwrackRaptor, BlightedGull | 3v3 |
| S2_BlackwaterBay | 7 | 2x DrownedSailor, DepthHorror | 3v3 |
| S2_LighthouseStorm | 8 | TidecallerRevenant, SaltPhantom | 3v2 (boss) |
| S2_BeneathTheLighthouse | 9 | 2x FadingWisp, DimGuardian | 3v3 |
| S2_MemoryVault | 10 | ThoughtEater, MemoryWisp, EchoSentinel | 3v3 |
| S2_EchoGallery | 10 | HollowWatcher, GriefShade, MemoryWisp | 3v3 |
| S2_ShatteredSanctum | 11 | MirrorSelf, VoidWeaver, GriefShade | 3v3 |
| S2_GuardiansThreshold | 12 | WardConstruct, NullPhantom, ThresholdEcho | 3v3 |
| S2_ForgottenArchive | 12 | ArchiveKeeper, SilentArchivist, LostRecord, FadedPage | 3v4 |
| S2_TheReveal | 13 | TheWarden, FracturedProtector (Sera) | 3v2 (boss) |
| S2_DepthsOfRemembrance | 14 | 2x GazeStalker, MemoryHarvester | 3v3 |
| S2_MawOfTheEye | 15 | ThoughtformKnight, OblivionShade, MemoryHarvester | 3v3 |
| S2_EyeAwakening | 16 | TheIris, OblivionShade | 3v2 (boss) |
| S2_EyeOfOblivion | 17 | TheLidlessEye | 3v1 (final boss) |

## Key Files

| File | Purpose |
|------|---------|
| `scripts/data/story2/enemy_db_s2.gd` | Act I enemy factories |
| `scripts/data/story2/enemy_db_s2_act2.gd` | Act II enemy factories |
| `scripts/data/story2/enemy_db_s2_act3.gd` | Act III enemy factories |
| `scripts/data/story2/enemy_db_s2_act4.gd` | Act IV enemy factories |
| `scripts/data/story2/enemy_ability_db_s2.gd` | Enemy abilities |
| `scripts/data/story2/battle_db_s2.gd` | Act I battle configs |
| `scripts/data/story2/battle_db_s2_act2.gd` | Act II battle configs |
| `scripts/data/story2/battle_db_s2_act3.gd` | Act III battle configs |
| `scripts/data/story2/battle_db_s2_act4.gd` | Act IV battle configs |
