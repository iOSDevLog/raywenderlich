using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Beginning_CSharp
{
    class UpperCaseReverser : Reverser
    {
        public UpperCaseReverser(string word) : base(word)
        {
            Console.WriteLine("UpperCaseReverser constructor");
        }

        public override string Transform()
        {
            Word = base.Transform().ToUpper();
            return Word;
        }
    }
}
