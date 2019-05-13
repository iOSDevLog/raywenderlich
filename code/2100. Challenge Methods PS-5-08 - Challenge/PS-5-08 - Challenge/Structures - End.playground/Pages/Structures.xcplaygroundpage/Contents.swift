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
typealias Miles = Double

struct Location {
    let x: Miles
    let y: Miles
    
    func getDistance(_ location: Location) -> Double {
        return abs(x - location.x) + abs(y - location.y)
    }
}

let distance = Location(x: 2, y: 3).getDistance(Location(x: 5.2, y: 4))
Location(x: 0, y: 8.5)
Location(x: 5.2, y: 4)

struct Restaurant {
    let location: Location
    var deliveryDistance: Miles
    
    func willDeliver(to location: Location) -> Bool {
        return self.location.getDistance(location) <= deliveryDistance
    }
}

let restaurants = [
    Restaurant(location: Location(x: 0, y: 0), deliveryDistance: 3),
    Restaurant(location: Location(x: 5, y: 5), deliveryDistance: 2)
]

restaurants[0].willDeliver(to: Location(x: 1, y: 2))

extension Location {
    var canGetPizzaDelivery: Bool {
        return restaurants.contains { restaurant in
            restaurant.willDeliver(to: self)
        }
    }
}

Location(x: 3, y: 0).canGetPizzaDelivery
Location(x: 5, y: 3).canGetPizzaDelivery
Location(x: 2, y: 2).canGetPizzaDelivery


var restaurant = Restaurant(location: Location(x: 2, y: 3), deliveryDistance: 4)
var copyRestaurant = restaurant
restaurant.deliveryDistance = 5
copyRestaurant
