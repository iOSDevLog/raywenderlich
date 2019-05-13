using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Beginning_CSharp
{
    class WordTransformer
    {
        public string Word { get; set; }

        public WordTransformer(string word)
        {
            Console.WriteLine("WordTransformer constructor");
            Word = word;
        }

        public virtual string Transform()
        {
            return Word;
        }
    }
}
