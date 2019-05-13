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
            EngineType engine = EngineType.hydrogen;
            var message = String.Empty;

            switch (engine)
            {
                case EngineType.gasoline:
                    message = "You are driving a gasoline engine";
                    break;
                case EngineType.electric:
                case EngineType.hybrid:
                    message = "You are driving an electric / hybrid engine";
                    break;
                default:
                    message = "You are driving future tech";
                    break;
            }

           
            Console.WriteLine(message);
        }
    }
}
