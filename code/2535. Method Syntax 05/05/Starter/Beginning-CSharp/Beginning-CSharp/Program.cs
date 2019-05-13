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

            var after1980Movies = from movie in movies
                                  where movie.ReleaseDate > 1980
                                  select movie;
            //printMovies(after1980Movies);

            var before80s = from movie in movies
                            where movie.ReleaseDate < 1970 && movie.Runtime > 30
                            select movie;
            printMovies(before80s);

            var actorList = from movie in movies
                            join actor in actors on movie.Title equals actor.Movie
                            where movie.Title == "Mr. B Natural"
                            select actor;
            foreach (var actor in actorList)
            {
                Console.WriteLine(actor.Name);
            }


        }
        
    }

    

}
