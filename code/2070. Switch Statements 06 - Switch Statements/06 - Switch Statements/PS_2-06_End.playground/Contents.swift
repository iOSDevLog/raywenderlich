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
let number = Int.max
let numberDescription: String

switch number {
case 0:
  numberDescription = "Zero"
case 1...9:
  numberDescription = "Between 1 and 9"
case let negativeNumber where negativeNumber < 0:
  numberDescription = "Negative"
case _ where number > .max / 2:
  numberDescription = "Very large!"
default:
  numberDescription = "No description"
}

let numberIsEven: Bool

switch number % 2 {
case 0:
  numberIsEven = true
default:
  numberIsEven = false
}

let animalString = "Elephant"
let isHousePet: Bool

switch animalString {
case "Dog", "Cat", "Potbellied Hamster":
  isHousePet = true
default:
  isHousePet = false
}

let coordinates = (2, 2)
let pointCategory: String

switch coordinates {
case (0, 0):
  pointCategory = "Origin"
case (let x, 0):
  pointCategory = "On the x-axis at \(x)"
case (0, let y):
  pointCategory = "On the y-axis at \(y)"
case _ where coordinates.0 == coordinates.1:
  pointCategory = "Along y = x"
case let (x, y) where y == x * x:
  pointCategory = "Along y = x ^ 2"
case let (x, y):
  pointCategory = "No zero coordinates. x = \(x), y = \(y)"
}
