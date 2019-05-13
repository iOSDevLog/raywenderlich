using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using RayWenderlich.VideoCourse.ProgrammingWithCSharp;

namespace Beginning_CSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            var word = "The quick fox jumped over the lazy dog";
            Reverser reverse = new Reverser();
            var moveObject = (ICustomFormatter)reverse;

            //Console.WriteLine(moveObject.Transform(word));
            Console.WriteLine(reverse.Transform(word));


            
           
            

        }
    }
}
