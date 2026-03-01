using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class RaiseDead : Ability
    {
        public RaiseDead()
        {
            Name = "Raise Dead";
            FlavorText = "Calls upon fallen spirits to empower allies. Increases all allies' attack.";
            ModifiedStat = StatEnum.Attack;
            Modifier = 5;
            impactedTurns = 2;
            UseOnEnemy = false;
            ManaCost = 5;
            TargetAll = true;
        }
    }
}
