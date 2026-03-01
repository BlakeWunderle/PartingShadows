using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class Paralyze : Ability
    {
        public Paralyze()
        {
            Name = "Paralyze";
            FlavorText = "Necrotic venom courses through the wound, freezing muscles.";
            ModifiedStat = StatEnum.Speed;
            Modifier = 5;
            impactedTurns = 2;
            UseOnEnemy = true;
            ManaCost = 3;
        }
    }
}
