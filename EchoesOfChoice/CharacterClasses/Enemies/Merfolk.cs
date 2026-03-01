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
            Health = Stat(72, 85, 3, 6, 4);
            MaxHealth = Health;
            PhysicalAttack = Stat(18, 22, 1, 3, 4);
            PhysicalDefense = Stat(10, 14, 1, 2, 4);
            MagicAttack = Stat(14, 18, 1, 3, 4);
            MagicDefense = Stat(12, 16, 1, 2, 4);
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
            var healthIncrease = random.Next(3, 6);
            Health += healthIncrease;
            MaxHealth += healthIncrease;
            var manaIncrease = random.Next(1, 3);
            Mana += manaIncrease;
            MaxMana += manaIncrease;
            PhysicalAttack += random.Next(1, 3);
            PhysicalDefense += random.Next(1, 2);
            MagicAttack += random.Next(1, 3);
            MagicDefense += random.Next(1, 2);
            Speed += random.Next(1, 3);
        }

        public override BaseFighter UpgradeClass(UpgradeItemEnum upgradeItem)
        {
            throw new System.NotImplementedException();
        }
    }
}
