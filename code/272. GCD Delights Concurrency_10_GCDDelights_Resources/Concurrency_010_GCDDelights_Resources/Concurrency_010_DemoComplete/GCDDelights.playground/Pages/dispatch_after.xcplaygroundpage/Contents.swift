//: [← dispatch_once](@previous)

import Foundation
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: ## `dispatch_after()`
//: Allows you to say that a closure should be executed at some point in the future, on a specified queue

func delay(delay: Double, closure: () -> ()) {
  let startTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
  dispatch_after(startTime, dispatch_get_main_queue(), closure)
}

print("One")
delay(0.5) { print("Two") }
print("Three")

