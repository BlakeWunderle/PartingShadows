using EchoesOfChoice.CharacterClasses.Abilities;
using EchoesOfChoice.CharacterClasses.Abilities.Enemy;
using EchoesOfChoice.CharacterClasses.Common;
using System.Collections.Generic;

namespace EchoesOfChoice.CharacterClasses.Enemies
{
    public class StrangerFinal : BaseFighter
    {
        public StrangerFinal(int level = 15)
        {
            Level = level;
            Health = Stat(380, 420, 10, 15, 15);
            MaxHealth = Health;
            PhysicalAttack = Stat(38, 44, 2, 4, 15);
            PhysicalDefense = Stat(30, 36, 2, 4, 15);
            MagicAttack = Stat(42, 48, 3, 5, 15);
            MagicDefense = Stat(30, 36, 2, 4, 15);
            Speed = Stat(34, 40, 2, 4, 15);
            Abilities = new List<Ability>() { new ShadowBlast(), new Siphon(), new DarkVeil(), new Unmake(), new Corruption() };
            CharacterType = "Stranger";
            Mana = Stat(40, 50, 3, 5, 15);
            MaxMana = Mana;
            CritChance = 25;
            CritDamage = 5;
            DodgeChance = 20;
        }

        public StrangerFinal(BaseFighter fighter) : base(fighter) { }

        public override BaseFighter Clone()
        {
            return new StrangerFinal(this);
        }

        public override void IncreaseLevel()
        {
            Level += 1;
            var healthIncrease = random.Next(10, 15);
            Health += healthIncrease;
            MaxHealth += healthIncrease;
            var manaIncrease = random.Next(3, 5);
            Mana += manaIncrease;
            MaxMana += manaIncrease;
            PhysicalAttack += random.Next(2, 4);
            PhysicalDefense += random.Next(2, 4);
            MagicAttack += random.Next(3, 5);
            MagicDefense += random.Next(2, 4);
            Speed += random.Next(2, 4);
        }

        public override BaseFighter UpgradeClass(UpgradeItemEnum upgradeItem)
        {
            throw new System.NotImplementedException();
        }
    }
}
