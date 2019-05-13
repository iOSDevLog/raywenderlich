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
            var word = "The quick fox jumped over the lazy dog";
            Console.WriteLine(StringUtilities.Reverse(word));
            Console.WriteLine(StringUtilities.Reverse(word));
            Console.WriteLine(StringUtilities.Reverse(word));
            Console.WriteLine(StringUtilities.Reverse(word));
            Console.WriteLine(StringUtilities.Reverse(word));
            Console.WriteLine(StringUtilities.Reverse(word));

            Console.WriteLine($"The reverse method was called {StringUtilities.ReverseCount}");
        }
    }
}
