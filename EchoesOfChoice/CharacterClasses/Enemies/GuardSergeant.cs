using EchoesOfChoice.CharacterClasses.Abilities;
using EchoesOfChoice.CharacterClasses.Abilities.Enemy;
using EchoesOfChoice.CharacterClasses.Common;
using System.Collections.Generic;

namespace EchoesOfChoice.CharacterClasses.Enemies
{
    public class GuardSergeant : BaseFighter
    {
        public GuardSergeant(int level = 9)
        {
            Level = level;
            Health = Stat(170, 195, 5, 8, 9);
            MaxHealth = Health;
            PhysicalAttack = Stat(30, 34, 2, 4, 9);
            PhysicalDefense = Stat(20, 24, 1, 3, 9);
            MagicAttack = Stat(8, 12, 0, 2, 9);
            MagicDefense = Stat(16, 20, 1, 2, 9);
            Speed = Stat(24, 30, 1, 3, 9);
            Abilities = new List<Ability>() { new SwordStrike(), new Rally(), new DecisiveBlow() };
            CharacterType = "Guard Sergeant";
            Mana = Stat(14, 18, 1, 3, 9);
            MaxMana = Mana;
            CritChance = 15;
            CritDamage = 3;
            DodgeChance = 10;
        }

        public GuardSergeant(BaseFighter fighter) : base(fighter) { }

        public override BaseFighter Clone()
        {
            return new GuardSergeant(this);
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
