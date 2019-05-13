/*
* Copyright (c) 2016 Razeware LLC
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

protocol ImageDecompressionOperationDataProvider {
  var compressedData: Data? { get }
}

class ImageDecompressionOperation: Operation {
  
  fileprivate let inputData: Data?
  fileprivate let completion: ((UIImage?) -> ())?
  fileprivate var outputImage: UIImage?
  
  init(data: Data?, completion: ((UIImage?) -> ())? = nil) {
    inputData = data
    self.completion = completion
    super.init()
  }
  
  override func main() {    
    let compressedData: Data?
    if self.isCancelled { return }
    if let inputData = inputData {
      compressedData = inputData
    } else {
      let dataProvider = dependencies
        .filter { $0 is ImageDecompressionOperationDataProvider }
        .first as? ImageDecompressionOperationDataProvider
      compressedData = dataProvider?.compressedData
    }
    
    guard let data = compressedData else { return }
    
    if self.isCancelled { return }
    if let decompressedData = Compressor.decompressData(data) {
      outputImage = UIImage(data: decompressedData)
    }
    
    if self.isCancelled { return }
    completion?(outputImage)
  }
}

extension ImageDecompressionOperation: ImageFilterDataProvider {
  var image: UIImage? { return outputImage }
}

