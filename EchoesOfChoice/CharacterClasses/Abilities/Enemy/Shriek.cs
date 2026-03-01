using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class Shriek : Ability
    {
        public Shriek()
        {
            Name = "Shriek";
            FlavorText = "An ear-splitting screech that leaves all enemies reeling.";
            ModifiedStat = StatEnum.Speed;
            Modifier = 4;
            impactedTurns = 2;
            UseOnEnemy = true;
            ManaCost = 4;
            TargetAll = true;
        }
    }
}
