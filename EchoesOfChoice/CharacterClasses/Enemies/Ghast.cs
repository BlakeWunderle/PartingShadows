using EchoesOfChoice.CharacterClasses.Abilities.Enemy;
using EchoesOfChoice.CharacterClasses.Common;
using System.Collections.Generic;

namespace EchoesOfChoice.CharacterClasses.Enemies
{
    public class Ghast : BaseFighter
    {
        public Ghast(int level = 11)
        {
            Level = level;
            Health = Stat(190, 215, 5, 8, 11);
            MaxHealth = Health;
            PhysicalAttack = Stat(32, 38, 2, 4, 11);
            PhysicalDefense = Stat(20, 24, 1, 3, 11);
            MagicAttack = Stat(14, 18, 1, 2, 11);
            MagicDefense = Stat(14, 18, 1, 2, 11);
            Speed = Stat(20, 26, 1, 2, 11);
            Abilities = new List<Ability>() { new Slam(), new PoisonCloud() };
            CharacterType = "Ghast";
            Mana = Stat(14, 18, 1, 3, 11);
            MaxMana = Mana;
            CritChance = 15;
            CritDamage = 3;
            DodgeChance = 5;
        }

        public Ghast(BaseFighter fighter) : base(fighter) { }

        public override BaseFighter Clone()
        {
            return new Ghast(this);
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
            MagicAttack += random.Next(1, 2);
            MagicDefense += random.Next(1, 2);
            Speed += random.Next(1, 2);
        }

        public override BaseFighter UpgradeClass(UpgradeItemEnum upgradeItem)
        {
            throw new System.NotImplementedException();
        }
    }
}
