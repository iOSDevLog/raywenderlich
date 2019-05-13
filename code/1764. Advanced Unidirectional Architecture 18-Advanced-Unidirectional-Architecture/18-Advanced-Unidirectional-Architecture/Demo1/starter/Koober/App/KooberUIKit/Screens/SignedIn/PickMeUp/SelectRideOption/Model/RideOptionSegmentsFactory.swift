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
import KooberKit

class RideOptionSegmentsFactory {
  let rideOptions: [RideOption]
  let selectedRideOptionID: RideOptionID

  init(state: RideOptionPickerRideOptions) {
    self.rideOptions = state.rideOptions
    self.selectedRideOptionID = state.selectedRideOptionID
  }

  func makeSegments() -> [RideOptionSegmentViewModel] {
    return rideOptions.map(makeSegment(fromRideOption:))
  }

  private func makeSegment(fromRideOption rideOption: RideOption) -> RideOptionSegmentViewModel {
    return RideOptionSegmentViewModel(id: rideOption.id,
                                      title: rideOption.name,
                                      isSelected: rideOption.id == selectedRideOptionID,
                                      images: .notLoaded(normal: rideOption.buttonRemoteImages.unselected.urlForScreenScale,
                                                         selected: rideOption.buttonRemoteImages.selected.urlForScreenScale))
  }

}
