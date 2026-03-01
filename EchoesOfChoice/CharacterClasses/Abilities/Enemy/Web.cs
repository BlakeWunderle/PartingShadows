using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class Web : Ability
    {
        public Web()
        {
            Name = "Web";
            FlavorText = "Shoots a sticky web that tangles the target's limbs. Reduces speed.";
            ModifiedStat = StatEnum.Speed;
            Modifier = 5;
            impactedTurns = 2;
            UseOnEnemy = true;
            ManaCost = 3;
        }
    }
}
