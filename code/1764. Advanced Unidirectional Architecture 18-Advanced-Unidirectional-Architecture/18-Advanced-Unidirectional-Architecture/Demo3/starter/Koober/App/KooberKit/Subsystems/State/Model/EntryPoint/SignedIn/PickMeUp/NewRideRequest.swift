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

public struct NewRideWaypoints: Codable {
  let pickupLocation: Location
  let dropoffLocation: Location

  public init(pickupLocation: Location, dropoffLocation: Location) {
    self.pickupLocation = pickupLocation
    self.dropoffLocation = dropoffLocation
  }
}

extension NewRideWaypoints: Equatable {
  public static func ==(lhs: NewRideWaypoints, rhs: NewRideWaypoints) -> Bool {
    return lhs.pickupLocation == rhs.pickupLocation &&
           lhs.dropoffLocation == rhs.dropoffLocation
  }
}

public struct NewRideRequest: Codable {
  let waypoints: NewRideWaypoints
  let rideOptionID: RideOptionID

  public init(waypoints: NewRideWaypoints, rideOptionID: RideOptionID) {
    self.waypoints = waypoints
    self.rideOptionID = rideOptionID
  }
}

extension NewRideRequest: Equatable {
  public static func ==(lhs: NewRideRequest, rhs: NewRideRequest) -> Bool {
    return lhs.waypoints == rhs.waypoints &&
           lhs.rideOptionID == rhs.rideOptionID
  }
}
