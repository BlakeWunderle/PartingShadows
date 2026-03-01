using EchoesOfChoice.CharacterClasses.Abilities;
using EchoesOfChoice.CharacterClasses.Abilities.Enemy;
using EchoesOfChoice.CharacterClasses.Common;
using System.Collections.Generic;

namespace EchoesOfChoice.CharacterClasses.Enemies
{
    public class RoyalGuard : BaseFighter
    {
        public RoyalGuard(int level = 9)
        {
            Level = level;
            Health = Stat(155, 175, 5, 8, 9);
            MaxHealth = Health;
            PhysicalAttack = Stat(26, 30, 2, 3, 9);
            PhysicalDefense = Stat(24, 28, 2, 3, 9);
            MagicAttack = Stat(6, 10, 0, 2, 9);
            MagicDefense = Stat(18, 22, 1, 3, 9);
            Speed = Stat(22, 28, 1, 2, 9);
            Abilities = new List<Ability>() { new ShieldSlam(), new DefensiveFormation() };
            CharacterType = "Royal Guard";
            Mana = Stat(12, 16, 1, 3, 9);
            MaxMana = Mana;
            CritChance = 10;
            CritDamage = 2;
            DodgeChance = 10;
        }

        public RoyalGuard(BaseFighter fighter) : base(fighter) { }

        public override BaseFighter Clone()
        {
            return new RoyalGuard(this);
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
            PhysicalAttack += random.Next(2, 3);
            PhysicalDefense += random.Next(2, 3);
            MagicAttack += random.Next(0, 2);
            MagicDefense += random.Next(1, 3);
            Speed += random.Next(1, 2);
        }

        public override BaseFighter UpgradeClass(UpgradeItemEnum upgradeItem)
        {
            throw new System.NotImplementedException();
        }
    }
}
