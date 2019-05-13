using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Beginning_CSharp
{
    class MyCollection<T> where T : class, IMovement
    {
        IList<T> items;

        public MyCollection()
        {
            items = new List<T>();
        }

        public void AddItem(T item)
        {
            items.Add(item);
        }
    }
}
