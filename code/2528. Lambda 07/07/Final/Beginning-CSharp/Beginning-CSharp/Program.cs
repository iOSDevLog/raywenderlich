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
                "Frank", "Fred", "Ronnie", "Ted", "Fran", "Sean"
            };
            var fNames = names.FindAll(n => n[0].ToString().ToLower() == "f");
            foreach (var name in fNames)
            {
                Console.WriteLine(name);
            }
        }
    }

    

}
