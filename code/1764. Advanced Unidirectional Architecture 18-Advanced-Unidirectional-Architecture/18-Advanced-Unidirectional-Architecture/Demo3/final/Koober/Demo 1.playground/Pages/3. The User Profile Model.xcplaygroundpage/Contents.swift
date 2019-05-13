/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # The User Profile Model
 Here is the user profile model you will be working with to render the settings screen:
 */
import Foundation
import ReSwift

struct UserProfile {
  var name: String
  var mobileNumber: String
  var email: String
  var clawed: Bool

  init(name: String,
       mobileNumber: String,
       email: String,
       clawed: Bool) {
    self.name = name
    self.mobileNumber = mobileNumber
    self.email = email
    self.clawed = clawed
  }
}
/*:
 ## Equatable
 The user profile model needs to be equatable to avoid duplicate change events from ReSwift and RxSwift. Both ReSwift and RxSwift detect when a model is equatable and can test for changes automatically - for RxSwift you still need to call `distinctUntilChanged()` on the observable.

 */
extension UserProfile: Equatable {
  static func ==(lhs: UserProfile,
                 rhs: UserProfile) -> Bool {
    return lhs.name == rhs.name &&
      lhs.mobileNumber == rhs.mobileNumber &&
      lhs.email == rhs.email &&
      lhs.clawed == rhs.clawed
  }
}
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
