/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # The Use Case
 Use cases are perfect for coordinating side effects and redux actions. Use cases do the actual work of a screen. For example, the use case in this page is used to restore the app's state from persistence. One nice thing about use cases is that they are re-usable from any view controller, i.e. they are not tied to a specific screen.
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
 ## Load Persisted State Use Case
 */
class LoadPersistedStateUseCase: UseCase {
  let userStore: PersistentUserStore
  let reduxStore: Store<AppState>
  let statePersister: StatePersister

  public init(userStore: PersistentUserStore,
              reduxStore: Store<AppState>,
              statePersister: StatePersister) {
    self.userStore = userStore
    self.reduxStore = reduxStore
    self.statePersister = statePersister
  }

  public func start() {
    userStore.readUserProfile()
      .then(execute: dispatchLoadedAction(userProfile:))
      .then(execute: startPersistingStateChanges)
      .catch { error in }
  }

  func dispatchLoadedAction(userProfile: UserProfile) {
    let appState = AppState(userProfile: userProfile)
    let action = LoadedPersistedState(appState: appState)
    reduxStore.dispatch(action)
  }

  func startPersistingStateChanges() {
    statePersister.startPersistingStateChanges(to: userStore)
  }
}
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
