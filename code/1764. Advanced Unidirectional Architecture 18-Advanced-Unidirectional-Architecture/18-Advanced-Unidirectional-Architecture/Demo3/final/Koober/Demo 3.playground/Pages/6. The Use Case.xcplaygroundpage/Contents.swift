/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # The Use Case
 Use cases are perfect for coordinating side effects and redux actions. Use cases do the actual work of a screen. For example, the use case in this page is used to load a new user profile from the network. One nice thing about use cases is that they are re-usable from any view controller, i.e. they are not tied to a specific screen.
 */
import Foundation
import PromiseKit
import ReSwift
/*:
 ## Protocol for faking
 Although the following protocol is super simple, the protocol is helpful for providing fake implementations during tests. For example, you could test that a view controller starts a use case when intended without actually doing the work.
 */
protocol UseCase {
  func start()
}
/*:
 ## Load User Profile Use Case
 Here's the use case used to load fresh user profiles from the network:
 */
class LoadUserProfileUseCase: UseCase {
  let remoteAPI: UserRemoteAPI
  let reduxStore: Store<AppState>

  init(remoteAPI: UserRemoteAPI,
       reduxStore: Store<AppState>) {
    self.remoteAPI = remoteAPI
    self.reduxStore = reduxStore
  }

  func start() {
    dispatchLoadingAction()
      .then(execute: remoteAPI.getUserProfile)
      .then(execute: dispatchLoadedAction(userProfile:))
      .catch { error in }
  }

  func dispatchLoadingAction() -> Promise<Void> {
    let action = LoadingUserProfile()
    reduxStore.dispatch(action)
    return Promise()
  }

  func dispatchLoadedAction(userProfile: UserProfile) {
    let action = LoadedUserProfile(userProfile: userProfile)
    reduxStore.dispatch(action)
  }
}
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
