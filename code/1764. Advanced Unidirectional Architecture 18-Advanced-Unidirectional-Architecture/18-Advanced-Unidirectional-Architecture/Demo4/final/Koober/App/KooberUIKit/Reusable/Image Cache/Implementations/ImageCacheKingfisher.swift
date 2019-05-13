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
import Kingfisher

class ImageCacheKingfisher: ImageCache {
  let manager = KingfisherManager.shared

  func getImagePair(at url1: URL, and url2: URL) -> Promise<(image1: UIImage, image2: UIImage)> {
    let promises = [getImage(at: url1), getImage(at: url2)]
    return when(fulfilled: promises).then { images in
      return Promise(value: (image1: images[0], image2: images[1]))
    }
  }

  func getImage(at url: URL) -> Promise<UIImage> {
    return Promise { fulfill, reject in
      let resource = ImageResource(downloadURL: url)

      manager.retrieveImage(
        with: resource,
        options: [KingfisherOptionsInfoItem.scaleFactor(UIScreen.main.scale)],
        progressBlock: nil) { image, error, cacheType, imageURL in
          if let error = error {
            reject(error)
            return
          }
          guard let image = image else {
            reject(ImageCacheError.any)
            return
          }
          fulfill(image)
      }
    }
  }
  
}
