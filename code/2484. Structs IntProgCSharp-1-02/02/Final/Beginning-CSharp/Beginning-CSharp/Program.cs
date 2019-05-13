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
            var tesla = new Car();
            tesla.Name = "Roadster";
            tesla.Engine = EngineType.electric;
            tesla.Color = "red";

            Console.WriteLine($"{tesla.Name} - {tesla.Color}");

        }
    }
}
