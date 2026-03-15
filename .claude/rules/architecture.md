# Project Architecture

Godot 4 project using GDScript at `EchoesOfChoice/`.

## File Map

All paths below are relative to `EchoesOfChoice/`.

### Core Data -- Shared (`scripts/data/`)
- `ability_data.gd` -- Ability model (name, type, modifier, targets, flavor text)
- `ability_db.gd` -- Ability factory: static methods returning AbilityData for enemy abilities
- `ability_db_player.gd` -- Player ability factory: static methods for all player class abilities
- `battle_data.gd` -- Battle definition (enemies, narrative text, choices, music_track)
- `battle_db.gd` -- Battle router: dispatches battle_id to story1/, story2/, and story3/ act modules
- `enums.gd` -- Shared enums (ability types, targeting, etc.)
- `fighter_data.gd` -- Fighter stat model (HP, MP, ATK, DEF, SPD, abilities, buffs/debuffs)
- `fighter_db.gd` -- Player class factory: base classes (T0), display names, ability lookups, upgrade preview with stat deltas
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

### Core Data -- Story 3 (`scripts/data/story3/`)
- `battle_db_s3.gd` -- Acts I-II battles (dream onset through cult discovery)
- `battle_db_s3_act3.gd` -- Act III battles (cult confrontation)
- `battle_db_s3_act45.gd` -- Acts IV-V battles (Loom approach through Woven Night)
- `enemy_db_s3.gd` -- Acts I-II enemies
- `enemy_db_s3_act3.gd` -- Act III enemies
- `enemy_db_s3_act45.gd` -- Acts IV-V enemies
- `enemy_ability_db_s3.gd` -- Story 3 enemy ability definitions

### Autoload (`scripts/autoload/`)
- `logger.gd` -- GameLog autoload: info/warn logging, clipboard export
- `scene_manager.gd` -- Scene transitions with fade overlay, loading spinner with random gameplay tips, stops music on transition
- `music_manager.gd` -- Background music with crossfade, context-based track pools (battle, exploration, town, menu, boss, cutscene), routed to Music bus
- `sfx_manager.gd` -- SFX playback with categorized sound pools, pitch variation, cooldowns, round-robin AudioStreamPlayer pool on SFX bus
- `audio_loader.gd` -- Static utility (class_name AudioLoader, not autoloaded): runtime audio file loading for WAV/OGG/MP3
- `input_config.gd` -- Input action registration with runtime keyboard remapping (gamepad hardcoded), binding persistence via SettingsManager
- `game_state.gd` -- Game state: party, battle progression, story tracking, phase tracking, playtime counter, Steam rich presence updates
- `save_manager.gd` -- Multi-slot save system (3 manual + autosave), JSON serialization with story_id, delete_save, Steam Cloud sync
- `unlock_manager.gd` -- Persistent unlock tracking (story completion, reward classes) via user://unlocks.json, Steam achievement hooks, Steam Cloud sync
- `pause_overlay.gd` -- CanvasLayer pause menu with save, settings, compendium, key bindings sub-menus, confirmation dialogs, ESC keybinding; multiplayer-aware (no tree pause, hide save, leave session); Open to Multiplayer with fighter picker
- `compendium_manager.gd` -- Cross-session enemy/class compendium tracking via user://compendium.json, Steam achievement hooks, Steam Cloud sync
- `settings_manager.gd` -- Global settings persistence (music/SFX/master volume, text speed, display mode, resolution, color blind mode with HP/MP/buff/debuff palettes, key bindings) via user://settings.json, Steam Cloud sync
- `steam_manager.gd` -- Steam SDK initialization, persona name, overlay detection, achievements, Cloud read/write/delete, rich presence
- `net_manager.gd` -- Multiplayer session manager: lobby create/join, peer tracking, slot assignment, transport abstraction (ENet/Steam), disconnect handling with AI takeover, game state broadcast for mid-game join
- `local_coop.gd` -- Local co-op manager: device tracking, input gating via _input() filter, slot-to-player mapping, active player control

