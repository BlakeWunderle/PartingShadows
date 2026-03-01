using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class DarkVeil : Ability
    {
        public DarkVeil()
        {
            Name = "Dark Veil";
            FlavorText = "Wraps in layers of shadow that deflect all attacks.";
            ModifiedStat = StatEnum.Defense;
            Modifier = 8;
            impactedTurns = 2;
            UseOnEnemy = false;
            ManaCost = 5;
        }
    }
}
