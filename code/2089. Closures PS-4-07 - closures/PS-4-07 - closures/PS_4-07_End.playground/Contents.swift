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
//: # Closures
//: Remember functions?
typealias Operate = (Int, Int) -> (Int)

func add(number1: Int, number2: Int) -> Int {
  return number1 + number2
}

func printResultOf(_ a: Int, _ b: Int, operation: Operate) {
  let result = operation(a, b)
  print("Result is \(result)")
}
printResultOf(5, 3, operation: add)

//let multiply: (Int, Int) -> Int = { (a: Int, b: Int) -> Int in
//  return a * b
//}

let multiply: (Int, Int) -> Int = { (a, b) in
  a * b
}

//let multiply: (Int, Int) -> Int = {
//  $0 * $1
//}

let divide: Operate = { a, b in
  return a / b
}

multiply(4, 2)

printResultOf(6, 8, operation: multiply)
printResultOf(92, 3, operation: divide)

printResultOf(4, 2) { $0 - $1 }

let voidClosure: () -> Void = {
  print("Yay, Swift!")
}

voidClosure()






//: Closures close over values!
//////////////
var count = 0
let incrementCount = {
  count += 1
}
/////////////

incrementCount()
incrementCount()
incrementCount()
incrementCount()
count


/////////////
func makeCountingClosure() -> () -> Int {
  var count = 0
  let incrementCount: () -> Int = {
    count += 1
    return count
  }
  return incrementCount
}
////////////

let counter1 = makeCountingClosure()
let counter2 = makeCountingClosure()

counter1()
counter2()
counter1()
counter2()
counter2()
