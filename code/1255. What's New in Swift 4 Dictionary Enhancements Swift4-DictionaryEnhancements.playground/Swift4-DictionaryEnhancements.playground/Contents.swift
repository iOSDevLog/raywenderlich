//: Playground - noun: a place where people can play

import UIKit

let groceries = Dictionary(uniqueKeysWithValues: zip(1..., ["Prosciutto", "Heavy Cream", "Butter", "Parmesan", "Small shells"]))
let housePointTotals = [("Slytherin", 472), ("Ravenclaw", 426), ("Hafflepuff", 352), ("Gryffindor", 312)]
let banquetBegins = Dictionary(uniqueKeysWithValues: housePointTotals)

let duplicates = [("a", 1), ("b", 2), ("a", 3), ("b", 4)]
let sortingHat = [
  ("Gryffindor", "Harry Potter"), ("Slytherin", "Draco Malfoy"), ("Gryffindor", "Ron Weasley"), ("Slytherin", "Pansy Parkinson"), ("Gryffindor", "Hermione Granger"), ("Hufflepuff", "Hannah Abbott"), ("Ravenclaw", "Terry Boot"), ("Hufflepuff", "Susan Bones"), ("Ravenclaw", "Lisa Turpin"), ("Gryffindor", "Neville Longbottom")
]

let houses = Dictionary(sortingHat.map { ($0.0, [$0.1])}, uniquingKeysWith: {
  (current, new) in
    return current + new
})

print(houses)

let defaultStyling: [String: UIColor] = [ "body": .black, "title": .blue, "byline": .green]
var userStyling: [String: UIColor] = [ "body": .purple, "title": .blue]

userStyling.merge(defaultStyling) {
  (user, _) -> UIColor in
    user
}
print(userStyling)

var anotherBanquetBegins: [String: Int] = [:]
anotherBanquetBegins["House elves", default: 0]

groceries
let addGroceries = groceries.filter { $0.key % 2 == 1 }
addGroceries

let set: Set = ["a", "b", "c", "d", "e"]
let filteredSet = set.filter { $0.hashValue % 2 == 0 }
filteredSet

let mirroredGroceries = addGroceries.mapValues {
  print(String($0.reversed()))
}

let names = ["Harry", "Ron", "Hermione", "Hannah", "Neville", "Pansy", "Padma"]
let nameList = Dictionary(grouping: names) { $0.prefix(1) }
nameList

struct Student {
  let firstName: String
  let lastName: String
}

let lastNameKeypath = \Student.lastName
let classRoll = sortingHat.map {
  $0.1.split(separator: " ")
}.map {
  Student(firstName: String($0[0]), lastName: String($0[1]))
}
let contactList = Dictionary(grouping: classRoll) {
  $0[keyPath: lastNameKeypath].prefix(1)
}
contactList["A"]![0].firstName

extension Collection {
  subscript<Indices: Sequence>(indices: Indices) -> [Element] where Indices.Element == Index {
    var result: [Element] = []
    for index in indices {
      result.append(self[index])
    }
    return result
  }
}

let words = "It was the best of times it was the worst of times".split(separator: " ")
words[[3, 9, 11]]










































