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
            var monteCristo = new BookReview();
            monteCristo.SetName("The Count of Monte Cristo");
            monteCristo.SetScore(10);
            monteCristo.SetScore(100);

            Console.WriteLine($"{monteCristo.GetName()} - {monteCristo.GetScore()}");

        }
    }
}
