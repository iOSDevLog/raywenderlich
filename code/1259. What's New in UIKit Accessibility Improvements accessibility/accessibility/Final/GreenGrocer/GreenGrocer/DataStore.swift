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

final class DataStore {
  private static let defaultPlistName = "GreenGrocer"
  private static let productsKey = "products"
  
  // MARK:- Storage
  var products: [Product] = []
  
  init(products: [Product]) {
    self.products = products
  }
}

// MARK:- Reading from disc
extension DataStore {
  convenience init(plistURL: URL) {
    guard let rawDict = DataStore.loadPlistFromURL(plistURL),
      let productArray = rawDict[DataStore.productsKey] as? [[String: AnyObject]],
      let products = Product.fromDictArray(productArray) else {
        self.init(products: [])
        return
    }
    
    let sortedProducts = products.sorted { $0.name < $1.name }
    self.init(products: sortedProducts)
  }
  
  convenience init(plistName: String) {
    let fileURL = URL.urlForFileInDocumentsDirectory(plistName, fileExtension: "plist")
    self.init(plistURL: fileURL)
  }
  
  convenience init() {
    self.init(plistName: DataStore.defaultPlistName)
  }
  
  fileprivate static func loadPlistFromURL(_ plistURL: URL) -> [String: AnyObject]? {
    let rawDict = NSDictionary(contentsOf: plistURL)
    return rawDict as? [String: AnyObject]
  }
  
  static var defaultDataStorePresentOnDisk: Bool {
    let storePath = URL.urlForFileInDocumentsDirectory(defaultPlistName, fileExtension: "plist").path
    return FileManager.default.fileExists(atPath: storePath)
  }
}

// MARK:- Persisting
extension DataStore {
  func save(plistName: String) {
    let serialisedData = [
      DataStore.productsKey: products.map { $0.dictRepresentation },
      ] as NSDictionary
    serialisedData.write(to: URL.urlForFileInDocumentsDirectory(plistName, fileExtension: "plist"), atomically: true)
  }
  
  func save() {
    save(plistName: DataStore.defaultPlistName)
  }
}

// MARK:- Accessors
extension DataStore {
  public func product(withId identifier: String) -> Product? {
    return products.filter { $0.id.uuidString == identifier }.first
  }
}

// MARK:- NSURL Util methods
extension URL {
  fileprivate static var documentsDirectory : URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  }
  
  fileprivate static func urlForFileInDocumentsDirectory(_ fileName: String, fileExtension: String) -> URL {
    return URL.documentsDirectory.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
  }
}
