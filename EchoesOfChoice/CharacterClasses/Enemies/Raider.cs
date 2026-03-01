using EchoesOfChoice.CharacterClasses.Abilities.Enemy;
using EchoesOfChoice.CharacterClasses.Common;
using System.Collections.Generic;

namespace EchoesOfChoice.CharacterClasses.Enemies
{
    public class Raider : BaseFighter
    {
        public Raider(int level = 4)
        {
            Level = level;
            Health = Stat(78, 90, 3, 6, 4);
            MaxHealth = Health;
            PhysicalAttack = Stat(20, 24, 1, 3, 4);
            PhysicalDefense = Stat(12, 16, 1, 2, 4);
            MagicAttack = Stat(4, 8, 0, 2, 4);
            MagicDefense = Stat(10, 14, 1, 2, 4);
            Speed = Stat(24, 30, 1, 3, 4);
            Abilities = new List<Ability>() { new Cleave(), new WarCry() };
            CharacterType = "Raider";
            Mana = Stat(10, 14, 1, 3, 4);
            MaxMana = Mana;
            CritChance = 15;
            CritDamage = 2;
            DodgeChance = 10;
        }

        public Raider(BaseFighter fighter) : base(fighter) { }

        public override BaseFighter Clone()
        {
            return new Raider(this);
        }

        public override void IncreaseLevel()
        {
            Level += 1;
            var healthIncrease = random.Next(3, 6);
            Health += healthIncrease;
            MaxHealth += healthIncrease;
            var manaIncrease = random.Next(1, 3);
            Mana += manaIncrease;
            MaxMana += manaIncrease;
            PhysicalAttack += random.Next(1, 3);
            PhysicalDefense += random.Next(1, 2);
            MagicAttack += random.Next(0, 2);
            MagicDefense += random.Next(1, 2);
            Speed += random.Next(1, 3);
        }

        public override BaseFighter UpgradeClass(UpgradeItemEnum upgradeItem)
        {
            throw new System.NotImplementedException();
        }
    }
}
