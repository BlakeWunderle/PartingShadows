---
name: battle-sim
description: Full balance feedback loop for Echoes of Choice. Iterates enemy tuning, player power curve validation, and per-class win rate banding until all stages pass. Supports Story 1 and Story 2 independently via --story flag. Use when the user wants to run the full balance loop, do a complete balance pass, iterate on game balance, or ensure the difficulty gradient and class power curve are correct.
---

# Balance Feedback Loop

All paths are relative to the workspace root. The Godot project lives at `EchoesOfChoice/`.

**Before starting:** Read `C:\Users\blake\.claude\projects\c--Projects-EchoesOfChoice\memory\balance-log.md` to pick up progress from previous sessions. Use `/balance-log` after each sim run to record results and changes.

**After all progressions locked:** Run `/class-report` to generate a comprehensive per-class performance snapshot.

### Quick Reference

```bash
GODOT="C:/Users/blake/AppData/Local/Microsoft/WinGet/Packages/GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe/Godot_v4.6.1-stable_win64_console.exe"
NOISE='No loader\|Oswald\|game_theme\|custom project\|Unreferenced static string\|RID allocations.*leaked\|Pages in use exist at exit\|PagedAllocator\|ObjectDB instances leaked\|resources still in use at exit\|OpenGL API\|NVIDIA\|WASAPI\|Cleanup\|Main::'

# Quick iteration (any tier)
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --story <N> --sample 100 --sims 50 --progression <P> 2>&1 | grep -v "$NOISE"

# Progressive validation (stops at first failing progression -- saves time)
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --progressive --story <N> --auto --sample 100 2>&1 | grep -v "$NOISE"

# Progressive validation -- parallel (recommended for full balance passes)
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_sim_parallel.gd -- --progressive --story <N> --auto --jobs 10 2>&1 | grep -v "$NOISE"

# WEAK class investigation (shows why classes underperform)
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --diagnostics --sims 50 <StageName> 2>&1 | grep -v "$NOISE"

# Final validation -- sequential (use 600000ms timeout; --auto caps at 500 sims/combo)
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --story <N> --auto --all 2>&1 | grep -v "$NOISE"

# Final validation -- parallel (much faster, use --jobs to set worker count)
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_sim_parallel.gd -- --story <N> --auto --all --jobs 10 2>&1 | grep -v "$NOISE"

# Filter by tier (base, tier1, tier2)
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --tier base --auto --all 2>&1 | grep -v "$NOISE"
```

### Resuming a Previous Session

1. Read the balance log. If it has an active pass, find the first non-LOCKED progression.
2. Start from that progression (do not re-validate already LOCKED progs unless a cascade occurred).
3. If the log shows a cascade note (e.g., "player change, restart from Prog 3"), start from the noted progression.

---

Iterative balancing process for progression stages. Each cycle has three phases that must all pass before a story is considered balanced. Use `--story 1`, `--story 2`, or `--story 3` to target a specific story.

## The Loop

**Work one progression at a time, lowest to highest.** Each progression completes all three phases before moving on. Player class changes cascade forward -- adjusting a Tier 1 growth rate at Prog 3 affects every stage from Prog 3 onward but leaves Prog 0-2 untouched.

```
FOR each progression 0 -> 13, in order:
  +-------------------------------------------------+
  |  STEP 1: Enemy Tuning                           |
  |  Stage hits gradient win rate?                   |
  |  NO -> adjust enemy stats -> re-sim -> repeat   |
  |  YES v                                          |
  +-------------------------------------------------+
  |  STEP 2: Power Curve Check                      |
  |  Archetype ranking correct for this stage?       |
  |  NO -> adjust player growth -> restart this prog |
  |  YES v                                          |
  +-------------------------------------------------+
  |  STEP 3: Class Win Rate Band                    |
  |  Every class between 57% and 93%?               |
  |  NO -> buff/nerf outliers -> restart this prog   |
  |  YES -> LOCK this progression, move to next      |
  +-------------------------------------------------+

AFTER all progressions locked:
  -> Final validation pass (--story <N> --auto --all)
  -> If any stage broke, restart FROM that progression forward
```

### Why This Order Matters

- **Enemy-only changes** (Step 1) don't affect other stages -- safe to iterate freely.
- **Player-side changes** (Steps 2-3) cascade forward through every later stage because growth rates compound with level-ups. A Tier 1 buff applies at Prog 3+ and a base stat change applies everywhere.
- By locking stages low-to-high, earlier work is preserved. A player change at Prog 8 only requires re-validating Prog 8-13, not restarting from Prog 0.

