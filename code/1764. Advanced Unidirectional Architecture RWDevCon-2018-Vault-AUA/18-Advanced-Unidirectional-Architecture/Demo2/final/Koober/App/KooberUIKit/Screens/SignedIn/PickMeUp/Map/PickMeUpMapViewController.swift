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

public class PickMeUpMapViewController: NiblessViewController {
  // MARK: Dependencies
  let imageCache: ImageCache
  // MARK: State
  let stateObservable: Observable<PickMeUpMapState>
  let disposeBag = DisposeBag()
  // MARK: Root View
  var mapView: PickMeUpMapRootView {
    return view as! PickMeUpMapRootView
  }

  public init(imageCache: ImageCache,
              stateObservable: Observable<PickMeUpMapState>) {
    self.imageCache = imageCache
    self.stateObservable = stateObservable
    super.init()
  }

  public override func loadView() {
    view = PickMeUpMapRootView(imageCache: imageCache)
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

    mapView.imageCache = imageCache
    subscribe(to: stateObservable)
  }

  func subscribe(to stateObservable: Observable<PickMeUpMapState>) {
    stateObservable.subscribe(onNext: { [weak self] mapState in
      let pickupAnnotations = [MapAnnotationType.makePickupLocationAnnotation(for: mapState.usersCurrentLocation)]
      
      let dropOffAnnotations: [MapAnnotation]
      if let dropoffLocation = mapState.dropoffLocation {
        dropOffAnnotations = [MapAnnotationType.makeDropoffLocationAnnotation(for: dropoffLocation)]
      } else {
        dropOffAnnotations = []
      }
      
      let model = MapViewModel(pickupLocationAnnotations: pickupAnnotations,
                               dropoffLocationAnnotations: dropOffAnnotations,
                               availableRideLocationAnnotations: [])
      self?.mapView.viewModel = model
    }).disposed(by: disposeBag)
  }

  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  public override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }
}
