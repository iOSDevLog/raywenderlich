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
            for (var i = 0; i < names.Length; i += 1) {
                Console.Write($"{names[i]} ");
            }
        }
    }
}
