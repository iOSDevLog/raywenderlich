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
            var car = new Car();
            car.Speed = 100;
            Console.WriteLine(car.Speed);
        }
    }
}
