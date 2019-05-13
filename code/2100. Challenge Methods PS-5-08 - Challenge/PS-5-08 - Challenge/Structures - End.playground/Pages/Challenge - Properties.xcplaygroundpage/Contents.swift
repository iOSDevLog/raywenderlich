//: [Previous](@previous)
/*:
 # Challenge Time - Properties!
 
 Create a struct named `Temperature` with properties for degrees in both Celsius and Fahrenheit, as `Double`s.
 * _Hint 1_: One property must be stored, but the other can be computed. They should always stay in sync.
 * _Hint 2_: To convert from Fahrenheit to Celsius, subtract 32, then divide by 1.8.
 */


struct Temperature {
  var degreesF: Double {
    didSet {
      if degreesF > 100 {
        print("It's \(degreesF) degrees Fahrenheit! I had fun coding in Swift with you before I melted.")
      }
    }
  }
  var degreesC: Double {
    get { return (degreesF - 32) / 1.8 }
    set { degreesF = newValue * 1.8 + 32 }
  }
}

var temperature = Temperature(degreesF: 32)
temperature.degreesC
temperature.degreesC = 75


//: Modify the Fahrenheit property to print out a warning message if it is set to above 100 degrees.

//: [Next](@next)
