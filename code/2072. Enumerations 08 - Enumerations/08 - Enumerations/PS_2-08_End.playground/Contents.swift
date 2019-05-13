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
enum Month: Int {
  case january = 1, february, march, april, may, june, july, august, september, october, november, december
}

let month: Month = .october

enum Semester {
  /// 🍂
  case fall
  
  /// 🌸
  case spring
  
  /// 😎
  case summer
}

Semester.fall

let semester: Semester
switch month {
case .august, .september, .october, .november, .december:
  semester = .fall
case .january, .february, .march, .april, .may:
  semester = .spring
case .june, .july:
  semester = .summer
}

Month.january.rawValue
Month(rawValue: 5)
let monthsUntilWinterBreak = Month.december.rawValue - month.rawValue

enum TwoDimensionalPoint {
  case origin
  case onXAxis(Double)
  case onYAxis(Double)
  case noZeroCoordinate(Double, Double)
}

let coordinates = (0.0, 5.0)
let twoDimensionalPoint: TwoDimensionalPoint

switch coordinates {
case (0, 0):
  twoDimensionalPoint = .origin
case (_, 0):
  twoDimensionalPoint = .onXAxis(coordinates.0)
case (0, _):
  twoDimensionalPoint = .onYAxis(coordinates.1)
default:
  twoDimensionalPoint = .noZeroCoordinate(coordinates.0, coordinates.1)
}

let pointValue: (Double, Double)
switch twoDimensionalPoint {
case .origin:
  pointValue = (0, 0)
case let .onXAxis(x):
  pointValue = (x, 0)
case .onYAxis(let y):
  pointValue = (0, y)
case .noZeroCoordinate(let x, let y):
  pointValue = (x, y)
}
