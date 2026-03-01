using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class Cleave : Ability
    {
        public Cleave()
        {
            Name = "Cleave";
            FlavorText = "A wide sweeping strike that cuts through multiple targets.";
            ModifiedStat = StatEnum.PhysicalAttack;
            Modifier = 4;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 4;
            TargetAll = true;
        }
    }
}
