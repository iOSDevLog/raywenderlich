/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # The Use Case
 */
import Foundation
import PromiseKit
import ReSwift

class UpdateClawedUseCase: UseCase {
  // MARK: Input
  let clawed: Bool
  // MARK: Dependencies
  let remoteAPI: UserRemoteAPI
  let reduxStore: Store<AppState>

  init(clawed: Bool,
       remoteAPI: UserRemoteAPI,
       reduxStore: Store<AppState>) {
    self.clawed = clawed
    self.remoteAPI = remoteAPI
    self.reduxStore = reduxStore
  }

  func start() {
    remoteAPI.putUserProfile(clawed: clawed)
      .then(execute: dispatchUpdateAction(userProfile:))
      .catch { error in }
  }

  func dispatchUpdateAction(userProfile: UserProfile) {
    let action = UpdateClawed(userProfile: userProfile)
    self.reduxStore.dispatch(action)
  }
}
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
