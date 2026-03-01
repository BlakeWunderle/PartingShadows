using EchoesOfChoice.CharacterClasses.Abilities.Enemy;
using EchoesOfChoice.CharacterClasses.Common;
using System.Collections.Generic;

namespace EchoesOfChoice.CharacterClasses.Enemies
{
    public class Wisp : BaseFighter
    {
        public Wisp(int level = 4)
        {
            Level = level;
            Health = Stat(58, 82, 5, 9, 4);
            MaxHealth = Health;
            PhysicalAttack = Stat(6, 10, 1, 2, 4);
            PhysicalDefense = Stat(8, 13, 1, 2, 4);
            MagicAttack = Stat(22, 34, 3, 6, 4);
            MagicDefense = Stat(11, 18, 1, 3, 4);
            Speed = Stat(28, 38, 2, 3, 4);
            Abilities = new List<Ability>() { new Lure(), new Bewitch() };
            CharacterType = "Wisp";
            Mana = Stat(24, 40, 2, 5, 4);
            MaxMana = Mana;
            CritChance = 10;
            CritDamage = 1;
            DodgeChance = 30;
        }

        public Wisp(BaseFighter fighter) : base(fighter) { }

        public override BaseFighter Clone()
        {
            return new Wisp(this);
        }

        public override void IncreaseLevel()
        {
            Level += 1;
            var healthIncrease = random.Next(5, 10);
            Health += healthIncrease;
            MaxHealth += healthIncrease;
            var manaIncrease = random.Next(2, 5);
            Mana += manaIncrease;
            MaxMana += manaIncrease;
            PhysicalAttack += random.Next(1, 2);
            PhysicalDefense += random.Next(1, 2);
            MagicAttack += random.Next(3, 6);
            MagicDefense += random.Next(2, 4);
            Speed += random.Next(2, 3);
        }

        public override BaseFighter UpgradeClass(UpgradeItemEnum upgradeItem)
        {
            throw new System.NotImplementedException();
        }
    }
}
