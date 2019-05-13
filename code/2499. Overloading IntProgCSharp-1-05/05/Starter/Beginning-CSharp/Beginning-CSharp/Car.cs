using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Beginning_CSharp
{
    enum EngineType
    {
        gasoline, electric, hybrid, hydrogen
    }

    struct Car
    {
        public string Name;
        public EngineType Engine;
        public string Color;
    }
}
