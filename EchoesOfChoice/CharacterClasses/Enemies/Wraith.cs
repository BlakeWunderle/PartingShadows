using EchoesOfChoice.CharacterClasses.Abilities.Enemy;
using EchoesOfChoice.CharacterClasses.Common;
using System.Collections.Generic;

namespace EchoesOfChoice.CharacterClasses.Enemies
{
    public class Wraith : BaseFighter
    {
        public Wraith(int level = 7)
        {
            Level = level;
            Health = Stat(110, 125, 4, 7, 7);
            MaxHealth = Health;
            PhysicalAttack = Stat(8, 12, 0, 2, 7);
            PhysicalDefense = Stat(10, 14, 1, 2, 7);
            MagicAttack = Stat(24, 28, 2, 3, 7);
            MagicDefense = Stat(18, 22, 1, 3, 7);
            Speed = Stat(26, 32, 2, 3, 7);
            Abilities = new List<Ability>() { new SoulDrain(), new Terrify() };
            CharacterType = "Wraith";
            Mana = Stat(18, 22, 2, 4, 7);
            MaxMana = Mana;
            CritChance = 15;
            CritDamage = 2;
            DodgeChance = 20;
        }

        public Wraith(BaseFighter fighter) : base(fighter) { }

        public override BaseFighter Clone()
        {
            return new Wraith(this);
        }

        public override void IncreaseLevel()
        {
            Level += 1;
            var healthIncrease = random.Next(4, 7);
            Health += healthIncrease;
            MaxHealth += healthIncrease;
            var manaIncrease = random.Next(2, 4);
            Mana += manaIncrease;
            MaxMana += manaIncrease;
            PhysicalAttack += random.Next(0, 2);
            PhysicalDefense += random.Next(1, 2);
            MagicAttack += random.Next(2, 3);
            MagicDefense += random.Next(1, 3);
            Speed += random.Next(2, 3);
        }

        public override BaseFighter UpgradeClass(UpgradeItemEnum upgradeItem)
        {
            throw new System.NotImplementedException();
        }
    }
}
