/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
 
func printMultipleOf(multiplier: Int, value: Int = 1) {
  print("\(multiplier) * \(value) = \(multiplier * value)")
}

printMultipleOf(multiplier: 1, value: 2)

func printMultipleOf(_ multiplier: Int, and value: Int = 1) {
  print("\(multiplier) * \(value) = \(multiplier * value)")
}

printMultipleOf(1, and: 2)

func printMultipleOf(_ multiplier: Int, and value: Int = 1, another: Int) {
  print("\(multiplier) * \(value) = \(multiplier * value)")
}

func printMultipleOf(_ multiplier: Double, and value: Double = 1) {
  print("\(multiplier) * \(value) = \(multiplier * value)")
}

func getValue() -> Int {
  return 32
}
func getValue() -> String {
  return "hello"
}

let value: Int = getValue()
let value2: String = getValue()

func incrementAndPrint(_ value: inout Int) {
  value += 1
  print(value)
}

var value3 = 5
incrementAndPrint(&value3)

func add(_ a: Int, _ b: Int) -> Int {
  return a + b
}

var function = add
function(4, 2)

func subtract(_ a: Int, _ b: Int) -> Int {
  return a - b
}

function = subtract
function(4, 2)

typealias operation = (Int, Int) -> (Int)

func printResult(_ function: operation, _ a: Int, _ b: Int) {
  let result = function(a, b)
  print(result)
}
printResult(add, 4, 2)
printResult(subtract, 4, 2)




