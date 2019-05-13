/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # The Redux Reducer
 */
import Foundation
import ReSwift

func reduce(action: Action, state: AppState?) -> AppState {
  var appState = state ?? AppState(UserProfile.makeEmpty())

  switch action {
  case let action as LoadedPersistedState:
    appState = action.appState
  case _ as LoadingUserProfile:
    appState.settingsViewState.loadingUserProfile = true
  case let action as LoadedUserProfile:
    appState.settingsViewState.userProfile = action.userProfile
    appState.settingsViewState.loadingUserProfile = false
  case let action as UpdateClawed: // New
    appState.settingsViewState.userProfile = action.userProfile
  default:
    break
  }

  return appState
}
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
