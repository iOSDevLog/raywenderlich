//: [Previous](@previous)

import Foundation
/*:
 ### TUPLES
 
 Declare a constant tuple that contains three Int values followed by a String. Use this to represent a date (month, day, year) followed by an emoji or word you might associate with that day.
 */

let halloween = (10, 31, 2016, "👻")

/*:
 Create another tuple, but this time name the constituent components. Give them names related to the data that they contain: month, day, year and emoji.
 */

let piDay = (month: 3, day: 14, year: 1592, emoji: "🥧")

/*:
 In one line, read the day and emoji values into two constants. You’ll need to employ the underscore to ignore the month and year.
 */

let (_, day, _, emoji) = piDay
day
emoji

/*:
 Up until now, you’ve only seen constant tuples. But you can create variable tuples, too. Create one more tuple, like in the exercises above, but this time use var instead of let. Now change the emoji to a new value. */

var groundhogDay = (month: 2, day: 2, year: 1993, emoji: "🐹")
groundhogDay.emoji = "⏰"
groundhogDay

//: [Next](@next)
