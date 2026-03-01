using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class Unmake : Ability
    {
        public Unmake()
        {
            Name = "Unmake";
            FlavorText = "Tears at the fabric of the target's existence with overwhelming force.";
            ModifiedStat = StatEnum.MixedAttack;
            Modifier = 18;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 8;
        }
    }
}
