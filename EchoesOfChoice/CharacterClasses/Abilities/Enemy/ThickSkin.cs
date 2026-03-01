using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class ThickSkin : Ability
    {
        public ThickSkin()
        {
            Name = "Thick Skin";
            FlavorText = "Toughened hide absorbs incoming blows. Increases defense.";
            ModifiedStat = StatEnum.Defense;
            Modifier = 4;
            impactedTurns = 2;
            UseOnEnemy = false;
            ManaCost = 3;
        }
    }
}
