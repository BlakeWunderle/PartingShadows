using EchoesOfChoice.CharacterClasses.Common;
using EchoesOfChoice.CharacterClasses.Abilities;
using System.Collections.Generic;

namespace EchoesOfChoice.CharacterClasses.Scholar
{
    public class Chronomancer : BaseFighter
    {
        public Chronomancer()
        {
            Abilities = new List<Ability>() { new WarpSpeed(), new TimeBomb(), new TimeFreeze() };
            CharacterType = "Chronomancer";
            CritChance = 10;
            CritDamage = 1;
            DodgeChance = 10;
        }

        public Chronomancer(BaseFighter fighter) : base(fighter) { }

        public override BaseFighter Clone()
        {
            return new Chronomancer(this);
        }

        protected override void ApplyUpgradeBonuses()
        {
            MagicAttack += 5;
            Speed += 7;
            MagicDefense += 3;
        }

        public override void IncreaseLevel()
        {
            Level += 1;
            var healthIncrease = random.Next(11, 14);
            Health += healthIncrease;
            MaxHealth += healthIncrease;
            var manaIncrease = random.Next(7, 10);
            Mana += manaIncrease;
            MaxMana += manaIncrease;
            PhysicalAttack += random.Next(2, 4);
            PhysicalDefense += random.Next(2, 4);
            MagicAttack += random.Next(5, 8);
            MagicDefense += random.Next(5, 8);
            Speed += random.Next(1, 3);
        }

        public override BaseFighter UpgradeClass(UpgradeItemEnum upgradeItem)
        {
            throw new System.NotImplementedException();
        }
    }
}
