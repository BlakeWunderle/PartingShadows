using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class TalonRake : Ability
    {
        public TalonRake()
        {
            Name = "Talon Rake";
            FlavorText = "Swoops down and rakes with razor-sharp talons.";
            ModifiedStat = StatEnum.PhysicalAttack;
            Modifier = 7;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 3;
        }
    }
}
