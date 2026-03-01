using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class ThrowRock : Ability
    {
        public ThrowRock()
        {
            Name = "Throw Rock";
            FlavorText = "Hurls a jagged stone with surprising accuracy.";
            ModifiedStat = StatEnum.PhysicalAttack;
            Modifier = 3;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 2;
        }
    }
}
