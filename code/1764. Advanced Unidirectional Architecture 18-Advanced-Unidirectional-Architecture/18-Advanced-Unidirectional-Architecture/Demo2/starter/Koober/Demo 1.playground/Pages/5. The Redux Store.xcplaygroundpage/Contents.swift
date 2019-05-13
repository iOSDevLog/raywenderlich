/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
  # The Redux Store
 ## The Store
  The following shows the ReSwift redux store you'll need in this demo.
 */
import Foundation
import ReSwift

let store = Store<AppState>(reducer: reduce,
                            state: nil)
/*:
 ## The Reducer
 Here is the simple reducer used to create the store above:
 */
func reduce(action: Action, state: AppState?) -> AppState {
  let appState = state ?? AppState(UserProfile.makeEmpty())
  return appState
}
/*:
 ## Initial State
 And this is an extension that creates the initial state to be used for rendering the settings screen:
 */
extension UserProfile {
  static func makeEmpty() -> UserProfile {
    return UserProfile(name: "",
                       mobileNumber: "",
                       email: "",
                       clawed: true)
  }
}
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
