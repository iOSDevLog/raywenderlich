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

public class EntryPointAppDependencyContainer: EntryPointDependencyContainer, EntryPointAppDependencyProvider {
  public func makeMainViewController() -> MainViewController {
    let rootScreenStateObservable = makeRootScreenObservable()
    let launchViewController = makeLaunchViewController()
    return MainViewController(rootScreenStateObservable: rootScreenStateObservable,
                              launchViewController: launchViewController,
                              viewControllerFactory: self)
  }

  public func makeLaunchViewController() -> LaunchViewController {
    return LaunchViewController(useCaseFactory: self)
  }

  public func makeOnboardingViewController() -> OnboardingViewController {
    let dependencyContainer = OnboardingAppDependencyContainer(entryPointAppContainer: self)
    return dependencyContainer.makeOnboardingViewController()
  }

  public func makeSignedInViewController(session: UserSession) -> SignedInViewController {
    let dependencyContainer = makeSignedInAppContainer(session: session)
    return dependencyContainer.makeSignedInViewController()
  }

  public func makeSignedInAppContainer(session: UserSession) -> SignedInAppDependencyContainer  {
    return SignedInAppDependencyContainer(userSession: session, entryPointContainer: self)
  }
}

extension EntryPointAppDependencyContainer: LaunchUseCaseFactory {}

extension EntryPointAppDependencyContainer: MainViewControllerFactory {}
