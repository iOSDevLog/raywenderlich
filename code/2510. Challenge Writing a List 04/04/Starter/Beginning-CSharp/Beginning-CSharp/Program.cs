using System.Collections.Generic;

namespace Beginning_CSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            List<string> myList = new List<string>();
            var anotherList = new List<string>()
            {
                "Tim", "Ted", "Tom"
            };

            myList.Add("Fred");
            myList.Add("Ellie");
            myList.Add("Tim");

            System.Console.WriteLine(myList[0]);

            myList.Remove("Fred");
            System.Console.WriteLine(myList[0]);
            myList.Clear();

            myList.Add(10.ToString());
        }



    }
}
