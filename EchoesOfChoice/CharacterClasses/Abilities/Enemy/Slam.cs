using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class Slam : Ability
    {
        public Slam()
        {
            Name = "Slam";
            FlavorText = "A massive fist crashes down with the weight of death behind it.";
            ModifiedStat = StatEnum.PhysicalAttack;
            Modifier = 10;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 4;
        }
    }
}
