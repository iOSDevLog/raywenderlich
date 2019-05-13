using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Beginning_CSharp
{
    class InterestAccount : Account
    {
        public decimal Total
        {
            get
            {
                return Amount;
            }
        }
    }
}
