using EchoesOfChoice.CharacterClasses.Common;

namespace EchoesOfChoice.CharacterClasses.Abilities.Enemy
{
    public class TidalSplash : Ability
    {
        public TidalSplash()
        {
            Name = "Tidal Splash";
            FlavorText = "Conjures a wave of saltwater that crashes over all enemies.";
            ModifiedStat = StatEnum.MagicAttack;
            Modifier = 5;
            impactedTurns = 0;
            UseOnEnemy = true;
            ManaCost = 4;
            TargetAll = true;
        }
    }
}
