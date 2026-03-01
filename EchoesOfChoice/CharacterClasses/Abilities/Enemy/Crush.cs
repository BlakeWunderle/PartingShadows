using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class Crush : Ability
    {
        public Crush()
        {
            Name = "Crush";
            FlavorText = "Brings a massive fist down with bone-shattering force.";
            ModifiedStat = StatEnum.PhysicalAttack;
            Modifier = 8;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 4;
        }
    }
}
