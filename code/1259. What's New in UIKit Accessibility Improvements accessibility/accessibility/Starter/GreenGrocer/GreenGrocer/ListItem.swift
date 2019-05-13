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

enum EncodingError: Error {
  case invalidData
}

final class ListItem: NSObject {
  static let listItemTypeId = "com.razeware.listItem"
  
  public enum Key {
    public static let name = "name"
    public static let checked = "checked"
  }

  var name: String
  var checked: Bool
  
  init(name: String, checked: Bool = false) {
    self.name = name
    self.checked = checked
  }
  
  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: Key.name)
    aCoder.encode(checked, forKey: Key.checked)
  }
  
  public required convenience init?(coder aDecoder: NSCoder) {
    guard let name = aDecoder.decodeObject(forKey: Key.name) as? String
      else { return nil }
    let checked = aDecoder.decodeBool(forKey: Key.checked)
    
    self.init(name: name, checked: checked)
  }
  
  override var hash: Int {
    return name.hashValue
  }
  
  override func isEqual(_ object: Any?) -> Bool {
    guard let object = object as? ListItem
      else { return false }
    
    return self.name == object.name
  }
}

// MARK: - NSItemProviderWriting
extension ListItem: NSItemProviderWriting {
  static var writableTypeIdentifiersForItemProvider: [String] {
    return [listItemTypeId]
  }
  
  func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
    if typeIdentifier == ListItem.listItemTypeId {
      let data = NSKeyedArchiver.archivedData(withRootObject: self)
      completionHandler(data, nil)
    }
    return nil
  }
}

// MARK: - NSItemProviderReading
extension ListItem: NSItemProviderReading {
  static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Self {
    switch typeIdentifier {
    case listItemTypeId:
      guard let item = NSKeyedUnarchiver
        .unarchiveObject(with: data) as? ListItem
        else { throw EncodingError.invalidData }
      return self.init(name: item.name, checked: item.checked)
    default:
      throw EncodingError.invalidData
    }
  }
  
  public static var readableTypeIdentifiersForItemProvider: [String] {
    return [listItemTypeId]
  }
}

