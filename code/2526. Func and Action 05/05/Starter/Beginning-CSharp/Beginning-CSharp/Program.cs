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
            Library.BookAdded myDelegate = delegate ()
            {
                Console.WriteLine("This space for rent");
            };
            library.ProcessBook += myDelegate;
            library.AddBook(book);
            library.ProcessBook -= book.PrintTitle;
            library.ProcessBook -= myDelegate;
            library.AddBook(book);

        }
    }

    

}
