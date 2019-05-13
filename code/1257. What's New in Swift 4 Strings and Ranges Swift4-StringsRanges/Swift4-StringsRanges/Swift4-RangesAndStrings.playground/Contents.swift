//: Playground - noun: a place where people can play

import UIKit

let esports = ["Hearthstone", "CS:GO", "League of Legends", "Super Smash Bros", "Overwatch", "Gigantic"]
esports[3..<esports.endIndex]
esports[3...]
esports[...2]
esports[..<2]

let uppercase = ["A", "B", "C", "D", "E", "F", "G"]
let asciiCodes = zip(65..., uppercase)
print(Array(asciiCodes))

func gameRank(_ index: Int) -> String {
  switch index {
    case ...1:
      return "Oldie but goodie"
    case 3...:
      return "Meh"
    default:
      return "Awesome-sauce!"
  }
}

gameRank(2)


func sentiment(_ rating: Double) -> String {
  switch rating {
    case ..<0.33:
      return "😞"
    case ..<0.66:
      return "😐"
    default:
      return "😁"
  }
}

sentiment(0.5)

let text = "fiver"
text.count
text.isEmpty
"".isEmpty

text.reversed()
String(text.reversed())

let unicodeText = "👇🏿👏🏻🤝🇦🇹🇧🇿🇧🇹🇫🇯🇧🇷"
for c in unicodeText {
  print(c)
}

let verse = """
  Half a league, half a league,
  Half a league onward,
  """

let greeting = "Hakuna Matata"
var index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]

let lastWord = greeting[index...]

index = greeting.index(greeting.endIndex, offsetBy:-7)
let firstWord = greeting[..<index]
firstWord

type(of:lastWord)
lastWord.uppercased()
let lastWordAsString = String(lastWord)
type(of:lastWordAsString)

let c: Character = "🇨🇭"
Array(c.unicodeScalars)

"🇧🇿🇫🇯🇧🇷".count
"👇🏿".count
let population = "1️⃣👩🏽‍🌾2️⃣🐓3️⃣👨‍👩‍👧‍👦"
population.count
var nsRange = NSRange(population.startIndex..., in: population)
population.utf16.count

let textInput = "You have traveled 483.2 miles."
let pattern = "[0-9]+(\\.([0-9])?)?"
let regex = try! NSRegularExpression(pattern: pattern, options:[])

nsRange = NSRange(textInput.startIndex..., in: textInput)
let mileage = regex.rangeOfFirstMatch(in: textInput, options: [], range: nsRange)
let range = Range(mileage, in: textInput)!
textInput[range]














































