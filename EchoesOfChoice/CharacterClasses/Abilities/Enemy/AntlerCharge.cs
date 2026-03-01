using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class AntlerCharge : Ability
    {
        public AntlerCharge()
        {
            Name = "Antler Charge";
            FlavorText = "Lowers corrupted antlers and charges with devastating force.";
            ModifiedStat = StatEnum.PhysicalAttack;
            Modifier = 12;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 5;
        }
    }
}
