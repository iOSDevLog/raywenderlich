import UIKit

/*:
 #### Intermediate Swift Video Tutorial Series - raywenderlich.com
 #### Video 3: Structures
 
 **Note:** If you're seeing this text as comments rather than nicely-rendered text, select Editor\Show Rendered Markup in the Xcode menu.
 */

//: Create a T-shirt struct that has size, color and material options. The size prices go from 3, 5, 7. The colors range from red, blue, and white. It should range from 2, 3, and 1. Finally, for material options, choose regular or organic. It should be 5 or 10. Print out the result in calculatePrice()

//: Here's an example of creating a struct: 
//: var tshirt = TShirt(size: "M", color: "red", material: "organic")


struct TShirt {
  
  var size: String
  var color: String
  var material: String
  
  func calculatePrice() -> Int {
    var value = 0
    
    switch size {
      case "S":
        value += 3
      case "M":
        value += 5
      case "L":
        value += 7
      default:
        ()
    }

    switch color {
    case "red":
      value += 2
    case "blue":
      value += 3
    case "white":
      value += 1
    default:
      ()
    }
    
    switch material {
    case "regular":
      value += 5
    case "organic":
      value += 10
    default:
      ()
    }
    
    return value
  }
  
}

var tshirt = TShirt(size: "M", color: "red", material: "organic")
tshirt.calculatePrice()

//: **Ub3r H4ck3r Challenge** Refactor the code so that materials, color, and sizes are structs with a name and a price. Pass these structs into the TShirt and have it calculate the price

struct TShirtProperty {
  var name = ""
  var price = 0
}

var mediumSize = TShirtProperty(name: "Medium", price: 5)
var material = TShirtProperty(name: "Organic", price: 10)
var color = TShirtProperty(name: "Blue", price: 3)

struct NewTShirt {
  var size: TShirtProperty
  var color: TShirtProperty
  var material: TShirtProperty
  
  func calculatePrice() -> Int {
    var value = 0
    
    value += mediumSize.price
    value += color.price
    value += material.price
    
    return value
  }

}



