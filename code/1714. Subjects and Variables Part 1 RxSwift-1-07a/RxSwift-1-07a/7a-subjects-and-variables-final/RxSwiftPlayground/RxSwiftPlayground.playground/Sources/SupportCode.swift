import Foundation
import RxSwift

public func example(of description: String, action: () -> Void) {
  print("\n--- Example of:", description, "---")
  action()
}

public func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
  print(label, event.element ?? event.error ?? event)
}

public enum Quote: Error {
  case neverSaidThat
}

public enum MyError: Error {
  case anError
}

public let itsNotMyFault = "It’s not my fault."
public let doOrDoNot = "Do. Or do not. There is no try."
public let lackOfFaith = "I find your lack of faith disturbing."
public let eyesCanDeceive = "Your eyes can deceive you. Don’t trust them."
public let stayOnTarget = "Stay on target."
public let iAmYourFather = "Luke, I am your father"
public let useTheForce = "Use the Force, Luke."
public let theForceIsStrong = "The Force is strong with this one."
public let mayTheForceBeWithYou = "May the Force be with you."
public let mayThe4thBeWithYou = "May the 4th be with you."
