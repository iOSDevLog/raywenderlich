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
            var message = (engine == EngineType.gasoline) ? "You are driving a gasoline engine" : 
                (engine == EngineType.electric) ? "You are driving an electric engine" : "You are driving a hybrid engine";
            Console.WriteLine(message);
        }
    }
}
