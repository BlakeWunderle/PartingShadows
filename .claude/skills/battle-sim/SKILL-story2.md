# Story 2 Balance Reference

Story 2 has 18 progressions (Prog 0-17), 24 battle stages. Harder than Story 1: 80% down to 55%. T1 transition at Prog 3, T2 at Prog 6. Both tier transitions include a +4% bump.

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
| 0 | 80% | 77-83% | Base | S2_CaveAwakening |
| 1 | 78% | 75-81% | Base | S2_DeepCavern, S2_FungalHollow |
| 2 | 75% | 72-78% | Base | S2_TranquilPool, S2_TorchChamber |
| 3 | 79% | 76-82% | T1 | S2_CaveExit *(T1 bump)* |
| 4 | 76% | 73-79% | T1 | S2_CoastalDescent |
| 5 | 73% | 70-76% | T1 | S2_FishingVillage, S2_SmugglersBluff |
| 6 | 77% | 74-80% | T2 | S2_WreckersCove, S2_CoastalRuins *(T2 bump)* |
| 7 | 75% | 72-78% | T2 | S2_BlackwaterBay |
| 8 | 73% | 70-76% | T2 | S2_LighthouseStorm |
| 9 | 71% | 68-74% | T2 | S2_BeneathTheLighthouse |
| 10 | 69% | 66-72% | T2 | S2_MemoryVault, S2_EchoGallery |
| 11 | 67% | 64-70% | T2 | S2_ShatteredSanctum |
| 12 | 65% | 62-68% | T2 | S2_GuardiansThreshold, S2_ForgottenArchive |
| 13 | 63% | 60-66% | T2 | S2_TheReveal |
| 14 | 61% | 58-64% | T2 | S2_DepthsOfRemembrance |
| 15 | 59% | 56-62% | T2 | S2_MawOfTheEye |
| 16 | 57% | 54-60% | T2 | S2_EyeAwakening |
| 17 | 55% | 52-58% | T2 | S2_EyeOfOblivion |

## Class Band Table

Band = target +/- 15%.

| Prog | Target | Floor | Ceiling |
|------|--------|-------|---------|
| 0 | 80% | 65% | 95% |
| 1 | 78% | 63% | 93% |
| 2 | 75% | 60% | 90% |
| 3 | 79% | 64% | 94% |
| 4 | 76% | 61% | 91% |
| 5 | 73% | 58% | 88% |
| 6 | 77% | 62% | 92% |
| 7 | 75% | 60% | 90% |
| 8 | 73% | 58% | 88% |
| 9 | 71% | 56% | 86% |
| 10 | 69% | 54% | 84% |
| 11 | 67% | 52% | 82% |
| 12 | 65% | 50% | 80% |
| 13 | 63% | 48% | 78% |
| 14 | 61% | 46% | 76% |
| 15 | 59% | 44% | 74% |
| 16 | 57% | 42% | 72% |
| 17 | 55% | 40% | 70% |

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
