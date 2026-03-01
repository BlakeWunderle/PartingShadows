using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class Intimidate : Ability
    {
        public Intimidate()
        {
            Name = "Intimidate";
            FlavorText = "A menacing glare that weakens the target's resolve. Reduces attack.";
            ModifiedStat = StatEnum.Attack;
            Modifier = 3;
            impactedTurns = 2;
            UseOnEnemy = true;
            ManaCost = 2;
        }
    }
}
