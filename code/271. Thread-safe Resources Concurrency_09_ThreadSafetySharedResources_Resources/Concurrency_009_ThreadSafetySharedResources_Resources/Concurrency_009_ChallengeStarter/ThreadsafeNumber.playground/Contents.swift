import Foundation
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: # Threadsafe Number
//: __Challenge:__ Your challenge is to make the following `Number` class threadsafe.
//: > __Note:__ This class is for demo purposes, it should be a value type

class Number {
  var value: Int
  var name: String
  
  init(value: Int, name: String) {
    self.value = value
    self.name = name
  }
  
  func changeNumber(value: Int, name: String) {
    randomDelay(0.1)
    self.value = value
    randomDelay(0.5)
    self.name = name
  }
  
  var number: String {
    return "\(value) :: \(name)"
  }
}

//: Setting up some GCD guff
let workerQueue = dispatch_queue_create("com.raywenderlich.worker", DISPATCH_QUEUE_CONCURRENT)
let numberGroup = dispatch_group_create()
let numberArray = [(1, "one"), (2, "two"), (3, "three"), (4, "four"), (5, "five"), (6, "six")]

//: A starter number
let changingNumber = Number(value: 0, name: "zero")

//: Accessing the `changingNumber` from multiple threads
for pair in numberArray {
  dispatch_group_async(numberGroup, workerQueue) {
    changingNumber.changeNumber(pair.0, name: pair.1)
    print("Current number: \(changingNumber.number)")
  }
}

//: Completed
dispatch_group_notify(numberGroup, dispatch_get_main_queue()) {
  print("Final number: \(changingNumber.number)")
  XCPlaygroundPage.currentPage.finishExecution()
}


