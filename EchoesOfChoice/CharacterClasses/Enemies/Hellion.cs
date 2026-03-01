using EchoesOfChoice.CharacterClasses.Abilities.Enemy;
using EchoesOfChoice.CharacterClasses.Common;
using System.Collections.Generic;

namespace EchoesOfChoice.CharacterClasses.Enemies
{
    public class Hellion : BaseFighter
    {
        public Hellion(int level = 17)
        {
            Level = level;
            Health = Stat(260, 300, 8, 12, 17);
            MaxHealth = Health;
            PhysicalAttack = Stat(59, 67, 4, 6, 17);
            PhysicalDefense = Stat(30, 36, 2, 4, 17);
            MagicAttack = Stat(50, 58, 3, 5, 17);
            MagicDefense = Stat(28, 34, 2, 4, 17);
            Speed = Stat(36, 42, 3, 5, 17);
            Abilities = new List<Ability>() { new InfernalStrike(), new ShadowStrike(), new Hex() };
            CharacterType = "Hellion";
            Mana = Stat(34, 40, 3, 5, 17);
            MaxMana = Mana;
            CritChance = 27;
            CritDamage = 4;
            DodgeChance = 21;
        }

        public Hellion(BaseFighter fighter) : base(fighter) { }

        public override BaseFighter Clone()
        {
            return new Hellion(this);
        }

        public override void IncreaseLevel()
        {
            Level += 1;
            var healthIncrease = random.Next(0, 1);
            Health += healthIncrease;
            MaxHealth += healthIncrease;
            var manaIncrease = random.Next(0, 1);
            Mana += manaIncrease;
            MaxMana += manaIncrease;
            PhysicalAttack += random.Next(0, 1);
            PhysicalDefense += random.Next(0, 1);
            MagicAttack += random.Next(0, 1);
            MagicDefense += random.Next(0, 1);
            Speed += random.Next(0, 1);
        }

        public override BaseFighter UpgradeClass(UpgradeItemEnum upgradeItem)
        {
            throw new System.NotImplementedException();
        }
    }
}
