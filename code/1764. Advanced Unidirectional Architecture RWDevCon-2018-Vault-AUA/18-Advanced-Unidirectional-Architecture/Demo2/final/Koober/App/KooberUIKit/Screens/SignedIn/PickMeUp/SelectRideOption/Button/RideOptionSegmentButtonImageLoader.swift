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
import PromiseKit

class RideOptionSegmentButtonImageLoader {
  let imageCache: ImageCache

  init(imageCache: ImageCache) {
    self.imageCache = imageCache
  }

  func loadImages(using segments: [RideOptionSegmentViewModel]) -> Promise<[RideOptionSegmentViewModel]> {
    let promises = segments.map { (segment) -> Promise<RideOptionSegmentViewModel> in
      guard case let .notLoaded(normalURL, selectedURL) = segment.images else {
        return Promise(value: segment)
      }
      return imageCache.getImagePair(at: normalURL, and: selectedURL).then { imagePair in
        var s = segment
        s.images = .loaded(normalURL: normalURL, normalImage: imagePair.image1,
                           selectedURL: selectedURL, selectedImage: imagePair.image2)
        return Promise(value: s)
      }
    }
    return when(fulfilled: promises)
  }
  
}
