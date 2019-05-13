//: Playground - noun: a place where people can play

import UIKit

struct Person {
  private let firstName: String
  private let lastName: String
  
  init(firstName: String, lastName: String) {
    self.firstName = firstName
    self.lastName = lastName
  }
  
  var name: String {
    return "\(firstName) \(lastName)"
  }
}

extension Person {
  func greeting(with message: String) -> String {
    return "\(message), \(firstName)"
  }
}

let dumbledore = Person(firstName: "Albus", lastName: "Dumbledore")
dumbledore.greeting(with: "Good morningafterevening")

var numbers = Array(1...5)
// swap(&numbers[1], &numbers[3]) - legal in Swift 3

numbers.swapAt(1, 3)
print(numbers)

protocol MySpecialDelegateProtocol {}
class MySpecialView: UIView {}
class myController {
  var delegate: (UIView & MySpecialDelegateProtocol)?
}






















