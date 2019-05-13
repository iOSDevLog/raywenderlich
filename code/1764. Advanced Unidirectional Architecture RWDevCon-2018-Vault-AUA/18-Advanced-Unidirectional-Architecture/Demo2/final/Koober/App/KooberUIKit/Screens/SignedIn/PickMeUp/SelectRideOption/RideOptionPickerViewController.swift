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

public class RideOptionPickerViewController: NiblessViewController {
  // MARK: Dependencies
  let imageCache: ImageCache
  // MARK: State
  var selectedRideOptionID: RideOptionID?
  let stateObservable: Observable<RideOptionPickerState>
  let disposeBag = DisposeBag()
  // MARK: Factories
  let useCaseFactory: RideOptionPickerUseCaseFactory
  // MARK: Root View
  var rideOptionSegmentedControl: RideOptionSegmentedControl {
    return view as! RideOptionSegmentedControl
  }

  init(imageCache: ImageCache,
              useCaseFactory: RideOptionPickerUseCaseFactory,
              stateObservable: Observable<RideOptionPickerState>) {
    self.imageCache = imageCache
    self.useCaseFactory = useCaseFactory
    self.stateObservable = stateObservable
    super.init()
  }

  public override func loadView() {
    view = RideOptionSegmentedControl(frame: .zero, imageCache: imageCache)
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

    rideOptionSegmentedControl.onSelected = { [weak self] selectedRideOptionID in
      guard let strongSelf = self else { return }
      strongSelf.handle(selectedRideOptionID: selectedRideOptionID)
    }
  }

  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    subscribe(to: stateObservable)
  }

  func subscribe(to stateObservable: Observable<RideOptionPickerState>) {
    stateObservable.subscribe(onNext: { [weak self] state in
      self?.update(withState: state)
    }).disposed(by: disposeBag)
  }

  func update(withState state: RideOptionPickerState) {
    switch state.loadState {
    case .notLoaded:
      self.useCaseFactory.makeLoadRideOptionsUseCase(pickupLocation: state.pickupLocation).start()
    case .loaded(let rideOptions):
      let selectionChanged =
        rideOptions.selectedRideOptionID != self.selectedRideOptionID
      if selectionChanged {
        self.selectedRideOptionID = rideOptions.selectedRideOptionID
        rideOptionSegmentedControl.viewModel =
          SegmentedControlStateReducer.reduce(from: rideOptions)
      }
    }
  }

  func handle(selectedRideOptionID: RideOptionID) {
    useCaseFactory.makeSelectRideOptionUseCase(selectedRideOptionID: selectedRideOptionID).start()
  }

  class SegmentedControlStateReducer {
    static func reduce(from rideOptions: RideOptionPickerRideOptions) -> RideOptionSegmentedControlViewModel {
      let segments = RideOptionSegmentsFactory(state: rideOptions).makeSegments()
      return RideOptionSegmentedControlViewModel(segments: segments)
    }
  }
}

protocol RideOptionPickerUseCaseFactory {
  func makeLoadRideOptionsUseCase(pickupLocation: Location) -> UseCase
  func makeSelectRideOptionUseCase(selectedRideOptionID: RideOptionID) -> UseCase
}
