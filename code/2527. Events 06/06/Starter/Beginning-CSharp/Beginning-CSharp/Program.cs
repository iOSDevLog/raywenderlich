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
            Action<Book> processBook = delegate (Book aBook)
            {
                Console.WriteLine(aBook.Title);
            };

            Action sayHello = delegate ()
            {
                Console.WriteLine("Hello!");
            };
            processBook(book);
            sayHello();

            Func<int, int, string> subtract = delegate (int x, int y)
            {
                return (x - y).ToString();
            };
            Console.WriteLine(subtract(43, 21));
        }
    }

    

}
