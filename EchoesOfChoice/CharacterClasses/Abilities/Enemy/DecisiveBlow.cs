using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class DecisiveBlow : Ability
    {
        public DecisiveBlow()
        {
            Name = "Decisive Blow";
            FlavorText = "A powerful overhead strike meant to end the fight.";
            ModifiedStat = StatEnum.PhysicalAttack;
            Modifier = 12;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 5;
        }
    }
}
