using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Beginning_CSharp
{
    interface ITransformer
    {
        string Word { get; set; }
        string Transform(string word);
    }
}
