/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Redux Actions
 Here are the redux actions that will be dispatched to the redux store.
 */
import Foundation
import ReSwift
/*:
 ## Loading User Profile Action
 This action is dispatched when the app starts to get a new user profile from the network. The reducer will use this to set the setting view's state's loading flag to true. Nothing will react to this value change; the action is necessary to keep the redux store's state up to date so that when the app is done loading, a change event is sent because the flag is changed from `true` to `false`.
 */
struct LoadingUserProfile: Action {}
/*:
 ## Loaded User Profile Action
 This action is dispatched once a fresh user profile is fetched from the network. The action carries the new user profile data in order for the reducer to update the redux store resulting in a change event sent to the view controller via RxSwift `Observable`.
 */
struct LoadedUserProfile: Action {
  let userProfile: UserProfile
}
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
