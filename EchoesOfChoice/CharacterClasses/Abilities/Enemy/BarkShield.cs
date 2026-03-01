using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class BarkShield : Ability
    {
        public BarkShield()
        {
            Name = "Bark Shield";
            FlavorText = "Hardens bark plating to absorb incoming damage.";
            ModifiedStat = StatEnum.Defense;
            Modifier = 6;
            impactedTurns = 2;
            UseOnEnemy = false;
            ManaCost = 4;
        }
    }
}
