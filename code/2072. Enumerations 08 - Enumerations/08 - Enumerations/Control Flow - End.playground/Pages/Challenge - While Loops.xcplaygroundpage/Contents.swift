//: [Previous](@previous)
//: # Challenge Time - While Loops! 😃
/*:
 Create a variable named `count` and set it equal to 0. Create a `while` loop with the condition `count < 10` which prints out "Count is `X`" (where `X` is replaced with the `count` value) and then increments `count` by 1.
 */


var count = 0
while count < 10 {
  print("Count is \(count)")
  count += 1
}


/*:
 **Simulate the roll of a six-sided die, and roll until you get a 6**
 Create a variable named count and set it equal to 0. Create another variable named roll and make it an Int. Create a repeat-while loop. Inside the loop, set roll equal to `Int.random(in: 1...6)`, which means to pick a random number between 1 and 6. Then increment count by 1. Finally, print "After `X` rolls, roll is `Y`" (where `X` is the value of count and `Y` is the value of roll). Set the loop condition so that the loop finishes when the first 6 is rolled.
 */


count = 0
var roll: Int = 0

repeat {
  roll = Int.random(in: 1...6)
  count += 1
  //    if count > 5 {
  //        break
  //    }
  print("After \(count) roll(s), roll is \(roll)")
} while roll != 6 && count < 5


/*:
 **Extra Challenge!**
 Stop the execution of the loop when `count` is greater than 5. You've learned two ways to do this so far in this course!
 */

//: [Next](@next)
