using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RayWenderlich.VideoCourse.ProgrammingWithCSharp
{
    struct Score
    {
        public int Current { get; set; }
        public int Low { get; set; }

        public Score(int current, int low)
        {
            Current = current;
            Low = low;
        }

        public Score(int score) : this(score, score)
        {

        }
    }
}

namespace Beginning_CSharp
{
    struct Score
    {
        public int Current { get; set; }
        public int High { get; set; }

        public Score(int current, int high)
        {
            Current = current;
            High = high;
        }

        public Score(int score) : this(score, score)
        {

        }
    }
}
