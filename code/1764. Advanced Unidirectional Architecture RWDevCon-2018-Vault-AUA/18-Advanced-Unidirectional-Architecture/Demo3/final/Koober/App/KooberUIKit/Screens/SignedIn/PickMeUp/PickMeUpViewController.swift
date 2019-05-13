/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import KooberKit
import RxSwift

public class PickMeUpViewController: NiblessViewController {
  // MARK: Child View Controllers
  let mapViewController: PickMeUpMapViewController
  let rideOptionPickerViewController: RideOptionPickerViewController
  let sendingRideRequestViewController: SendingRideRequestViewController
  // MARK: State
  var lastErrorMessage: String?
  let stateObservable: Observable<PickMeUpState>
  let stepObservable: Observable<PickMeUpStep>
  let disposeBag = DisposeBag()
  // MARK: Factories
  let useCaseFactory: PickMeUpUseCaseFactory
  let viewControllerFactory: PickMeUpViewControllerFactory

  init(mapViewController: PickMeUpMapViewController,
       rideOptionPickerViewController: RideOptionPickerViewController,
       sendingRideRequestViewController: SendingRideRequestViewController,
       stateObservable: Observable<PickMeUpState>,
       stepObservable: Observable<PickMeUpStep>,
       useCaseFactory: PickMeUpUseCaseFactory,
       viewControllerFactory: PickMeUpViewControllerFactory) {
    self.mapViewController = mapViewController
    self.rideOptionPickerViewController = rideOptionPickerViewController
    self.sendingRideRequestViewController = sendingRideRequestViewController
    self.viewControllerFactory = viewControllerFactory
    self.stateObservable = stateObservable
    self.stepObservable = stepObservable
    self.useCaseFactory = useCaseFactory
    super.init()
  }

  public override func loadView() {
    view = {
      let view = PickMeUpRootView()
      view.ixResponder = self
      return view
    }()
  }

  public override func viewDidLoad() {
    addFullScreen(childViewController: mapViewController)
    super.viewDidLoad()

    subscribe(to: stateObservable)
    subscribe(to: stepObservable)
  }

  func subscribe(to stateObservable: Observable<PickMeUpState>) {
    stateObservable
      .subscribe(onNext: { [weak self] state in
        if state.shouldDisplayWhereTo {
          self?.presentWhereTo()
        } else {
          self?.dismissWhereTo()
        }
      })
      .disposed(by: disposeBag)
  }

  func subscribe(to stepObservable: Observable<PickMeUpStep>) {
    stepObservable
      .subscribe(onNext: { [weak self] step in
        switch step {
        case .initial:
          self?.presentInitialState()
        case .selectDropoffLocation:
          self?.presentDropoffLocationPicker()
        case .selectRideOption:
          self?.dropoffLocationSelected()
        case .confirmRequest:
          self?.presentConfirmControl()
        case .requestConfirmed(let state):
          self?.send(newRideRequest: state.newRideRequest)
          self?.presentSendingRideRequestScreen()
        case .requestAccepted:
          self?.dismissSendingRideRequestScreen()
        }
      })
      .disposed(by: disposeBag)
  }

  public override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    mapViewController.view.frame = view.bounds
  }

  public override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  func presentInitialState() {
    if let _ = presentedViewController as? DropoffLocationPickerViewController {
      dismiss(animated: true)
    }
    remove(childViewController: rideOptionPickerViewController)
    confirmControl?.removeFromSuperview()
    confirmControl = nil
  }

  func presentWhereTo() {
    if let view = view as? PickMeUpRootView {
      view.presentWhereToControl()
    }
  }

  func presentDropoffLocationPicker() {
    let viewController = viewControllerFactory.makeDropoffLocationPickerViewController()
    present(viewController, animated: true)
  }

  func dropoffLocationSelected() {
    if let _ = presentedViewController as? DropoffLocationPickerViewController {
      dismiss(animated: true)
    }
    presentRideOptionPicker()
  }

  func dismissWhereTo() {
    if let view = view as? PickMeUpRootView {
      view.dismissWhereToControl()
    }
  }

  func presentRideOptionPicker() {
    let child = rideOptionPickerViewController
    guard child.parent == nil else {
      return
    }
    addChildViewController(child)
    child.view.frame = CGRect(x: 0, y: view.bounds.maxY - 140,
                              width: view.bounds.width, height: 140)
    view.addSubview(child.view)
    child.didMove(toParentViewController: self)
  }

  var confirmControl: UIButton?

  func presentConfirmControl() {
    guard confirmControl.isEmpty else {
      return
    }
    
    let buttonBackground: UIView = {
      let background = UIView()
      background.backgroundColor = Color.background
      background.frame = CGRect(x: 0, y: rideOptionPickerViewController.view.frame.maxY,
                                width: self.view.bounds.width, height: 70)
      return background
    }()

    let button: UIButton = {
      let button = UIButton(type: .system)
      button.backgroundColor = Color.lightButtonBackground
      button.setTitle("Confirm", for: .normal)
      button.frame = CGRect(x: 20, y: rideOptionPickerViewController.view.frame.maxY,
                            width: self.view.bounds.width - 40, height: 50)
      button.addTarget(self, action: #selector(PickMeUpViewController.handleConfirm), for: .touchUpInside)
      button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
      button.setTitleColor(UIColor.white, for: UIControlState.normal)
      button.layer.cornerRadius = 3
      return button
    }()

    view.addSubview(buttonBackground)
    view.addSubview(button)

    UIView.animate(withDuration: 0.7) {
      var rideOptionPickerFrame = self.rideOptionPickerViewController.view.frame
      rideOptionPickerFrame.origin.y -= 70
      self.rideOptionPickerViewController.view.frame = rideOptionPickerFrame

      var confirmControlFrame = button.frame
      confirmControlFrame.origin.y -= 70
      button.frame = confirmControlFrame
      
      var backgroundFrame = buttonBackground.frame
      backgroundFrame.origin.y -= 70
      buttonBackground.frame = backgroundFrame
    }

    self.confirmControl = button
  }

  @objc
  func handleConfirm() {
    useCaseFactory.makeConfirmRideRequestUseCase().start()
  }

  func presentSendingRideRequestScreen() {
    present(sendingRideRequestViewController, animated: true)
  }

  func send(newRideRequest: NewRideRequest) {
    self.useCaseFactory.makeRequestRideUseCase(newRideRequest: newRideRequest).start()
  }

  func dismissSendingRideRequestScreen() {
    view.alpha = 0
    dismiss(animated: true) {
      self.useCaseFactory.makeExitPickMeUpUseCase().start()
    }
  }
}

extension PickMeUpViewController: PickMeUpIXResponder {
  func selectWhereTo() {
    useCaseFactory.makeGoToDropoffLocationPickerUseCase().start()
  }
}


extension Optional {
  var isEmpty: Bool {
    return self == nil
  }

  var exists: Bool {
    return self != nil
  }
}

protocol PickMeUpUseCaseFactory {
  func makeGoToDropoffLocationPickerUseCase() -> UseCase
  func makeConfirmRideRequestUseCase() -> UseCase
  func makeRequestRideUseCase(newRideRequest: NewRideRequest) -> UseCase
  func makeExitPickMeUpUseCase() -> UseCase
}

protocol PickMeUpViewControllerFactory {
  func makeDropoffLocationPickerViewController() -> DropoffLocationPickerViewController
}
