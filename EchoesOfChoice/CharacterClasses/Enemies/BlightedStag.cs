using EchoesOfChoice.CharacterClasses.Abilities.Enemy;
using EchoesOfChoice.CharacterClasses.Common;
using System.Collections.Generic;

namespace EchoesOfChoice.CharacterClasses.Enemies
{
    public class BlightedStag : BaseFighter
    {
        public BlightedStag(int level = 12)
        {
            Level = level;
            Health = Stat(190, 215, 5, 8, 12);
            MaxHealth = Health;
            PhysicalAttack = Stat(32, 38, 2, 4, 12);
            PhysicalDefense = Stat(18, 22, 1, 3, 12);
            MagicAttack = Stat(16, 20, 1, 2, 12);
            MagicDefense = Stat(16, 20, 1, 2, 12);
            Speed = Stat(28, 34, 2, 3, 12);
            Abilities = new List<Ability>() { new AntlerCharge(), new RotAura() };
            CharacterType = "Blighted Stag";
            Mana = Stat(16, 22, 1, 3, 12);
            MaxMana = Mana;
            CritChance = 15;
            CritDamage = 3;
            DodgeChance = 15;
        }

        public BlightedStag(BaseFighter fighter) : base(fighter) { }

        public override BaseFighter Clone()
        {
            return new BlightedStag(this);
        }

        public override void IncreaseLevel()
        {
            Level += 1;
            var healthIncrease = random.Next(5, 8);
            Health += healthIncrease;
            MaxHealth += healthIncrease;
            var manaIncrease = random.Next(1, 3);
            Mana += manaIncrease;
            MaxMana += manaIncrease;
            PhysicalAttack += random.Next(2, 4);
            PhysicalDefense += random.Next(1, 3);
            MagicAttack += random.Next(1, 2);
            MagicDefense += random.Next(1, 2);
            Speed += random.Next(2, 3);
        }

        public override BaseFighter UpgradeClass(UpgradeItemEnum upgradeItem)
        {
            throw new System.NotImplementedException();
        }
    }
}
