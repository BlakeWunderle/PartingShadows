using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class RotAura : Ability
    {
        public RotAura()
        {
            Name = "Rot Aura";
            FlavorText = "Decay radiates from the corrupted beast, withering all nearby.";
            ModifiedStat = StatEnum.MagicAttack;
            Modifier = 3;
            impactedTurns = 3;
            UseOnEnemy = true;
            ManaCost = 5;
            TargetAll = true;
            DamagePerTurn = 4;
        }
    }
}
