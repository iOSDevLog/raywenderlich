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

func rootScreenReducer(action: KooberAction, state: RootScreen?) -> RootScreen {
  var rootScreen = state ?? .launching

  switch action {
  case let action as LoadedUserSessionAction:
    // Entry Point
    if let session = action.session {
      rootScreen = .signedIn(state: SignedInState(userSession: session))
    } else {
      rootScreen = .onboarding(state:OnboardingState(screen: .welcome))
    }
  case _ as SignOutAction:
    rootScreen = .onboarding(state: OnboardingState(screen: .welcome))
  default:
    // Down the graph
    switch rootScreen {
    case .launching:
      break
    case .onboarding(let state):
      let onboardingState = onboardingReducer(action: action, state: state)
      rootScreen = .onboarding(state: onboardingState)
    case .signedIn(let state):
      let signedInState = signedInReducer(action: action, state: state)
      rootScreen = .signedIn(state: signedInState)
    }
  }

  return rootScreen
}
