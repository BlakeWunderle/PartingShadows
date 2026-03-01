using EchoesOfChoice.CharacterClasses.Abilities.Enemy;
using EchoesOfChoice.CharacterClasses.Common;
using System.Collections.Generic;

namespace EchoesOfChoice.CharacterClasses.Enemies
{
    public class Orc : BaseFighter
    {
        public Orc(int level = 4)
        {
            Level = level;
            Health = Stat(112, 130, 5, 8, 4);
            MaxHealth = Health;
            PhysicalAttack = Stat(25, 30, 2, 4, 4);
            PhysicalDefense = Stat(16, 20, 1, 3, 4);
            MagicAttack = Stat(3, 6, 0, 1, 4);
            MagicDefense = Stat(10, 14, 1, 2, 4);
            Speed = Stat(18, 24, 1, 2, 4);
            Abilities = new List<Ability>() { new Crush(), new ThickSkin() };
            CharacterType = "Orc";
            Mana = Stat(8, 12, 1, 3, 4);
            MaxMana = Mana;
            CritChance = 15;
            CritDamage = 3;
            DodgeChance = 5;
        }

        public Orc(BaseFighter fighter) : base(fighter) { }

        public override BaseFighter Clone()
        {
            return new Orc(this);
        }

        public override void IncreaseLevel()
        {
            Level += 1;
            var healthIncrease = random.Next(4, 7);
            Health += healthIncrease;
            MaxHealth += healthIncrease;
            var manaIncrease = random.Next(1, 3);
            Mana += manaIncrease;
            MaxMana += manaIncrease;
            PhysicalAttack += random.Next(2, 3);
            PhysicalDefense += random.Next(1, 3);
            MagicAttack += random.Next(0, 1);
            MagicDefense += random.Next(1, 2);
            Speed += random.Next(1, 2);
        }

        public override BaseFighter UpgradeClass(UpgradeItemEnum upgradeItem)
        {
            throw new System.NotImplementedException();
        }
    }
}
