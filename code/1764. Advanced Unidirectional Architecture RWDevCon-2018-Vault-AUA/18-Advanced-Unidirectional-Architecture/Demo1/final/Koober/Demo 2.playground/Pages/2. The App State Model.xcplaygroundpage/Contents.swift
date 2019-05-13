/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # The App State Model
 Here's the same state tree model from Demo 1.
 */
import Foundation
import ReSwift
/*:
 ## App State
 */
struct AppState: StateType {
  var settingsViewState: SettingsViewState

  init(userProfile: UserProfile) {
    self.settingsViewState =
      SettingsViewState(userProfile: userProfile)
  }
}
/*:
 ## Settings View State
*/
struct SettingsViewState {
  var userProfile: UserProfile

  init(userProfile: UserProfile) {
    self.userProfile = userProfile
  }
}
/*:
 ## Equatable
 */
extension AppState: Equatable {
  static func ==(lhs: AppState, rhs: AppState) -> Bool {
    return lhs.settingsViewState == rhs.settingsViewState
  }
}
extension SettingsViewState: Equatable {
  static func ==(lhs: SettingsViewState, rhs: SettingsViewState) -> Bool {
    return lhs.userProfile == rhs.userProfile
  }
}
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
