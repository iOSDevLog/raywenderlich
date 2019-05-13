/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # The IX Responder
 */
import Foundation

@objc
public protocol SettingsIXResponder: class {
  func loadUserProfile()
  func update(clawed: Bool) // New
}
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
