# Clean Export for Godot

Exports a fresh Godot build with cleared cache. Use this when assets aren't updating correctly in exports or before sending builds to testers.

## Workflow

### Step 1: Clear Cache

Remove cached imported assets and editor state:

```bash
rm -rf EchoesOfChoice/.godot/imported/ EchoesOfChoice/.godot/editor/ EchoesOfChoice/.godot/global_script_class_cache.cfg
```

This forces Godot to re-import all assets from source on the next run.

### Step 2: Re-import Assets

Run Godot in headless mode with the `--import` flag:

```bash
GODOT="C:/Users/blake/AppData/Local/Microsoft/WinGet/Packages/GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe/Godot_v4.6.1-stable_win64_console.exe"
NOISE='No loader\|Oswald\|game_theme\|custom project\|Unreferenced static string\|RID allocations.*leaked\|Pages in use exist at exit\|PagedAllocator\|ObjectDB instances leaked\|resources still in use at exit\|OpenGL API\|NVIDIA\|WASAPI\|Cleanup\|Main::'

"$GODOT" --path EchoesOfChoice --headless --import 2>&1 | grep -v "$NOISE"
```

This rebuilds the `.godot/imported/` directory with fresh imports of all assets.

### Step 3: Export Build

Export the platform build(s):

```bash
# Windows (default)
"$GODOT" --path EchoesOfChoice --headless --export-release "Windows Desktop" "../build/windows/EchoesOfChoice.exe" 2>&1 | grep -v "$NOISE"

# Linux (optional)
"$GODOT" --path EchoesOfChoice --headless --export-release "Linux" "../build/linux/EchoesOfChoice.x86_64" 2>&1 | grep -v "$NOISE"

# macOS (optional)
"$GODOT" --path EchoesOfChoice --headless --export-release "macOS" "../build/macos/EchoesOfChoice.zip" 2>&1 | grep -v "$NOISE"
```

### Step 4: Verify Build

Check the build directory to confirm files were created:

```bash
# Windows
ls -lh build/windows/ | head -10

# Expected files:
# - EchoesOfChoice.exe (~96 MB)
# - EchoesOfChoice.pck (~450+ MB)
# - libgodotsteam.windows.template_debug.x86_64.dll
# - steam_api64.dll
```

## When to Use This Skill

- **Before sending to testers**: Always do a clean export to ensure the latest asset changes are included
- **Assets not updating**: When you've replaced an image/audio file but the old version still appears in exports
- **Icon issues**: When the game icon or UI images show cached versions
- **After bulk asset changes**: When you've updated multiple assets at once

## Platform Selection

Ask the user which platform(s) to export:
- **Windows** (most common for testing)
- **Linux**
- **macOS**
- **All platforms** (for release builds)

If not specified, default to Windows only.

## Build Locations

Export presets are configured in `EchoesOfChoice/export_presets.cfg`:
- Windows: `build/windows/EchoesOfChoice.exe`
- Linux: `build/linux/EchoesOfChoice.x86_64`
- macOS: `build/macos/EchoesOfChoice.zip`

All paths are relative to the workspace root.

## Troubleshooting

**Import takes a long time**: This is normal for the first import after clearing cache. Godot is re-processing all ~2000 audio files and all images.

**Export fails**: Check that export templates are installed for Godot 4.6.1. Run the Godot editor and check Editor > Manage Export Templates.

**Missing DLLs**: Steam integration DLLs are automatically copied during export. If missing, check that the Steam plugin is properly installed.
