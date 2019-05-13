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
import ReSwift


public class SignedInAppDependencyContainer: SignedInDependencyContainer, SignedInAppDependencyProvider {
  public let imageCache: ImageCache = InBundleImageCache()

  public func makeSignedInViewController() -> SignedInViewController {
    let stateObservable: Observable<SignedInState> = makeSignedInStateObservable()
    let screenObservable: Observable<SignedInScreen> = makeSignedInScreenObservable()
    let errorMessageObservable = makeSignedInErrorObservable()
    let profileViewController = makeProfileViewController()
    return SignedInViewController(stateObservable: stateObservable,
                                  screenObservable: screenObservable,
                                  errorMessageObservable: errorMessageObservable,
                                  userSession: userSession,
                                  profileViewController: profileViewController,
                                  useCaseFactory: self,
                                  viewControllerFactory: self)
  }

  // MARK: Getting Users Location
  public func makeGettingUsersLocationViewController() -> GettingUsersLocationViewController {
    return GettingUsersLocationViewController(useCaseFactory: self)
  }

  // MARK: Pick Me Up
  public func makePickMeUpViewController(pickupLocation: Location) -> PickMeUpViewController {
    let pickMeUpDependencyContainer = PickMeUpAppDependencyContainer(signedInAppDependencyProvider: self,
                                                                     pickupLocation: pickupLocation)
    return pickMeUpDependencyContainer.makePickMeUpViewController()
  }

  // MARK: Waiting for Pickup
  public func makeWaitingForPickupViewController() -> WaitingForPickupViewController {
    return WaitingForPickupViewController(useCaseFactory: self)
  }

  // MARK: View Profile
  public func makeProfileViewController() -> ProfileViewController {
    let contentViewController = makeProfileContentViewController()
    return ProfileViewController(contentViewController: contentViewController)
  }

  func makeProfileContentViewController() -> ProfileContentViewController {
    let stateObservable = makeUserProfileStateObservable()
    return ProfileContentViewController(stateObservable: stateObservable,
                                        useCaseFactory: self)
  }
}

extension SignedInAppDependencyContainer: SignedInUseCaseFactory, GettingUsersLocationUseCaseFactory, WaitingForPickupUseCaseFactory, ProfileUseCaseFactory {}

extension SignedInAppDependencyContainer: SignedInViewControllerFactory {}
