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
            var ipads = 300;
            var cars = 500;
            var consoles = 700;
            var totalItems = ipads + cars + consoles;
            var average = totalItems / 3;

            Console.WriteLine("The average is " + average);
        }
    }
}
