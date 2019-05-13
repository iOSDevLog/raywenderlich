/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # The IX Responder
 In order to implement pull to refresh, the `SettingsViewController` needs to respond to the user's interaction with the scroll view. Specifically, the view controller needs to know when the user pulls to refresh in order to start a new `LoadUserProfileUseCase`.

 The view controller's root view needs a way to communicate with the view controller to let it know that the refresh control has been activated. That's what the interaction (ix) responder is for:
 */
import Foundation

@objc
public protocol SettingsIXResponder: class {
  func loadUserProfile()
}
/*:
 The view controller needs to conform to this protocol and instantiate the view with itself. Here's the view's initializer signature:

 `init(frame: CGRect = .zero, ixResponder: SettingsIXResponder)`
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
