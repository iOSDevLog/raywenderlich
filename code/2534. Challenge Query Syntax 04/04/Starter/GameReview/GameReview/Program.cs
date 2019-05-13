using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GameReview
{
    class Program
    {
        static void Main(string[] args)
        {
            var reviews = new List<GameReview>()
            {
                new GameReview()
                {
                    Name = "Bioshock Infinite",
                    Score = 9
                },
                new GameReview()
                {
                    Name = "Doom 2016",
                    Score = 8
                },
                new GameReview()
                {
                    Name = "Ride to Retribution",
                    Score = 1
                },
                new GameReview()
                {
                    Name = "Assassin's Creed Odyssey",
                    Score = 8.0
                },
                new GameReview()
                {
                    Name = "Call of Cthulhu",
                    Score = 5.0
                },
                new GameReview()
                {
                    Name = "ReCore",
                    Score = 6.0
                },
                new GameReview()
                {
                    Name = "Grand Theft Auto 5",
                    Score = 8.0
                }
            };
        }
    }
}
