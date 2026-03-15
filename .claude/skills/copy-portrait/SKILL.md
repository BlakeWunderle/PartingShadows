---
name: copy-portrait
description: Copy downloaded portrait images from Downloads to the project. Accepts one or more file paths (from Downloads) and maps them to the correct enemy/class portrait filename. Use when the user pastes downloaded Midjourney portrait file paths.
user_invocable: false
---

# Copy Portrait

Copies downloaded portrait images from the user's Downloads folder into the correct project directory.

## Destination Directories

| Type | Directory |
|------|-----------|
| Enemy portraits | `EchoesOfChoice/assets/art/portraits/enemies/` |
| Class portraits (male) | `EchoesOfChoice/assets/art/portraits/classes/` |
| Class portraits (female) | `EchoesOfChoice/assets/art/portraits/classes/` |

## Filename Mapping

When the user provides downloaded file paths, map them to the correct portrait name:

1. **Parse the Midjourney filename** -- extract the subject from the prompt text in the filename
2. **Match to the expected portrait name** from `midjourney_prompts.md`
3. **Copy with the correct name** (e.g., `thug.png`, `squire_m.png`)

### Enemy portraits
- One file per enemy type: `{enemy_type}.png`
- Example: `Duganer_street_thug_muscular_brawler_...png` -> `thug.png`

### Class portraits
- Two files per class (male/female): `{class}_m.png`, `{class}_f.png`
- Example: `Duganer_young_male_soldier_...png` -> `squire_m.png`

## Workflow

1. User pastes one or more file paths from Downloads
2. For each file:
   - Identify which portrait it corresponds to from the filename keywords
   - Copy to the correct destination with the correct name
3. Report what was copied

## After Copying

After copying a batch of portraits, run Godot import to generate `.import` files:

```bash
GODOT="C:/Users/blake/AppData/Local/Microsoft/WinGet/Packages/GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe/Godot_v4.6.1-stable_win64_console.exe"
"$GODOT" --path EchoesOfChoice --headless --import --quit
```

## Tracking Progress

After copying, report how many enemy portraits are now complete vs total needed (138 total enemy types across 3 stories).
