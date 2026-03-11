# Project Architecture

Godot 4 project using GDScript at `EchoesOfChoice/`.

## File Map

All paths below are relative to `EchoesOfChoice/`.

### Core Data -- Shared (`scripts/data/`)
- `ability_data.gd` -- Ability model (name, type, modifier, targets, flavor text)
- `ability_db.gd` -- Ability factory: static methods returning AbilityData for enemy abilities
- `ability_db_player.gd` -- Player ability factory: static methods for all player class abilities
- `battle_data.gd` -- Battle definition (enemies, narrative text, choices, music_track)
- `battle_db.gd` -- Battle router: dispatches battle_id to story1/ and story2/ act modules
- `enums.gd` -- Shared enums (ability types, targeting, etc.)
- `fighter_data.gd` -- Fighter stat model (HP, MP, ATK, DEF, SPD, abilities, buffs/debuffs)
- `fighter_db.gd` -- Player class factory: base classes (T0), display names, ability lookups
- `fighter_db_t1.gd` -- Tier 1 class upgrades and level-up functions
- `fighter_db_t2.gd` -- Tier 2 class upgrades (A-M) and level-up functions
- `fighter_db_t2b.gd` -- Tier 2 class upgrades (N-Z) and level-up functions
- `story_db.gd` -- Story registry: available stories, unlock requirements, first battle IDs

### Core Data -- Story 1 (`scripts/data/story1/`)
- `battle_db_act1.gd` -- Act I battles (city streets, forest, waypoint, forest waypoint town)
- `battle_db_act2.gd` -- Act II battles (branching wilds)
- `battle_db_act3.gd` -- Act III battles (city return + tower reveal)
- `battle_db_act45.gd` -- Act IV-V battles (corruption + final)
- `enemy_db.gd` -- Act I enemies (thug, ruffian, pickpocket, wolf, boar, goblin, hound, bandit)
- `enemy_db_act2.gd` -- Act II enemies (raider through wraith, 26 types)
- `enemy_db_act345.gd` -- Acts III-V enemies (royal_guard through stranger_final, 17 types)
- `enemy_ability_db.gd` -- Story 1 enemy ability definitions

### Core Data -- Story 2 (`scripts/data/story2/`)
- `battle_db_s2.gd` -- Act I battles (cave awakening through cave exit)
- `battle_db_s2_act2.gd` -- Act II battles (coastal descent through lighthouse storm)
- `battle_db_s2_act3.gd` -- Act III battles (beneath lighthouse through the reveal)
- `battle_db_s2_act4.gd` -- Act IV battles (depths through Eye of Oblivion)
- `enemy_db_s2.gd` -- Act I enemies
- `enemy_db_s2_act2.gd` -- Act II enemies
- `enemy_db_s2_act3.gd` -- Act III enemies
- `enemy_db_s2_act4.gd` -- Act IV enemies
- `enemy_ability_db_s2.gd` -- Story 2 enemy ability definitions

### Autoload (`scripts/autoload/`)
- `logger.gd` -- GameLog autoload: info/warn logging, clipboard export
- `scene_manager.gd` -- Scene transitions with fade overlay, stops music on transition
- `music_manager.gd` -- Background music with crossfade, context-based track pools (battle, exploration, town, menu, boss, cutscene)
- `audio_loader.gd` -- Static utility (class_name AudioLoader, not autoloaded): runtime audio file loading for WAV/OGG/MP3
- `input_config.gd` -- Input action registration (keyboard + gamepad mappings)
- `game_state.gd` -- Game state: party, battle progression, story tracking, phase tracking
- `save_manager.gd` -- Multi-slot save system (3 manual + autosave), JSON serialization with story_id
- `unlock_manager.gd` -- Persistent unlock tracking (story completion, reward classes) via user://unlocks.json
- `pause_overlay.gd` -- CanvasLayer pause menu with save sub-menu, ESC keybinding

### Scenes (`scenes/`)
- `splash/splash.gd/.tscn` -- Wunderelf Studios splash screen, auto-advances to title
- `title/title.gd/.tscn` -- Title screen with Continue/Load Game/New Game/Quit
- `story_select/story_select.gd/.tscn` -- Story selection screen with lock state (New Game submenu)
- `party_creation/party_creation.gd/.tscn` -- Tavern intro + 3 character creation loops
- `narrative/narrative.gd/.tscn` -- Pre/post-battle narrative text, branch choices, endings, story completion unlocks
- `battle/battle.gd/.tscn` -- ATB battle scene with turn order, buff/debuff indicators
- `town_stop/town_stop.gd/.tscn` -- Town rest stops between battles with class upgrades

### Battle Engine (`scripts/battle/`)
- `battle_engine.gd` -- ATB combat loop, turn resolution, ability execution

### UI (`scripts/ui/`)
- `dialogue_panel.gd` -- Typewriter text display with input guards
- `choice_menu.gd` -- Vertical choice menu with keyboard/gamepad navigation
- `name_input.gd` -- Text input for character naming
- `fighter_bar.gd` -- HP/MP bars with status effect indicators
- `combat_log.gd` -- Scrolling battle log
- `stats_panel.gd` -- Character stats display with close button
- `virtual_keyboard.gd` -- On-screen keyboard for gamepad text input

### Tools (`scripts/tools/` and `tools/`)
- `scripts/tools/battle_stage_db.gd` -- Battle stage definitions for balance simulator
- `scripts/tools/party_composer.gd` -- Party generation for simulation
- `scripts/tools/simulation_runner.gd` -- Battle simulation engine
- `tools/battle_simulator.gd` -- Headless battle simulator entry point

### Assets (`assets/`)
- `audio/music/` -- ~70 music tracks across contexts (menu, battle, battle_dark, battle_scifi, boss, town, cutscene, game_over, victory)
- `art/ui/` -- Title background, Wunderelf Studios logo
- `art/battles/` -- 51 battle scene background images
- `fonts/` -- Oswald-Bold.ttf for game theme
