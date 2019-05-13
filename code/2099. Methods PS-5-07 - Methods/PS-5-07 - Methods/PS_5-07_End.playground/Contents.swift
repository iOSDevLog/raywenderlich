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
enum Weekday: CaseIterable {
  case monday, tuesday, wednesday, thursday, friday, saturday, sunday
  
  mutating func advance(by dayCount: UInt) {
    let indexOfToday = Weekday.allCases.firstIndex(of: self)!
    let indexOfAdvancedDay = indexOfToday + Int(dayCount)
    
    self = Weekday.allCases[indexOfAdvancedDay % Weekday.allCases.count]
  }
}

Weekday.allCases
var weekday: Weekday = .tuesday
weekday.advance(by: 6)

struct Time {
  var day: Weekday
  var hour: UInt

  init(day: Weekday, hour: UInt = 0) {
    self.day = day
    self.hour = hour
  }

  mutating func advance(byHours hourCount: UInt) {
    self = self.advanced(byHours: hourCount)
  }
  
  func advanced(byHours hourCount: UInt) -> Time {
    let (dayCount, hour) = (self.hour + hourCount).quotientAndRemainder(dividingBy: 24)
    var time = self
    time.day.advance(by: dayCount)
    time.hour = hour
    return time
  }
}

let time = Time(day: .monday)
var advancedTime = time.advanced(byHours: 24 * 3 + 5)
advancedTime.advance(byHours: 6)

enum Mathematics {
  static func getLength(x: Double, y: Double) -> Double {
    return (x * x + y * y).squareRoot()
  }
}

Mathematics.getLength(x: 3, y: 4)
