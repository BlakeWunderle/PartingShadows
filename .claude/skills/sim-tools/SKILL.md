---
name: sim-tools
description: "Advanced simulation utilities. Use for staged validation (--progressive), WEAK class investigation (--diagnostics), or cache management (--clear-cache)."
---

# Sim Tools

Advanced utilities for the battle simulator: progressive validation, outlier diagnostics, and balance snapshot caching.

```bash
GODOT="C:/Users/blake/AppData/Local/Microsoft/WinGet/Packages/GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe/Godot_v4.6.1-stable_win64_console.exe"
NOISE='No loader\|Oswald\|game_theme\|custom project\|Unreferenced static string\|RID allocations.*leaked\|Pages in use exist at exit\|PagedAllocator\|ObjectDB instances leaked\|resources still in use at exit\|OpenGL API\|NVIDIA\|WASAPI\|Cleanup\|Main::'
```

---

## Targeted Battles (`--battles`)

Run specific battles by name with full `--auto` precision, without simming the entire tier. Much faster than `--all` when only a few battles changed.

### Usage

```bash
# Run 3 specific battles with auto sims
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --auto --battles S3_DreamShadowChase,S3_DreamLabyrinth,S3_DreamNightmare --compact 2>&1 | grep -v "$NOISE"

# Combine with --json to persist class data for those battles
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --auto --battles CityStreetBattle,WolfForestBattle --json report.json 2>&1 | grep -v "$NOISE"
```

### When to Use

- **After enemy-only changes**: Only the battles using those enemies need re-simming
- **Quick iteration**: Verify 2-3 battles land before committing to a full tier validation
- **Spot checks**: Re-verify specific battles after player-side changes cascade

---

## Progressive Runner (`--progressive`)

Runs battles grouped by progression stage (lowest to highest), stopping at the first progression where any stage fails. Prevents wasting time on later progressions when early ones are broken.

### Sequential

```bash
# Run all Story 1 progressions, stop on first failure
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --progressive --story 1 --auto --sample 100 2>&1 | grep -v "$NOISE"

# Skip Progs 0-2, start from Prog 3
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --progressive --from 3 --story 1 --sims 50 --sample 100 2>&1 | grep -v "$NOISE"

# Specific tier within a story
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --progressive --story 2 --tier tier1 --sims 50 2>&1 | grep -v "$NOISE"
```

### Parallel

```bash
# Progressive with parallel workers (recommended for full validation)
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_sim_parallel.gd -- --progressive --story 1 --auto --jobs 10 2>&1 | grep -v "$NOISE"

# Skip early progressions in parallel
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_sim_parallel.gd -- --progressive --from 5 --story 2 --sims 50 --jobs 10 2>&1 | grep -v "$NOISE"
```

### Output

```
============================================================
  PROGRESSION 0  (1 battle)
============================================================
  CityStreetBattle: 84.5% (PASS)

  PROGRESSION 0: ALL PASS

============================================================
  PROGRESSION 1  (2 battles)
============================================================
  WolfForestBattle: 80.2% (TOO HARD)
  ForestWaypointBattle: 83.1% (PASS)

  PROGRESSION 1 FAILED:
    WolfForestBattle (80.2%, TOO HARD)
```

### When to Use

- **During balance iteration**: Use `--progressive --from <last_locked_prog>` to validate from where you left off
- **Full validation**: Use `--progressive` to verify all progressions in order
- **Saves time**: If Prog 3 fails, you don't waste time simulating Progs 4-12
- **Combine with `--from`**: Skip already-locked progressions

---

## Outlier Diagnostics (`--diagnostics`)

When a class is flagged WEAK (win rate < target * 60%), diagnostics explain *why* by comparing per-class combat stats against stage averages.

### Usage

```bash
# Single battle with diagnostics
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --diagnostics --sims 50 CityStreetBattle 2>&1 | grep -v "$NOISE"

# All battles in a progression with diagnostics
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --diagnostics --sims 50 --progression 3 --story 1 2>&1 | grep -v "$NOISE"

# Diagnostics in JSON output
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --diagnostics --sims 50 --json report.json CityStreetBattle 2>&1 | grep -v "$NOISE"
```

### Output

```
  WEAK CLASS DIAGNOSTICS for CityStreetBattle:

    Monk (win_rate: 42.3%, category: LOW_OFFENSE)
      Offense: avg damage 95 (stage avg 146, 0.65x)
      Defense: avg taken 72 (stage avg 68, 1.06x)
      Heals: avg 30 | Death rate: 38%
      Enemies: 3 units, avg p_def=38 m_def=25 p_atk=22 m_atk=15
```

