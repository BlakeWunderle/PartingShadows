---
name: fight-length
description: Analyze battle fight length from the sim JSON — average actions, player actions per character, and max outliers. Use after any sim run to check for slogs or to see how a class rework shifted fight duration.
---

# Fight Length Analysis

Reads `turn_stats` from the sim JSON and surfaces battles with slog problems.
Does **not** run the simulator — reads existing data only.

## Data Source

```
JSON_PATH="C:/Users/blake/.claude/projects/c--Projects-EchoesOfChoice/memory/class-report-data.json"
```

The JSON has a `stages` array. Each entry contains:

```
turn_stats: {
  avg_player_per_char  -- average actions taken per player character
  avg_all_actions      -- average total actions (players + enemies) per battle
  min_all_actions      -- minimum total actions observed across all sims
  max_all_actions      -- maximum total actions observed across all sims
}
```

`avg_player_per_char` is calculated as `total_player_actions / (party_size * sim_count)`.
A party of 3 each taking ~8-12 actions is healthy. Over 20/char suggests a slog.

## What to Pull

For each stage, extract:
- `stage_name`, `story`, `tier`
- `turn_stats.avg_player_per_char`
- `turn_stats.avg_all_actions`
- `turn_stats.min_all_actions`
- `turn_stats.max_all_actions`

Sort by `avg_all_actions` descending.

## Thresholds

| Metric | Healthy | Elevated | Slog |
|--------|---------|----------|------|
| `avg_all_actions` | < 80 | 80–120 | > 120 |
| `max_all_actions` | < 200 | 200–400 | > 400 |
| `avg_player_per_char` | < 15 | 15–22 | > 22 |

Any battle exceeding **two or more** thresholds is a priority fix.

High `max_all_actions` with moderate `avg_all_actions` means the fight is fine most of the time but has catastrophic outlier runs — usually caused by a specific class combo that can't deal enough damage to close out.

## Output Format

Print a table sorted by `avg_all_actions` descending:

```
Battle                                          S  Tier    AvgPly/Char  AvgAll  MinAll  MaxAll
----------------------------------------------------------------------------------------------
ArmyBattle                                      1  tier1         22.28  129.07      41    1284  <<< SLOG
...
```

Flag each row:
- `<<< SLOG` — max > 400
- `<<  long` — max 200–400
- (no flag) — max < 200

After the table, print a summary:

```
FIGHT LENGTH SUMMARY
  Total battles analyzed: N
  Slogs (max > 400):      N  [list names]
  Elevated (max 200-400): N  [list names]
  Healthy (max < 200):    N
```

## Notes on Interpreting After a Class Rework

After reworking a class's kit (damage, abilities, healing), fight length can shift because:
- **More damage** → shorter fights (lower avg and max)
- **More healing** → longer fights (higher avg and max, especially max)
- **New debuffs/stuns** → can cut enemy actions, lowering all_actions

When comparing before/after a rework, check both `avg_all_actions` (did the typical fight get shorter?) and `max_all_actions` (did the worst-case outlier improve?). The max is more sensitive to problem class combos.

## STOP: This Skill Is Read-Only

After printing the summary, **stop**. Do not tune enemies or modify abilities.
Surface any slogs to the user and wait for explicit instructions.

## Related Skills

| Skill | When to Use |
|-------|-------------|
| `/battle-sim` | Re-sim after changes to get fresh data |
| `/balance-log` | Record what changed and what fight lengths were before/after |
| `/class-report` | Per-class win rates — pair with fight length to understand full battle health |
