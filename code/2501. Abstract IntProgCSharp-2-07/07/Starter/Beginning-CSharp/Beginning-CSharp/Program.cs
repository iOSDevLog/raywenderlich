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
            var wordTransform = new WordTransformer();
            var reverser = new Reverser();
            var upperReverser = new UpperCaseReverser();

            var word = "The quick fox jumped over the lazy dog";

            Console.WriteLine($"word transform: {wordTransform.Transform(word)}");
            Console.WriteLine($"reverser transform: {reverser.Transform(word)}");
            Console.WriteLine($"upper reverser transform: {upperReverser.Transform(word)}");
        }
    }
}
