using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class Tackle : Ability
    {
        public Tackle()
        {
            Name = "Tackle";
            FlavorText = "Leaps at the target, knocking them off balance.";
            ModifiedStat = StatEnum.PhysicalAttack;
            Modifier = 4;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 3;
        }
    }
}
