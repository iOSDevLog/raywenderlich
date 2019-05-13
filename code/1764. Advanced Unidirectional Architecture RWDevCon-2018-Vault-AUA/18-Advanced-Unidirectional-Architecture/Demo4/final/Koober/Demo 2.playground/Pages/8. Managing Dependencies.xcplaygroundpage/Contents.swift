/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Managing Dependencies
 This demo introduces more external dependencies such as the  the persistent store. In order to manage these dependencies, the `DependencyProvider` is augmented as follows:
 ## Dependency Provider
 */
import Foundation
import UIKit
import RxSwift
import ReSwift

protocol DependencyProvider: SettingsViewControllerFactory,
                             LoadPersistedStateUseCaseFactory {
  var reduxStore: Store<AppState> { get }
  var userStore: PersistentUserStore { get }
  var statePersister: StatePersister { get }

  func makeSettingsViewController() -> UIViewController

  func makeSettingsViewStateObservable() -> Observable<SettingsViewState>
  func makeLoadPersistedStateUseCase () -> UseCase
}
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
