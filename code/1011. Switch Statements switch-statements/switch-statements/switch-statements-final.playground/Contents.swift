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
 
let number = 4
switch number {
  case 0:
    print("Zero")
  case 1...9:
    print("Between 1 and 9")
  case 10:
    print("Ten")
  default:
    print("Undefined")
}

let string = "Pigs"
switch string {
  case "Dog", "Cat":
    print("Animal is a house pet.")
  default:
    print("Animal is not a house pet.")
}

switch number {
  case _ where number % 2 == 0:
    print("Even \(number)")
  default:
    print("Odd")
}

let coordinates = (x: 2, y: 4, z: 0)
switch coordinates {
  case (0, 0, 0):
    print("Origin")
  case (let x, 0, 0):
    print("On the x-axis at x=\(x).")
  case (0, let y, 0):
    print("On the y-axis at y=\(y).")
  case (0, 0, let z):
    print("On the z-axis at z=\(z).")
  case let (x, y, _) where y == x:
    print("Along the y=x line.")
  case let (x, y, _) where y == x * x:
    print("Along the y=x^2 line.")
  case let (x, y, z):
    print("Somewhere in space at x=\(x), y=\(y), and z=\(z).")
}

