//: [Previous](@previous)
import Foundation

/*:
 ### BOOLEANS
 Create a constant called `myAge` and set it to your age. Then, create a constant called `isTeenager` that uses Boolean logic to determine if the age denotes someone in the age range of 13 to 19.
 */

let myAge = 35
let isTeenager = myAge >= 13 && myAge <= 19

/*:
 Create another constant called `leonardosAge` and set it to 14, the age of Leonardo in the 1984 Teenage Mutant Ninja Turtles comic. Then, create a constant called `eitherTeenagers` that uses Boolean logic to determine if either you or Leonardo are teenagers.
 */

let leonardosAge = 14
let eitherTeenagers = isTeenager || (leonardosAge >= 13 && leonardosAge <= 19)

/*:
 Create a constant called student and set it to your name as a string. Create a constant called author and set it to "Matt Galloway", the original author of these exercises. Create a constant called `authorIsStudent` that uses string equality to determine if student and author are equal.
 */

let student = "Catie Catterwaul"
let author = "Matt Galloway"
let authorIsStudent = student == author

/*:
 Create a constant called `studentBeforeAuthor` which uses string comparison to determine if student comes before author.
 */

let studentBeforeAuthor = student < author


/*:
 ### IF STATEMENTS AND BOOLEANS
 You've already created a constant called "myAge" and checked to see if you are a teenager. Using that information, write an if statement to print out "Teenager" if you're a teenager, and "Not a teenager" if you're not.
 */

if isTeenager {
  print("Teenager")
} else {
  print("Not a teenager")
}

/*:
 Create a constant called `answer` and use a ternary condition to check if you are *not* a teenager and set it equal the same strings you printed in the above exercise. Then print out answer.
 */

let answer = !isTeenager ? "Not a teenager" : "Teenager"
print(answer)

//: [Next](@next)
