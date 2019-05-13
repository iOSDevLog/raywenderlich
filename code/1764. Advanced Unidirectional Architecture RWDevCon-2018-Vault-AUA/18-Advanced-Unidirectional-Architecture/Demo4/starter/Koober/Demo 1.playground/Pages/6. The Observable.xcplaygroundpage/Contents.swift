/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # The Observable
 Designing a flexible architecture is a game of decoupling.

 ## View Controllers Observing Models
 The redux store contains the user profile that the settings view controller needs in order to render its view.

 One option would be to instantiate all view controllers with a reference to the store and have each view controller subscribe to the store for changes in state. This option would require every view controller to `import ReSwift` which isn't bad in and of itself other than being fully commited to ReSwift.

 Another downside is that each view controller will have to know how to traverse the store's `StateType` model graph in order to only get subscription events for the specific models the view controller cares about. This is not ideal because if you refactor the shape of your StateType, your view controller's code will have to change.

 A more flexible approach is to decouple ReSwift from the view controllers using RxSwift observables.

 ## Adding RxSwift support to ReSwift
 Out of the box, ReSwift does not provide a way to use ReactiveSwift nor RxSwift to observe redux store state changes. However, adding support is not difficult.

 This tutorial adds custom extensions on ReSwift's Store type in order to add RxSwift support. With the tutotial's custom extension, you can take a redux store instance and ask for an RxSwift observable for observing changes in the store.

 ## Behavior Subject-like Observables
 The observables you get out of the tutorial's extension behave like behavior subjects. This behavior is important because when a view controller subscribes to a store observable you're going to want to get the store's current state to render the view controller's screen without depending on a state change to receive the store's state.

---

 Ok, here's how to create an observable from a ReSwift redux store using the tutorial's extension:

 */
import Foundation
import ReSwift
import RxSwift

let store = Store<AppState>(reducer: reduce, state: nil)
//: Then call `makeObservable` on the store:
let appStateObservable: Observable<AppState> =
  store
    .makeObservable()
/*:
 The previous line creates an observable that emits an event every time a new app state is set by the reducer. For this simple example you could get away with passing this observable to the view controller becuase the `AppState` model is tiny. The view controller can just access the `settingsViewState` property to read the latest settings view state.

 However in a real world app, the app state struct usually has many properties that can go pretty deep. The last thing you want to write in your view controllers is code that traverses a large state tree just to get to the piece of data that the view controller needs. Not to mention the refacotring that you'd have to do if you decide to restructre your state model.

 Instead, you can create a new observable for just the data your view controller needs. You can do this by providing a closure to the `makeObservable` method that declares how to drill into the state tree. In return you'll get an observable that only fires when that one piece of data changes, so you won't get change events if something else unlrelated to the view controller changes.

 This is how you can create an observable just for the settings view state:
 */
let viewStateObservable: Observable<SettingsViewState> =
  store
    .makeObservable { appState in
      return appState.settingsViewState
    }

/*:
 Once you have the observable, the trick is giving the observable to a view controller. That's next.
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
