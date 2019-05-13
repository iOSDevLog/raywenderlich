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
            var calc = new Calculator();
            calc.Add(10, 20);

            var numbers = new int[] { 1, 2, 3 };
            calc.Add(numbers);
        }
    }
}
