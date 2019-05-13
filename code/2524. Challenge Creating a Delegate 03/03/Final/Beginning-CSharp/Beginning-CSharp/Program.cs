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
            library.ProcessBook += book.PrintTitle;
            library.AddBook(book);
            library.ProcessBook -= book.PrintTitle;

        }
    }

    

}
