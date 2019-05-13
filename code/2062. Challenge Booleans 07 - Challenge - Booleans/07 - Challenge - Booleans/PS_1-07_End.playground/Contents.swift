/*:
 Copyright (c) 2018 Razeware LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 distribute, sublicense, create a derivative work, and/or sell copies of the
 Software in any work that is designed, intended, or marketed for pedagogical or
 instructional purposes related to programming, coding, application development,
 or information technology.  Permission for such use, copying, modification,
 merger, publication, distribution, sublicensing, creation of derivative works,
 or sale is expressly withheld.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 ---
 */

/*:
 ### BOOLEANS
 Create a constant called `myAge` and set it to your age. Then, create a constant called `isTeenager` that uses Boolean logic to determine if the age denotes someone in the age range of 13 to 19.
 */

let myAge = 35
let isTeenager = myAge >= 13 && myAge <= 19

/*:
 Create another constant called `leonardosAge` and set it to 14, the age of Leonardo in the 1984 Teenage Mutant Ninja Turtles comic. Then, create a constant called `eitherAreTeenagers` that uses Boolean logic to determine if either you or Leonardo are teenagers.
 */

let leonardosAge = 14
let eitherAreTeenagers = isTeenager || (leonardosAge >= 13 && leonardosAge <= 19)

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
 Create a constant called `answer` and use a ternary conditional operator to check if you are *not* a teenager and set it equal the same strings you printed in the above exercise. Then print out answer.
 */

let answer = !isTeenager ? "Not a teenager" : "Teenager"
print(answer)
