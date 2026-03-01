using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class SwordStrike : Ability
    {
        public SwordStrike()
        {
            Name = "Sword Strike";
            FlavorText = "A disciplined blade strike honed by years of training.";
            ModifiedStat = StatEnum.PhysicalAttack;
            Modifier = 8;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 3;
        }
    }
}
