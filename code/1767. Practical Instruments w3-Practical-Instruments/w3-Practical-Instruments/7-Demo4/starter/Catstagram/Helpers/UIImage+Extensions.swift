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

import UIKit

extension UIImage {
  static let simpleImageCache = NSCache<NSURL, UIImage>()
  
  // Add JPEG drawing here
  class func decodedImage(_ image: UIImage) -> UIImage? {
    guard let newImage = image.cgImage else { return nil }
    if let cachedImage = UIImage.globalCache.object(forKey: image) as? UIImage {
      return cachedImage
    }

    let colorspace = CGColorSpaceCreateDeviceRGB()
    let context = CGContext(data: nil,
                            width: newImage.width,
                            height: newImage.height,
                            bitsPerComponent: 8,
                            bytesPerRow: newImage.width * 4,
                            space: colorspace,
                            bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
    
    context?.draw(newImage, in: CGRect(x: 0, y: 0, width: newImage.width, height: newImage.height))
    let drawnImage = context?.makeImage()
    
    if let drawnImage = drawnImage {
      let decodedImage = UIImage(cgImage: drawnImage)
      UIImage.globalCache.setObject(decodedImage, forKey: image)
      return decodedImage
    }
    
    return nil
  }

  
  // Add circular image method here
  
  
  class func downloadImage(with url: URL?, completion: @escaping ((_ image: UIImage) -> Void)) {
    guard let url = url else { return }
    
    if let image = simpleImageCache.object(forKey: url as NSURL) {
      if Thread.isMainThread {
        completion(image)
      } else {
        DispatchQueue.main.async {
          completion(image)
        }
      }
    } else {
      let session = URLSession(configuration: .ephemeral)
      
      let task = session.dataTask(with: url, completionHandler: { (data, urlResponse, error) in
        if let data = data, let image = UIImage(data: data) {
          simpleImageCache.setObject(image, forKey: url as NSURL)
          DispatchQueue.main.async {
            completion(image)
          }
        }
      })
      
      task.resume()
    }
  }
}

// Add global NSCache here

extension UIImage {
  // 1)
  struct StaticCacheWrapper {
    static var cache = NSCache<AnyObject, AnyObject>()
  }
  // 2)
  class var globalCache: NSCache<AnyObject, AnyObject> {
    get { return StaticCacheWrapper.cache }
    set { StaticCacheWrapper.cache = newValue }
  }
}

