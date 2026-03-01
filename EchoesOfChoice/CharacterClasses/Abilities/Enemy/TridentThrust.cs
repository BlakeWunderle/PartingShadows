using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class TridentThrust : Ability
    {
        public TridentThrust()
        {
            Name = "Trident Thrust";
            FlavorText = "A precise strike with a coral-tipped trident.";
            ModifiedStat = StatEnum.PhysicalAttack;
            Modifier = 6;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 3;
        }
    }
}
