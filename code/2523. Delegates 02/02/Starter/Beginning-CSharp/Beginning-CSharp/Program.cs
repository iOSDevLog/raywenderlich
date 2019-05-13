using System.Collections.Generic;
using System;

namespace Beginning_CSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine(Program.ConvertItem<int>(30.5));
        }

        public static T ConvertItem<T>(object item)
        {
            Type objectType = typeof(T);
            return (T) Convert.ChangeType(item, objectType);
        }
    }
}
