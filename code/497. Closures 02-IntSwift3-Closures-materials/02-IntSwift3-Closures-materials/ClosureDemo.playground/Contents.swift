//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var closure = { () -> Void in print("hello") }
//closure()
var anotherClosure: () -> Void = { print("hello") }

func runClosure(_ aClosure: () -> Void) {
  //aClosure()
}

runClosure(anotherClosure)

runClosure{
  //print("hello")
}

var yetAnotherClosure: (String, Int) -> Void = { (message: String, times: Int)
     in
  for _ in 0 ..< times {
    //print(message)
  }
}
yetAnotherClosure("Hello world", 5)
//var  multiply: (Int, Int) -> Int = { (a: Int, b: Int) in return a * b }
//var  multiply: (Int, Int) -> Int = { return $0 * $1 }
var  multiply: (Int, Int) -> Int = { $0 * $1 }

multiply(5, 7)

var counter = 0
var counterClosure = {
  counter += 1
}
counterClosure()
counterClosure()
counterClosure()
counterClosure()
counterClosure()
counterClosure()
counter
counter = 0
counterClosure()
counter








