using EchoesOfChoice.CharacterClasses.Common;
using EchoesOfChoice.CharacterClasses.Abilities;
using System.Collections.Generic;
using System;

namespace EchoesOfChoice.CharacterClasses.Entertainer
{
    public class Bard : BaseFighter
    {
        public Bard()
        {
            Abilities = new List<Ability>() { new Seduce(), new Melody(), new Encourage() };
            CharacterType = "Bard";
            CritChance = 10;
            CritDamage = 1;
            DodgeChance = 20;
            UpgradeItems = new List<UpgradeItemEnum>() { UpgradeItemEnum.WarHorn, UpgradeItemEnum.Hat };
        }

        public Bard( BaseFighter fighter ) : base ( fighter ) { }

        public override BaseFighter Clone()
        {
            return new Bard(this);
        }

        protected override void ApplyUpgradeBonuses()
        {
            MagicAttack += 3;
            Speed += 3;
        }

        public override void IncreaseLevel()
        {
            Level += 1;
            var healthIncrease = random.Next(5, 8);
            Health += healthIncrease;
            MaxHealth += healthIncrease;
            var manaIncrease = random.Next(2, 5);
            Mana += manaIncrease;
            MaxMana += manaIncrease;
            PhysicalAttack += random.Next(3, 6);
            PhysicalDefense += random.Next(2, 4);
            MagicAttack += random.Next(3, 6);
            MagicDefense += random.Next(2, 4);
            Speed += random.Next(1, 3);
        }

        public override BaseFighter UpgradeClass(UpgradeItemEnum upgradeItem)
        {
            switch (upgradeItem)
            {
                case UpgradeItemEnum.Hat:
                    {
                        var upgradedUnit = new Minstrel();
                        upgradedUnit.KeepStatsOnUpgrade(this);
                        return upgradedUnit;
                    }
                case UpgradeItemEnum.WarHorn:
                    {
                        var upgradedUnit = new Warcrier();
                        upgradedUnit.KeepStatsOnUpgrade(this);
                        return upgradedUnit;
                    }
                default:
                    {
                        throw new Exception("How the fuck did you get that upgrade item!");
                    }
            }
        }
    }
}
