using EchoesOfChoice.CharacterClasses.Abilities.Enemy;
using EchoesOfChoice.CharacterClasses.Common;
using System.Collections.Generic;

namespace EchoesOfChoice.CharacterClasses.Enemies
{
    public class Merfolk : BaseFighter
    {
        public Merfolk(int level = 4)
        {
            Level = level;
            Health = Stat(86, 102, 4, 7, 4);
            MaxHealth = Health;
            PhysicalAttack = Stat(22, 26, 2, 4, 4);
            PhysicalDefense = Stat(12, 17, 1, 3, 4);
            MagicAttack = Stat(17, 22, 2, 4, 4);
            MagicDefense = Stat(14, 19, 1, 3, 4);
            Speed = Stat(22, 28, 1, 3, 4);
            Abilities = new List<Ability>() { new TridentThrust(), new TidalSplash() };
            CharacterType = "Merfolk";
            Mana = Stat(12, 16, 1, 3, 4);
            MaxMana = Mana;
            CritChance = 10;
            CritDamage = 2;
            DodgeChance = 15;
        }

        public Merfolk(BaseFighter fighter) : base(fighter) { }

        public override BaseFighter Clone()
        {
            return new Merfolk(this);
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
            PhysicalAttack += random.Next(2, 4);
            PhysicalDefense += random.Next(1, 3);
            MagicAttack += random.Next(2, 4);
            MagicDefense += random.Next(1, 3);
            Speed += random.Next(1, 3);
        }

        public override BaseFighter UpgradeClass(UpgradeItemEnum upgradeItem)
        {
            throw new System.NotImplementedException();
        }
    }
}
