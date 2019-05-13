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

public protocol PickMeUpDependencyProvider {
  // MARK: - Context-State
  var signedInDependencyProvider: SignedInDependencyProvider { get }
  var pickupLocation: Location { get }

  // MARK: - Use Cases
  // MARK: Dropoff Location Picker
  func makeGoToDropoffLocationPickerUseCase() -> UseCase
  func makeCancelDropoffLocationSelectionUseCase() -> UseCase
  func makeSearchLocationsUseCase(query: String, pickupLocation: Location) -> CancelableUseCase
  func makeSelectDropoffLocationUseCase(dropoffLocation: Location) -> UseCase
  // MARK: Select Ride Option
  func makeLoadRideOptionsUseCase(pickupLocation: Location) -> UseCase
  func makeSelectRideOptionUseCase(selectedRideOptionID: RideOptionID) -> UseCase
  // MARK: Confirm Ride
  func makeConfirmRideRequestUseCase() -> UseCase
  func makeRequestRideUseCase(newRideRequest: NewRideRequest) -> UseCase
  // MARK: Exit
  func makeExitPickMeUpUseCase() -> UseCase

  // MARK: - Observables
  func makePickMeUpStateObservable() -> Observable<PickMeUpState>
  func makePickMeUpStepObservable() -> Observable<PickMeUpStep>
  func makeRideOptionPickerStateObservable() -> Observable<RideOptionPickerState>
  func makePickMeUpMapStateObservable() -> Observable<PickMeUpMapState>
  func makeDropoffLocationPickerStateObservable() -> Observable<DropoffLocationPickerState>
}