### Categories

| Category | Meaning | Typical Fix |
|----------|---------|-------------|
| `LOW_OFFENSE` | Deals <70% of stage avg damage | Buff class ATK stats or ability modifiers |
| `HIGH_DAMAGE_TAKEN` | Takes >130% of stage avg damage | Buff class DEF/HP or add defensive abilities |
| `LOW_OFFENSE + HIGH_DAMAGE_TAKEN` | Both problems | Major stat tuning needed |
| `MARGINAL` | Close to averages but still WEAK | Check ability synergy, cooldowns, or enemy type matchup |

### What Gets Tracked

Per-fighter stats accumulated during sim mode:
- **dmg_dealt**: Total damage dealt (physical attacks + ability damage)
- **dmg_taken**: Total damage received (physical + ability + DoT)
- **heals**: Total healing done (direct heals + life steal)
- **died**: Whether the fighter died in the battle

These are aggregated by class name across all battles in a stage.

---

## Compact Output (`--compact`)

Reduces stdout to 1 line per PASS stage and 3-5 lines per FAIL stage, writing full verbose output (combo extremes, class breakdowns, spread metrics, diagnostics) to `user://sim_report.txt`. Dramatically reduces context window consumption during iterative balance sessions.

### Usage

```bash
# Compact single progression
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --compact --story 1 --sims 50 --progression 0 2>&1 | grep -v "$NOISE"

# Compact full validation
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --compact --story 1 --auto --all 2>&1 | grep -v "$NOISE"

# Compact parallel
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_sim_parallel.gd -- --compact --story 1 --auto --all --jobs 10 2>&1 | grep -v "$NOISE"
```

### Output

PASS stages (1 line):
```
  CityStreetBattle: 84.7% (target 85%) PASS
```

FAIL stages (3-5 lines):
```
  WolfForestBattle: 71.2% (target 83%) TOO HARD
    Weak: Tinker 58.3%, Wildling 62.1%
    Core spread: 28.4% (CONCERNING)
```

Summary:
```
  Results: 20 PASS, 2 FAIL
  Full report: C:/Users/blake/AppData/.../sim_report.txt
```

The text report at `user://sim_report.txt` contains the same verbose output that would normally go to stdout, including auto-diagnostics for FAIL stages.

---

## Balance Snapshot Caching

Simulation results are automatically cached based on MD5 hashes of all dependency files. When you re-run a stage without changing any code, the cached result is returned instantly.

### How It Works

1. On each sim run, the tool hashes all files that affect results:
   - **Global**: fighter_db.gd, ability_db.gd, battle_engine.gd, simulation_runner.gd, etc.
   - **Per-story**: enemy_db*.gd, enemy_ability_db*.gd, battle_db*.gd
2. Results are stored in `user://sim_cache.json`
3. On subsequent runs, if hashes match and sims/sample match, the cached result is used

### Cache Management

```bash
# Force re-simulation (ignore cache)
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --no-cache --sims 50 CityStreetBattle 2>&1 | grep -v "$NOISE"

# Clear all cached results
"$GODOT" --path EchoesOfChoice --headless --script res://tools/battle_simulator.gd -- --clear-cache 2>&1 | grep -v "$NOISE"
```

### What Invalidates Cache

Any file change in the dependency chain:
- Editing `fighter_db.gd` (player stats) invalidates ALL cached results
- Editing `enemy_db_s2.gd` (Story 2 enemies) invalidates only Story 2 results
- Editing `battle_engine.gd` (combat logic) invalidates ALL cached results
- Changing `--sims` or `--sample` values invalidates cache for that run

### Cache File Location

`C:\Users\blake\AppData\Roaming\Godot\app_userdata\Echoes of Choice\sim_cache.json`

---

## Key Files

| File | Purpose |
|------|---------|
| `scripts/tools/sim_progressive.gd` | Progressive runner logic |
| `scripts/tools/sim_diagnostics.gd` | WEAK class analysis and reporting |
| `scripts/tools/sim_cache.gd` | Cache: hash, lookup, store |
| `scripts/tools/sim_report.gd` | JSON report building |
| `scripts/battle/battle_engine.gd` | sim_stats tracking (sim mode) |
| `scripts/tools/simulation_runner.gd` | class_diag accumulation |

---

## Related Skills

| Skill | When to Use |
|-------|-------------|
| `/battle-sim` | Main balance feedback loop |
| `/balance-log` | Record balance results across sessions |
| `/class-report` | Per-class win rate snapshot |
