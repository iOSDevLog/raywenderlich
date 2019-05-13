using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Beginning_CSharp
{
    class Library
    {
        public delegate void BookAdded();
        public event BookAdded OnBookAdded;
        public IList<Book> Books { get; private set; }

        public Library()
        {
            Books = new List<Book>();
        }

        public void AddBook(Book book)
        {
            Books.Add(book);
            if (OnBookAdded != null)
            {
                OnBookAdded();
            }
        }

    }
}
