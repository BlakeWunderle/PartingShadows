# Clear Godot Cache

Clear stale Godot editor/engine caches and reimport the project. Use after adding, renaming, or moving `.gd` files with `class_name`, or when you see unexplained "not found" or "Failed to compile" errors.

## When to Use

- After creating a new `.gd` file with `class_name`
- After renaming or moving a `.gd` file that has `class_name`
- When you see "Could not find type" errors for a class that definitely exists
- When you see "Failed to compile depended scripts" with misleading error messages
- After changing autoload order in `project.godot`

## Steps

1. Delete the script class cache:
```bash
rm -f PartingShadows/.godot/global_script_class_cache.cfg
```

2. Reimport the project:
```bash
"C:/Users/blake/AppData/Local/Microsoft/WinGet/Packages/GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe/Godot_v4.6.1-stable_win64_console.exe" --path PartingShadows --headless --import 2>&1 | grep -i "error\|fail\|parse" | grep -v "BUG:\|RID\|Pages\|Paged\|ObjectDB\|Unreferenced"
```

3. Verify with a headless build:
```bash
NOISE='No loader\|Oswald\|game_theme\|custom project\|Unreferenced static string\|RID allocations.*leaked\|Pages in use exist at exit\|PagedAllocator\|ObjectDB instances leaked\|resources still in use at exit\|OpenGL API\|NVIDIA\|WASAPI\|Cleanup\|Main::'
"C:/Users/blake/AppData/Local/Microsoft/WinGet/Packages/GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe/Godot_v4.6.1-stable_win64_console.exe" --path PartingShadows --headless --quit 2>&1 | grep -v "$NOISE"
```

## Note on CI

GitHub Actions CI does NOT need cache clearing. The `.godot/` directory is gitignored, so CI builds always start with a fresh import. This skill is only needed for local development.
