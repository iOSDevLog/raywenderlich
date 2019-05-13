using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Beginning_CSharp
{
    class MyOperator
    {
        public delegate void Operation(int x, int y);
        public Operation Operations;

        public void PerformOperations(int x, int y)
        {
            if (Operations != null)
            {
                Operations(x, y);
            }
        }
    }
}
