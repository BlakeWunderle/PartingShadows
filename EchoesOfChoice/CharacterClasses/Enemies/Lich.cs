using EchoesOfChoice.CharacterClasses.Abilities.Enemy;
using EchoesOfChoice.CharacterClasses.Common;
using System.Collections.Generic;

namespace EchoesOfChoice.CharacterClasses.Enemies
{
    public class Lich : BaseFighter
    {
        public Lich(int level = 11)
        {
            Level = level;
            Health = Stat(230, 260, 6, 9, 11);
            MaxHealth = Health;
            PhysicalAttack = Stat(10, 14, 0, 2, 11);
            PhysicalDefense = Stat(16, 20, 1, 2, 11);
            MagicAttack = Stat(36, 42, 2, 4, 11);
            MagicDefense = Stat(28, 32, 2, 3, 11);
            Speed = Stat(26, 32, 1, 3, 11);
            Abilities = new List<Ability>() { new DeathBolt(), new RaiseDead(), new SoulCage() };
            CharacterType = "Lich";
            Mana = Stat(30, 38, 2, 4, 11);
            MaxMana = Mana;
            CritChance = 20;
            CritDamage = 4;
            DodgeChance = 15;
        }

        public Lich(BaseFighter fighter) : base(fighter) { }

        public override BaseFighter Clone()
        {
            return new Lich(this);
        }

        public override void IncreaseLevel()
        {
            Level += 1;
            var healthIncrease = random.Next(6, 9);
            Health += healthIncrease;
            MaxHealth += healthIncrease;
            var manaIncrease = random.Next(2, 4);
            Mana += manaIncrease;
            MaxMana += manaIncrease;
            PhysicalAttack += random.Next(0, 2);
            PhysicalDefense += random.Next(1, 2);
            MagicAttack += random.Next(2, 4);
            MagicDefense += random.Next(2, 3);
            Speed += random.Next(1, 3);
        }

        public override BaseFighter UpgradeClass(UpgradeItemEnum upgradeItem)
        {
            throw new System.NotImplementedException();
        }
    }
}
