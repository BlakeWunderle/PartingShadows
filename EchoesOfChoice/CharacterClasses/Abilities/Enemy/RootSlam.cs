using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class RootSlam : Ability
    {
        public RootSlam()
        {
            Name = "Root Slam";
            FlavorText = "Massive roots burst from the ground, striking all enemies.";
            ModifiedStat = StatEnum.PhysicalAttack;
            Modifier = 7;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 5;
            TargetAll = true;
        }
    }
}
