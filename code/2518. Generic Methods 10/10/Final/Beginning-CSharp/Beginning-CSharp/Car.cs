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

        public double Speed
        {
            get
            {
                Console.WriteLine(_speed);
                return _speed;
            }
            set
            {
                _speed = value;
                Console.WriteLine(value);
            }
        }


        private double _speed;

    }
}
