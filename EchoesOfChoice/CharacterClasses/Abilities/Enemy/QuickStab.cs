using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class QuickStab : Ability
    {
        public QuickStab()
        {
            Name = "Quick Stab";
            FlavorText = "A swift blade flashes in the dark.";
            ModifiedStat = StatEnum.PhysicalAttack;
            Modifier = 2;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 1;
        }
    }
}
