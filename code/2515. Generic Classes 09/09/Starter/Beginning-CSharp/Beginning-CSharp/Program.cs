using System.Collections.Generic;
using System;

namespace Beginning_CSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            string[] names = new string[] { "Bill", "Ted", "Frank", "Fred" };

        }

        static void ProcessNames(string[] names)
        {
            foreach (var name in names)
            {
                Console.WriteLine(name);
            }
        }



    }
}
