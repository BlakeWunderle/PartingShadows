using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class Howl : Ability
    {
        public Howl()
        {
            Name = "Howl";
            FlavorText = "A piercing howl rallies the pack. Increases allies' speed.";
            ModifiedStat = StatEnum.Speed;
            Modifier = 3;
            impactedTurns = 2;
            UseOnEnemy = false;
            ManaCost = 3;
            TargetAll = true;
        }
    }
}
