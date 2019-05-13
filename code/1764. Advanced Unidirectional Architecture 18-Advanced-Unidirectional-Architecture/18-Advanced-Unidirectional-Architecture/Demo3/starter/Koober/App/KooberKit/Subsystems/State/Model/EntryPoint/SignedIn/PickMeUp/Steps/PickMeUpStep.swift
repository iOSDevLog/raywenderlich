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

public enum PickMeUpStep {
  case initial(state: PickMeUpInitialState)
  case selectDropoffLocation(state: SelectDropoffLocationState)
  case selectRideOption(state: SelectRideOptionState)
  case confirmRequest(state: ConfirmRequestState)
  case requestConfirmed(state: RequestConfirmedState)
  case requestAccepted
}

extension PickMeUpStep: Equatable {
  public static func ==(lhs: PickMeUpStep, rhs: PickMeUpStep) -> Bool {
    switch (lhs, rhs) {
    case let (.initial(l), .initial(r)):
      return l == r
    case let (.selectDropoffLocation(l), .selectDropoffLocation(r)):
      return l == r
    case let (.selectRideOption(l), .selectRideOption(r)):
      return l == r
    case let (.confirmRequest(l), .confirmRequest(r)):
      return l == r
    case let (.requestConfirmed(l), .requestConfirmed(r)):
      return l == r
    case (.requestAccepted, .requestAccepted):
      return true
    case (.initial, _),
         (.selectDropoffLocation, _),
         (.selectRideOption, _),
         (.confirmRequest, _),
         (.requestConfirmed, _),
         (.requestAccepted, _):
      return false
    }
  }
}
