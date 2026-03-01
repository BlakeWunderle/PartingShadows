using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class Stomp : Ability
    {
        public Stomp()
        {
            Name = "Stomp";
            FlavorText = "Slams the ground with tremendous force, shaking everything nearby.";
            ModifiedStat = StatEnum.PhysicalAttack;
            Modifier = 5;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 4;
            TargetAll = true;
        }
    }
}
