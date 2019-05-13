using System.Collections.Generic;
using System;

namespace Beginning_CSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            Action<int, string> printMessage = (n, s) =>
            {
                for (int i = 0; i < n; i++)
                {
                    Console.WriteLine(s);
                }
            };
            Program.RunAction(printMessage);
        }

        public static void RunAction(Action<int, string> myAction)
        {
            myAction(10, "C# Rocks");
        }
    }

    

}