### Cascade Scope (Story 1)

| Change Type | Affects | Restart From |
|-------------|---------|-------------|
| Enemy stat ranges in `enemy_db.gd` | The battle using that enemy | Re-sim that battle |
| Enemy ability Modifier | All battles with enemies using that ability | Earliest battle using that ability |
| Player base stats (Squire/Mage/Entertainer/Tinker/Wildling/Wanderer) | ALL stages | Prog 0 |
| Player Tier 1 growth rates | Prog 3+ (Tier 1 and later) | Prog 3 |
| Player Tier 2 growth rates | Prog 8+ (Tier 2 only) | Prog 8 |
| Ability Modifier changes | All stages using that ability | Earliest stage with a class that has the ability |

---

## Enemy Stat Mechanics

Enemy stats are defined in `scripts/data/enemy_db.gd`. Each factory function uses `_es(base_min, base_max, gmin, gmax, level, base_level)`:

```gdscript
# Example: create_raider at level 4
f.health = _es(98, 113, 4, 7, 4, 1)
# Result: range from base_min + (lvl-base_level)*gmin to base_max + (lvl-base_level)*(gmax-1)
```

- The **level parameter is passed to the factory** and used in `_es()` calls
- Growth is applied **once at construction time**, not per-turn
- `_es()` produces a random int within the computed range

### Tuning Levers (thematic first, then raw stats)

**Prefer thematic levers first.** They preserve enemy identity and create interesting matchup variance. Only fall back to raw HP changes when thematic levers are exhausted or the gap is too large (>5% off target).

#### Tier 1: Thematic (try these first)

1. **CritChance / DodgeChance** -- percentage-based, small changes (2-4%) have noticeable effects. Thematically expressive: a lumbering golem shouldn't crit, a nimble assassin should dodge. Safe to adjust without cascading effects.
2. **Abilities** -- changing which abilities the enemy has or their Modifiers. Swap a heal for a buff, add AoE to a crowd controller, reduce a damage ability's modifier. Changes the enemy's tactical role, not just their numbers.
3. **Speed** -- affects turn order and action economy. Slower enemies let players act first; faster enemies create pressure. A few points of speed shift can swing 2-3% WR.
4. **Enemy count** -- adding/removing enemies from the battle config (see 3-Enemy Rule below). Adding a weaker thematic minion is better than buffing HP on existing enemies.

#### Tier 2: Raw stats (fallback)

5. **HP base stat ranges** (1st and 2nd params of `_es()`) -- direct control over the stat floor/ceiling. Effective but generic. Use when thematic levers can't close the gap.
6. **Growth rates** (3rd and 4th params of `_es()`) -- amplified by level; changing growth by +1 at level 4 adds +3 to the stat range
7. **Level parameter** -- increasing from 4 to 5 adds one more growth roll to every stat

#### Thematic Tuning Examples

