using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class Stab : Ability
    {
        public Stab()
        {
            Name = "Stab";
            FlavorText = "A quick jab with a rusty blade.";
            ModifiedStat = StatEnum.PhysicalAttack;
            Modifier = 2;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 1;
        }
    }
}
