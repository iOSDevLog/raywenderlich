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
 
 # Challenge Time! 😃
 
 Write a struct that represents a pizza. Include toppings, size and any other option you’d want.
 */

//: Add a method to `Restaurant` that can tell you if its delivery area overlaps with another restaurant's.
typealias Miles = Double

struct Location {
  let x: Miles
  let y: Miles
  
  func getDistance(_ location: Location) -> Miles {
    return abs(x - location.x) + abs(y - location.y)
  }
}

struct Restaurant {
  let location: Location
  var deliveryDistance: Miles
  
  func willDeliver(to location: Location) -> Bool {
    return self.location.getDistance(location) <= deliveryDistance
  }
}
//: Test if these two restaurants' delivery areas overlap. They should not!
let restaurant1 = Restaurant(location: Location(x: 0, y: 0), deliveryDistance: 2)
let restaurant2 = Restaurant(location: Location(x: 3, y: 3), deliveryDistance: 2)

//: Test these two as well. They should overlap!
let restaurant3 = Restaurant(location: Location(x: 2, y: 4), deliveryDistance: 2)
let restaurant4 = Restaurant(location: Location(x: 3, y: 5), deliveryDistance: 3)
