import UIKit

/*:
 #### Intermediate Swift Video Tutorial Series - raywenderlich.com
 #### Video 4: Properties
 
 **Note:** If you're seeing this text as comments rather than nicely-rendered text, select Editor\Show Rendered Markup in the Xcode menu.
 */

//: Create a property called fullName that returns the firstName and lastName combined.


//: **Ub3r H4ck3r Challenge**
//: Here is an Fuel Tank object and through the magic of properties, you can add some behavior to it. Here's what you need to do: 
//: 1. Add a lowFuel stored property of Boolean type to the structure.
//: 2. Flip the lowFuel Boolean when the level drops below 10%.
//: 3. Ensure that when the tank fills back up, the lowFuel warning will turn off.
//: 4. Set the level to a minimum of 0 or a maximum of 1 if it gets set above or below the expected values.
//: To do this, you need to use a property observer called didSet. This runs just after a value is set. You use it the same way you use getters and setters. You also have a willSet as well.

