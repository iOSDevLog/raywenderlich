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

import Foundation
import ReSwift
import RxSwift

open class OnboardingDependencyContainer: OnboardingDependencyProvider {
  public let entryPointContainer: EntryPointDependencyContainer

  public init(entryPointContainer: EntryPointDependencyContainer) {
    self.entryPointContainer = entryPointContainer
  }

  public func makeGoToSignInUseCase() -> UseCase {
    let reSwiftStore = entryPointContainer.store
    return GoToSignInUseCase(actionDispatcher: reSwiftStore)
  }

  public func makeGoToSignUpUseCase() -> UseCase {
    let reSwiftStore = entryPointContainer.store
    return GoToSignUpUseCase(actionDispatcher: reSwiftStore)
  }

  public func makeSignInUseCase(username: String, password: String) -> UseCase {
    let remoteAPI = entryPointContainer.makeAuthRemoteAPI()
    let dataStore = entryPointContainer.userSessionDataStore
    let reSwiftStore = entryPointContainer.store
    return SignInUseCase(username: username,
                         password: password,
                         remoteAPI: remoteAPI,
                         dataStore: dataStore,
                         actionDispatcher: reSwiftStore)
  }

  public func makeSignUpUseCase(account: NewAccount) -> UseCase {
    let remoteAPI = entryPointContainer.makeAuthRemoteAPI()
    let dataStore = entryPointContainer.userSessionDataStore
    let reSwiftStore = entryPointContainer.store
    return SignUpUseCase(account: account,
                         remoteAPI: remoteAPI,
                         dataStore: dataStore,
                         actionDispatcher: reSwiftStore)
  }

  public func makeOnboardingStateObservable() -> Observable<OnboardingScreen> {
    return entryPointContainer.store
      .makeObservable { appState in
        return appState.rootScreen
      }
      .mapUntilNil { rootScreen -> OnboardingScreen? in
        if case .onboarding(let onboardingState) = rootScreen {
          return onboardingState.screen
        }
        return nil
      }
      .distinctUntilChanged()
  }

  public func makeOnboardingErrorObservable() -> Observable<ErrorMessage> {
    return entryPointContainer.store
      .makeObservable { state in
        return state.rootScreen
      }
      .mapUntilNil { rootScreen -> OnboardingState? in
        if case .onboarding(let onboardingState) = rootScreen {
          return onboardingState
        }
        return nil
      }
      .map { state in
        return state.errorMessage
      }
      .ignoreNil()
      .distinctUntilChanged()
  }
}
