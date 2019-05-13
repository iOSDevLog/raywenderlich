/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Managing Dependencies

 So the goal is to create the `SettingsViewController` with an `Observable<SettingsViewState>` in order to render the settings screen.

 ## Dependency Injection
 A great way to achieve this goal is to use the dependency injection pattern. In order to leverage this pattern you do not need a special library. As long as you follow some simple rules you can easily take advantage of this pattern.

 For this tutorial we need to create a dependency injection container that will create and hold on to the ReSwift store. The container will also know how to create a new observable from the store and use the newly created observable to create the settings view controller.

 ## Dependency Protocol
 To make the architecture more flexible, you can define a protocol that describes all the dependencies in the app. This is great for testing because you can replace real implementatios of dependencies such as networking with fake implementations for which you have full control over.

 Here's the `DependencyProvider` protocol you'll be implementing in demo 1, notice how all the dependency imports live here instead of the view controller:
 */
import Foundation
import UIKit
import ReSwift
import RxSwift

protocol DependencyProvider {
  var reduxStore: Store<AppState> { get }
  
  func makeSettingsViewController() -> UIViewController
  func makeSettingsViewStateObservable() -> Observable<SettingsViewState>
}
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
