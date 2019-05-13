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
            var totalBeers = 5;
            for (var i = 0; i < 5; i++)
            {
                if (i % 2 != 0) { break; }
                var bottlesOfBeer = (totalBeers - i == 1) ? "bottle of beer" : "bottles of beer";
                Console.WriteLine($"{totalBeers - i} {bottlesOfBeer} on the wall, {totalBeers - i} {bottlesOfBeer}");
                Console.WriteLine($"Take one down, pass it around, {totalBeers - (i+1)} {bottlesOfBeer} on the wall");
            }
        }
    }
}
