using EchoesOfChoice.CharacterClasses.Abilities.Enemy;
using EchoesOfChoice.CharacterClasses.Common;
using System.Collections.Generic;

namespace EchoesOfChoice.CharacterClasses.Enemies
{
    public class DarkKnight : BaseFighter
    {
        public DarkKnight(int level = 13)
        {
            Level = level;
            Health = Stat(245, 275, 6, 10, 13);
            MaxHealth = Health;
            PhysicalAttack = Stat(34, 40, 2, 4, 13);
            PhysicalDefense = Stat(28, 32, 2, 3, 13);
            MagicAttack = Stat(22, 26, 1, 3, 13);
            MagicDefense = Stat(22, 26, 1, 3, 13);
            Speed = Stat(24, 30, 1, 3, 13);
            Abilities = new List<Ability>() { new DarkBlade(), new ShadowGuard(), new Cleave() };
            CharacterType = "Dark Knight";
            Mana = Stat(18, 24, 2, 4, 13);
            MaxMana = Mana;
            CritChance = 20;
            CritDamage = 4;
            DodgeChance = 10;
        }

        public DarkKnight(BaseFighter fighter) : base(fighter) { }

        public override BaseFighter Clone()
        {
            return new DarkKnight(this);
        }

        public override void IncreaseLevel()
        {
            Level += 1;
            var healthIncrease = random.Next(6, 10);
            Health += healthIncrease;
            MaxHealth += healthIncrease;
            var manaIncrease = random.Next(2, 4);
            Mana += manaIncrease;
            MaxMana += manaIncrease;
            PhysicalAttack += random.Next(2, 4);
            PhysicalDefense += random.Next(2, 3);
            MagicAttack += random.Next(1, 3);
            MagicDefense += random.Next(1, 3);
            Speed += random.Next(1, 3);
        }

        public override BaseFighter UpgradeClass(UpgradeItemEnum upgradeItem)
        {
            throw new System.NotImplementedException();
        }
    }
}
