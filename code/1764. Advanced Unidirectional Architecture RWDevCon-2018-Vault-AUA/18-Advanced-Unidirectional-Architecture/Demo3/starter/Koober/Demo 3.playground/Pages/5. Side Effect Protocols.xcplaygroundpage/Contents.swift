/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Side Effect Protocols
 Redux helps you separate side effects from pure functions like the reducer. In the previous page you saw the pure side of things, in this page you can see the protcols used to implement common side effects found in most apps, i.e. networking and persistence. Protocols are used in order to allow tests to use fake implementations so that tests are not flakey due to something such as a web service being down.
 */
import Foundation
import PromiseKit
/*:
 ## Persistent User Store
 This protocols defines the persistence system for saving the user's profile to disk. This is a protocol so you can implement an in memory version to help develop, debug, and test.
 */
protocol PersistentUserStore {
  func readUserProfile() -> Promise<UserProfile>
  func save(userProfile: UserProfile) -> Promise<UserProfile>
}
/*:
 ## State Persister
 */
protocol StatePersister {
  func startPersistingStateChanges(to userStore: PersistentUserStore)
}
/*:
 ## User Remote API
 This remote API is used to fetch a new user profile from the network.
 */
protocol UserRemoteAPI {
  func getUserProfile() -> Promise<UserProfile>
}
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
