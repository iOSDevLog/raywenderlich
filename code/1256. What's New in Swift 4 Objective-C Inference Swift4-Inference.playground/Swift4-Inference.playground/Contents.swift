//: Playground - noun: a place where people can play

import UIKit

class MyClass: NSObject {
  func print() {
    Swift.print("hello")
  }
  @objc func show() {
    print()
  }
}

@objc extension MyClass {
  @nonobjc func f(_ foo: String?) {}
}

@objcMembers
class MySecondClass: NSObject {
  func f() {}
  func g() -> (Int, Int) {
    return (1, 1)
  }
}

@nonobjc extension MySecondClass {
  func h() -> Int? { return nil }
  func j(_ value: Double?) {}
}

class Super {
  @objc func foo() {}
}

class Sub: Super {
  override func foo() {}
}














