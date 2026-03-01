using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class ShadowBite : Ability
    {
        public ShadowBite()
        {
            Name = "Shadow Bite";
            FlavorText = "Jaws of pure darkness clamp down, draining warmth and light.";
            ModifiedStat = StatEnum.MagicAttack;
            Modifier = 10;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 4;
        }
    }
}
