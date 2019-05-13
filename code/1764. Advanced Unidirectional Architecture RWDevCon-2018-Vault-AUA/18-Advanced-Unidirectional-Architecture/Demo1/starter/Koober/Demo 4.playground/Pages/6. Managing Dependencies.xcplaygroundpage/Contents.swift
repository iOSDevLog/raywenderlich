/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Managing Dependencies
 */
import Foundation
import UIKit
import RxSwift
import ReSwift

protocol DependencyProvider: SettingsViewControllerFactory,
                             LoadPersistedStateUseCaseFactory,
                             LoadUserProfileUseCaseFactory,
                             UpdateClawedUseCaseFactory { // New
  var reduxStore: Store<AppState> { get }
  var userStore: PersistentUserStore { get }
  var statePersister: StatePersister { get }

  func makeSettingsViewController() -> UIViewController

  func makeSettingsViewStateObservable() -> Observable<SettingsViewState>
  func makeLoadPersistedStateUseCase () -> UseCase
  func makeLoadUserProfileUseCase() -> UseCase
  func makeUpdateClawedUseCase(clawed: Bool) -> UseCase // New

  func makeUserRemoteAPI() -> UserRemoteAPI
}
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
