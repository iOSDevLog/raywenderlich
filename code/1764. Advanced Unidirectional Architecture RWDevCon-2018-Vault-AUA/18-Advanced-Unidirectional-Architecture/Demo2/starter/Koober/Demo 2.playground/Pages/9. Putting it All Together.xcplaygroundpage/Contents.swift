/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Putting it All Together

 Now that you've explored the tutorial's scenario, it's time to build out the settings view controller.
 */
import PlaygroundSupport

import UIKit
import ReSwift
import RxSwift

//: First, implement the settings view controller by including a new designated initializer with an observable parameter. Use the provided observable to render the screen:
class SettingsViewController: NiblessViewController {
  let stateObservable: Observable<SettingsViewState>
  let disposeBag = DisposeBag()

  init(stateObservable: Observable<SettingsViewState>) {
    self.stateObservable = stateObservable
    super.init()
  }

  var rootView: SettingsRootView {
    return view as! SettingsRootView
  }

  override func loadView() {
    view = SettingsRootView()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    subscribe(to: stateObservable)
  }

  func updateView(with viewState: SettingsViewState) {
    rootView.update(with: viewState)
  }

  func subscribe(to observable: Observable<SettingsViewState>) {
    observable.subscribe(
      onNext: { [weak self] viewState in
        self?.updateView(with: viewState)
    }).disposed(by: disposeBag)
  }
}
//: Next, the settings view controller needs to be presented. To do that build a home view controller:
class HomeViewController: NiblessViewController {
  let settingsViewControllerFactory: SettingsViewControllerFactory

  init(settingsViewControllerFactory: SettingsViewControllerFactory) {
    self.settingsViewControllerFactory = settingsViewControllerFactory
    super.init()
  }

  override func loadView() {
    self.view = HomeRootView(ixResponder: self)
  }
}

extension HomeViewController: HomeIXResponder {
  public func goToSettings() {
    let settingsViewController =
      settingsViewControllerFactory.makeSettingsViewController()
    present(settingsViewController, animated: true)
  }
}

//: Finally, implement the dependency provider protocol:
class DependencyContainer: DependencyProvider {
  let reduxStore = Store<AppState>(reducer: reduce,
                                   state: nil)

  func makeSettingsViewStateObservable() -> Observable<SettingsViewState> {
    let observable =
      reduxStore
        .makeObservable { appState in
          return appState.settingsViewState
        }.distinctUntilChanged()
    return observable
  }

  func makeSettingsViewController() -> UIViewController {
    let observable = makeSettingsViewStateObservable()
    return SettingsViewController(stateObservable: observable)
  }
}

//: Present the view controller in the live view window:
let dependencyContainer: DependencyProvider = DependencyContainer()
let homeViewController = HomeViewController(settingsViewControllerFactory: dependencyContainer)
PlaygroundPage.current.liveView = homeViewController

/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */

