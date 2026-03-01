using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class Drain : Ability
    {
        public Drain()
        {
            Name = "Drain";
            FlavorText = "Dark tendrils leech the target's vitality.";
            ModifiedStat = StatEnum.MagicAttack;
            Modifier = 8;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 5;
            LifeStealPercent = 0.5f;
        }
    }
}
