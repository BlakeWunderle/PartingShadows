using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class SoulCage : Ability
    {
        public SoulCage()
        {
            Name = "Soul Cage";
            FlavorText = "Imprisons a fragment of the target's soul, feeding on it.";
            ModifiedStat = StatEnum.MagicAttack;
            Modifier = 10;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 6;
            LifeStealPercent = 0.5f;
        }
    }
}
