using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class ArrowShot : Ability
    {
        public ArrowShot()
        {
            Name = "Arrow Shot";
            FlavorText = "Draws and fires with practiced precision.";
            ModifiedStat = StatEnum.PhysicalAttack;
            Modifier = 7;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 2;
        }
    }
}
