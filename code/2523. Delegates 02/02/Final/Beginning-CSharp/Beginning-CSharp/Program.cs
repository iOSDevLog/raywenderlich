using System.Collections.Generic;
using System;

namespace Beginning_CSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            var myOperator = new MyOperator();
            var multipyOperation = new MultiplyOperation();
            var addOperation = new AdditiveOperation();

            myOperator.Operations += multipyOperation.MultiplyNumbers;
            myOperator.Operations += addOperation.AddNumbers;

            myOperator.PerformOperations(10, 20);

            myOperator.Operations -= addOperation.AddNumbers;

            myOperator.PerformOperations(10, 20);

        }
    }

    class MultiplyOperation
    {
        public void MultiplyNumbers(int x, int y)
        {
            Console.WriteLine(x * y);
        }
    }

    class AdditiveOperation
    {
        public void AddNumbers(int x, int y)
        {
            Console.WriteLine(x + y);
        }
    }

}
