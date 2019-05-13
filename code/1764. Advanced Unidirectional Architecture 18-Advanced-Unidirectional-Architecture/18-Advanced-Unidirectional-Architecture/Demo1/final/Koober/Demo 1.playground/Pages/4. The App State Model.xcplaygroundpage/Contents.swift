/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # The App State Model
 In a redux architecture, the goal is to place the app's entire state into the redux store's state tree. So the first step is to model the entire app's state.
 */
import Foundation
import ReSwift
/*:
 ## App State
 Here is the app state model you'll be using in this demo. The `StateType` marker protocol is required by ReSwift for models that will be processed by a reducer in the redux store.
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
 The settings view also has it's own view state model:
 */
struct SettingsViewState {
  var userProfile: UserProfile

  init(userProfile: UserProfile) {
    self.userProfile = userProfile
  }
}
/*:
 ## Equatable
 Because the settings view controller will be subscribing to an observable for changes in the settings view state, `SettingsViewState` and `AppState` need to be equatable to avoid duplicate change events from ReSwift and RxSwift. Both ReSwift and RxSwift detect when a model is equatable and can test for changes automatically - for RxSwift you still need to call `distinctUntilChanged()` on the observable.
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
