//: [Previous](@previous)
/*:
 # Challenge Time - Structures!
 
 Write a struct that represents a pizza. Include toppings, size and any other option you’d want.
 */
typealias Inches = Int

struct Pizza {
  enum Topping {
    case cheese
    case mushrooms
    case peppers
  }
  
  enum Crust {
    case thick
    case thin
  }
  
  let toppings: [Topping]
  let size: Inches
  let crust: Crust
}

let pizzaTopping: Pizza.Topping = .mushrooms
let pizza = Pizza(
  toppings: [.cheese, .mushrooms],
  size: 14,
  crust: .thick
)


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
  
  func deliveryAreaOverlaps(restaurant: Restaurant) -> Bool {
    return
      location.getDistance(restaurant.location)
      <=
      deliveryDistance + restaurant.deliveryDistance
  }
}

//: Test if these two restaurants' delivery areas overlap. They should not!
let restaurant1 = Restaurant(location: Location(x: 0, y: 0), deliveryDistance: 2)
let restaurant2 = Restaurant(location: Location(x: 3, y: 3), deliveryDistance: 2)
restaurant1.deliveryAreaOverlaps(restaurant: restaurant2)

//: Test these two as well. They should overlap!
let restaurant3 = Restaurant(location: Location(x: 2, y: 4), deliveryDistance: 2)
let restaurant4 = Restaurant(location: Location(x: 3, y: 5), deliveryDistance: 3)
restaurant3.deliveryAreaOverlaps(restaurant: restaurant4)

//: [Next](@next)
