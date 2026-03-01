using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class DarkPulse : Ability
    {
        public DarkPulse()
        {
            Name = "Dark Pulse";
            FlavorText = "A wave of shadow energy radiates outward, striking all enemies.";
            ModifiedStat = StatEnum.MagicAttack;
            Modifier = 10;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 6;
            TargetAll = true;
        }
    }
}
