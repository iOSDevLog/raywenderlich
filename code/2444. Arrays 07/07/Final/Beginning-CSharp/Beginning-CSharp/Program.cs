using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Beginning_CSharp
{
    class Program
    { 
        enum EngineType
        {
            gasoline, electric, hybrid, hydrogen
        }
        static void Main(string[] args)
        {
            int[] scores = new int[3];
            scores[0] = 60;
            scores[1] = 32;
            scores[2] = 66;

            var highScores = new int[]
            {
                130, 654, 234
            };
            var moreHighScores = new int[]
            {
                highScores[0], highScores[1], highScores[2], 549, 393, 654
            };
            int[,] playerScores = new int[,]
            {
                {30, 50, 10 },
                {42, 12, 60 }
            };
            Console.WriteLine(playerScores[0, 1]);
        }
    }
}
