using System.Collections.Generic;
using System;

namespace Beginning_CSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            var names = new List<string>()
            {
                "Ray", "Sam", "Chris"
            };
            foreach (var name in names)
            {
                Console.WriteLine(name);
            }

        }



    }
}
