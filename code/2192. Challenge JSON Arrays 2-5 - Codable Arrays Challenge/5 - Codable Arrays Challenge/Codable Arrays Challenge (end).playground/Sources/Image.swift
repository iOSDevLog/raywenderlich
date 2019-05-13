/// Copyright (c) 2018 Razeware LLC
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

import UIKit

public struct Image: Decodable {
  public enum Kind: String, Decodable {
    case scene
    case sticker
  }
  
  enum DecodingError: Error {
    case missingFile
  }
  
  let name: String
  let kind: Kind
  let pngData: Data
}

//MARK: public
public extension Image {
  static func getPNGFromDocumentDirectory(kind: Kind, name: String) -> UIImage? {
    return UIImage(
      contentsOfFile:
        FileManager.documentDirectoryURL
        .appendingPathComponent(kind.rawValue)
        .appendingPathComponent(name)
        .appendingPathExtension("png")
        .path
    )    
  }
  
  func save(directory: FileManager.SearchPathDirectory) throws {
    let kindDirectoryURL = URL(
      fileURLWithPath: kind.rawValue,
      relativeTo: FileManager.default.urls(for: directory, in: .userDomainMask)[0]
    )
    
    try? FileManager.default.createDirectory(at: kindDirectoryURL, withIntermediateDirectories: true)
    
    try pngData.write(
      to: kindDirectoryURL.appendingPathComponent(name).appendingPathExtension("png"),
      options: .atomic
    )
  }
}

//MARK:-
public extension Array where Element == Image {
  init(fileName: String) throws {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
      throw Image.DecodingError.missingFile
    }
    
    let data = try Data(contentsOf: url)
    let decoder = JSONDecoder()
    self = try decoder.decode([Image].self, from: data)
  }
}
