using System.Collections.Generic;
using System;

namespace Beginning_CSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            var movies = new Dictionary<int, string>()
            {
                [1966] = "The Good, The Bad, The Ugly",
                [1980] = "The Pumaman",
                [2018] = "Infinity War"
            };

            Console.WriteLine(movies[1966]);
            Console.WriteLine(movies[2018]);

        }



    }
}
