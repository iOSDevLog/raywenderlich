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

func signedInReducer(action: KooberAction, state: SignedInState) -> SignedInState {
  var state = state

  switch action {
  case _ as GoToProfileAction:
    state.showingProfileScreen = true
  case _ as CloseProfileAction:
    state.showingProfileScreen = false
  case let action as DeterminedUsersCurrentLocationAction:
    let initialStep: PickMeUpStep = .initial(state: PickMeUpInitialState(pickupLocation: action.location))
    let mapState = PickMeUpMapState(usersCurrentLocation: action.location)
    let rideOptionPickerState = RideOptionPickerState(pickupLocation: action.location)
    state.screen = .pickMeUp(PickMeUpState(pickupLocation: action.location,
                                           pickMeUpStep: initialStep,
                                           rideOptionPickerState: rideOptionPickerState,
                                           mapState: mapState))
  case _ as PickMeUpScreenFinished:
    state.screen = .waitingForPickup
  case _ as StartNewRideRequestAction:
    state.screen = .gettingUsersLocation
  case let action as SignedInErrorOccuredAction:
    state.errorMessage = action.errorMessage
  default:
    // Down the graph
    switch state.screen {
    case .gettingUsersLocation:
      break
    case .pickMeUp(let currentState):
      let pickMeUpState = pickMeUpReducer(action: action, state: currentState)
      state.screen = .pickMeUp(pickMeUpState)
    case .waitingForPickup:
      break
    }
  }

  return state
}
