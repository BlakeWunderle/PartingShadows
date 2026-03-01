using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class DarkBlade : Ability
    {
        public DarkBlade()
        {
            Name = "Dark Blade";
            FlavorText = "A shadow-infused sword strike that cuts body and soul.";
            ModifiedStat = StatEnum.MixedAttack;
            Modifier = 12;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 5;
        }
    }
}
