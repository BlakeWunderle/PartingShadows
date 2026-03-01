using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class VenomousBite : Ability
    {
        public VenomousBite()
        {
            Name = "Venomous Bite";
            FlavorText = "Fangs inject a burning venom that eats away at the target.";
            ModifiedStat = StatEnum.PhysicalAttack;
            Modifier = 8;
            impactedTurns = 3;
            UseOnEnemy = true;
            ManaCost = 4;
            DamagePerTurn = 4;
        }
    }
}
