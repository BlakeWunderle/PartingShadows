# Enemy Design Rules

## Every battle gets unique enemies

Never share enemy types across battles. Each battle must define its own enemy factory functions with unique names. If two battles need a similar archetype (e.g., a tanky melee fighter), create two separate enemies with different names, flavors, and stat profiles.

**Why:** Shared enemies create invisible stat coupling. Tuning one battle breaks another. Unique enemies per battle allow independent balance tuning.

## Enemies must fit the battle's flavor

An enemy's name, flavor text, abilities, and stats should make sense for the environment and narrative context of the battle it appears in. A cave battle gets cave creatures. An underwater battle gets aquatic predators. A library battle gets ink-and-page horrors.

Do not drop generic fantasy monsters into a scene just to fill a slot. If you need a tank for a fungal cave, make it a fungal tank, not a stone golem.

## Prioritize variety across the game

Before creating a new enemy, check what already exists in adjacent battles (same act, same progression). Avoid recycling the same creature archetypes repeatedly. The game already has plenty of constructs, wisps, shades, and guardians. Reach for fresh concepts:

- Animals, predators, parasites
- Animated objects (books, armor, tools)
- Environmental hazards given form (silt, ink, fungus, ice)
- Twisted versions of mundane things

If three consecutive battles all feature "ethereal floating things," something has gone wrong.

## Stat profiles must match the fantasy

An enemy's stats should reflect what it is:

| Fantasy | Stat Profile |
|---------|-------------|
| Armored brute | High HP, high phys_def, low speed, low dodge |
| Ambush predator | High speed, high crit, moderate HP, low def |
| Glass cannon caster | Low HP, low def, high mag_atk, moderate speed |
| Swarm/parasite | Low HP each, high dodge or crit, moderate atk |
| Tank/guardian | Highest HP in the battle, balanced def, low atk |

Do not give a "swift ambush predator" high HP and high defense. Do not give a "lumbering brute" 20% dodge chance.

## New enemies require updates across all systems

When adding a new enemy, update all of the following:

1. **Enemy factory** (`enemy_db_*.gd`) -- stat block and flavor text
2. **Enemy abilities** (`enemy_ability_db_*.gd`) -- ability definitions
3. **Enemy roles** (`enemy_roles.gd`) -- combat role, subtype, damage type, tier metadata
4. **Battle config** (`battle_db_*.gd`) -- add enemy to the battle's enemy array
5. **Battle stage DB** (`battle_stage_db*.gd`) -- update sim composition
6. **Enemy DB router** (`enemy_db_router.gd`) -- add routing entry
7. **Compendium registry** (`compendium_registry.gd`) -- add to enemy list

Missing any of these causes build errors, sim failures, or invisible enemies in the compendium.
