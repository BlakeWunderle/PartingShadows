using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class Scurry : Ability
    {
        public Scurry()
        {
            Name = "Scurry";
            FlavorText = "Skitters around erratically, becoming harder to hit.";
            ModifiedStat = StatEnum.DodgeChance;
            Modifier = 15;
            impactedTurns = 2;
            UseOnEnemy = false;
            ManaCost = 2;
        }
    }
}
