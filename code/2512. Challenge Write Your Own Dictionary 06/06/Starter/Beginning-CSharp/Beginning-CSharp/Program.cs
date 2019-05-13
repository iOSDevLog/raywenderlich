using System.Collections.Generic;
using System;

namespace Beginning_CSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            var dictionary = new Dictionary<int, string>()
            {
                [65] = "Barely passing",
                [75] = "Passes but could be better",
                [85] = "Good, but try harder",
                [95] = "Awesome work",
                [100] = "God tier effort"
            };
            Console.WriteLine(dictionary[85]);
            dictionary[86] = "Good but not great";
            Console.WriteLine(dictionary[86]);
            dictionary.Remove(86);

            foreach (var key in dictionary.Keys)
            {
                Console.WriteLine($"{key} - {dictionary[key]}");
            }


        }



    }
}
