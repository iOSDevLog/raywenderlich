using System.Collections.Generic;
using System;

namespace Beginning_CSharp
{
    class Program
    {
        static void Main(string[] args)
        {

            var book = new Book()
            {
                Title = "The Count of Monte Cristo"
            };
            var library = new Library();
            Library.BookAdded bookAdded = delegate ()
            {
                Console.WriteLine("A book was added to the library");
            };
            library.OnBookAdded += bookAdded;
            library.AddBook(book);
        }
    }

    

}
