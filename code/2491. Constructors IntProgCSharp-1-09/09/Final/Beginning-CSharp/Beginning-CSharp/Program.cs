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
            var warrior = new NPC("Frank");
            Console.WriteLine(warrior.Name);
            Console.WriteLine(warrior.Health);
        }
    }
}
