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

public struct RideOptionPickerState {
  public let pickupLocation: Location
  public internal(set) var loadState: LoadedState<RideOptionPickerRideOptions>

  public init(pickupLocation: Location, loadState: LoadedState<RideOptionPickerRideOptions> = .notLoaded) {
    self.pickupLocation = pickupLocation
    self.loadState = loadState
  }
}

extension RideOptionPickerState: Equatable {
  public static func ==(lhs: RideOptionPickerState, rhs: RideOptionPickerState) -> Bool {
    return lhs.pickupLocation == rhs.pickupLocation &&
           lhs.loadState == rhs.loadState
  }
}

public struct RideOptionPickerRideOptions: Equatable {
  public internal(set) var rideOptions: [RideOption]
  public internal(set) var selectedRideOptionID: RideOptionID

  public init(rideOptions: [RideOption], selectedRideOptionID: RideOptionID? = nil) {
    self.rideOptions = rideOptions
    if let selectedRideOptionID = selectedRideOptionID {
      self.selectedRideOptionID = selectedRideOptionID
    } else if let selectedRideOptionID = rideOptions.first?.id  {
      self.selectedRideOptionID = selectedRideOptionID
    } else {
      fatalError("Encountered empty array of ride options.")
    }
  }

  public static func ==(lhs: RideOptionPickerRideOptions, rhs: RideOptionPickerRideOptions) -> Bool {
    return lhs.selectedRideOptionID == rhs.selectedRideOptionID
      && lhs.rideOptions == rhs.rideOptions
  }
}
