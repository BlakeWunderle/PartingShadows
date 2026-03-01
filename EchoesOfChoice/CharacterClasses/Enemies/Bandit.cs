using EchoesOfChoice.CharacterClasses.Abilities;
using EchoesOfChoice.CharacterClasses.Abilities.Enemy;
using EchoesOfChoice.CharacterClasses.Common;
using System.Collections.Generic;

namespace EchoesOfChoice.CharacterClasses.Enemies
{
    public class Bandit : BaseFighter
    {
        public Bandit(int level = 3)
        {
            Level = level;
            Health = Stat(60, 72, 3, 6, 3);
            MaxHealth = Health;
            PhysicalAttack = Stat(18, 22, 1, 3, 3);
            PhysicalDefense = Stat(10, 14, 1, 2, 3);
            MagicAttack = Stat(4, 7, 0, 2, 3);
            MagicDefense = Stat(8, 12, 1, 2, 3);
            Speed = Stat(22, 28, 1, 3, 3);
            Abilities = new List<Ability>() { new Slash(), new Ambush() };
            CharacterType = "Bandit";
            Mana = Stat(8, 12, 1, 3, 3);
            MaxMana = Mana;
            CritChance = 15;
            CritDamage = 2;
            DodgeChance = 10;
        }

        public Bandit(BaseFighter fighter) : base(fighter) { }

        public override BaseFighter Clone()
        {
            return new Bandit(this);
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
