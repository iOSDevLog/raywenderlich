import UIKit

/*:
 #### Intermediate Swift Video Tutorial Series - raywenderlich.com
 #### Video 5: Classes
 
 **Note:** If you're seeing this text as comments rather than nicely-rendered text, select Editor\Show Rendered Markup in the Xcode menu.

 Make the following objects and determine whether they are structs or classes. For the properties, use properties unless noted below.
 
 TShirt: size, color
 Address: street, city, state, zipCode
 User: firstName, lastName, address (Address object)
 ShoppingCart: shirts (array of TShirt), User (user object)
 
 
 
 
 Solution:
 
 - TShirt: A TShirt can be thought of as a value, because it doesn't represent a real shirt, only a description of a shirt. For instance, a TShirt would represent "a large green shirt order" and not "an actual large green shirt". For this reason, TShirt can be a struct instead of a class.
 - User: A User represents a real person. This means every user is unique so User is best implemented as a class.
 - Address: Addresses group multiple values together and two addresses can be considered equal if they hold the same values. This means Address works best as a value type (struct).
 - ShoppingCart: The ShoppingCart is a bit tricker. While it could be argued that it could be done as a value type, it's best to think of the real world semantics you are modeling. If you add an item to a shopping cart, would you expect to get a new shopping cart? Or put the new item in your existing cart? By using a class, the reference semantics help model real world behaviors. Using a class also makes it easier to share a single ShoppingCart object between multiple components of your application (shopping, ordering, invoicing, ...).
 
 For classes, you will need to create an init() to set an empty properties. You will learn about init() in the initializer videos.
 */

struct TShirt {
  var size = ""
  var color = ""
}

class ShoppingCart {
  var shirts: [TShirt]
  var user: User
  init() {
    shirts = [TShirt]()
    user = User()
  }
}

class User {
  var firstName: String
  var lastName: String
  var address: Address
  init() {
    firstName = ""
    lastName = ""
    address = Address()
  }
}

struct Address {
  var street = ""
  var city = ""
  var state = ""
  var zipCode = ""
}
