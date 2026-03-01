using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class ShadowBlast : Ability
    {
        public ShadowBlast()
        {
            Name = "Shadow Blast";
            FlavorText = "Unleashes a devastating explosion of pure darkness.";
            ModifiedStat = StatEnum.MagicAttack;
            Modifier = 14;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 7;
            TargetAll = true;
        }
    }
}
