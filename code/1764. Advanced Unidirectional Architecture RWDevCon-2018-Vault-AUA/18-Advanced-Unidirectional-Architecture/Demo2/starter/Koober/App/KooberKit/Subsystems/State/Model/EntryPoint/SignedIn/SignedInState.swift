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

public struct SignedInState {
  public let userSession: UserSession
  public internal(set) var screen: SignedInScreen
  public internal(set) var showingProfileScreen: Bool
  public internal(set) var errorMessage: ErrorMessage?

  public init(userSession: UserSession,
              screen: SignedInScreen = SignedInScreen.gettingUsersLocation,
              showingProfileScreen: Bool = false) {
    self.userSession = userSession
    self.screen = screen
    self.showingProfileScreen = showingProfileScreen
  }
}

extension SignedInState: Equatable {
  public static func ==(lhs: SignedInState, rhs: SignedInState) -> Bool {
    return lhs.userSession == rhs.userSession &&
           lhs.screen == rhs.screen &&
           lhs.showingProfileScreen == rhs.showingProfileScreen &&
           lhs.errorMessage == rhs.errorMessage
  }
}
