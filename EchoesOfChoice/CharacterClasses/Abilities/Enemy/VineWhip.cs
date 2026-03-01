using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class VineWhip : Ability
    {
        public VineWhip()
        {
            Name = "Vine Whip";
            FlavorText = "Lashes out with thorned vines that tear at the target.";
            ModifiedStat = StatEnum.PhysicalAttack;
            Modifier = 9;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 3;
        }
    }
}
