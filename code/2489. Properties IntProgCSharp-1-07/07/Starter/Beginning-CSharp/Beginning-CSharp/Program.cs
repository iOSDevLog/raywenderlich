using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Beginning_CSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            var service = new WebService();
            var data = service.GetStudentProfile(100);

            Console.WriteLine(data.student.FirstName + " " + data.student.LastName);
            Console.WriteLine(data.grades[0]);

        }
    }
}
