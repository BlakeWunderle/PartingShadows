using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class DefensiveFormation : Ability
    {
        public DefensiveFormation()
        {
            Name = "Defensive Formation";
            FlavorText = "Locks shields in a disciplined formation. Increases all allies' defense.";
            ModifiedStat = StatEnum.Defense;
            Modifier = 4;
            impactedTurns = 2;
            UseOnEnemy = false;
            ManaCost = 3;
            TargetAll = true;
        }
    }
}
