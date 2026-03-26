---
name: battle-sim
description: Full balance feedback loop for Echoes of Choice. Iterates enemy tuning, player power curve validation, and per-class win rate banding until all stages pass. Supports Story 1, 2, and 3 independently via --story flag.
---

# Balance Feedback Loop

All paths relative to workspace root. Godot project at `EchoesOfChoice/`.

**Before starting:** Read `C:\Users\blake\.claude\projects\c--Projects-EchoesOfChoice\memory\balance-log.md` to pick up progress from previous sessions. Use `/balance-log` after each sim run to record results and changes.

**Class data is built into every parallel sim run.** Pass `--diagnostics` to any parallel sim command and the coordinator prints the full per-class win rate breakdown after the summary table. No second sim needed.

**After locking a tier:** The `--json "$JSON_PATH"` flag persists all class breakdown data to disk. Read the JSON file in later sessions instead of re-simming.

---

## Multi-Story T2 Enemy Tuning

For a full T2 enemy tuning pass across all three stories, run each story in sequence (one at a time — never run two parallel sims simultaneously).

```bash
GODOT="C:/Users/blake/AppData/Local/Microsoft/WinGet/Packages/GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe/Godot_v4.6.1-stable_win64_console.exe"
NOISE='No loader\|Oswald\|game_theme\|custom project\|Unreferenced static string\|RID allocations.*leaked\|Pages in use exist at exit\|PagedAllocator\|ObjectDB instances leaked\|resources still in use at exit\|OpenGL API\|NVIDIA\|WASAPI\|Cleanup\|Main::'
JSON_PATH="C:/Users/blake/.claude/projects/c--Projects-EchoesOfChoice/memory/class-report-data.json"

# Story 1 T2 -- full tier with class breakdown in one pass
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_sim_parallel.gd -- \
  --story 1 --tier tier2 --auto --all --diagnostics --jobs 8 --json "$JSON_PATH" 2>&1 | grep -v "$NOISE"

# Story 2 T2
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_sim_parallel.gd -- \
  --story 2 --tier tier2 --auto --all --diagnostics --jobs 8 --json "$JSON_PATH" 2>&1 | grep -v "$NOISE"

# Story 3 T2
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_sim_parallel.gd -- \
  --story 3 --tier tier2 --auto --all --diagnostics --jobs 8 --json "$JSON_PATH" 2>&1 | grep -v "$NOISE"
```

Each run produces:
- Pass/fail summary for every T2 battle
- Full per-class win rate breakdown (sorted by win rate)
- WEAK class diagnostics (offense/defense ratios for classes below 60% of target)
- Persisted JSON for later reference

**Enemy tuning iteration** (changed battles only — much faster):
```bash
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_sim_parallel.gd -- \
  --battles BattleA,BattleB --diagnostics --auto --jobs 8 2>&1 | grep -v "$NOISE"
```

---

## Quick Reference

```bash
GODOT="C:/Users/blake/AppData/Local/Microsoft/WinGet/Packages/GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe/Godot_v4.6.1-stable_win64_console.exe"
NOISE='No loader\|Oswald\|game_theme\|custom project\|Unreferenced static string\|RID allocations.*leaked\|Pages in use exist at exit\|PagedAllocator\|ObjectDB instances leaked\|resources still in use at exit\|OpenGL API\|NVIDIA\|WASAPI\|Cleanup\|Main::'
JSON_PATH="C:/Users/blake/.claude/projects/c--Projects-EchoesOfChoice/memory/class-report-data.json"

# Quick iteration (single prog) -- use --compact to reduce context
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- \
  --story <N> --sample 100 --sims 50 --progression <P> --compact 2>&1 | grep -v "$NOISE"

# Tier validation with class data in one pass (recommended)
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_sim_parallel.gd -- \
  --story <N> --tier <TIER> --auto --all --diagnostics --jobs 8 --json "$JSON_PATH" 2>&1 | grep -v "$NOISE"

# Targeted battles (specific changed battles only)
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_sim_parallel.gd -- \
  --battles S3_DreamShadowChase,S3_DreamLabyrinth --diagnostics --auto --jobs 8 2>&1 | grep -v "$NOISE"

# Full story validation (all tiers, all battles)
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_sim_parallel.gd -- \
  --story <N> --auto --all --diagnostics --jobs 8 --json "$JSON_PATH" 2>&1 | grep -v "$NOISE"
```

### Parallel Sim Behavior

The parallel coordinator (`battle_sim_parallel.gd`) auto-detects the best split mode:

- **Stage-split** (default): each worker gets a round-robin slice of stages. Used when stages ≥ workers.
- **Combo-split** (auto): when fewer stages than workers (e.g. 3 battles, 8 workers), all workers share party combos. Single-stage and small-batch runs use all workers automatically.

