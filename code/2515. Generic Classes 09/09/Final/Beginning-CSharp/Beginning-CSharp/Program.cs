using System.Collections.Generic;
using System;

namespace Beginning_CSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            var collection = new MyCollection<int>();
            collection.AddItem(100);
            var anotherCollection = new MyCollection<string>();
            anotherCollection.AddItem("Hello World");
        }
    }
}
