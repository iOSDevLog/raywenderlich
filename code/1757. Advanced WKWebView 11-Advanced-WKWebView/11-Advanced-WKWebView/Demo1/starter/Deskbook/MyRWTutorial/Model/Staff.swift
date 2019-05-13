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
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
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

/**
 Defines our main struct to represent a Staff Member.
 */
struct Staff: Codable {
  let id: Int
  let name: String
  let mobile: String
  let email: String
  let image: String
  let department: String
  let title: String
  let bio: String
  let twitter: String
}

extension Staff: CustomStringConvertible {
  var description: String {
    return "name: \(name)" +
      " email: \(email)"
  }
}

extension Staff {
  /**
   A convenience method to extract the mobile phone's digits only
   */
  func mobileDigits() -> String {
    return mobile.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
  }
}

//typealias StaffData = (title: String, value: Any)
//
//extension Staff {
//  var tableRepresentation: [StaffData] {
//    return [
//      ("Id", id),
//      ("Name", name),
//      ("Email", email),
//      ("Department", department),
//      ("Title", title),
//      ("Bio", bio),
//      ("Twitter", twitter)
//    ]
//  }
//}

