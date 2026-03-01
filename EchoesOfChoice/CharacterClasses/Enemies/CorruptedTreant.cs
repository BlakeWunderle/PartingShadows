using EchoesOfChoice.CharacterClasses.Abilities.Enemy;
using EchoesOfChoice.CharacterClasses.Common;
using System.Collections.Generic;

namespace EchoesOfChoice.CharacterClasses.Enemies
{
    public class CorruptedTreant : BaseFighter
    {
        public CorruptedTreant(int level = 11)
        {
            Level = level;
            Health = Stat(240, 270, 6, 10, 11);
            MaxHealth = Health;
            PhysicalAttack = Stat(28, 34, 2, 3, 11);
            PhysicalDefense = Stat(26, 30, 2, 3, 11);
            MagicAttack = Stat(12, 16, 1, 2, 11);
            MagicDefense = Stat(20, 24, 1, 3, 11);
            Speed = Stat(16, 22, 1, 2, 11);
            Abilities = new List<Ability>() { new VineWhip(), new RootSlam(), new BarkShield() };
            CharacterType = "Corrupted Treant";
            Mana = Stat(16, 22, 1, 3, 11);
            MaxMana = Mana;
            CritChance = 10;
            CritDamage = 3;
            DodgeChance = 5;
        }

        public CorruptedTreant(BaseFighter fighter) : base(fighter) { }

        public override BaseFighter Clone()
        {
            return new CorruptedTreant(this);
        }

        public override void IncreaseLevel()
        {
            Level += 1;
            var healthIncrease = random.Next(6, 10);
            Health += healthIncrease;
            MaxHealth += healthIncrease;
            var manaIncrease = random.Next(1, 3);
            Mana += manaIncrease;
            MaxMana += manaIncrease;
            PhysicalAttack += random.Next(2, 3);
            PhysicalDefense += random.Next(2, 3);
            MagicAttack += random.Next(1, 2);
            MagicDefense += random.Next(1, 3);
            Speed += random.Next(1, 2);
        }

        public override BaseFighter UpgradeClass(UpgradeItemEnum upgradeItem)
        {
            throw new System.NotImplementedException();
        }
    }
}
