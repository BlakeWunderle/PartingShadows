using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class Charge : Ability
    {
        public Charge()
        {
            Name = "Charge";
            FlavorText = "Barrels forward with unstoppable momentum.";
            ModifiedStat = StatEnum.PhysicalAttack;
            Modifier = 7;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 4;
        }
    }
}
