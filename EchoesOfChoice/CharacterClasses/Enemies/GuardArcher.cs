using EchoesOfChoice.CharacterClasses.Abilities.Enemy;
using EchoesOfChoice.CharacterClasses.Common;
using System.Collections.Generic;

namespace EchoesOfChoice.CharacterClasses.Enemies
{
    public class GuardArcher : BaseFighter
    {
        public GuardArcher(int level = 9)
        {
            Level = level;
            Health = Stat(130, 150, 4, 6, 9);
            MaxHealth = Health;
            PhysicalAttack = Stat(28, 32, 2, 3, 9);
            PhysicalDefense = Stat(14, 18, 1, 2, 9);
            MagicAttack = Stat(6, 10, 0, 2, 9);
            MagicDefense = Stat(14, 18, 1, 2, 9);
            Speed = Stat(26, 32, 2, 3, 9);
            Abilities = new List<Ability>() { new ArrowShot(), new Volley(), new PinDown() };
            CharacterType = "Guard Archer";
            Mana = Stat(14, 18, 1, 3, 9);
            MaxMana = Mana;
            CritChance = 20;
            CritDamage = 3;
            DodgeChance = 15;
        }

        public GuardArcher(BaseFighter fighter) : base(fighter) { }

        public override BaseFighter Clone()
        {
            return new GuardArcher(this);
        }

        public override void IncreaseLevel()
        {
            Level += 1;
            var healthIncrease = random.Next(4, 6);
            Health += healthIncrease;
            MaxHealth += healthIncrease;
            var manaIncrease = random.Next(1, 3);
            Mana += manaIncrease;
            MaxMana += manaIncrease;
            PhysicalAttack += random.Next(2, 3);
            PhysicalDefense += random.Next(1, 2);
            MagicAttack += random.Next(0, 2);
            MagicDefense += random.Next(1, 2);
            Speed += random.Next(2, 3);
        }

        public override BaseFighter UpgradeClass(UpgradeItemEnum upgradeItem)
        {
            throw new System.NotImplementedException();
        }
    }
}
