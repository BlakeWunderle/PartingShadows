using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class Siphon : Ability
    {
        public Siphon()
        {
            Name = "Siphon";
            FlavorText = "Draws the very essence from the target, healing the caster.";
            ModifiedStat = StatEnum.MagicAttack;
            Modifier = 12;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 6;
            LifeStealPercent = 0.5f;
        }
    }
}
