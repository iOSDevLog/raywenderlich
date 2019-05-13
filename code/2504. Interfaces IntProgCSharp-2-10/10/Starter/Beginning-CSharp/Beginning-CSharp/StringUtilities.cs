using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Beginning_CSharp
{
    class StringUtilities
    {
        public static int ReverseCount { get; private set; }
        public int WordCount { get; set; }

        public static string Reverse(string word)
        {
            StringUtilities.ReverseCount += 1;
            var newWord = String.Empty;
            for (var i = 0; i < word.Length; i++)
            {
                int letterIndex = (word.Length - 1) - i;
                newWord += word[letterIndex];
            }
            WordCount += newWord.Length;
            return newWord;
        }
    }
}
