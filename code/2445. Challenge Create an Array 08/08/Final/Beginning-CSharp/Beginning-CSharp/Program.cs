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
            Console.WriteLine($"{names[0]} {names[1]} {names[2]}");
        }
    }
}
