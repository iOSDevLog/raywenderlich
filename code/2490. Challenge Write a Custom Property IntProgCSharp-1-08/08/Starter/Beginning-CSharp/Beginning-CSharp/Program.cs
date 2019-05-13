using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Beginning_CSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            var monster = new Monster();
            monster.Name = "Slime Monster";
            monster.Damage = 10;

            Console.WriteLine($"{monster.Name} does {monster.Damage} damage");
            monster.DoubleDamage = true;
            Console.WriteLine($"{monster.Name} does {monster.Damage} damage");

        }
    }
}
