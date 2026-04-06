---
name: balance-log
description: Record balance tuning progress to a persistent markdown log. Use during /battle-sim sessions to capture sim results, stat changes, and progression status so context survives across sessions. Invoke after each sim run or stat change.
---

# Balance Tuning Log

Maintains a persistent tuning journal at `C:\Users\blake\.claude\projects\c--Projects-PartingShadows\memory\balance-log.md` that tracks sim results and changes during balance passes.

## Arguments

- No args: record the latest sim results and changes from this conversation
- `wipe`: clear the log for a fresh tuning pass
- `status`: print the current status table without recording anything

## Procedure

### If argument is `wipe`

Write a fresh file to the log path with only:

```markdown
# Balance Tuning Log

No active tuning pass.
```

Print "Balance log cleared." and stop.

### If argument is `status`

Read the log file. Print the Status table from it. If the file doesn't exist, print "No balance log found." Stop.

### If no args (record results)

#### Step 1: Read the existing log

Read `C:\Users\blake\.claude\projects\c--Projects-PartingShadows\memory\balance-log.md`. If it doesn't exist or says "No active tuning pass", create a fresh log with the header and status table (see format below).

#### Step 2: Determine what to record

Look at the current conversation for the most recent sim results. Extract:

- **Story number** and **progression stage**
- **Battle name(s)** at this progression
- **Overall win rate** and **status** (PASS / TOO HARD / TOO EASY) per battle
- **Top 3 classes** by win rate
- **Bottom 3 classes** by win rate (note any WEAK flags)
- **Core spread** and **verdict**
- **Step 2 result** (power curve check -- which archetype leads)
- **Step 3 result** (class band check -- any classes outside target +/- 15%)

Also look for any **changes made** since the last sim run:
- Enemy stat changes (HP, ATK, DEF, SPD, crit, dodge)
- Ability swaps or modifier changes
- Enemy count changes in battle configs
- Player class changes (note cascade scope)

**Class data source priority:** If a JSON report exists at the standard path (`C:/Users/blake/.claude/projects/c--Projects-PartingShadows/memory/class-report-data.json`), read per-class win rates from it instead of requiring sim output in the conversation. Only fall back to conversation output if no JSON is available.

#### Step 3: Append to the log

Find the section for the current progression. If it doesn't exist, create it. Append a new run entry under it.

Count existing runs for this progression to determine the run number (Run 1, Run 2, etc.).

Format:

```markdown
### Run N
- Overall: XX.X% (STATUS)
- Top: ClassName XX.X%, ClassName XX.X%, ClassName XX.X%
- Bottom: ClassName XX.X%, ClassName XX.X%, ClassName XX.X%
- Spread: XX.X% core (VERDICT)
- Power curve: [archetype] leads (expected: [archetype])
- Band check: PASS / [list classes outside band]
```

If changes were made before this run, add them before the run entry:

```markdown
**Changes before this run:**
- EnemyName: stat X -> Y
- EnemyName: swapped ability A for B
```

If this run's status is PASS and all 3 steps pass, add `- LOCKED` at the end.

#### Recording class band data on LOCK

When a progression (or tier validation) is LOCKED, append a **full class band table** to the log entry. This preserves per-class win rates so future sessions don't need to re-sim.

```markdown
**Class bands (target XX%):**
| Class | WR | Band |
|-------|----|------|
| ClassName | XX.X% | OK / BELOW / ABOVE |
| ... | ... | ... |
```

Sort by win rate descending. Mark BELOW if under floor, ABOVE if over ceiling, OK otherwise. Include all classes active at the tier. If the data comes from the JSON file, note `(from JSON)` next to the heading.

#### Step 4: Update the status table

Update the Status table at the top of the log:
- Mark the current progression as LOCKED if all 3 steps passed
- Mark it as IN PROGRESS if tuning is ongoing
- Leave others as PENDING or their current state

Update the "Last updated" date.

#### Step 5: Check for completion

If ALL progressions for the active story are LOCKED:

1. Print a completion message with final stats
2. Suggest running `/class-report --from-json "$JSON_PATH"` (no re-sim needed if JSON exists from tier validation)
3. Replace the log body with:

```markdown
# Balance Tuning Log

No active tuning pass.

Last completed: Story N on YYYY-MM-DD (all progs locked)
```

#### Step 6: Print summary

```
BALANCE LOG UPDATED
  Story: N | Prog: N | Run: N
  Status: PASS / TOO HARD / TOO EASY
  Locked: X/Y progressions
  Log: C:\Users\blake\.claude\projects\c--Projects-PartingShadows\memory\balance-log.md
```

## Log File Format (fresh log)

When creating a new log, use the battle-sim skill's difficulty gradient table (from the active story) to populate the status table. Reference:

- Story 1: 14 progressions (Prog 0-13), T0 85%->78% (Easy), T1 83%->75% (Normal), T2 73%->65% (Hard)
- Story 2: 18 progressions (Prog 0-17), T0 85%->81% (Easy), T1 81%->77% (Normal), T2 77%->62% (Hard)
- Story 3: 18 progressions (Prog 0-17, Prog 2 skipped), T0 85%->83% (Easy), T1 81%->71% (Normal), T2 71%->62% (Hard), 3 branching paths

```markdown
# Balance Tuning Log

Story: N | Started: YYYY-MM-DD | Last updated: YYYY-MM-DD

## Status

| Prog | Battles | Target | Status |
|------|---------|--------|--------|
| 0 | BattleName | XX% | PENDING |
| 1 | BattleName | XX% | PENDING |
| ... | ... | ... | ... |

---

[progression sections appended here as tuning proceeds]
```

## Related Skills

| Skill | When to Use |
|-------|-------------|
| `/battle-sim` | The main balance loop. This log tracks its progress. |
| `/class-report` | Run after all progs locked for a per-class performance snapshot. |
| `/update-ability-catalog` | After changing any abilities during tuning. |

## Key References

- Battle-sim skill: `.claude/skills/battle-sim/skill.md` (difficulty gradients, battle mappings)
- Battle stage DB: `PartingShadows/scripts/tools/battle_stage_db.gd` (stage definitions)
- Memory dir: `C:\Users\blake\.claude\projects\c--Projects-PartingShadows\memory\`
