using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class Volley : Ability
    {
        public Volley()
        {
            Name = "Volley";
            FlavorText = "Launches a rain of arrows that falls on all enemies.";
            ModifiedStat = StatEnum.PhysicalAttack;
            Modifier = 5;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 5;
            TargetAll = true;
        }
    }
}
