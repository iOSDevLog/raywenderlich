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

import UIKit
import PromiseKit

public class InBundleImageCache: ImageCache {
  public init() {}

  public func getImage(at url: URL) -> Promise<UIImage> {
    let imageFilename = self.imageFilename(from: url)
    return Promise(value: UIImage(named: imageFilename,
                                  in: Bundle(for: InBundleImageCache.self),
                                  compatibleWith: nil)!)
  }

  public func getImagePair(at url1: URL, and url2: URL) -> Promise<(image1: UIImage, image2: UIImage)> {
    let imageFilename1 = imageFilename(from: url1)
    let imageFilename2 = imageFilename(from: url2)
    return Promise(value: (UIImage(named: imageFilename1)!, UIImage(named: imageFilename2)!) )
  }

  func imageFilename(from url: URL) -> String {
    var imageFilename = url.lastPathComponent
    imageFilename = imageFilename.replacingOccurrences(of: "@2x", with: "")
    imageFilename = imageFilename.replacingOccurrences(of: "@3x", with: "")
    return imageFilename
  }
}
