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
import PromiseKit

public struct RideOptionsLoadedAction: KooberAction {
  let rideOptionsById: [RideOptionID: RideOption]
  let rideOptions: [RideOption]
}

public class LoadRideOptionsUseCase: UseCase {
  let pickupLocation: Location
  let actionDispatcher: ActionDispatcher
  let rideOptionDataStore: RideOptionDataStore
  let newRideRemoteAPI: NewRideRemoteAPI

  init(pickupLocation: Location,
              actionDispatcher: ActionDispatcher,
              rideOptionDataStore: RideOptionDataStore,
              newRideRemoteAPI: NewRideRemoteAPI) {
    self.pickupLocation = pickupLocation
    self.actionDispatcher = actionDispatcher
    self.rideOptionDataStore = rideOptionDataStore
    self.newRideRemoteAPI = newRideRemoteAPI
  }

  public func start() {
    readRideOptionsFromDataStore()
      .then(execute: loadFromRemoteIfNecessary(basedOnStoredRideOptions:))
      .then(execute: updateState(withRideOptions:))
      .catch { error in
        let errorMessage = ErrorMessage(title: "Error Loading Data",
                                        message: "\(error)")
        let action = SignedInErrorOccuredAction(errorMessage: errorMessage)
        self.actionDispatcher.dispatch(action: action)
      }
  }

  func readRideOptionsFromDataStore() -> Promise<[RideOption]> {
    return rideOptionDataStore.read()
  }

  func loadFromRemoteIfNecessary(basedOnStoredRideOptions storedRideOptions: [RideOption])
    -> Promise<[RideOption]> {
      if storedRideOptions.isEmpty {
        return getRideOptionsFromRemoteAPI()
          .then(execute: updateDataStore(with:))
      } else {
        return Promise(value: storedRideOptions)
      }
  }

  func updateState(withRideOptions rideOptions: [RideOption]) {
    let action = RideOptionsLoadedAction(rideOptionsById: rideOptions.asDictionary(),
                                         rideOptions: rideOptions)
    actionDispatcher.dispatch(action: action)
  }

  func getRideOptionsFromRemoteAPI() -> Promise<[RideOption]> {
    return newRideRemoteAPI.getRideOptions(pickupLocation: pickupLocation)
  }

  func updateDataStore(with rideOptions: [RideOption]) -> Promise<[RideOption]> {
    return rideOptionDataStore.update(rideOptions: rideOptions)
  }

}
