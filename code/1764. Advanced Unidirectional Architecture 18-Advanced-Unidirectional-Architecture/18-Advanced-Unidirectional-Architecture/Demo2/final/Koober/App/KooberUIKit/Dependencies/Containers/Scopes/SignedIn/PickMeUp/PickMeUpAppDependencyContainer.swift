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

public class PickMeUpAppDependencyContainer: PickMeUpDependencyContainer, PickMeUpAppDependencyProvider {
  public let signedInAppDependencyProvider: SignedInAppDependencyProvider
  var imageCache: ImageCache {
    return signedInAppDependencyProvider.imageCache
  }

  init(signedInAppDependencyProvider: SignedInAppDependencyProvider,
       pickupLocation: Location) {
    self.signedInAppDependencyProvider = signedInAppDependencyProvider
    super.init(signedInDependencyProvider: signedInAppDependencyProvider as SignedInDependencyProvider,
               pickupLocation: pickupLocation)
  }

  public func makePickMeUpViewController() -> PickMeUpViewController {
    let mapViewController = makePickMeUpMapViewController()
    let rideOptionPickerViewController = makeRideOptionPickerViewController()
    let sendingRideRequestViewController = makeSendingRideRequestViewController()
    let stateObservable = makePickMeUpStateObservable()
    let stepObservable = makePickMeUpStepObservable()
    return PickMeUpViewController(mapViewController: mapViewController,
                                  rideOptionPickerViewController: rideOptionPickerViewController,
                                  sendingRideRequestViewController: sendingRideRequestViewController,
                                  stateObservable: stateObservable,
                                  stepObservable: stepObservable,
                                  useCaseFactory: self,
                                  viewControllerFactory: self)
  }

  func makePickMeUpMapViewController() -> PickMeUpMapViewController {
    let stateObservable = makePickMeUpMapStateObservable()
    return PickMeUpMapViewController(imageCache: imageCache,
                                     stateObservable: stateObservable)
  }

  public func makeDropoffLocationPickerViewController() -> DropoffLocationPickerViewController {
    let contentViewController = makeDropoffLocationPickerContentViewController()
    return DropoffLocationPickerViewController(contentViewController: contentViewController)
  }

  func makeDropoffLocationPickerContentViewController() -> DropoffLocationPickerContentViewController {
    let stateObservable = makeDropoffLocationPickerStateObservable()
    return DropoffLocationPickerContentViewController(pickupLocation: pickupLocation,
                                                      useCaseFactory: self,
                                                      stateObservable: stateObservable)
  }

  public func makeRideOptionPickerViewController() -> RideOptionPickerViewController {
    let observable = makeRideOptionPickerStateObservable()
    return RideOptionPickerViewController(imageCache: imageCache,
                                          useCaseFactory: self,
                                          stateObservable: observable)
  }

  public func makeSendingRideRequestViewController() -> SendingRideRequestViewController {
    return SendingRideRequestViewController()
  }
}

extension PickMeUpAppDependencyContainer: PickMeUpUseCaseFactory, DropoffLocationPickerUseCaseFactory, RideOptionPickerUseCaseFactory {}

extension PickMeUpAppDependencyContainer: PickMeUpViewControllerFactory {}
