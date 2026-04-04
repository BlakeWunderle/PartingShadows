# Repetitiveness Analysis

Analyze consecutive battles for archetype similarity and damage type monotony. Flags pairs of battles that feel samey (>80% cosine similarity on role/subtype vectors) and runs of 3+ battles with the same dominant damage type.

This is a pure metadata analysis — it does not run battle simulations.

## Usage

Run the standalone repetitiveness tool, then invoke `/battle-sim` with the appropriate arguments to check balance.

```bash
GODOT="C:/Users/blake/AppData/Local/Microsoft/WinGet/Packages/GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe/Godot_v4.6.1-stable_win64_console.exe"
NOISE='No loader\|Oswald\|game_theme\|custom project\|Unreferenced static string\|RID allocations.*leaked\|Pages in use exist at exit\|PagedAllocator\|ObjectDB instances leaked\|resources still in use at exit\|OpenGL API\|NVIDIA\|WASAPI\|Cleanup\|Main::'

# All stories (default)
"$GODOT" --path PartingShadows --headless --script res://tools/repetitiveness.gd 2>&1 | grep -v "$NOISE"

# Single story
"$GODOT" --path PartingShadows --headless --script res://tools/repetitiveness.gd -- --story 3 2>&1 | grep -v "$NOISE"
```

## Workflow

1. Run the repetitiveness analysis (above)
2. Review flagged pairs — decide which battles need enemy profile changes
3. After making changes, invoke `/battle-sim` with the affected battles to verify balance

## What It Detects

- **High similarity (>=80%):** Adjacent progression stages whose enemy teams share similar role/subtype distributions (cosine similarity on a 14-dimensional vector of role + subtype counts)
- **Damage monotony (>=3 consecutive):** Runs of battles where the dominant damage type (PHYSICAL, MAGICAL, or MIXED) is the same

## Arguments

| Flag | Description |
|------|-------------|
| `--story <n>` | Filter to story 1, 2, or 3 |

## Key Files

| File | Purpose |
|------|---------|
| `tools/repetitiveness.gd` | Standalone entry point |
| `scripts/tools/sim_repetitiveness.gd` | Analysis logic (cosine similarity, monotony detection) |
| `scripts/data/enemy_roles.gd` | Enemy role/subtype/damage metadata |
