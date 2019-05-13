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

open class PickMeUpDependencyContainer: PickMeUpDependencyProvider {
  public let signedInDependencyProvider: SignedInDependencyProvider
  public let pickupLocation: Location
  var reSwiftStore: Store<EntryPointState> {
    return signedInDependencyProvider.entryPointDependencyProvider.store
  }

  public init(signedInDependencyProvider: SignedInDependencyProvider,
              pickupLocation: Location) {
    self.signedInDependencyProvider = signedInDependencyProvider
    self.pickupLocation = pickupLocation
  }

  // MARK: - Use Cases
  public func makeGoToDropoffLocationPickerUseCase() -> UseCase {
    return GoToDropoffLocationPickerUseCase(actionDispatcher: reSwiftStore as ActionDispatcher)
  }

  public func makeConfirmRideRequestUseCase() -> UseCase {
    return ConfirmRideRequestUseCase(actionDispatcher: reSwiftStore as ActionDispatcher)
  }

  public func makeCancelDropoffLocationSelectionUseCase() -> UseCase {
    return CancelDropoffSelectionUseCase(actionDispatcher: reSwiftStore as ActionDispatcher)
  }

  public func makeSearchLocationsUseCase(query: String, pickupLocation: Location) -> CancelableUseCase {
    let remoteAPI = signedInDependencyProvider.newRideRemoteAPI
    return SearchLocationsUseCase(query: query,
                                  pickupLocation: pickupLocation,
                                  actionDispatcher: reSwiftStore as ActionDispatcher,
                                  remoteAPI: remoteAPI)
  }

  public func makeSelectDropoffLocationUseCase(dropoffLocation: Location) -> UseCase {
    return SelectDropoffLocationUseCase(dropoffLocation: dropoffLocation,
                                        actionDispatcher: reSwiftStore as ActionDispatcher)
  }

  public func makeLoadRideOptionsUseCase(pickupLocation: Location) -> UseCase {
    return LoadRideOptionsUseCase(pickupLocation: pickupLocation,
                                  actionDispatcher: reSwiftStore as ActionDispatcher,
                                  rideOptionDataStore: signedInDependencyProvider.rideOptionDataStore,
                                  newRideRemoteAPI: signedInDependencyProvider.newRideRemoteAPI)
  }

  public func makeSelectRideOptionUseCase(selectedRideOptionID: RideOptionID) -> UseCase {
    return SelectRideOptionUseCase(selectedRideOptionID: selectedRideOptionID,
                                   actionDispatcher: reSwiftStore as ActionDispatcher,
                                   newRideRemoteAPI: signedInDependencyProvider.newRideRemoteAPI)
  }

  public func makeRequestRideUseCase(newRideRequest: NewRideRequest) -> UseCase {
    return RequestRideUseCase(newRideRequest: newRideRequest,
                              actionDispatcher: reSwiftStore as ActionDispatcher,
                              remoteAPI: signedInDependencyProvider.newRideRemoteAPI)
  }

  public func makeExitPickMeUpUseCase() -> UseCase {
    return ExitPickMeUpUseCase(actionDispatcher: reSwiftStore as ActionDispatcher)
  }

  // MARK: - Observables
  public func makePickMeUpStateObservable() -> Observable<PickMeUpState> {
    return reSwiftStore
      .makeObservable { state in
        return state.rootScreen
      }
      .mapUntilNil { rootScreen -> SignedInScreen? in
        if case .signedIn(let signedInState) = rootScreen {
          return signedInState.screen
        }
        return nil
      }
      .mapUntilNil { signedInScreen in
        if case .pickMeUp(let pickMeUpState) = signedInScreen {
          return pickMeUpState
        }
        return nil
      }
      .distinctUntilChanged()
  }

  public func makePickMeUpStepObservable() -> Observable<PickMeUpStep> {
    return makePickMeUpStateObservable()
      .map { state in return state.pickMeUpStep }
      .distinctUntilChanged { lhs, rhs in
        switch (lhs, rhs) {
        case (.initial, .initial): return true
        case (.selectDropoffLocation, .selectDropoffLocation): return true
        case (.selectRideOption, .selectRideOption): return true
        case (.confirmRequest, .confirmRequest): return true
        case (.requestConfirmed, .requestConfirmed): return true
        case (.requestAccepted, .requestAccepted): return true
        case (.initial, _),
             (.selectDropoffLocation, _),
             (.selectRideOption, _),
             (.confirmRequest, _),
             (.requestConfirmed, _),
             (.requestAccepted, _): return false
        }
    }
  }

  public func makeRideOptionPickerStateObservable() -> Observable<RideOptionPickerState> {
    return reSwiftStore
      .makeObservable { state in
        return state.rootScreen
      }
      .mapUntilNil { rootScreen -> SignedInScreen? in
        if case .signedIn(let signedInState) = rootScreen {
          return signedInState.screen
        }
        return nil
      }
      .mapUntilNil { signedInScreen in
        if case .pickMeUp(let pickMeUpState) = signedInScreen {
          return pickMeUpState.rideOptionPickerState
        }
        return nil
      }
      .distinctUntilChanged()
  }

  public func makePickMeUpMapStateObservable() -> Observable<PickMeUpMapState> {
    return reSwiftStore
      .makeObservable { state in
        return state.rootScreen
      }
      .mapUntilNil { rootScreen -> SignedInScreen? in
        if case .signedIn(let signedInState) = rootScreen {
          return signedInState.screen
        }
        return nil
      }
      .mapUntilNil { signedInScreen in
        if case .pickMeUp(let pickMeUpState) = signedInScreen {
          return pickMeUpState.mapState
        }
        return nil
      }
      .distinctUntilChanged()
  }

  public func makeDropoffLocationPickerStateObservable() -> Observable<DropoffLocationPickerState> {
    return reSwiftStore
      .makeObservable { state in
        return state.rootScreen
      }
      .mapUntilNil { rootScreen -> SignedInScreen? in
        if case .signedIn(let signedInState) = rootScreen {
          return signedInState.screen
        }
        return nil
      }
      .mapUntilNil { signedInScreen -> PickMeUpStep? in
        if case .pickMeUp(let pickMeUpState) = signedInScreen {
          return pickMeUpState.pickMeUpStep
        }
        return nil
      }
      .mapUntilNil { pickMeUpStep -> DropoffLocationPickerState? in
        if case .selectDropoffLocation(let selectDropoffLocationState) = pickMeUpStep {
          return selectDropoffLocationState.dropoffLocationPickerState
        }
        return nil
      }
      .distinctUntilChanged()
  }
}
