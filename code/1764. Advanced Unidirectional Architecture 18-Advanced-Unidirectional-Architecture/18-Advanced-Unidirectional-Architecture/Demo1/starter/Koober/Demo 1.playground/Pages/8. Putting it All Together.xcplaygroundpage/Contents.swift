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
  let disposeBag = DisposeBag()

  var rootView: SettingsRootView {
    return view as! SettingsRootView
  }

  override func loadView() {
    view = SettingsRootView()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  func subscribe(to observable: Observable<SettingsViewState>) {
    observable.subscribe(
      onNext: { [weak self] viewState in
        self?.updateView(with: viewState)
    }).disposed(by: disposeBag)
  }

  func updateView(with viewState: SettingsViewState) {
    rootView.update(with: viewState)
  }
}

//: Next, the settings view controller needs to be presented. To do that build a home view controller:
class HomeViewController: NiblessViewController, HomeIXResponder {

  override func loadView() {
    self.view = HomeRootView(ixResponder: self)
  }

  func goToSettings() {

  }
}

//: Finally, implement the dependency provider protocol:
class DependencyContainer {

}

//: Present the view controller in the live view window:



/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
