import UIKit

/*:
 #### Intermediate Swift Video Tutorial Series - raywenderlich.com
 #### Video 6: Initializers
 
 **Note:** If you're seeing this text as comments rather than nicely-rendered text, select Editor\Show Rendered Markup in the Xcode menu.
 
 */

//: Create a class called Account that has a balance property. Have the balance set to 0. Create a function to withdrawl money from the balance. Make sure the withdrawl amount is greater than 0 and the amount is less than the balance.

class Account {
  var balance = 0
  
  func withdrawl(_ amount: Int) {
    if amount > 0 && amount < balance {
      balance -= amount
    }
  }
  
}

//: Create a subclass called SavingsAccount and override withdrawl(). In this method, make sure that the withdrawn amount is greater than 10.

class SavingsAccount: Account {
  override func withdrawl(_ amount: Int) {
    if amount > 10 {
      super.withdrawl(amount)
    }
  }
}

