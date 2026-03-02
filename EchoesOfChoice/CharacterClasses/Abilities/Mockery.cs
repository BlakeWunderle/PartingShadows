using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities
{
    public class Mockery : Ability
    {
        public Mockery()
        {
            Name = "Mockery";
            FlavorText = "A cruel, humiliating taunt that cuts deeper than any blade.";
            ModifiedStat = StatEnum.MixedAttack;
            Modifier = 2;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 1;
        }
    }
}
