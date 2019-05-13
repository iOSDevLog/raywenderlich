using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Beginning_CSharp
{
    class Calculator
    {
        public void Add(int x, int y)
        {
            Console.WriteLine(x+y);
        }

        public void Add(int[] numbers)
        {
            var totalNumbers = 0;
            foreach (int number in numbers)
            {
                totalNumbers += number;
            }
            Console.WriteLine(totalNumbers);
        }
    }
}
