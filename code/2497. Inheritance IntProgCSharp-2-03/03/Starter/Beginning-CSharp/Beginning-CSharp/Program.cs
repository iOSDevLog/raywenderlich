using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using RayWenderlich.VideoCourse.ProgrammingWithCSharp;

namespace Beginning_CSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            var bigBoat = new Boat();
            bigBoat.Name = "Titanic";
            bigBoat.Tonnage = 46_000;

            Boat? mysteriousBoat = bigBoat;
            Boat mysteriousBoatValue = mysteriousBoat.Value;
            mysteriousBoatValue.Name = "Mary Celeste";
            mysteriousBoatValue.Tonnage = 247;

            Console.WriteLine($"{bigBoat.Name} - {bigBoat.Tonnage} tons");
            Console.WriteLine($"{mysteriousBoatValue.Name} - {mysteriousBoatValue.Tonnage} tons");

            mysteriousBoat = null;

            Console.WriteLine($"{bigBoat.Name} - {bigBoat.Tonnage} tons");
            Console.WriteLine($"{mysteriousBoatValue.Name} - {mysteriousBoatValue.Tonnage} tons");

        }
    }
}
