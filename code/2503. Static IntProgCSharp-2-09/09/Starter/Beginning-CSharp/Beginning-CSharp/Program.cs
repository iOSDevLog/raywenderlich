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
            var upperReverser = new UpperCaseReverser(word);

            Console.WriteLine($"upper reverser transform: {upperReverser.Transform()}");
        }
    }
}
