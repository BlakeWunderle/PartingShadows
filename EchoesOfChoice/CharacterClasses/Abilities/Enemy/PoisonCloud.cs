using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class PoisonCloud : Ability
    {
        public PoisonCloud()
        {
            Name = "Poison Cloud";
            FlavorText = "Exhales a cloud of noxious fumes that sickens all enemies.";
            ModifiedStat = StatEnum.MagicAttack;
            Modifier = 4;
            impactedTurns = 3;
            UseOnEnemy = true;
            ManaCost = 5;
            TargetAll = true;
            DamagePerTurn = 5;
        }
    }
}
