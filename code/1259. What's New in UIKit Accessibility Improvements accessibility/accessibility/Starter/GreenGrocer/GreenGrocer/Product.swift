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

typealias ProductID = UUID

final class Product: NSObject, NSCoding {
  static let productTypeId = "com.razeware.product"
  private struct PropertyKey {
    static let id = "id"
    static let name = "name"
    static let price = "price"
    static let details = "details"
    static let photoName = "photoName"
  }
  
  let id: ProductID
  let name: String
  let price: Int
  let details: String
  let photoName: String
  
  init(id: ProductID, name: String, price: Int, details: String, photoName: String) {
    self.id = id
    self.name = name
    self.price = price
    self.details = details
    self.photoName = photoName
  }
  
  public func encode(with aCoder: NSCoder) {
    aCoder.encode(id, forKey: PropertyKey.id)
    aCoder.encode(name, forKey: PropertyKey.name)
    aCoder.encode(price, forKey: PropertyKey.price)
    aCoder.encode(details, forKey: PropertyKey.details)
    aCoder.encode(photoName, forKey: PropertyKey.photoName)
  }
  
  public required convenience init?(coder aDecoder: NSCoder) {
    guard let id = aDecoder.decodeObject(forKey: PropertyKey.id) as? UUID,
      let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String,
      let details = aDecoder.decodeObject(forKey: PropertyKey.details) as? String,
      let photoName = aDecoder.decodeObject(forKey: PropertyKey.photoName) as? String
      else { return nil }
    
    let price = aDecoder.decodeInteger(forKey: PropertyKey.price)
    
    self.init(id: id, name: name, price: price, details: details, photoName: photoName)
  }
}

extension Product {
  convenience init(name: String, price: Int, details: String, photoName: String) {
    self.init(id: UUID(), name: name, price: price, details: details, photoName: photoName)
  }
}

extension Product: Serializable {
  convenience init?(dict: [String: AnyObject]) {
    guard let idString = dict[PropertyKey.id] as? String,
      let id = UUID(uuidString: idString),
      let name = dict[PropertyKey.name] as? String,
      let price = dict[PropertyKey.price] as? Int,
      let details = dict[PropertyKey.details] as? String,
      let photoName = dict[PropertyKey.photoName] as? String else {
        return nil
    }
    self.init(id: id, name: name, price: price, details: details, photoName: photoName)
  }
  
  var dictRepresentation: [String: AnyObject] {
    return [
      PropertyKey.id            : id.uuidString as AnyObject,
      PropertyKey.name          : name as AnyObject,
      PropertyKey.price         : price as AnyObject,
      PropertyKey.details       : details as AnyObject,
      PropertyKey.photoName     : photoName as AnyObject,
    ]
  }
}

func ==(lhs: Product, rhs: Product) -> Bool {
  return lhs.id == rhs.id
}

extension Product {
  override var hashValue: Int {
    return id.uuidString.hashValue
  }
}

// MARK: - NSItemProviderReading
extension Product: NSItemProviderReading {
  static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Self {
    switch typeIdentifier {
    case productTypeId:
      guard let item = NSKeyedUnarchiver
        .unarchiveObject(with: data) as? Product
        else { throw EncodingError.invalidData }
      return self.init(name: item.name, price: item.price, details: item.details, photoName: item.photoName)
    default:
      throw EncodingError.invalidData
    }
  }
  
  static var readableTypeIdentifiersForItemProvider: [String] {
    return [productTypeId]
  }  
}
