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
            gasoline, electric, hybrid
        }
        static void Main(string[] args)
        {
            EngineType engine = EngineType.electric;
            if (engine == EngineType.electric)
            {
                Console.WriteLine("Electric engine");
            }
            else
            {
                Console.WriteLine("There is a gas component");
            }            


        }
    }
}
