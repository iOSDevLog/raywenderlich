/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # The Redux Reducer
 Reducers should be free functions meaning they should never perform side effects. Reducers are designed to perform state transformations such as converting a raw data model to a presentable display model for the view. Another thing to note is reducers are run on the main thread so they need to be fast.

 This reducer:
 * handles toggling the `loadingUserProfile` flag to drive the activity indicator and
 * handles storing the newest user profile.
 */
import Foundation
import ReSwift

public func reduce(action: Action, state: AppState?) -> AppState {
  var appState = state ?? AppState(UserProfile.makeEmpty())

  switch action {
  case let action as LoadedPersistedState:
    appState = action.appState
  case _ as LoadingUserProfile:
    appState.settingsViewState.loadingUserProfile = true
  case let action as LoadedUserProfile:
    appState.settingsViewState.userProfile = action.userProfile
    appState.settingsViewState.loadingUserProfile = false
  default:
    break
  }

  return appState
}
/*:
 ## Step by step
 ### The Reducer free function
 When an action is dispatched to the redux store, this function will be called with the action and previous app state. The responsibility of this function is to return the new state based on the action.
 */
func reduce_(action: Action, state: AppState?) -> AppState {
/*:
 ### Make a copy of the existing state
 In the following line, if the redux store is created with a `nil` value for the initial state new `AppState` is created. Notice that the state is stored in a variable instead of a constant. This line *copies* the existing state into a mutable struct variable so that the reducer can modify the copy and return the modified copy as the new redux store state.
 */
  // TODO: Clean up.
  var appState = state ?? AppState(UserProfile.makeEmpty())
/*:
 ### Handle action
 Mutate new state based on action that caused the reducer to be called. This is a very typical reducer implementation using a swtich statement to determine what kind of action was dispatched.
 */
  switch action {
  case let action as LoadedPersistedState:
    appState = action.appState
  case _ as LoadingUserProfile:
    appState.settingsViewState.loadingUserProfile = true
  case let action as LoadedUserProfile:
    appState.settingsViewState.userProfile = action.userProfile
    appState.settingsViewState.loadingUserProfile = false
  default:
    break
  }

/*:
 ### Return modified copy
 Return the new state. This will trigger change events if the new state is different than the previous state based on `Equatable`.
 */
  return appState
}
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */

