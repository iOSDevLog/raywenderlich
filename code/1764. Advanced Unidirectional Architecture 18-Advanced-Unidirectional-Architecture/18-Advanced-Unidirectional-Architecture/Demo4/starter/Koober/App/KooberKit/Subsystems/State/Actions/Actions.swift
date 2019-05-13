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

public struct DeterminedUsersCurrentLocationAction: KooberAction {
  public let location: Location

  public init(location: Location) {
    self.location = location
  }
}

public struct ReceivedSearchResultsAction: KooberAction {
  public let results: [NamedLocation]

  public init(results: [NamedLocation]) {
    self.results = results
  }
}

public struct CancelDropoffSelectionAction: KooberAction {}

public struct LoadedUserSessionAction: KooberAction {
  public let session: UserSession?
}

public struct OnboardingErrorOccuredAction: KooberAction {
  let errorMessage: ErrorMessage
}

public struct GoToSignUpAction: KooberAction {}

public struct GoToSignInAction: KooberAction {}

public struct SignedInErrorOccuredAction: KooberAction {
  let errorMessage: ErrorMessage
}

public struct GoToDropoffLocationPickerAction: KooberAction {}

struct SelectDropoffLocationAction: KooberAction {
  let dropoffLocation: Location
}

struct SelectedRideOptionAction: KooberAction {
  let rideOptionID: RideOptionID
}

struct ConfirmRideRequestAction: KooberAction {}

struct RideRequestAcceptedAction: KooberAction {}

struct PickMeUpScreenFinished: KooberAction {}

struct StartNewRideRequestAction: KooberAction {}

struct GoToProfileAction: KooberAction {}

struct CloseProfileAction: KooberAction {}

struct SignOutAction: KooberAction {}
