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
import RxSwift
import ReSwift

open class SignedInDependencyContainer: SignedInDependencyProvider {
  public let userSession: UserSession
  public let locator: Locator = FakeLocator()
  public let rideOptionDataStore: RideOptionDataStore = RideOptionDataStoreInMemory()
  public let newRideRemoteAPI: NewRideRemoteAPI
  public let entryPointDependencyProvider: EntryPointDependencyProvider

  public init(userSession: UserSession, entryPointContainer: EntryPointDependencyProvider) {
    self.userSession = userSession
    self.newRideRemoteAPI = FakeNewRideRemoteAPI()
    self.entryPointDependencyProvider = entryPointContainer
  }

  // MARK: - Use Cases
  public func makeGoToProfileUseCase() -> UseCase {
    let actionDispatcher = entryPointDependencyProvider.store as ActionDispatcher
    return GoToProfileUseCase(actionDispatcher: actionDispatcher)
  }

  public func makeStartNewRideRequestUseCase() -> UseCase {
    let actionDispatcher = entryPointDependencyProvider.store as ActionDispatcher
    return StartNewRideRequestUseCase(actionDispatcher: actionDispatcher)
  }

  public func makeCloseProfileUseCase() -> UseCase {
    let actionDispatcher = entryPointDependencyProvider.store as ActionDispatcher
    return CloseProfileUseCase(actionDispatcher: actionDispatcher)
  }

  public func makeSignOutUseCase() -> UseCase {
    let actionDispatcher = entryPointDependencyProvider.store as ActionDispatcher
    let dataStore = entryPointDependencyProvider.userSessionDataStore
    return SignOutUseCase(userSession: userSession, dataStore: dataStore, actionDispatcher: actionDispatcher)
  }

  public func makeGetUsersCurrentLocationUseCase() -> UseCase {
    let actionDispatcher = entryPointDependencyProvider.store as ActionDispatcher
    return GetUsersCurrentLocationUseCase(actionDispatcher: actionDispatcher,
                                          locator: locator)
  }

  // MARK: - Observables
  public func makeSignedInStateObservable() -> Observable<SignedInState> {
    return entryPointDependencyProvider.store
      .makeObservable { state in
        return state.rootScreen
      }
      .mapUntilNil { rootScreen in
        if case .signedIn(let signedInState) = rootScreen {
          return signedInState
        }
        return nil
      }
      .distinctUntilChanged()
  }

  public func makeSignedInScreenObservable() -> Observable<SignedInScreen> {
    return makeSignedInStateObservable()
      .map { state in return state.screen }
      .distinctUntilChanged { lhs, rhs in
        switch (lhs, rhs) {
        case (.gettingUsersLocation, .gettingUsersLocation): return true
        case (.pickMeUp, .pickMeUp): return true
        case (.waitingForPickup, .waitingForPickup): return true
        case (.gettingUsersLocation, _),
             (.pickMeUp, _),
             (.waitingForPickup, _): return false
        }
    }
  }

  public func makeSignedInErrorObservable() -> Observable<ErrorMessage> {
    return entryPointDependencyProvider.store
      .makeObservable { state in
        return state.rootScreen
      }
      .mapUntilNil { rootScreen -> SignedInState? in
        if case .signedIn(let signedInState) = rootScreen {
          return signedInState
        }
        return nil
      }
      .map { state in
        return state.errorMessage
      }
      .ignoreNil()
      .distinctUntilChanged()
  }

  public func makeUserProfileStateObservable() -> Observable<UserProfile> {
    return entryPointDependencyProvider.store
      .makeObservable { state in
        return state.rootScreen
      }
      .mapUntilNil { rootScreen -> SignedInState? in
        if case .signedIn(let signedInState) = rootScreen {
          return signedInState
        }
        return nil
      }
      .mapUntilNil { signedInState in
        return signedInState.userSession.profile
      }
      .distinctUntilChanged()
  }
}
