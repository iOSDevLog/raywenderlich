//: [← dispatch_once](@previous)

import Foundation
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: ## `dispatch_after()`
//: Allows you to say that a closure should be executed at some point in the future, on a specified queue

func delay(delay: Double, closure: () -> ()) {
  // TODO: Add the implementation
}

print("One")
delay(0.5) { print("Two") }
print("Three")