**Worker count guidance:**
- Default on Windows: **8 workers** (sentinel-based serialization makes this safe)
- Full tier validation: `--jobs 8` recommended (~7x speedup)
- Maximum: `--jobs 32` (hard cap); diminishing returns above 8 for most runs
- Sentinel mechanism serializes Godot startup automatically — no manual stagger tuning needed

**IMPORTANT: Never run two sim processes at the same time.** Running two parallel sims simultaneously causes CPU contention (10x+ slower, unreliable results). Always wait for one sim to complete before launching the next.

### Persisted Class Data

The JSON file at `$JSON_PATH` accumulates results across runs. New runs merge into existing data, replacing matching stage names. Structure:

```json
{ "stages": [ { "stage_name": "...", "class_breakdown": { "ClassName": { "win_rate": 0.75, "wins": N, "total": N, "combo_count": N } } } ] }
```

**When you need class data** (band checks, outlier analysis, tier handoffs): read the JSON file first. Only re-sim if stats changed since it was written.

### Resuming a Previous Session

1. Read the balance log. If it has an active pass, find the first non-LOCKED progression.
2. Start from that progression (do not re-validate already LOCKED progs unless a cascade occurred).
3. If the log shows a cascade note, start from the noted progression.
4. Check if `$JSON_PATH` has recent class data — use it for context instead of re-simming.

---

## The Loop

**Work one progression at a time, lowest to highest.** Each progression completes all three phases before moving on.

```
FOR each progression 0 -> N, in order:
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
  |  Every class between floor and ceiling?          |
  |  NO -> buff/nerf outliers -> restart this prog   |
  |  YES -> LOCK this progression, move to next      |
  +-------------------------------------------------+

AFTER all progressions locked:
  -> Final validation pass (--story <N> --auto --all --diagnostics)
  -> If any stage broke, restart FROM that progression forward
```

### Why This Order Matters

- **Enemy-only changes** (Step 1) don't affect other stages -- safe to iterate freely.
- **Player-side changes** (Steps 2-3) cascade forward through every later stage because growth rates compound with level-ups.
- By locking stages low-to-high, earlier work is preserved.

### Generic Cascade Scope

| Change Type | Affects | Restart From |
|-------------|---------|-------------|
| Enemy stat ranges | The battle using that enemy | Re-sim that battle |
| Enemy ability Modifier | Battles with enemies using that ability | Earliest battle using it |
| Player base stats (T0) | ALL stages | Prog 0 |
| Player T1 growth rates | Prog 3+ (T1 and later) | Prog 3 |
| Player T2 growth rates | Prog 8+ (T2 only) | Prog 8 |
| Ability Modifier changes | All stages with classes using that ability | Earliest affected stage |

---

## Enemy Stat Mechanics

Enemy stats use `_es(base_min, base_max, gmin, gmax, level, base_level)`:

```gdscript
f.health = _es(98, 113, 4, 7, 4, 1)
# Result: range from base_min + (lvl-base_level)*gmin to base_max + (lvl-base_level)*(gmax-1)
```

Growth is applied **once at construction time**, not per-turn.

### Tuning Levers (thematic first, then raw stats)

**Prefer thematic levers.** They preserve enemy identity and create matchup variance. Fall back to raw HP changes only when the gap is >5% off target.

**Tier 1 -- Thematic (try first):**
1. **CritChance / DodgeChance** -- 2-4% changes have noticeable effects. Match enemy fantasy.
2. **Abilities** -- swap abilities, change Modifiers. Changes tactical role.
3. **Speed** -- affects turn order and action economy. A few points swing 2-3% WR.
4. **Enemy count** -- add/remove from battle config (see 3-Enemy Rule).

**Tier 2 -- Raw stats (fallback):**
5. **HP base ranges** (1st/2nd params of `_es()`)
6. **Growth rates** (3rd/4th params) -- amplified by level
7. **Level parameter** -- +1 level adds one growth roll to every stat

| Enemy | Identity | Thematic Levers | Avoid |
|-------|----------|-----------------|-------|
| Sorcerer boss | High magic, cunning | Ability modifiers, speed | High crit |
| Brute/Troll | Tanky, slow, hits hard | HP, low speed, low dodge | High crit, high dodge |
| Agile flier | Fast, evasive, fragile | High dodge, speed, low HP | High HP |
| Android/Construct | Resilient, methodical | HP, abilities, low crit | High dodge |
| Undead horde | Slow, numerous | HP, low speed, enemy count | High crit, high dodge |

### 3-Enemy Rule

