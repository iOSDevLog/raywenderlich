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

import UIKit

class CopyStringActivity: UIActivity {

  let colorDocument: ColorDocument
  
  init(colorDocument: ColorDocument) {
    self.colorDocument = colorDocument
  }
  
  override class var activityCategory: UIActivityCategory {
    return .action
  }
  
  override var activityType: UIActivityType? {
    return UIActivityType(rawValue: "ColorBrowserCopy")
  }
  
  override var activityTitle: String? {
    return "Copy"
  }
  
  override var activityImage: UIImage? {
    return UIImage(named: "copy_activity_icon")
  }
  
  override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
    return true
  }
  
  override func perform() {
    colorDocument.open {
      success in
        if success {
          UIPasteboard.general.string = try! self.colorDocument.stringRepresentation()
          self.activityDidFinish(true)
        }
    }
  }
  
}















