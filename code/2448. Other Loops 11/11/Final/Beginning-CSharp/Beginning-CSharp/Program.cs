using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Beginning_CSharp
{
    class Program
    { 
        enum EngineType
        {
            gasoline, electric, hybrid, hydrogen
        }
        static void Main(string[] args)
        {
            var names = new string[] { "Brian", "Douglas", "Moakley" };
            foreach (var name in names)
            {
                Console.Write($"{name} ");
            }
            Console.WriteLine("");
            var iterator = 0;
            while (true)
            {
                Console.Write($"{names[iterator]} ");
                iterator += 1;
                if (iterator == names.Length) { break;}
            }
            Console.WriteLine("");
            iterator = 0;
            do
            {
                Console.Write($"{names[iterator]} ");
                iterator += 1;
            } while (iterator < names.Length);
        }
    }
}
