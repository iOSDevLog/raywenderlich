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

enum DocumentError : Error {
  case runtimeError(String)
  case missingColor
}

struct RGBColor {
  let R: Int
  let G: Int
  let B: Int
  
  func lighterColor(by toAdd: Int) -> RGBColor {
    return RGBColor(R: lighter(component: R, by: toAdd), G: lighter(component: G, by: toAdd), B: lighter(component: B, by: toAdd))
  }
  
  func lighter(component: Int, by toAdd: Int) -> Int {
    return min(component + toAdd, 255)
  }
}

class ColorDocument: UIDocument {
  
  var color: RGBColor?
  
  override func load(fromContents contents: Any, ofType typeName: String?) throws {
    guard let data = contents as? Data, data.count > 0 else { return }
    
    let colorText = String(data: data, encoding: .utf8)
    
    guard let colorValues = colorText?.components(separatedBy: ","),
      let rValue = Int(colorValues[0]),
      let gValue = Int(colorValues[1]),
      let bValue = Int(colorValues[2])
      else {
        throw DocumentError.runtimeError("Wrong file format")
    }
    
    color = RGBColor(R: rValue, G: gValue, B: bValue)
  }
  
  override func contents(forType typeName: String) throws -> Any {
    guard let color = color else {
      throw DocumentError.missingColor
    }
    
    return "\(color.R),\(color.G),\(color.B)".data(using: .utf8) as Any
  }
  
  func stringRepresentation() throws -> String {
    guard let color = color else {
      throw DocumentError.missingColor
    }
    
    return "R: \(color.R), G:\(color.G), B:\(color.B)"
  }
  
  override func fileAttributesToWrite(to url: URL, for saveOperation: UIDocumentSaveOperation) throws -> [AnyHashable : Any] {
    guard let color = color else {
      throw DocumentError.missingColor
    }
    let uicolor = UIColor(red: CGFloat(color.R)/255, green: CGFloat(color.G)/255, blue: CGFloat(color.B)/255, alpha: 1)
    return [ URLResourceKey.hasHiddenExtensionKey: true,
             URLResourceKey.thumbnailDictionaryKey: [URLThumbnailDictionaryItem.NSThumbnail1024x1024SizeKey: generateThumbnail(forColor: uicolor) ]
    ]
  }
}
