---
name: class-report
description: Generate a per-class win rate report across all battles. Runs the battle simulator with JSON output, then builds a persistent markdown report saved to the memory directory. Use after balance changes, before releases, or to understand how each class performs across every fight.
---

# Class Performance Report Generator

Runs simulations and generates a persistent markdown report showing how every player class performs at every battle.

## Arguments

- No args: quick report for all stories
- `quick`: explicit quick mode (default)
- `full`: full --auto simulation (10-15 minutes)
- `story 1`, `story 2`, `story 3`: filter to a specific story
- Combined: `full story 2`

## Procedure

### Step 1: Run the simulator with JSON output

```bash
GODOT="C:/Users/blake/AppData/Local/Microsoft/WinGet/Packages/GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe/Godot_v4.6.1-stable_win64_console.exe"
NOISE='No loader\|Oswald\|game_theme\|custom project\|Unreferenced static string\|RID allocations.*leaked\|Pages in use exist at exit\|PagedAllocator\|ObjectDB instances leaked\|resources still in use at exit\|OpenGL API\|NVIDIA\|WASAPI\|Cleanup\|Main::'
JSON_PATH="C:/Users/blake/.claude/projects/c--Projects-EchoesOfChoice/memory/class-report-data.json"
```

**Quick mode** (default): `--sample 150 --sims 80`
```bash
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --sample 150 --sims 80 [--story N] --all --json "$JSON_PATH" 2>&1 | grep -v "$NOISE"
```

**Full mode**: `--auto`
```bash
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --auto [--story N] --all --json "$JSON_PATH" 2>&1 | grep -v "$NOISE"
```

Use a 600000ms timeout for full mode.

### Step 2: Read and parse the JSON

Read the JSON file at `$JSON_PATH`. It contains an object with a `stages` array, where each stage has:

```
stage_name, story, progression_stage, tier, target_win_rate, overall_win_rate,
combo_count, elapsed_ms, status, class_breakdown, spread, best_combos, worst_combos
```

`class_breakdown` is a dictionary keyed by class display name, each with `wins`, `total`, `win_rate`, `combo_count`.

### Step 3: Generate the markdown report

Write the report to: `C:\Users\blake\.claude\projects\c--Projects-EchoesOfChoice\memory\class-balance.md`

Use the format below. For each table, classes are rows and battles are columns.

#### Report Format

```markdown
# Class Balance Report

Generated: YYYY-MM-DD | Mode: quick/full | Stories: 1, 2, 3

## Summary

| Metric | Story 1 | Story 2 | Story 3 |
|--------|---------|---------|---------|
| Stages | N | N | N |
| All PASS | YES/NO | YES/NO | YES/NO |
| Avg WR | XX.X% | XX.X% | XX.X% |

### Strongest Classes (avg win rate across all battles they appear in)
1. ClassName -- XX.X%
2. ...
[top 5]

### Weakest Classes
1. ClassName -- XX.X%
2. ...
[bottom 5]

## Base Tier (Prog 0-2)

### Story 1
| Class | Battle1 (P0, T%) | Battle2 (P1, T%) | ... | Avg |
|-------|-------------------|-------------------|-----|-----|
| Squire | XX.X% | XX.X% | ... | XX.X% |

[Repeat for Story 2, Story 3 if included]

## Tier 1 (Prog 3-7)

### Story 1
[same table format with T1 class names]

## Tier 2 (Prog 8+)

### Story 1
[same table format with T2 class names]

## Spread Analysis

| Battle | Story | Prog | Target | Overall | Core Spread | Verdict |
|--------|-------|------|--------|---------|-------------|---------|
| ... | ... | ... | ... | ... | ... | ... |

## Outlier Details

[Only include classes that fall outside target +/- 15% at any battle]

### ClassName (avg XX.X%)
- Battle1: XX.X% (target YY%, **below floor**)
- Best combo: A / B / C -- XX.X%
- Worst combo: A / B / C -- XX.X%
```

#### Formatting Rules

- **Bold** win rates that are below the class floor (`target - 15%`)
- *Italic* win rates that are above the class ceiling (`target + 15%`)
- Shorten battle names in column headers if needed (e.g., `CityStr` for `CityStreetBattle`, drop the `Battle` suffix)
- Sort classes alphabetically within each tier section
- Only show classes that are active at the tier (base = 6 classes, T1 = 16, T2 = 34)

#### Tier-to-Class Mapping

Base (6): Squire, Mage, Entertainer, Tinker, Wildling, Wanderer

T1 (16): Duelist, Ranger, Martial Artist, Invoker, Acolyte, Bard, Dervish, Orator, Artificer, Philosopher, Arithmancer, Herbalist, Shaman, Beastcaller, Sentinel, Pathfinder

T2 (34): Cavalry, Dragoon, Mercenary, Hunter, Ninja, Monk, Infernalist, Tidecaller, Tempest, Paladin, Priest, Warlock, Warcrier, Minstrel, Illusionist, Mime, Laureate, Elegist, Alchemist, Bombardier, Chronomancer, Astronomer, Automaton, Technomancer, Blighter, Grove Keeper, Witch Doctor, Spiritwalker, Falconer, Shapeshifter, Bulwark, Aegis, Trailblazer, Survivalist

### Step 4: Delete the intermediate JSON file

```bash
rm "$JSON_PATH"
```

### Step 5: Print summary to user

```
CLASS BALANCE REPORT GENERATED
  Stories: 1, 2, 3
  Mode: quick / full
  Stages: N
  All passing: YES / NO (list failures)
  Report: C:\Users\blake\.claude\projects\c--Projects-EchoesOfChoice\memory\class-balance.md

  Top 3 strongest: ClassName (XX.X%), ...
  Top 3 weakest: ClassName (XX.X%), ...
  Outliers: N classes outside target +/- 15% band
```

## Related Skills

| Skill | When to Use |
|-------|-------------|
| `/battle-sim` | The main balance loop. Run this report after all progs are locked. |
| `/balance-log` | Tracks tuning progress during a balance pass. Suggests running this report on completion. |
| `/update-ability-catalog` | After changing any abilities during tuning. |

## Key Files

| File | Purpose |
|------|---------|
| `EchoesOfChoice/tools/battle_simulator.gd` | CLI entry point (supports --json flag) |
| `EchoesOfChoice/scripts/tools/simulation_runner.gd` | Simulation engine with class breakdown |
| `EchoesOfChoice/scripts/tools/battle_stage_db.gd` | Stage definitions with targets |
| `EchoesOfChoice/scripts/tools/party_composer.gd` | Party composition generation |
| `.claude/rules/class-trees.md` | Class upgrade tree structure |
