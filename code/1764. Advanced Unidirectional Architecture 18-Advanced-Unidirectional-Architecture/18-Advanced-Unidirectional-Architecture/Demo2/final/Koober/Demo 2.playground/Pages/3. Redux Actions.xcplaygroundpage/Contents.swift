/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Redux Actions
 Here are the redux actions that will be dispatched to the redux store.
 */
import Foundation
import ReSwift
/*:
 ## Loaded Persisted State
 This action should fire once the app's initial state has been read from persistence.
 */
struct LoadedPersistedState: Action {
  let appState: AppState
}
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
