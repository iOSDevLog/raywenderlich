/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # The App State Model
 Here's the redux store's state tree model.
 */
import Foundation
import ReSwift
/*:
 ## App State
 `AppState` hasn't changed since Demo 1.
 */
struct AppState: StateType {
  var settingsViewState: SettingsViewState

  init(_ userProfile: UserProfile) {
    self.settingsViewState =
      SettingsViewState(userProfile: userProfile)
  }
}
/*:
 ## Settings View State
 The view's state model has a new boolean property you will use to drive the animating state of the setting view's activity indicator.
*/
struct SettingsViewState {
  var userProfile: UserProfile
  var loadingUserProfile: Bool // New

  init(userProfile: UserProfile) {
    self.userProfile = userProfile
    self.loadingUserProfile = false // New
  }
}
/*:
 ## Equatable
 Just like in Demo 1, the state models need to be `Equatable` in order to avoid sending state change events when nothing has changed. The state tree here is very shallow so the need for `Equatable` is not as apparant. If `AppState` had another property that a view controller was listening for changes, you wouldn't want to send a change event when only the other property has changed.
 */
extension AppState: Equatable {
  static func ==(lhs: AppState, rhs: AppState) -> Bool {
    return lhs.settingsViewState == rhs.settingsViewState
  }
}
extension SettingsViewState: Equatable {
  static func ==(lhs: SettingsViewState, rhs: SettingsViewState) -> Bool {
    return lhs.userProfile == rhs.userProfile &&
      lhs.loadingUserProfile == rhs.loadingUserProfile
  }
}
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
