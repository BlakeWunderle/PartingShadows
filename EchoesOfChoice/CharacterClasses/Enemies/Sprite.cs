using EchoesOfChoice.CharacterClasses.Abilities.Enemy;
using EchoesOfChoice.CharacterClasses.Common;
using System.Collections.Generic;

namespace EchoesOfChoice.CharacterClasses.Enemies
{
    public class Sprite : BaseFighter
    {
        public Sprite(int level = 4)
        {
            Level = level;
            Health = Stat(60, 84, 4, 9, 4);
            MaxHealth = Health;
            PhysicalAttack = Stat(19, 29, 2, 5, 4);
            PhysicalDefense = Stat(9, 16, 1, 3, 4);
            MagicAttack = Stat(10, 18, 1, 3, 4);
            MagicDefense = Stat(11, 18, 1, 3, 4);
            Speed = Stat(24, 35, 1, 3, 4);
            Abilities = new List<Ability>() { new Thorn(), new Pollen() };
            CharacterType = "Sprite";
            Mana = Stat(21, 37, 2, 5, 4);
            MaxMana = Mana;
            CritChance = 20;
            CritDamage = 1;
            DodgeChance = 30;
        }

        public Sprite(BaseFighter fighter) : base(fighter) { }

        public override BaseFighter Clone()
        {
            return new Sprite(this);
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
            PhysicalAttack += random.Next(3, 5);
            PhysicalDefense += random.Next(1, 3);
            MagicAttack += random.Next(1, 4);
            MagicDefense += random.Next(2, 4);
            Speed += random.Next(1, 3);
        }

        public override BaseFighter UpgradeClass(UpgradeItemEnum upgradeItem)
        {
            throw new System.NotImplementedException();
        }
    }
}
