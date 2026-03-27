# Ability Design Rules

## No mixing DoT and stat buff/debuff on the same ability

An ability with `damage_per_turn > 0` (DoT) must have `modifier = 0`.
An ability with `modifier > 0` and `turns > 0` (stat buff/debuff) must have `damage_per_turn = 0`.

These are mutually exclusive. Never combine them.

**Why:** The engine creates two separate `modified_stats` entries — one for the DOT tick, one for the stat change — both tied to the same `turns` counter. At expiry, the stat change reverses but the DOT entry is silently dropped. The interaction is confusing, untested, and produces unreliable results. Keep each ability doing one thing.

**Valid patterns:**
- `turns=0, modifier>0, dot=0` — instant damage/heal (modifier = damage formula bonus)
- `turns>0, modifier>0, dot=0` — stat buff/debuff with duration
- `turns>0, modifier=0, dot>0` — damage over time (use `stat=HEALTH` for clarity)
- `turns=0, modifier=0, steal>0` — life steal (steal applies in the instant branch)

**Examples of violations to fix:**
- Burning Brand: was `MAGIC_ATTACK, mod=7, turns=3, dot=7` → split: pure DOT only
- Poison Sting: was `MAGIC_DEFENSE, mod=5, turns=3, dot=7` → split: pure DOT only
- Corrosive Acid: was `MAGIC_ATTACK, mod=10, turns=3, dot=5` → split: pure DOT only

## Stats carry the load; modifiers fill the gap

Ability modifiers represent an ability's *extra* punch beyond what the class's stats already provide. They should not be inflated to compensate for weak stat growth. If a class's output is too low, fix the T2 upgrade stats or level-up rates first, then set modifiers at an appropriate level for those stats.

**Target output range at late T2 (prog 10-13):**
- Single-target damage ability: 35–50 total (stat diff + modifier)
- AoE damage ability: 30–45 per target (stat diff + modifier; lower modifier acceptable)
- Signature 5MP single: up to 50
