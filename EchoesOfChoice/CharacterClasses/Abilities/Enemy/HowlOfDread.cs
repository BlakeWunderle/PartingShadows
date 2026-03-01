using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class HowlOfDread : Ability
    {
        public HowlOfDread()
        {
            Name = "Howl of Dread";
            FlavorText = "A bone-chilling howl that weakens the resolve of all enemies.";
            ModifiedStat = StatEnum.Attack;
            Modifier = 5;
            impactedTurns = 2;
            UseOnEnemy = true;
            ManaCost = 5;
            TargetAll = true;
        }
    }
}
