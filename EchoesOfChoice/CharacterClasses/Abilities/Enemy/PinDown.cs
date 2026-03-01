using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class PinDown : Ability
    {
        public PinDown()
        {
            Name = "Pin Down";
            FlavorText = "A well-placed arrow pins the target's cloak to the ground. Reduces speed.";
            ModifiedStat = StatEnum.Speed;
            Modifier = 4;
            impactedTurns = 2;
            UseOnEnemy = true;
            ManaCost = 3;
        }
    }
}