### Scenes (`scenes/`)
- `splash/splash.gd/.tscn` -- Wunderelf Studios splash screen, auto-advances to title
- `title/title.gd/.tscn` -- Title screen with Continue/Load Game/New Game/Settings/Credits/Quit; New Game opens play mode submenu (Single/Co-op 2P/Co-op 3P/Online)
- `story_select/story_select.gd/.tscn` -- Story selection screen with lock state (New Game submenu)
- `controller_assign/controller_assign.gd/.tscn` -- Local co-op controller assignment: device registration, New Story/Load Save/Back menu
- `lobby/lobby.gd/.tscn` -- Multiplayer lobby: host/join, player list, player count toggle (2P/3P), story select, load save, fighter picker, start
- `party_creation/party_creation.gd/.tscn` -- Tavern intro + 3 character creation loops; multiplayer-aware with per-player creation and waiting overlay; local co-op device gating with player indicator
- `credits/credits.gd/.tscn` -- Scrolling credits scene with music, any-key skip
- `narrative/narrative.gd/.tscn` -- Pre/post-battle narrative text, branch choices, endings, defeat choices, story completion unlocks; multiplayer ready gate, branch voting
- `battle/battle.gd/.tscn` -- ATB battle scene with turn order, buff/debuff indicators, SFX on combat events, post-battle summary overlay, auto-battle mode (unlock-gated); multiplayer: host/guest code paths, remote action RPCs, state sync, disconnect recovery; local co-op device-gated turns
- `town_stop/town_stop.gd/.tscn` -- Town rest stops between battles with class upgrades and stat comparison preview; multiplayer ready gate, per-player upgrades, branch voting

### Battle Engine (`scripts/battle/`)
- `battle_engine.gd` -- ATB combat loop, turn resolution, ability execution, combat_event signal for floating damage numbers

### UI (`scripts/ui/`)
- `dialogue_panel.gd` -- Typewriter text display with configurable speed, input guards
- `choice_menu.gd` -- Vertical choice menu with keyboard/gamepad navigation, screen reader hints
- `name_input.gd` -- Text input for character naming
- `fighter_bar.gd` -- HP/MP bars with color-blind-aware palettes, status effect indicators, screen reader tooltips
- `combat_log.gd` -- Scrolling battle log with configurable font size
- `stats_panel.gd` -- Character stats display with close button
- `settings_panel.gd` -- Reusable settings UI (music/SFX/master volume sliders, speed/font/color blind dropdowns, toggles, key bindings button)
- `compendium_panel.gd` -- Compendium viewer with Enemies (by story) and Classes (by tier) tabs
- `confirm_dialog.gd` -- Modal Yes/No confirmation dialog with dark teal styling
- `tip_overlay.gd` -- One-time contextual tutorial tips with JSON persistence (user://tips_seen.json)
- `portrait_card.gd` -- Fighter portrait card with tweened HP/MP bars, floating damage numbers, death animation, status indicators, screen reader tooltips
- `waiting_overlay.gd` -- Animated "Waiting for [Player]..." overlay for multiplayer turn waits
- `virtual_keyboard.gd` -- On-screen keyboard for gamepad text input
- `fighter_picker.gd` -- Multiplayer fighter slot assignment overlay with host cycling and RPC sync
- `ready_gate.gd` -- Multi-player ready gate: blocks progression until all players confirm (local co-op + online)
- `vote_panel.gd` -- Multi-player branch voting: sequential (local co-op) or simultaneous (online) with majority/random tie-break
- `input_remap_panel.gd` -- Keyboard rebinding UI with per-action key capture, reset defaults, settings persistence

### Tools (`scripts/tools/` and `tools/`)
- `scripts/tools/battle_stage_db.gd` -- Battle stage definitions for balance simulator
- `scripts/tools/party_composer.gd` -- Party generation for simulation
- `scripts/tools/simulation_runner.gd` -- Battle simulation engine
- `tools/battle_simulator.gd` -- Headless battle simulator entry point

### Resources (`resources/`)
- `audio/default_bus_layout.tres` -- Audio bus layout: Master, Music (→Master), SFX (→Master)

### Assets (`assets/`)
- `audio/music/` -- ~70 music tracks across contexts (menu, battle, battle_dark, battle_scifi, boss, town, cutscene, game_over, victory)
- `audio/sfx/` -- ~1600 SFX files: combat subfolders (strike, impact, slash, spell, etc.) + ui/
- `art/ui/` -- Title background, Wunderelf Studios logo
- `art/battles/` -- 71 battle scene background images
- `fonts/` -- Oswald-Bold.ttf for game theme
