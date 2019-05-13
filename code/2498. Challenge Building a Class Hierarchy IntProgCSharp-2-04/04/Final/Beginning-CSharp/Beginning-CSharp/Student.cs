using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Beginning_CSharp
{
    struct Student
    {
        public string FirstName;
        public string LastName;
        public double GPA;

        public void CalculateGPA(double[] grades)
        {
            foreach (var grade in grades)
            {
                GPA += grade;
            }
            if (GPA > 0)
            {
                GPA /= grades.Length + 1;
            }
            else
            {
                GPA /= grades.Length;
            }
        }

    }
}
