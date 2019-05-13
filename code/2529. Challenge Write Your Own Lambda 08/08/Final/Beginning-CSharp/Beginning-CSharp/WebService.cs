using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Beginning_CSharp
{
    struct WebService
    {
        public (Student student, int[] grades) GetStudentProfile(int id)
        {
            var student = new Student();
            student.FirstName = "Joe";
            student.LastName = "Average";
            var grades = new int[] { 40, 70, 40 };

            return (student, grades);
        }
    }
}
