/*
* Copyright (c) 2015 Razeware LLC
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

class TiltShiftImageProvider {
  
  let tiltShiftImage: TiltShiftImage
  
  init(tiltShiftImage: TiltShiftImage) {
    self.tiltShiftImage = tiltShiftImage
  }
  
  var image: UIImage? {
    let url = NSBundle.mainBundle().URLForResource(tiltShiftImage.imageName, withExtension: "compressed")!
    
    guard let rawData = NetworkSimulator.syncLoadDataAtURL(url),
      let decompressedData = Compressor.decompressData(rawData),
      let inputImage = UIImage(data: decompressedData) else { return .None }
    
    let mask = topAndBottomGradient(inputImage.size)
    return inputImage.applyBlurWithRadius(5, maskImage: mask)
  }
  
}

extension TiltShiftImageProvider: Hashable {
  var hashValue: Int {
    return (tiltShiftImage.title + tiltShiftImage.imageName).hashValue
  }
}

func ==(lhs: TiltShiftImageProvider, rhs: TiltShiftImageProvider) -> Bool {
  return lhs.tiltShiftImage == rhs.tiltShiftImage
}

