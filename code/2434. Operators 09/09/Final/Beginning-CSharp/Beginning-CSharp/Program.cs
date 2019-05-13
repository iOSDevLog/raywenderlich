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
            var addition = 10 + 20;
            var greeting = "Hello" + " " + "World";
            var anotherGreeting = "Hello world";
            Console.WriteLine(greeting);

            var name = "Ray";
            var yetAnotherGreeting = "hello " + name;
            Console.WriteLine(yetAnotherGreeting);
            Console.WriteLine($"hello {name}");

            var number = 10;
            number += 10;
            number *= 2;
            number -= 1;
            number /= 2;

            Console.WriteLine(10 % 2);
            Console.WriteLine(10 % 3);

        }
    }
}
