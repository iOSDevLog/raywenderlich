﻿using System;
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
            var averageStudent = new Student();
            averageStudent.FirstName = "Joe";
            averageStudent.LastName = "Average";
            averageStudent.GPA = 2.5;

            Console.WriteLine($"{averageStudent.FirstName} {averageStudent.LastName} - GPA: {averageStudent.GPA}");
            var grades = new double[] { 1.0, 2.0, 3.0 };
            averageStudent.CalculateGPA(grades);

            Console.WriteLine(averageStudent.GPA);



        }
    }
}