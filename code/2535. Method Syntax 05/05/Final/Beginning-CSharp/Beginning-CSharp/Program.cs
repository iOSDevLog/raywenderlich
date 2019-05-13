using System.Collections.Generic;
using System;
using System.Linq;

namespace Beginning_CSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            var eegah = new Movie
            {
                Title = "Eegah",
                ReleaseDate = 1962,
                Runtime = 89
            };
            var spaceMutiny = new Movie
            {
                Title = "Space Mutiny",
                ReleaseDate = 1988,
                Runtime = 93
            };
            var caveDwellers = new Movie
            {
                Title = "Cave Dwellers",
                ReleaseDate = 1984,
                Runtime = 85
            };
            var atlanticRim = new Movie
            {
                Title = "Atlantic Rim",
                ReleaseDate = 2013,
                Runtime = 85
            };
            var mrB = new Movie
            {
                Title = "Mr. B Natural",
                ReleaseDate = 1956,
                Runtime = 26
            };
            var movies = new List<Movie>()
            {
                eegah, spaceMutiny, caveDwellers, atlanticRim, mrB
            };
            var actors = new List<Actor>()
            {
                new Actor()
                {
                    Name = "Betty Luster",
                    Movie = "Mr. B Natural"
                },
                new Actor()
                {
                    Name = "Bela Lugosi",
                    Movie = "Dracula"
                },
                new Actor()
                {
                    Name = "Joe Don Baker",
                    Movie = "Mitchell"
                }
            };


            Action<IEnumerable<Movie>> printMovies = (movieList) =>
            {
                foreach (var movie in movieList)
                {
                    Console.WriteLine(movie.Title);
                }
            };

            var after1980Movies = movies.Where(m => m.ReleaseDate > 1980);

            //printMovies(after1980Movies);

            var before80s = movies.Where(m => m.ReleaseDate < 1970 && m.Runtime > 30);

            //printMovies(before80s);

            var actorList = movies.Join(actors, m => m.Title, a => a.Movie, (movie, actor) => actor);

            foreach (var actor in actorList)
            {
                Console.WriteLine(actor.Name);
            }
            var singleMovie = movies.Where(m => m.Runtime > 30).Reverse().First();
            Console.WriteLine(singleMovie.Title);

        }
        
    }

    

}
