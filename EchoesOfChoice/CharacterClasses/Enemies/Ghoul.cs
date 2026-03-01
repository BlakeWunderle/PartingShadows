using EchoesOfChoice.CharacterClasses.Abilities.Enemy;
using EchoesOfChoice.CharacterClasses.Common;
using System.Collections.Generic;

namespace EchoesOfChoice.CharacterClasses.Enemies
{
    public class Ghoul : BaseFighter
    {
        public Ghoul(int level = 6)
        {
            Level = level;
            Health = Stat(92, 105, 3, 6, 6);
            MaxHealth = Health;
            PhysicalAttack = Stat(20, 24, 1, 3, 6);
            PhysicalDefense = Stat(12, 16, 1, 2, 6);
            MagicAttack = Stat(8, 12, 0, 2, 6);
            MagicDefense = Stat(10, 14, 1, 2, 6);
            Speed = Stat(26, 32, 2, 3, 6);
            Abilities = new List<Ability>() { new Claw(), new Paralyze(), new Devour() };
            CharacterType = "Ghoul";
            Mana = Stat(12, 16, 1, 3, 6);
            MaxMana = Mana;
            CritChance = 15;
            CritDamage = 2;
            DodgeChance = 15;
        }

        public Ghoul(BaseFighter fighter) : base(fighter) { }

        public override BaseFighter Clone()
        {
            return new Ghoul(this);
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
            Speed += random.Next(2, 3);
        }

        public override BaseFighter UpgradeClass(UpgradeItemEnum upgradeItem)
        {
            throw new System.NotImplementedException();
        }
    }
}
