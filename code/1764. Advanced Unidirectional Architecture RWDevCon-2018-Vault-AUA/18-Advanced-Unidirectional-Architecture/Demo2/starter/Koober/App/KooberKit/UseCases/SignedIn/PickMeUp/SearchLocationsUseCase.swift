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

public class SearchLocationsUseCase: CancelableUseCase {
  let query: String
  let pickupLocation: Location
  let actionDispatcher: ActionDispatcher
  let remoteAPI: NewRideRemoteAPI
  var cancelled = false


  init(query: String,
       pickupLocation: Location,
       actionDispatcher: ActionDispatcher,
       remoteAPI: NewRideRemoteAPI) {
    self.query = query
    self.pickupLocation = pickupLocation
    self.actionDispatcher = actionDispatcher
    self.remoteAPI = remoteAPI
  }

  public func start() {
    assert(Thread.isMainThread)
    guard !cancelled else {
      return
    }
    remoteAPI.getLocationSearchResults(query: query, pickupLocation: pickupLocation)
      .then { results -> Void in
        guard self.cancelled == false else {
          return
        }
        let action = ReceivedSearchResultsAction(results: results)
        self.actionDispatcher.dispatch(action: action)
      }
      .catch { error in
        let errorMessage = ErrorMessage(title: "Error Searching",
                                        message: "Could not run location search.\nPlease try again.")
        let action = SignedInErrorOccuredAction(errorMessage: errorMessage)
        self.actionDispatcher.dispatch(action: action)
      }
  }

  public func cancel() {
    assert(Thread.isMainThread)
    cancelled = true
  }
}
