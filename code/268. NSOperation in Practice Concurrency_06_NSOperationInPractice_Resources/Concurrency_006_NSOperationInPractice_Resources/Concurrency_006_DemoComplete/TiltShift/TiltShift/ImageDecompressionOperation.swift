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

protocol ImageDecompressionOperationDataProvider {
  var compressedData: NSData? { get }
}

class ImageDecompressionOperation: NSOperation {
  
  private let inputData: NSData?
  private let completion: ((UIImage?) -> ())?
  private var outputImage: UIImage?
  
  init(data: NSData?, completion: ((UIImage?) -> ())? = nil) {
    inputData = data
    self.completion = completion
    super.init()
  }
  
  override func main() {
    let compressedData: NSData?
    if let inputData = inputData {
      compressedData = inputData
    } else {
      let dataProvider = dependencies
        .filter { $0 is ImageDecompressionOperationDataProvider }
        .first as? ImageDecompressionOperationDataProvider
      compressedData = dataProvider?.compressedData
    }
    
    guard let data = compressedData else { return }
    
    if let decompressedData = Compressor.decompressData(data) {
      outputImage = UIImage(data: decompressedData)
    }
    
    completion?(outputImage)
  }
}

extension ImageDecompressionOperation: ImageFilterDataProvider {
  var image: UIImage? { return outputImage }
}

