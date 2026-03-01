using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class Ambush : Ability
    {
        public Ambush()
        {
            Name = "Ambush";
            FlavorText = "Strikes from hiding with deadly precision.";
            ModifiedStat = StatEnum.PhysicalAttack;
            Modifier = 6;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 4;
        }
    }
}
