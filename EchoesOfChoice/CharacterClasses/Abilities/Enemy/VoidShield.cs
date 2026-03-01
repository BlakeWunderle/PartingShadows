using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class VoidShield : Ability
    {
        public VoidShield()
        {
            Name = "Void Shield";
            FlavorText = "Wraps in a cocoon of dark energy that absorbs incoming blows.";
            ModifiedStat = StatEnum.Defense;
            Modifier = 6;
            impactedTurns = 2;
            UseOnEnemy = false;
            ManaCost = 4;
        }
    }
}
