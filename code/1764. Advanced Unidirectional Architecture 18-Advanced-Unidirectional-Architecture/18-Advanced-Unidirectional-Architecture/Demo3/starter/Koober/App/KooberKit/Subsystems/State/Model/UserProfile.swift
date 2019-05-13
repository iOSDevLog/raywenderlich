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

public struct UserProfile: Codable {
  public let name: String
  public let email: String
  public let mobileNumber: String
  public let avatar: URL

  public init(name: String, email: String, mobileNumber: String, avatar: URL) {
    self.name = name
    self.email = email
    self.mobileNumber = mobileNumber
    self.avatar = avatar
  }
}

extension UserProfile: Equatable {
  public static func ==(lhs: UserProfile, rhs: UserProfile) -> Bool {
    return lhs.name == rhs.name &&
           lhs.email == rhs.email &&
           lhs.mobileNumber == rhs.mobileNumber &&
           lhs.avatar == rhs.avatar
  }
}
