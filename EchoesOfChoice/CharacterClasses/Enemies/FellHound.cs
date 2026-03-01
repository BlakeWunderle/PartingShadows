using EchoesOfChoice.CharacterClasses.Abilities.Enemy;
using EchoesOfChoice.CharacterClasses.Common;
using System.Collections.Generic;

namespace EchoesOfChoice.CharacterClasses.Enemies
{
    public class FellHound : BaseFighter
    {
        public FellHound(int level = 13)
        {
            Level = level;
            Health = Stat(195, 220, 5, 8, 13);
            MaxHealth = Health;
            PhysicalAttack = Stat(16, 20, 1, 2, 13);
            PhysicalDefense = Stat(18, 22, 1, 2, 13);
            MagicAttack = Stat(30, 36, 2, 4, 13);
            MagicDefense = Stat(22, 26, 1, 3, 13);
            Speed = Stat(30, 36, 2, 3, 13);
            Abilities = new List<Ability>() { new ShadowBite(), new HowlOfDread() };
            CharacterType = "Fell Hound";
            Mana = Stat(18, 24, 2, 4, 13);
            MaxMana = Mana;
            CritChance = 15;
            CritDamage = 3;
            DodgeChance = 20;
        }

        public FellHound(BaseFighter fighter) : base(fighter) { }

        public override BaseFighter Clone()
        {
            return new FellHound(this);
        }

        public override void IncreaseLevel()
        {
            Level += 1;
            var healthIncrease = random.Next(5, 8);
            Health += healthIncrease;
            MaxHealth += healthIncrease;
            var manaIncrease = random.Next(2, 4);
            Mana += manaIncrease;
            MaxMana += manaIncrease;
            PhysicalAttack += random.Next(1, 2);
            PhysicalDefense += random.Next(1, 2);
            MagicAttack += random.Next(2, 4);
            MagicDefense += random.Next(1, 3);
            Speed += random.Next(2, 3);
        }

        public override BaseFighter UpgradeClass(UpgradeItemEnum upgradeItem)
        {
            throw new System.NotImplementedException();
        }
    }
}
