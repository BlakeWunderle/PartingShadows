using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class WarCry : Ability
    {
        public WarCry()
        {
            Name = "War Cry";
            FlavorText = "A ferocious shout that emboldens allies. Increases attack.";
            ModifiedStat = StatEnum.Attack;
            Modifier = 3;
            impactedTurns = 2;
            UseOnEnemy = false;
            ManaCost = 3;
            TargetAll = true;
        }
    }
}
