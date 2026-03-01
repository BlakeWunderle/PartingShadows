using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class Gore : Ability
    {
        public Gore()
        {
            Name = "Gore";
            FlavorText = "Drives tusks into the target with brutal force.";
            ModifiedStat = StatEnum.PhysicalAttack;
            Modifier = 5;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 3;
        }
    }
}
