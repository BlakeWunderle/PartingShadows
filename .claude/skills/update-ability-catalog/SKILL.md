---
name: update-ability-catalog
description: Sync the ability catalog memory file with the C# source code. Use after adding, changing, or removing abilities in the C# codebase, or after class roster changes.
---

# Update Ability Catalog

Keep `C:\Users\blake\.claude\projects\c--Projects-EchoesOfChoice\memory\abilities.md` in sync with the C# source at `EchoesOfChoice/CharacterClasses/`.

## When to Run

- After adding new ability .cs files
- After changing ability properties (Modifier, ManaCost, etc.)
- After adding/removing abilities from a class's ability list
- After adding new classes or enemies
- Periodically to verify catalog accuracy

## Procedure

### Step 1: Scan class ability assignments

For each class tree directory, find which abilities each class uses:

```bash
grep -rn "new.*Ability\b\|Abilities\s*=" EchoesOfChoice/CharacterClasses/Fighter/ --include="*.cs"
grep -rn "new.*Ability\b\|Abilities\s*=" EchoesOfChoice/CharacterClasses/Mage/ --include="*.cs"
grep -rn "new.*Ability\b\|Abilities\s*=" EchoesOfChoice/CharacterClasses/Entertainer/ --include="*.cs"
grep -rn "new.*Ability\b\|Abilities\s*=" EchoesOfChoice/CharacterClasses/Scholar/ --include="*.cs"
grep -rn "new.*Ability\b\|Abilities\s*=" EchoesOfChoice/CharacterClasses/Wildling/ --include="*.cs"
grep -rn "new.*Ability\b\|Abilities\s*=" EchoesOfChoice/CharacterClasses/Enemies/ --include="*.cs"
```

### Step 2: Read ability definitions

For each ability .cs file, extract: Name, ModifiedStat, Modifier, impactedTurns, UseOnEnemy, ManaCost, TargetAll, DamagePerTurn, LifeStealPercent, FlavorText.

Ability files are in:
- `EchoesOfChoice/CharacterClasses/Abilities/` — player abilities
- `EchoesOfChoice/CharacterClasses/Abilities/Enemy/` — enemy-only abilities

### Step 3: Classify each ability

Apply these rules in order (first match wins):
- **LSTEAL**: LifeStealPercent > 0
- **DOT**: DamagePerTurn > 0
- **TAUNT**: ModifiedStat = Taunt
- **HEAL**: ModifiedStat = Health AND UseOnEnemy = false
- **BUFF**: UseOnEnemy = false AND impactedTurns > 0
- **DEBUFF**: UseOnEnemy = true AND impactedTurns > 0
- **DMG**: everything else (UseOnEnemy = true, instant)

### Step 4: Compare against catalog

Read `abilities.md` and diff against scanned data:
- **New**: ability .cs exists but no row in catalog
- **Removed**: row in catalog but .cs deleted or class no longer uses it
- **Changed**: property values differ between .cs and catalog
- **New class**: class .cs with abilities not in catalog
- **Removed class**: class in catalog but .cs removed

### Step 5: Update catalog

- Add/remove/update rows to match source
- Update the "Last updated" date at the top
- Preserve the Thematic Misfits section (update if affected abilities changed)

### Step 6: Report

```
ABILITY CATALOG SYNC
  Player classes scanned: N
  Player abilities: N
  Enemy classes scanned: N
  Enemy abilities: N

  Added: [list]
  Removed: [list]
  Modified: [list with old→new]

  RESULT: UP TO DATE / UPDATED (N changes)
```

## Table Format

```markdown
| Ability | Type | Stat | Mod | Dur | Tgt | Mana | DPT | LS% | Notes |
```

- Type: DMG, HEAL, BUFF, DEBUFF, DOT, LSTEAL, TAUNT
- Stat: PA, PD, MA, MD, ATK, DEF, SPD, HP, MIX, TAUNT, DODGE
- Dur: 0=instant, N=N turns
- Tgt: E=enemy, A=ally, AoE=all
- DPT/LS%: only fill if nonzero

## Key Files

- Player classes: `EchoesOfChoice/CharacterClasses/{Fighter,Mage,Entertainer,Scholar,Wildling}/`
- Enemy classes: `EchoesOfChoice/CharacterClasses/Enemies/`
- Player abilities: `EchoesOfChoice/CharacterClasses/Abilities/*.cs`
- Enemy abilities: `EchoesOfChoice/CharacterClasses/Abilities/Enemy/*.cs`
- Ability base: `EchoesOfChoice/CharacterClasses/Common/Ability.cs`
- StatEnum: `EchoesOfChoice/CharacterClasses/Common/StatEnum.cs`
- Catalog: `C:\Users\blake\.claude\projects\c--Projects-EchoesOfChoice\memory\abilities.md`

## Related

- `.claude/rules/class-trees.md` — class upgrade tree structure
- `.claude/rules/game-design.md` — combat formulas and design reference
