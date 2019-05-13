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
            string name = null;
            var text = name + " Johnson";
            Console.WriteLine(text);
            string lastName = null;
            int? i = null;
            float? f = null;
            i += 1;

            Console.WriteLine($"number = {i}");

            string anotherName = null;
            Console.WriteLine(anotherName.ToUpper());


        }
    }
}
