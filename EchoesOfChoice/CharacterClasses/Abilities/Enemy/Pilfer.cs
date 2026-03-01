using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class Pilfer : Ability
    {
        public Pilfer()
        {
            Name = "Pilfer";
            FlavorText = "Nimble fingers lighten the target's pockets and slow their step.";
            ModifiedStat = StatEnum.Speed;
            Modifier = 3;
            impactedTurns = 2;
            UseOnEnemy = true;
            ManaCost = 2;
        }
    }
}