Every battle after the first must have **at least 3 enemies**, unless it is a boss fight. 3v2 battles give players a 50% action economy advantage, making stat tuning extremely sensitive.

---

## Step 1: Enemy Tuning

**Goal:** Stage overall win rate falls within target +/- 3%.

- **PASS** -> move to Step 2
- **TOO HARD** -> weaken enemies: lower crit/dodge, reduce ability Modifiers, lower speed, remove an enemy (if >3), then fallback to HP ranges
- **TOO EASY** -> strengthen enemies: add crit/dodge, increase ability Modifiers, raise speed, add a thematic enemy, then fallback to HP ranges

Re-sim after each change until all battles at this progression show PASS. Use `--sample 100 --sims 50` for quick iteration.

## Step 2: Power Curve Check

**Goal:** Archetype ranking at this stage roughly follows the expected peaks. Per-battle variation is fine; the concern is persistent, stage-wide deviations.

Group classes by archetype in CLASS BREAKDOWN and average their win rates. Compare against the story-specific power curve (see story reference file).

If the ranking is roughly correct -> move to Step 3. If not, adjust player growth (see story reference for fixing curve problems).

## Step 3: Class Win Rate Band

**Goal:** Every class's win rate at this stage falls within the tier-specific band.

- **Base (T0):** `target +/- 15%`
- **Tier 1:** `target +/- 12.5%`
- **Tier 2:** `target +/- 10%`
- Classes flagged `** WEAK **` (below `target * 0.60`) are most urgent
- If all classes within band -> **LOCK** this progression, move to next

**Fixing outliers:**
- Underpowered: check siblings (same T1 parent). If both weak, buff T1 growth. If solo, buff T2 growth or check for dead abilities.
- Overpowered: reduce primary stat growth or ability Modifiers.
- After any player-side change, restart from earliest affected progression.

### When to Stop

All battles show PASS. Power curve roughly correct. Every class within or near the 57-93% band. **Perfection is not the goal.** Borderline 55-57% is acceptable variance.

---

## Simulator Flags

| Flag | Description |
|------|-------------|
| `--story <n>` | Filter to story 1, 2, or 3 |
| `--progression <n>` | Run all battles in a progression |
| `--progressive` | Run all progs in order, stop on failure |
| `--from <n>` | Start progressive run from prog n |
| `--all` | Run all battles |
| `--battles <a,b,...>` | Run specific battles by name (comma-separated) |
| `--auto` | Auto-calculate sims (200k+ total) |
| `--sims <n>` | Manual sims per combo |
| `--sample <n>` | Stratified sample of n combos |
| `--tier <t>` | Filter by tier (base, tier1, tier2) |
| `--diagnostics` | Show per-class win rate breakdown and WEAK class analysis (works in parallel sim) |
| `--compact` | Minimal stdout (1 line/PASS, 3-5 lines/FAIL) |
| `--json <path>` | Write/merge JSON report |
| `--jobs <n>` | Worker count (parallel only; default 8 on Windows) |
| `--stagger <ms>` | Delay between worker spawns if sentinel fails (parallel only; default 2000) |
| `--timeout <s>` | Kill workers after N seconds (parallel only; default max(300, jobs×120)) |
| `--no-cache` | Force re-simulation |

---

## Story Reference Files

Before tuning a story, read the story-specific reference file for difficulty gradient, class band table, battle-enemy mapping, cascade scope, power curve, and constraint rules:

- **Story 1:** `.claude/skills/battle-sim/SKILL-story1.md`
- **Story 2:** `.claude/skills/battle-sim/SKILL-story2.md`
- **Story 3:** `.claude/skills/battle-sim/SKILL-story3.md`

---

## Related Skills

| Skill | When to Use |
|-------|-------------|
| `/balance-log` | After each sim run to record results and changes |
| `/class-report` | After all progressions locked. Use `--from-json "$JSON_PATH"` with JSON from the final validation pass. |
| `/update-ability-catalog` | After changing abilities |

## Key Files

| File | Purpose |
|------|---------|
| `scripts/data/fighter_db.gd` | Base (T0) player class factories |
| `scripts/data/fighter_db_t1.gd` | Tier 1 growth |
| `scripts/data/fighter_db_t2.gd`, `fighter_db_t2b.gd` | Tier 2 growth |
| `scripts/data/ability_db.gd`, `ability_db_player.gd` | Player abilities |
| `scripts/tools/simulation_runner.gd` | CLASS BREAKDOWN, WEAK flags |
| `scripts/tools/battle_stage_db.gd` | Target win rates per stage |
| `tools/battle_simulator.gd` | CLI entry point |
| `tools/battle_sim_parallel.gd` | Parallel coordinator |

Enemy DBs and battle configs are story-specific -- see the story reference files.
