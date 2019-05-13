//: [Previous](@previous)
/*:
 ## Challenge Time - Arrays!

Use firstIndex(of:) to determine the position of the element "Dan" in players.
*/
var players = ["Alice", "Bob", "Dan", "Eli", "Frank"]


if let index = players.firstIndex(of: "Dan") {
  print(index)
}


/*:
 Write a for-in loop that prints the players' names and scores.
 */
players = ["Anna", "Brian", "Craig", "Dan", "Donna", "Eli", "Franklin"]
let scores = [2, 2, 8, 6, 1, 2, 1]

for (index, player) in players.enumerated() {
  print(player, scores[index])
}




//: [Next](@next)
