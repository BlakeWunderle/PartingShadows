class_name Enums

## Stat types matching C# StatEnum. Used for ability targeting and stat modification.
enum StatType {
	PHYSICAL_ATTACK,
	PHYSICAL_DEFENSE,
	MAGIC_ATTACK,
	MAGIC_DEFENSE,
	ATTACK,       ## Both physical + magic attack
	DEFENSE,      ## Both physical + magic defense
	SPEED,
	HEALTH,       ## Used for DoT effects
	MIXED_ATTACK, ## Average of physical + magic
	TAUNT,
	DODGE_CHANCE,
}

## Combat role archetypes for player classes and enemies.
enum Role {
	DPS,      ## Fast, frequent hits (high speed, crits, dodges)
	FIGHTER,  ## Sustained, moderate speed, consistent damage
	BURST,    ## Slow but massive per-hit damage (nukers)
	TANK,     ## Absorbs damage, protects allies
	SUPPORT,  ## Buffs, heals, debuffs
}

## Mechanical specialization subtypes. A class/enemy can have multiple.
enum Subtype {
	GLASS_CANNON, ## High damage, low survivability
	HEALER,       ## Restores ally HP (subtype of SUPPORT)
	BUFFER,       ## Increases ally stats
	DEBUFFER,     ## Reduces enemy stats
	DOT,          ## Damage over time specialist
	DRAIN,        ## Life steal / self-sustaining
	AOE,          ## Area-of-effect specialist
	EVASION,      ## High dodge chance
	CRIT,         ## High crit chance/damage specialist
}

## Primary damage type for a class or enemy.
enum DamageType {
	PHYSICAL, ## Scales with physical_attack
	MAGICAL,  ## Scales with magic_attack
	MIXED,    ## Uses both or average
}

## Enemy threat tier within a battle encounter.
enum EnemyTier {
	BOSS,      ## Named antagonist (Stranger, Threadmaster, etc.)
	ELITE,     ## Tougher-than-normal, mini-boss
	UNDERLING, ## Companion/add that appears alongside a boss
	STANDARD,  ## Regular enemy (default)
}
