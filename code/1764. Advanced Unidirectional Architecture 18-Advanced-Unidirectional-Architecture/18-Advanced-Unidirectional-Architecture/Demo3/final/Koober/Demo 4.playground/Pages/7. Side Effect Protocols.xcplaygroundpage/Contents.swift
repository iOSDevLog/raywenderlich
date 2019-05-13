/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Side Effect Protocols
 */
import Foundation
import PromiseKit

protocol PersistentUserStore {
  func readUserProfile() -> Promise<UserProfile>
  func save(userProfile: UserProfile) -> Promise<UserProfile>
}

protocol StatePersister {
  func startPersistingStateChanges(to userStore: PersistentUserStore)
}

protocol UserRemoteAPI {
  func getUserProfile() -> Promise<UserProfile>
  func putUserProfile(clawed: Bool) -> Promise<UserProfile> // New
}
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
