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

func pickMeUpReducer(action: KooberAction, state: PickMeUpState) -> PickMeUpState {
  var state = state

  state.pickMeUpStep =
    pickMeUpStepReducer(action: action, state: state.pickMeUpStep)
  state.rideOptionPickerState =
    rideOptionPickerStateReducer(action: action, state: state.rideOptionPickerState)
  state.shouldDisplayWhereTo =
    shouldDisplayWhereToReducer(action: action, state: state.shouldDisplayWhereTo)
  state.mapState =
    mapStateReducer(action: action, state: state.mapState)

  return state
}

func mapStateReducer(action: KooberAction, state: PickMeUpMapState) -> PickMeUpMapState {
  var mapState = state

  switch action {
  case let action as SelectDropoffLocationAction:
    mapState.dropoffLocation = action.dropoffLocation
  case _ as SelectedRideOptionAction:
    break
  default:
    break
  }

  return mapState
}

func shouldDisplayWhereToReducer(action: KooberAction, state: Bool?) -> Bool {
  var shouldDisplay = state ?? false

  switch action {
  case _ as SelectDropoffLocationAction:
    shouldDisplay = false
  default:
    break
  }

  return shouldDisplay
}

func pickMeUpStepReducer(action: KooberAction, state: PickMeUpStep) -> PickMeUpStep {
  var step = state

  switch action {

  case _ as GoToDropoffLocationPickerAction:
    guard case .initial(let initialState) = step else {
      break
    }
    let selectDropoffLocationState = SelectDropoffLocationState(pickupLocation: initialState.pickupLocation)
    step = .selectDropoffLocation(state: selectDropoffLocationState)

  case _ as CancelDropoffSelectionAction:
    guard case .selectDropoffLocation(let selectDropoffLocationState) = step else {
      break
    }
    step = .initial(state: PickMeUpInitialState(pickupLocation: selectDropoffLocationState.pickupLocation))

  case let action as ReceivedSearchResultsAction:
    guard case .selectDropoffLocation(var selectDropoffLocationState) = step else {
      break
    }
    selectDropoffLocationState.dropoffLocationPickerState.searchResults = action.results
    step = .selectDropoffLocation(state: selectDropoffLocationState)

  case let action as SelectDropoffLocationAction:
    guard case .selectDropoffLocation(let selectDropoffLocationState) = step else {
      break
    }
    let waypoints = NewRideWaypoints(pickupLocation: selectDropoffLocationState.pickupLocation,
                                     dropoffLocation: action.dropoffLocation)
    let selectRideOptionState = SelectRideOptionState(newRideWaypoints: waypoints)
    step = .selectRideOption(state: selectRideOptionState)

  case let action as SelectedRideOptionAction:
    guard case .selectRideOption(let selectRideOptionState) = step else {
      break
    }
    let newRideRequest = NewRideRequest(waypoints: selectRideOptionState.newRideWaypoints,
                                        rideOptionID: action.rideOptionID)
    let confirmRequestState = ConfirmRequestState(newRideRequest: newRideRequest)
    step = .confirmRequest(state: confirmRequestState)

  case _ as ConfirmRideRequestAction:
    guard case .confirmRequest(let confirmRequestState) = step else {
      break
    }
    let requestConfirmedState = RequestConfirmedState(newRideRequest: confirmRequestState.newRideRequest)
    step = .requestConfirmed(state: requestConfirmedState)

  case _ as RideRequestAcceptedAction:
    step = .requestAccepted
  default:
    break
  }

  return step
}

func rideOptionPickerStateReducer(action: KooberAction, state: RideOptionPickerState) -> RideOptionPickerState {
  var state = state

  switch action {
  case let action as RideOptionsLoadedAction:
    let rideOptions = RideOptionPickerRideOptions(rideOptions: action.rideOptions)
    state.loadState = .loaded(state: rideOptions)
  default:
    switch state.loadState {
    case .loaded(let originalRideOptions):
      let rideOptions = rideOptionsLoadedReducer(action: action, state: originalRideOptions)
      state.loadState = .loaded(state: rideOptions)
    case .notLoaded:
      break
    }
  }

  return state
}

func rideOptionsLoadedReducer(action: KooberAction, state: RideOptionPickerRideOptions) -> RideOptionPickerRideOptions {
  var rideOptions = state

  switch action {
  case let action as SelectedRideOptionAction:
    rideOptions.selectedRideOptionID = action.rideOptionID
  default:
    break
  }

  return rideOptions
}
