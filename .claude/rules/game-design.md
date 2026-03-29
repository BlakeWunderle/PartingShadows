# Parting Shadows -- Design Reference

This file documents the design decisions for Parting Shadows.

The project is a visual RPG built in Godot 4 with GDScript at `PartingShadows/`.

## Class System

56 player classes. 6 base (Tier 0) -> 16 Tier 1 -> 34 Tier 2. See `class-trees.md` for the full tree structure. The GDScript data layer at `PartingShadows/scripts/data/` is the authoritative source for stat values and ability definitions.

## Combat Formulas

- Physical: `attacker.phys_atk - defender.phys_def` (min 0)
- Magic: `ability.modifier + attacker.mag_atk - defender.mag_def`
- Mixed: `ability.modifier + avg(phys+mag atk) - avg(phys+mag def)`
- Crit: roll 1-100, crit if <= crit_chance, adds crit_damage
- Dodge: roll 1-100, dodge if <= dodge_chance

## Current Battle System

- **ATB turn system**: Speed accumulates to 100 threshold, turn order prediction display
- **Abilities**: 5 types (damage, heal, buff, debuff, terrain), AoE targeting
- **Status effects**: Buff/debuff indicators on fighter bars, stat modification tracking
- **Progression**: Level-up after battles, class upgrades at town stops (T0 -> T1 -> T2)
