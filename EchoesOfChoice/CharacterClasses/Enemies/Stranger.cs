using EchoesOfChoice.CharacterClasses.Abilities.Enemy;
using EchoesOfChoice.CharacterClasses.Common;
using System.Collections.Generic;

namespace EchoesOfChoice.CharacterClasses.Enemies
{
    public class Stranger : BaseFighter
    {
        public Stranger(int level = 10)
        {
            Level = level;
            Health = Stat(280, 320, 8, 12, 10);
            MaxHealth = Health;
            PhysicalAttack = Stat(32, 38, 2, 4, 10);
            PhysicalDefense = Stat(24, 28, 2, 3, 10);
            MagicAttack = Stat(34, 40, 2, 4, 10);
            MagicDefense = Stat(24, 28, 2, 3, 10);
            Speed = Stat(30, 36, 2, 3, 10);
            Abilities = new List<Ability>() { new ShadowStrike(), new DarkPulse(), new VoidShield(), new Drain() };
            CharacterType = "Stranger";
            Mana = Stat(30, 40, 2, 4, 10);
            MaxMana = Mana;
            CritChance = 20;
            CritDamage = 4;
            DodgeChance = 20;
        }

        public Stranger(BaseFighter fighter) : base(fighter) { }

        public override BaseFighter Clone()
        {
            return new Stranger(this);
        }

        public override void IncreaseLevel()
        {
            Level += 1;
            var healthIncrease = random.Next(8, 12);
            Health += healthIncrease;
            MaxHealth += healthIncrease;
            var manaIncrease = random.Next(2, 4);
            Mana += manaIncrease;
            MaxMana += manaIncrease;
            PhysicalAttack += random.Next(2, 4);
            PhysicalDefense += random.Next(2, 3);
            MagicAttack += random.Next(2, 4);
            MagicDefense += random.Next(2, 3);
            Speed += random.Next(2, 3);
        }

        public override BaseFighter UpgradeClass(UpgradeItemEnum upgradeItem)
        {
            throw new System.NotImplementedException();
        }
    }
}
