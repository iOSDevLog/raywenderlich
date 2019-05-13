import UIKit

/*:
 #### Intermediate Swift Video Tutorial Series - raywenderlich.com
 #### Video 7: Initializers
 
 **Note:** If you're seeing this text as comments rather than nicely-rendered text, select Editor\Show Rendered Markup in the Xcode menu. */
//: Create a protocol called TipCalculator. This calculator should take one method: func tipForAmount(_ amount:Float, atPercentage percentage: Float) -> Float
//: Implement the protocol on a ScientificCalculator class with an extension.
 

protocol TipCalculator {
  func tipForAmount(_ amount:Float, atPercentage percentage: Float) -> Float
}

class ScientificCalculator {
  
}

extension ScientificCalculator: TipCalculator {
  func tipForAmount(_ amount: Float, atPercentage percentage: Float) -> Float {
    return amount * percentage
  }
}

//: Here is a story class. Often times, it's helpful to print out the contents to the console. yet when you print out an instance of a Story object, you get: Story.
class Story {
  var name: String
  var writer: String
  
  init(name: String, writer: String) {
    self.name = name
    self.writer = writer
  }
}

//: Implement the CustomStringConvertiable protocol on the Story object via. an extension to print out the contents of the object. Implement the description method that will return a string. The string should read: "name: <name>, writer: <writer>"
extension Story: CustomStringConvertible {
  var description: String {
    return "name: \(name), writer: \(writer)"
  }
}

var story = Story(name: "Game of Thrones", writer: "G.R.R Marin")
print(story)
