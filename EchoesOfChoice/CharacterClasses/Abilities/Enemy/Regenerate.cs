using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class Regenerate : Ability
    {
        public Regenerate()
        {
            Name = "Regenerate";
            FlavorText = "Wounds knit shut as flesh mends itself.";
            ModifiedStat = StatEnum.Health;
            Modifier = 15;
            impactedTurns = 0;
            UseOnEnemy = false;
            ManaCost = 4;
        }
    }
}
