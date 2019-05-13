using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Beginning_CSharp
{
    class Dinosaur
    {
        public string Name { get; set; }
        protected void Roar()
        {
            Console.WriteLine("Roar!!!!!");
        }
    }
}
