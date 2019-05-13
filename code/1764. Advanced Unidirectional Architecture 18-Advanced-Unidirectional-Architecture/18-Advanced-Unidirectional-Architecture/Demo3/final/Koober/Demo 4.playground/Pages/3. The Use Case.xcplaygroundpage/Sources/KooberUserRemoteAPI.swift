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

var remoteUserSession = UserProfile(name: "Johnny Fox Net",
                                    mobileNumber: "+1 (512) 874 9938",
                                    email: "johnny@aple.com",
                                    clawed: true)

class KooberUserRemoteAPI: UserRemoteAPI {
  func getUserProfile() -> Promise<UserProfile> {
    return Promise { fulfill, reject in
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
        fulfill(remoteUserSession)
      }
    }
  }

  func putUserProfile(clawed: Bool) -> Promise<UserProfile> { // New
    return Promise { fulfill, reject in
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
        remoteUserSession.clawed = clawed
        fulfill(remoteUserSession)
      }
    }
  }
}
