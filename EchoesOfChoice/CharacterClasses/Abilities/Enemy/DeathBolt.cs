using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class DeathBolt : Ability
    {
        public DeathBolt()
        {
            Name = "Death Bolt";
            FlavorText = "A crackling bolt of necrotic energy that withers flesh on contact.";
            ModifiedStat = StatEnum.MagicAttack;
            Modifier = 12;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 5;
        }
    }
}
