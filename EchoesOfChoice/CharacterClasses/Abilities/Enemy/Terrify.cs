using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class Terrify : Ability
    {
        public Terrify()
        {
            Name = "Terrify";
            FlavorText = "An otherworldly presence that saps the will to fight. Reduces attack.";
            ModifiedStat = StatEnum.Attack;
            Modifier = 4;
            impactedTurns = 2;
            UseOnEnemy = true;
            ManaCost = 3;
        }
    }
}
