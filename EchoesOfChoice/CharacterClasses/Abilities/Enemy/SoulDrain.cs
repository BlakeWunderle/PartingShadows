using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class SoulDrain : Ability
    {
        public SoulDrain()
        {
            Name = "Soul Drain";
            FlavorText = "Reaches into the target's essence, feeding on their life force.";
            ModifiedStat = StatEnum.MagicAttack;
            Modifier = 6;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 4;
            LifeStealPercent = 0.5f;
        }
    }
}
