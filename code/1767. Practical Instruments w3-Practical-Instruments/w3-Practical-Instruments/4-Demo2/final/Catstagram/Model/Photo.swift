/// Copyright (c) 2017 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation

class Photo : Decodable {
  enum CodingKeys : String, CodingKey {
    case urls = "image_url"
    case uploadDateString = "created_at"
    case descriptionText = "name"
    case commentsCount = "comments_count"
    case likesCount = "positive_votes_count"
    case user
  }
  
  let urls: [URL]
  let uploadDateString: Date
  let descriptionText: String
  let commentsCount: UInt
  let likesCount: UInt

  let user: User
  
  func descriptionAttributedString(withFontSize size: CGFloat) -> NSAttributedString {
    return NSAttributedString(string: "\(user.username) \(descriptionText)", fontSize: CGFloat(size), color: UIColor.darkGray, firstWordColor: UIColor.darkBlue())
  }

  func uploadDateAttributedString(withFontSize size: Float) -> NSAttributedString {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    
    let string = formatter.string(from: uploadDateString)
    return NSAttributedString(string: string, fontSize: CGFloat(size), color: UIColor.lightGray, firstWordColor: nil)
  }

  func likesAttributedString(withFontSize size: Float) -> NSAttributedString {
    return NSAttributedString(string: "\(likesCount) likes", fontSize: CGFloat(size), color: UIColor.darkBlue(), firstWordColor: nil)
  }

  static func ==(lhs: Photo, rhs: Photo) -> Bool {
    return lhs.urls == rhs.urls &&
    lhs.uploadDateString == rhs.uploadDateString &&
    lhs.descriptionText == rhs.descriptionText &&
    lhs.commentsCount == rhs.commentsCount &&
    lhs.likesCount == rhs.likesCount
  }
}