| Enemy | Identity | Thematic Levers | Avoid |
|-------|----------|-----------------|-------|
| Stranger (dark sorcerer) | High magic, cunning | Ability modifiers, speed | High crit (sorcerers don't precision-strike) |
| Troll (brute) | Tanky, slow, hits hard | HP, low speed, low dodge | High crit, high dodge |
| Harpy (agile flier) | Fast, evasive, fragile | High dodge, high speed, low HP | High HP (defeats the fantasy) |
| Android (defensive kit) | Resilient, methodical | HP, abilities, low crit | High dodge (machines don't dodge) |
| Zombie (undead horde) | Slow, numerous, relentless | HP, low speed, enemy count | High crit, high dodge |

### 3-Enemy Rule

Every battle after the first must have **at least 3 enemies**, unless it is a boss fight. Boss fights and special battles (MirrorBattle) are exempt.

3v2 battles give players a 50% action economy advantage, making stat tuning extremely sensitive. If a battle has only 2 enemies, add a 3rd by duplicating an existing enemy type with a new character name before tuning stats.

---

## Running the Simulator

The Godot battle simulator is the CLI tool at `tools/battle_simulator.gd`:

```bash
GODOT="C:/Users/blake/AppData/Local/Microsoft/WinGet/Packages/GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe/Godot_v4.6.1-stable_win64_console.exe"
NOISE='No loader\|Oswald\|game_theme\|custom project\|Unreferenced static string\|RID allocations.*leaked\|Pages in use exist at exit\|PagedAllocator\|ObjectDB instances leaked\|resources still in use at exit\|OpenGL API\|NVIDIA\|WASAPI\|Cleanup\|Main::'
```

### Story Filtering

Use `--story <n>` to target a specific story's stages:

```bash
# Story 1 only
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --story 1 --auto --all 2>&1 | grep -v "$NOISE"

# Story 2 only
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --story 2 --auto --all 2>&1 | grep -v "$NOISE"

# All stories (default)
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --auto --all 2>&1 | grep -v "$NOISE"
```

---

## Parallel Simulator

For full-story or all-story validation runs, use the parallel coordinator at `tools/battle_sim_parallel.gd`. It spawns multiple headless Godot worker processes, each handling a round-robin slice of stages, then merges results into a unified summary.

**This machine has 24 physical cores / 32 logical threads.** Recommended `--jobs` values:

| Scenario | Workers | Notes |
|----------|---------|-------|
| Quick parallel check | `--jobs 4` | ~3x speedup, low system load |
| Standard validation | `--jobs 10` | Recommended default, good speed vs resources |
| Fast full validation | `--jobs 16` | ~12x speedup, moderate load |
| Maximum throughput | `--jobs 24` | Uses all physical cores |

Using more workers than physical cores (e.g., 32) gives diminishing returns due to CPU contention. Stay at or below 24 for best performance.

### Parallel Usage

```bash
# All stories, 8 workers (recommended default)
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_sim_parallel.gd -- --auto --all --jobs 10 2>&1 | grep -v "$NOISE"

# Single story, parallel
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_sim_parallel.gd -- --story 2 --auto --all --jobs 10 2>&1 | grep -v "$NOISE"

# Filter by tier, parallel
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_sim_parallel.gd -- --tier tier2 --auto --all --jobs 12 2>&1 | grep -v "$NOISE"

# With JSON output
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_sim_parallel.gd -- --auto --all --jobs 10 --json sim_results.json 2>&1 | grep -v "$NOISE"
```

### Parallel Options

| Flag | Description |
|------|-------------|
| `--jobs <n>` | Number of worker processes (default: CPU count, max 32) |
| `--json <path>` | Write merged JSON report to file |
| All other flags | Forwarded to workers: `--story`, `--tier`, `--sims`, `--sample`, `--auto`, `--all`, `--progression` |

### When to Use Sequential vs Parallel

- **Sequential** (`battle_simulator.gd`): Quick iteration on a single progression (`--progression <N>`), single battle by name, or when you need per-combo class breakdowns in the output.
- **Parallel** (`battle_sim_parallel.gd`): Full-story validation (`--all`), multi-story runs, or any run touching 4+ stages. The parallel coordinator prints a unified summary table but not per-stage class breakdowns.

---

# Story 1 Balance

Story 1 has 14 progressions (Prog 0-13), 22 battle stages, and uses all 6 base class archetypes (Squire, Mage, Entertainer, Tinker, Wildling, Wanderer).

## Step 1: Enemy Tuning

**Goal:** This stage's overall win rate falls within its target +/- 3%.

### Run sims for the current progression

For Progressions 0-2 (Base classes, 56 combos):
```bash
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --story 1 --sims 50 --progression <N> 2>&1 | grep -v "$NOISE"
```

For Progressions 3-7 (Tier 1 classes, ~816 combos), use `--sample 100` for fast iteration:
```bash
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --story 1 --sample 100 --sims 50 --progression <N> 2>&1 | grep -v "$NOISE"
```

For Progressions 8-13 (Tier 2 classes, ~8436 combos), use `--sample 100` for fast iteration:
```bash
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --story 1 --sample 100 --sims 50 --progression <N> 2>&1 | grep -v "$NOISE"
```

### Check each battle's STATUS line

- **PASS** -> move to Step 2
- **TOO HARD** -> weaken enemies using thematic levers first, then raw stats:
  1. Lower CritChance/DodgeChance (does this enemy's fantasy support precision/evasion?)
  2. Reduce ability Modifiers or swap to weaker abilities
  3. Lower Speed (fewer enemy turns = less pressure)
  4. Remove an enemy from the battle config (if >3 enemies)
  5. *Fallback:* lower HP `_es()` ranges if thematic changes aren't enough
- **TOO EASY** -> strengthen enemies using thematic levers first, then raw stats:
  1. Add CritChance/DodgeChance where thematically appropriate (assassins, agile creatures)
  2. Increase ability Modifiers or swap to stronger abilities
  3. Raise Speed (more enemy turns = more pressure)
  4. Add a thematic enemy to the battle config (see 3-Enemy Rule)
  5. *Fallback:* raise HP `_es()` ranges if thematic changes aren't enough

All enemy stats are set in enemy factory functions (see Key Files). Battle compositions are in the battle_db files. **Consider each enemy's thematic identity before adjusting.** A sorcerer boss with high crit is thematically wrong and should be retuned through ability/dodge instead. Avoid touching player classes in this step.

### Re-sim after each change until all battles at this stage show PASS

Use `--sample 100 --sims 50` for quick iteration. Drop `--sample` for Steps 2-3 and final validation, which need the full party list for accurate class breakdowns.

### Story 1 Difficulty Gradient

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

---

## Step 2: Power Curve Check

**Goal:** The archetype ranking at this stage roughly follows the expected power curve. This is a guideline, not a hard rule -- individual battles will naturally favor certain archetypes based on enemy composition. The concern is persistent, stage-wide deviations, not per-battle variation.

### Expected Power Curve (6 Archetypes)

| Archetype | Peak Window | Behavior |
|-----------|-------------|----------|
| **Squire (Fighter tree)** | Prog 0-2 (early) | Highest class win rate at base tier. Strong physical stats out of the gate. Should taper to middle-of-pack by Prog 5+. |
| **Wanderer** | Prog 0-4 (early-mid) | Magic-defense fighter. Strong early alongside Squire, especially vs magic enemies. Tapers to mid-pack by Prog 5+. |
| **Mage** | Prog 3-7 (mid) | Ramps after Tier 1 upgrade. Peaks during mid-game battles with magic scaling. |
| **Entertainer** | Throughout (flexible) | Consistently strong across all stages. Buffs/debuffs scale well. Can lead individual battles but shouldn't have extreme spikes or troughs. Never flagged WEAK. |
| **Tinker (Scholar tree)** | Prog 8-13 (late) | Weakest early but highest growth rates catch up. Utility and tech abilities pay off in complex late fights. Top performer by endgame. |
| **Wildling** | Prog 2-8 (mid-wide) | Nature-based utility and beast synergies. Competitive across mid-game, shouldn't be dominant at early or late extremes. |

Classes that bridge archetypes (e.g., Paladin from Mage tree, Monk from Squire tree) can deviate -- they intentionally live between power spikes.

### How to Check

Group classes by archetype in the CLASS BREAKDOWN and average their win rates for the current stage.

- **Prog 0-2:** Squire and Wanderer classes should lead.
- **Prog 3-7:** Mage classes should lead (or be close). Wildling and Wanderer competitive.
- **Prog 8-13:** Tinker classes should lead.
- **Any stage:** Entertainer should be strong. No extreme spikes (>95%) or troughs (<57%). Wildling should stay mid-pack.

If the ranking is roughly correct (or deviations are explained by matchup) -> move to Step 3.

### Fixing Curve Problems

| Problem | Fix | Where | Cascade |
|---------|-----|-------|---------|
| Squire too weak early | Buff Squire base stats | `fighter_db.gd` (Squire factory) | Restart from Prog 0 |
| Squire too strong late | Reduce Squire T2 growth | `fighter_db_t2.gd` / `fighter_db_t2b.gd` | Restart from Prog 8 |
| Wanderer too weak early | Buff Wanderer base stats | `fighter_db.gd` (Wanderer factory) | Restart from Prog 0 |
| Wanderer too strong mid | Reduce Wanderer T1 growth | `fighter_db_t1.gd` (Sentinel, Pathfinder) | Restart from Prog 3 |
| Mage doesn't spike mid | Buff T1 Mage growth | `fighter_db_t1.gd` (Invoker, Acolyte) | Restart from Prog 3 |
| Entertainer flagged WEAK | Buff Entertainer base or growth | `fighter_db.gd` / `fighter_db_t1.gd` (Bard, Dervish, Orator) | Restart from affected prog |
| Tinker still weak late | Buff T2 Tinker growth | `fighter_db_t2.gd` / `fighter_db_t2b.gd` | Restart from Prog 8 |
| Wildling too weak mid | Buff T1 Wildling growth | `fighter_db_t1.gd` (Herbalist, Shaman, Beastcaller) | Restart from Prog 3 |
| Wildling too strong early | Reduce Wildling base stats | `fighter_db.gd` (Wildling factory) | Restart from Prog 0 |

**After any player-side change, restart from the earliest affected progression** (see Cascade Scope table).

---

## Step 3: Class Win Rate Band

**Goal:** Every individual class's win rate (from CLASS BREAKDOWN) at this stage falls within `target +/- 15%`.

### Class Band Formula

The band tracks the stage target, not a fixed range:

- **Floor:** `target - 15%`
- **Ceiling:** `target + 15%`

| Prog | Target | Class Floor | Class Ceiling |
|------|--------|-------------|---------------|
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

No class should feel unwinnable or trivially easy relative to the stage difficulty.

### How to Check

From this stage's CLASS BREAKDOWN output:

1. **Flag any class below `target - 15%`** -- this class makes parties feel hopeless when drafted.
2. **Flag any class above `target + 15%`** -- this class trivializes the content.
3. Classes flagged `** WEAK **` by the simulator (below `TargetWinRate * 0.60`) are most urgent.

If all classes are within band -> **LOCK this progression** and move to the next.

### Fixing Outliers

**Class below 57% (underpowered):**

1. Check if this is expected for the power curve (e.g., Tinker at Prog 0 being 65% is fine -- below Squire but above 57%).
2. Check the class's sibling (same Tier 1 parent). If both siblings are weak, the problem is likely the Tier 1 parent's growth rates, not the individual Tier 2 class.
3. If it violates the curve OR is below 57%: buff the class.
   - Offensive class: increase primary attack stat growth in `increase_level()` in the fighter_db files
   - Support class: ensure it has at least one damage ability alongside buffs
   - Check if it has dead abilities (e.g., MagDef debuff vs physical-only enemies)

**Class above 93% (overpowered):**

1. Reduce its primary stat growth or ability Modifiers.
2. Check if it has self-healing + damage (this combo tends to overperform).

**After any player-side change, restart from the earliest affected progression.**

---

## Final Validation (Story 1)

After all progressions are locked at `--sims 50`, run a full validation pass:

```bash
# Sequential (slower, includes per-stage class breakdowns)
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --story 1 --auto --all 2>&1 | grep -v "$NOISE"

# Parallel (faster, summary table only)
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_sim_parallel.gd -- --story 1 --auto --all --jobs 10 2>&1 | grep -v "$NOISE"
```

Sequential takes 2-5 minutes; parallel with 8 workers takes under 1 minute. Use a 600000ms timeout.

If any stage flips to TOO HARD / TOO EASY at full sample size, prefer small thematic adjustments (crit/dodge/speed/abilities) before touching HP. Re-validate **from that stage forward**.

---

## Story 1 Battle -> Enemy Mapping

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
| MirrorBattle | 7 | Shadow clones (98% stat copies of party) | 3vN |
| ReturnToCityStreetBattle | 8 | RoyalGuard, GuardSergeant, 2x GuardArcher | 3v4 |
| StrangerTowerBattle | 9 | Stranger | 3v1 (boss) |
| CorruptedCityBattle | 10 | 2x Lich, 2x Ghast | 3v4 |
| CorruptedWildsBattle | 10 | 2x Demon, 2x CorruptedTreant | 3v4 |
| DepthsBattle | 11 | SigilWretch, 2x TunnelLurker | 3v3 |
| GateBattle | 12 | 2x DarkKnight, 2x FellHound | 3v4 |
| StrangerFinalBattle | 13 | StrangerFinal | 3v1 (boss) |

Enemy factories are in `scripts/data/enemy_db.gd`. Battle compositions are in `scripts/data/battle_db.gd` (and act-specific files). When tuning a battle, check this table to know which enemy factories to modify.

---

## Story 1 Iteration Checklist

Copy and track progress. Each progression is locked only after all three steps pass.

```
PROGRESSION 0 (CityStreetBattle, target 82-88%):
- [ ] Step 1: Enemy tuning PASS
- [ ] Step 2: Squire/Wanderer lead class breakdown
- [ ] Step 3: All classes within target +/- 15%
- [ ] LOCKED

PROGRESSION 1 (WolfForestBattle, target 80-86%):
- [ ] Step 1: Enemy tuning PASS
- [ ] Step 2: Squire/Wanderer lead class breakdown
- [ ] Step 3: All classes within target +/- 15%
- [ ] LOCKED

PROGRESSION 2 (WaypointDefenseBattle, target 75-81%):
- [ ] Step 1: Enemy tuning PASS
- [ ] Step 2: Squire/Wanderer lead (transitioning)
- [ ] Step 3: All classes within target +/- 15%
- [ ] LOCKED

PROGRESSION 3 (Highland/DeepForest/Shore, target 80-86%):
- [ ] Step 1: All 3 battles PASS
- [ ] Step 2: Mage leads (or close)
- [ ] Step 3: All classes within target +/- 15%
- [ ] LOCKED

PROGRESSION 4 (MountainPass/Cave/Beach, target 78-84%):
- [ ] Step 1: All 3 battles PASS
- [ ] Step 2: Mage leads (or close)
- [ ] Step 3: All classes within target +/- 15%
- [ ] LOCKED

PROGRESSION 5 (Circus/Lab/Army/Cemetery, target 76-82%):
- [ ] Step 1: All 4 battles PASS
- [ ] Step 2: Mage leads (or close)
- [ ] Step 3: All classes within target +/- 15%
- [ ] LOCKED

PROGRESSION 6 (OutpostDefenseBattle, target 74-80%):
- [ ] Step 1: Enemy tuning PASS
- [ ] Step 2: Mage leads
- [ ] Step 3: All classes within target +/- 15%
- [ ] LOCKED

PROGRESSION 7 (MirrorBattle, target 72-78%):
- [ ] Step 1: Enemy tuning PASS
- [ ] Step 2: Power curve check
- [ ] Step 3: All classes within target +/- 15%
- [ ] LOCKED

PROGRESSION 8 (ReturnToCityStreetBattle, target 77-83%):
- [ ] Step 1: Enemy tuning PASS
- [ ] Step 2: Tinker leads (or close)
- [ ] Step 3: All classes within target +/- 15%
- [ ] LOCKED

PROGRESSION 9 (StrangerTowerBattle, target 75-81%):
- [ ] Step 1: Enemy tuning PASS
- [ ] Step 2: Tinker leads
- [ ] Step 3: All classes within target +/- 15%
- [ ] LOCKED

PROGRESSION 10 (CorruptedCity/CorruptedWilds, target 72-78%):
- [ ] Step 1: Both battles PASS
- [ ] Step 2: Tinker leads
- [ ] Step 3: All classes within target +/- 15%
- [ ] LOCKED

PROGRESSION 11 (DepthsBattle, target 69-75%):
- [ ] Step 1: Enemy tuning PASS
- [ ] Step 2: Tinker leads
- [ ] Step 3: All classes within target +/- 15%
- [ ] LOCKED

PROGRESSION 12 (GateBattle, target 66-72%):
- [ ] Step 1: Enemy tuning PASS
- [ ] Step 2: Tinker leads
- [ ] Step 3: All classes within target +/- 15%
- [ ] LOCKED

PROGRESSION 13 (StrangerFinalBattle, target 62-68%):
- [ ] Step 1: Enemy tuning PASS
- [ ] Step 2: Power curve check
- [ ] Step 3: All classes within target +/- 15%
- [ ] LOCKED

FINAL VALIDATION (Story 1):
- [ ] All Prog 0-13 validated with --story 1 --auto --all
- [ ] No stage broke at full sample size

RESULT: [ ] ALL LOCKED -> balanced  |  [ ] Stage broke -> restart from that prog
```

---

## When to Stop (Story 1)

The loop converges when:

1. All 22 battles show PASS at `--auto` sample sizes
2. The archetype power curve roughly follows the expected peaks (per-battle variation is fine)
3. Every class sits within or near the 57-93% band at every stage (borderline 55-57% is acceptable variance)

**Perfection is not the goal.** If a class is at 58% in one stage and 92% in another, that's fine -- it's within band. Borderline cases (55-57%) are acceptable variance in individual battles, especially when the class recovers to healthy rates in other battles at the same stage. Focus effort on classes that are clearly outside the band or violating the power curve, not on chasing every decimal.

---
---

# Story 2 Balance

Story 2 is a separate adventure with fresh characters. Players create a new party using all 6 base classes (including Wanderer, unlocked by completing Story 1). The same tier transitions and progression structure apply.

## Story 2 Constraint Rule

**Story 1 balance is LOCKED.** When balancing Story 2, ONLY modify:

- **Story 2 enemies**: stats/abilities in `enemy_db.gd` / `enemy_ability_db.gd`, compositions in `battle_db_s2.gd`
- **Wanderer tree**: stats/abilities in `fighter_db.gd` (Wanderer factory), `fighter_db_t1.gd` (Sentinel, Pathfinder), `fighter_db_t2.gd` (Bulwark, Aegis), `fighter_db_t2b.gd` (Trailblazer, Survivalist), `ability_db.gd` (wild_strike, natures_ward), `ability_db_player.gd` (Wanderer tree abilities)

**Do NOT modify** Squire, Mage, Entertainer, Tinker, or Wildling class trees. These are shared with Story 1 and any changes would break Story 1 balance.

### Story 2 Cascade Scope

| Change Type | Affects | Restart From |
|-------------|---------|-------------|
| S2 enemy stat ranges | The S2 battle using that enemy | Re-sim that battle |
| S2 enemy ability Modifier | All S2 battles with enemies using that ability | Earliest S2 battle using it |
| Wanderer base stats (T0) | ALL stages (both stories) | S2 Prog 0 + re-validate S1 |
| Wanderer T1 growth (Sentinel/Pathfinder) | S2 Prog 3+ | S2 Prog 3 + re-validate S1 Prog 3+ |
| Wanderer T2 growth (Bulwark/Aegis/Trailblazer/Survivalist) | S2 Prog 8+ | S2 Prog 8 + re-validate S1 Prog 8+ |
| Wanderer ability Modifier | All stages with Wanderer classes using that ability | Earliest affected stage + re-validate S1 |

**Cross-story validation**: After ANY Wanderer tree change, re-validate Story 1:
```bash
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --story 1 --auto --all 2>&1 | grep -v "$NOISE"
```
If any Story 1 stage breaks, revert the Wanderer change and compensate by adjusting Story 2 enemies instead.

---

## Story 2 Power Curve (6 Archetypes)

| Archetype | Peak Window | Behavior | Tunable? |
|-----------|-------------|----------|----------|
| **Squire** | Prog 0-2 | Strong fighter early, tapers mid-game | LOCKED |
| **Wanderer** | Prog 0-4 | Magic-defense fighter, strong early-mid vs magic enemies, tapers late | **YES** |
| **Mage** | Prog 3-7 | Ramps after T1, peaks mid-game | LOCKED |
| **Entertainer** | Throughout | Consistently strong, never WEAK | LOCKED |
| **Tinker** | Prog 8+ | Weakest early, strongest late | LOCKED |
| **Wildling** | Prog 2-8 | Mid-range utility, competitive mid-game | LOCKED |

Wanderer's magic-defense focus means it should perform especially well against magic-heavy enemies but weaker against purely physical enemies. Story 2 enemy compositions can exploit this -- mix physical and magic enemies to create matchup variety. This is a natural matchup variance, not a balance problem.

---

## Story 2 Difficulty Gradient

Story 2 is harder than Story 1: 80% down to 55% across 18 progressions. T1 transition at Prog 3, T2 at Prog 6. Both tier transitions include a +4% bump (reward for upgrading), mirroring Story 1's +5% bumps.

| Prog | Target | Range | Tier | Battles |
|------|--------|-------|------|---------|
| 0 | 80% | 77-83% | Base | S2_CaveAwakening |
| 1 | 78% | 75-81% | Base | S2_DeepCavern, S2_FungalHollow |
| 2 | 75% | 72-78% | Base | S2_TranquilPool, S2_TorchChamber |
| 3 | 79% | 76-82% | T1 | S2_CaveExit *(T1 bump: 75→79)* |
| 4 | 76% | 73-79% | T1 | S2_CoastalDescent |
| 5 | 73% | 70-76% | T1 | S2_FishingVillage, S2_SmugglersBluff |
| 6 | 77% | 74-80% | T2 | S2_WreckersCove, S2_CoastalRuins *(T2 bump: 73→77)* |
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

### Story 2 Class Band Formula

Same `target +/- 15%` rule:

| Prog | Target | Class Floor | Class Ceiling |
|------|--------|-------------|---------------|
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

---

## Story 2 Battle -> Enemy Mapping

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

Enemy factories: `scripts/data/story2/enemy_db_s2.gd` (Act I), `enemy_db_s2_act2.gd` (Act II), `enemy_db_s2_act3.gd` (Act III), `enemy_db_s2_act4.gd` (Act IV). Enemy abilities: `scripts/data/story2/enemy_ability_db_s2.gd`. Stage definitions: `scripts/tools/battle_stage_db.gd` (story = 2).

---
---

# Story 3 Balance

Story 3 ("The Woven Night") is the hardest story: 75% down to 50% across 13 progressions. No tier bumps (part of the difficulty). T1 transition at Prog 3, T2 at Prog 6. Note: Prog 2 is skipped (no battle at that progression).

## Story 3 Constraint Rule

**Stories 1 and 2 balance are LOCKED.** When balancing Story 3, ONLY modify:

- **Story 3 enemies**: stats/abilities in `enemy_db_s3*.gd` / `enemy_ability_db_s3.gd`
- **No player class changes** -- all 6 class trees are shared and locked.

### Story 3 Cascade Scope

| Change Type | Affects | Restart From |
|-------------|---------|-------------|
| S3 enemy stat ranges | The S3 battle using that enemy | Re-sim that battle |
| S3 enemy ability Modifier | All S3 battles with enemies using that ability | Earliest S3 battle using it |

No cross-story validation needed since no player classes can change.

---

## Story 3 Difficulty Gradient

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

### Story 3 Class Band Formula

| Prog | Target | Class Floor | Class Ceiling |
|------|--------|-------------|---------------|
| 0 | 75% | 60% | 90% |
| 1 | 73% | 58% | 88% |
| 3 | 70% | 55% | 85% |
| 4 | 68% | 53% | 83% |
| 5 | 65% | 50% | 80% |
| 6 | 62% | 47% | 77% |
| 7 | 60% | 45% | 75% |
| 8 | 58% | 43% | 73% |
| 9 | 56% | 41% | 71% |
| 10 | 54% | 39% | 69% |
| 11 | 52% | 37% | 67% |
| 12 | 50% | 35% | 65% |

---

## Story 3 Battle -> Enemy Mapping

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

Enemy factories: `scripts/data/story3/enemy_db_s3.gd` (Acts I-II), `enemy_db_s3_act3.gd` (Act III), `enemy_db_s3_act45.gd` (Acts IV-V). Enemy abilities: `scripts/data/story3/enemy_ability_db_s3.gd`. Stage definitions: `scripts/tools/battle_stage_db.gd` (story = 3).

---
---

# Related Skills

| Skill | When to Use |
|-------|-------------|
| `/sim-tools` | Progressive validation (`--progressive`), WEAK class investigation (`--diagnostics`), cache management (`--clear-cache`) |
| `/balance-log` | After each sim run to record results and changes. Read at session start. |
| `/class-report` | After all progressions locked. Generates comprehensive per-class report. |
| `/update-ability-catalog` | After changing any abilities during tuning. |

---

# Key Files

| File | Purpose |
|------|---------|
| `scripts/data/story1/enemy_db.gd` | Story 1 Act I enemy stat factories |
| `scripts/data/story1/enemy_db_act2.gd` | Story 1 Act II enemy stat factories |
| `scripts/data/story1/enemy_db_act345.gd` | Story 1 Acts III-V enemy stat factories |
| `scripts/data/story1/enemy_ability_db.gd` | Story 1 enemy abilities |
| `scripts/data/story2/enemy_db_s2.gd` | Story 2 Act I enemy stat factories |
| `scripts/data/story2/enemy_db_s2_act2.gd` | Story 2 Act II enemy stat factories |
| `scripts/data/story2/enemy_db_s2_act3.gd` | Story 2 Act III enemy stat factories |
| `scripts/data/story2/enemy_db_s2_act4.gd` | Story 2 Act IV enemy stat factories |
| `scripts/data/story2/enemy_ability_db_s2.gd` | Story 2 enemy abilities |
| `scripts/data/story3/enemy_db_s3.gd` | Story 3 Acts I-II enemy stat factories |
| `scripts/data/story3/enemy_db_s3_act3.gd` | Story 3 Act III enemy stat factories |
| `scripts/data/story3/enemy_db_s3_act45.gd` | Story 3 Acts IV-V enemy stat factories |
| `scripts/data/story3/enemy_ability_db_s3.gd` | Story 3 enemy abilities |
| `scripts/data/fighter_db.gd` | Base (T0) player class factories and stats |
| `scripts/data/fighter_db_t1.gd` | Tier 1 player class factories and growth |
| `scripts/data/fighter_db_t2.gd` | Tier 2 player class factories and growth (part 1) |
| `scripts/data/fighter_db_t2b.gd` | Tier 2 player class factories and growth (part 2) |
| `scripts/data/ability_db.gd` | Base player ability definitions (T0 + shared) |
| `scripts/data/ability_db_player.gd` | T1/T2 player ability definitions |
| `scripts/tools/simulation_runner.gd` | CLASS BREAKDOWN output, WEAK flags, class_diag accumulation |
| `scripts/tools/battle_stage_db.gd` | Target win rates per stage (story-aware) |
| `scripts/tools/party_composer.gd` | All valid party compositions |
| `scripts/tools/sim_progressive.gd` | Progressive runner logic (--progressive, --from) |
| `scripts/tools/sim_diagnostics.gd` | WEAK class analysis and reporting (--diagnostics) |
| `scripts/tools/sim_cache.gd` | Balance snapshot caching (--no-cache, --clear-cache) |
| `scripts/tools/sim_report.gd` | JSON report building with diagnostics |
| `tools/battle_simulator.gd` | CLI entry point (--story, --json, --worker flags) |
| `tools/battle_sim_parallel.gd` | Parallel coordinator (--jobs, --progressive, spawns workers) |
