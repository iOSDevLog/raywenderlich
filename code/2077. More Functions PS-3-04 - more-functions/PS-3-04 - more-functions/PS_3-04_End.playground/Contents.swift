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
//: # More Functions
//: Function Overloading

func printMultipleOf(number: Int, multiplier: Int) {
  print("\(number) * \(multiplier) = \(number * multiplier)")
}

func printMultipleOf(_ number: Int, multiplier: Int = 1) {
  print("\(number) * \(multiplier) = \(number * multiplier)")
}

func printMultipleOf(number: Double, multiplier: Double) {
  print("\(number) * \(multiplier) = \(number * multiplier)")
}

printMultipleOf(number: 7.5, multiplier: 7.5)
printMultipleOf(17)

func getValue() -> Int {
  return 31
}

func getValue() -> String {
  return "meow"
}

let valueInt: Int = getValue()

func add(number1: Int, number2: Int) -> Int {
  return number1 + number2
}

var function = add
function(4, 2)

func subtract(number1: Int, number2: Int) -> Int {
  return number1 - number2
}
function = subtract
function(5, 7)

typealias Operate = (Int, Int) -> Int

func printResult(_ operation: Operate, _ a: Int, _ b: Int) {
  let result = operation(a, b)
  print(result)
}

printResult(add, 4, 2)
printResult(subtract, 4, 2)
