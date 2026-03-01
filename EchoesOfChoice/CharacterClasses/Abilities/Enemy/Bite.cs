using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class Bite : Ability
    {
        public Bite()
        {
            Name = "Bite";
            FlavorText = "Lunges forward with snapping jaws.";
            ModifiedStat = StatEnum.PhysicalAttack;
            Modifier = 3;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 2;
        }
    }
}
