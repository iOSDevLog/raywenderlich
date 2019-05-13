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

public class GetUsersCurrentLocationUseCase: UseCase {
  let actionDispatcher: ActionDispatcher
  let locator: Locator

  init(actionDispatcher: ActionDispatcher,
       locator: Locator) {
    self.actionDispatcher = actionDispatcher
    self.locator = locator
  }

  public func start() {
    locator.getUsersCurrentLocation()
      .then { location -> Void in
        let action = DeterminedUsersCurrentLocationAction(location: location)
        self.actionDispatcher.dispatch(action: action)
      }
      .catch { error in
        let errorMessage = ErrorMessage(title: "Error Getting Location",
                                        message: "Could not get your location. Please check location settings and try again.")
        let action = SignedInErrorOccuredAction(errorMessage: errorMessage)
        self.actionDispatcher.dispatch(action: action)
      }
  }
}
