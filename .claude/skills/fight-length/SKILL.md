---
name: fight-length
description: Analyze battle fight length from the sim JSON — average actions, player actions per character, and max outliers. Use after any sim run to check for slogs or to see how a class rework shifted fight duration.
---

# Fight Length Analysis

Reads `turn_stats` from the sim JSON and surfaces battles with slog problems and boss
fights that are too short. Does **not** run the simulator — reads existing data only.

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

## Boss Battles

These battles are named-villain boss encounters and should be among the LONGER fights.
Flag them when they're too short (not just too long):

```
BOSS_BATTLES = {
  "StrangerTowerBattle", "StrangerFinalBattle", "StrangerUndoneBattle",
  "S2_TheReveal", "S2_EyeAwakening", "S2_EyeOfOblivion", "S2_B_EyeUnblinking",
  "S3_DreamShadowChase",
  "S3_DreamNexus", "S3_B_DreamNexus", "S3_C_DreamNexus"
}
```

## Excluded Battles

These battles are excluded from flagging (still shown in table, but no warning flags).
They get an `[EXCLUDED]` label instead of `<<< SLOG` / `<<  long`.

```
EXCLUDED_BATTLES = {
  "MirrorBattle"  -- mirror mechanic causes inherent outlier runs; not tunable
}
```

## Accepted-Short Bosses

These boss battles are intentionally short by narrative design. They skip the
`<<< SHORT` flag and get `[OK SHORT]` instead.

```
ACCEPTED_SHORT_BOSSES = {
  "S2_EyeOfOblivion"  -- intentionally short; Eye is dying after Sera's sacrifice
}
```

## What to Pull

For each stage, extract:
- `stage_name`, `story`, `tier`
- `turn_stats.avg_player_per_char`
- `turn_stats.avg_all_actions`
- `turn_stats.min_all_actions`
- `turn_stats.max_all_actions`
- Whether the stage name is in BOSS_BATTLES

Sort by `avg_all_actions` descending.

## Thresholds

### Regular Battles
| Metric | Healthy | Elevated | Slog |
|--------|---------|----------|------|
| `avg_all_actions` | < 80 | 80–120 | > 120 |
| `max_all_actions` | < 200 | 200–400 | > 400 |
| `avg_player_per_char` | < 15 | 15–22 | > 22 |

Any regular battle exceeding **two or more** thresholds is a priority fix.

### Boss Battles (should be LONGER than regular)
| Metric | Too Short | Healthy | Slog |
|--------|-----------|---------|------|
| `avg_all_actions` | < 60 | 60–150 | > 150 |
| `max_all_actions` | < 100 | 100–400 | > 400 |
| `avg_player_per_char` | < 8 | 8–18 | > 22 |

A boss fight is **too short** if avg_all_actions < 60 OR avg_player_per_char < 8.

High `max_all_actions` with moderate `avg_all_actions` means the fight is fine most of
the time but has catastrophic outlier runs — usually caused by a specific class combo
that can't deal enough damage to close out.

## Output Format

Print a table sorted by `avg_all_actions` descending:

```
Battle                                          S  Tier    AvgPly/Char  AvgAll  MinAll  MaxAll
----------------------------------------------------------------------------------------------
ArmyBattle                                      1  tier1         22.28  129.07      41    1284  <<< SLOG
StrangerFinalBattle [BOSS]                      1  tier2         11.42   78.31      32     312
S3_DreamShadowChase [BOSS]                      3  tier1          4.21   31.18      12      89  <<< SHORT
...
```

Flag each row:
- `<<< SLOG` — max > 400 (any battle, unless in EXCLUDED_BATTLES)
- `<<  long` — max 200–400 (regular battles only, unless in EXCLUDED_BATTLES)
- `<<< SHORT` — boss fight where avg_all_actions < 60 or avg_player_per_char < 8 (unless in ACCEPTED_SHORT_BOSSES)
- `[BOSS]` — label appended to battle name for boss battles
- `[EXCLUDED]` — replaces slog/long flags for battles in EXCLUDED_BATTLES
- `[OK SHORT]` — replaces SHORT flag for bosses in ACCEPTED_SHORT_BOSSES

After the table, print a summary:

```
FIGHT LENGTH SUMMARY
  Regular battles: N total
    Slogs (max > 400):      N  [list names]
    Excluded:               N  [list names]
    Elevated (max 200-400): N  [list names]
    Healthy:                N
  Boss battles: N total
    Too short (avg < 60):   N  [list names]
    Accepted short:         N  [list names]
    Healthy:                N
    Slogs (max > 400):      N  [list names]
```

## Notes on Interpreting After a Class Rework

After reworking a class's kit (damage, abilities, healing), fight length can shift because:
- **More damage** → shorter fights (lower avg and max)
- **More healing** → longer fights (higher avg and max, especially max)
- **New debuffs/stuns** → can cut enemy actions, lowering all_actions

When comparing before/after a rework, check both `avg_all_actions` (did the typical fight
get shorter?) and `max_all_actions` (did the worst-case outlier improve?). The max is more
sensitive to problem class combos.

For boss reworks specifically: check that avg_all_actions is above 60 and avg_player_per_char
is above 8 after buffing HP/abilities. A boss that dies too fast isn't grand.

## STOP: This Skill Is Read-Only

After printing the summary, **stop**. Do not tune enemies or modify abilities.
Surface any slogs or short bosses to the user and wait for explicit instructions.

## Related Skills

| Skill | When to Use |
|-------|-------------|
| `/battle-sim` | Re-sim after changes to get fresh data |
| `/balance-log` | Record what changed and what fight lengths were before/after |
| `/class-report` | Per-class win rates — pair with fight length to understand full battle health |
