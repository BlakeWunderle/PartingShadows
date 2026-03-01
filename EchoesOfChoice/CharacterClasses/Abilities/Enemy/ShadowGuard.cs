using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class ShadowGuard : Ability
    {
        public ShadowGuard()
        {
            Name = "Shadow Guard";
            FlavorText = "Dark energy reinforces armor, absorbing incoming blows.";
            ModifiedStat = StatEnum.Defense;
            Modifier = 6;
            impactedTurns = 2;
            UseOnEnemy = false;
            ManaCost = 4;
        }
    }
}
