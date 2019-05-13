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
            var text = "bottle(s) of beer";
            var amount = 5;
            //var lyric = amount + " " + text;
            var lyric = $"{amount} {text}";
            var takeOneDownLyric = "Take one down, pass it around";

            Console.WriteLine($"{lyric} on the wall");
            Console.WriteLine(lyric);
            Console.WriteLine(takeOneDownLyric);

            amount -= 1;
            lyric = $"{amount} {text}";
            Console.WriteLine(lyric);
            Console.WriteLine(takeOneDownLyric);

            amount -= 1;
            lyric = $"{amount} {text}";
            Console.WriteLine(lyric);
            Console.WriteLine(takeOneDownLyric);

            amount -= 1;
            lyric = $"{amount} {text}";
            Console.WriteLine(lyric);
            Console.WriteLine(takeOneDownLyric);

            amount -= 1;
            lyric = $"{amount} {text}";
            Console.WriteLine(lyric);
            Console.WriteLine(takeOneDownLyric);


        }
    }
}
