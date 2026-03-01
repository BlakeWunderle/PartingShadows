using EchoesOfChoice.CharacterClasses.Abilities.Enemy;
using EchoesOfChoice.CharacterClasses.Common;
using System.Collections.Generic;

namespace EchoesOfChoice.CharacterClasses.Enemies
{
    public class CaveSpider : BaseFighter
    {
        public CaveSpider(int level = 13)
        {
            Level = level;
            Health = Stat(205, 235, 5, 8, 13);
            MaxHealth = Health;
            PhysicalAttack = Stat(28, 34, 2, 3, 13);
            PhysicalDefense = Stat(20, 24, 1, 3, 13);
            MagicAttack = Stat(10, 14, 0, 2, 13);
            MagicDefense = Stat(18, 22, 1, 2, 13);
            Speed = Stat(28, 34, 2, 3, 13);
            Abilities = new List<Ability>() { new VenomousBite(), new Web() };
            CharacterType = "Cave Spider";
            Mana = Stat(14, 18, 1, 3, 13);
            MaxMana = Mana;
            CritChance = 20;
            CritDamage = 3;
            DodgeChance = 20;
        }

        public CaveSpider(BaseFighter fighter) : base(fighter) { }

        public override BaseFighter Clone()
        {
            return new CaveSpider(this);
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
            PhysicalDefense += random.Next(1, 3);
            MagicAttack += random.Next(0, 2);
            MagicDefense += random.Next(1, 2);
            Speed += random.Next(2, 3);
        }

        public override BaseFighter UpgradeClass(UpgradeItemEnum upgradeItem)
        {
            throw new System.NotImplementedException();
        }
    }
}
