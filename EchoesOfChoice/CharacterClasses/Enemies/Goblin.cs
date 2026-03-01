using EchoesOfChoice.CharacterClasses.Abilities.Enemy;
using EchoesOfChoice.CharacterClasses.Common;
using System.Collections.Generic;

namespace EchoesOfChoice.CharacterClasses.Enemies
{
    public class Goblin : BaseFighter
    {
        public Goblin(int level = 2)
        {
            Level = level;
            Health = Stat(30, 40, 2, 5, 2);
            MaxHealth = Health;
            PhysicalAttack = Stat(12, 16, 1, 3, 2);
            PhysicalDefense = Stat(5, 8, 0, 2, 2);
            MagicAttack = Stat(3, 6, 0, 2, 2);
            MagicDefense = Stat(5, 8, 0, 2, 2);
            Speed = Stat(26, 32, 2, 4, 2);
            Abilities = new List<Ability>() { new Stab(), new ThrowRock(), new Scurry() };
            CharacterType = "Goblin";
            Mana = Stat(6, 10, 1, 3, 2);
            MaxMana = Mana;
            CritChance = 10;
            CritDamage = 1;
            DodgeChance = 25;
        }

        public Goblin(BaseFighter fighter) : base(fighter) { }

        public override BaseFighter Clone()
        {
            return new Goblin(this);
        }

        public override void IncreaseLevel()
        {
            Level += 1;
            var healthIncrease = random.Next(2, 5);
            Health += healthIncrease;
            MaxHealth += healthIncrease;
            var manaIncrease = random.Next(1, 3);
            Mana += manaIncrease;
            MaxMana += manaIncrease;
            PhysicalAttack += random.Next(1, 3);
            PhysicalDefense += random.Next(0, 2);
            MagicAttack += random.Next(0, 2);
            MagicDefense += random.Next(0, 2);
            Speed += random.Next(2, 4);
        }

        public override BaseFighter UpgradeClass(UpgradeItemEnum upgradeItem)
        {
            throw new System.NotImplementedException();
        }
    }
}
