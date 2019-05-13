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

class ViewController: UIViewController {
  
  @IBOutlet weak var imageView0: UIImageView!
  @IBOutlet weak var imageView1: UIImageView!
  @IBOutlet weak var imageView2: UIImageView!
  
  let compressedFilePaths = ["01", "02", "03"].map {
    Bundle.main.path(forResource: "sample_\($0)_small", ofType: "compressed")
  }
  
  var operations = [ImageDecompressor]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // DONE: Use the ImageDecompressor Operation subclass in an OperationQueue
    // to decompress the files whose paths are in compressedFilePaths.
    
    for compressedFile in compressedFilePaths {
      // DONE: create an ImageDecompressor operation and add it to the operations array
      let decompressionOp = ImageDecompressor()
      decompressionOp.inputPath = compressedFile
      operations += [decompressionOp]
    }
    
    // DONE: Create an OperationQueue and use its addOperations method.
    // Wrap these statements in a global async so you can set waitUntilFinished to true.
    // Dispatch back to the main queue to set the imageViews' images.
    DispatchQueue.global().async {
      let decompressionQ = OperationQueue()
      decompressionQ.addOperations(self.operations, waitUntilFinished: true)
      
      DispatchQueue.main.async {
        self.imageView0.image = self.operations[0].outputImage
        self.imageView1.image = self.operations[1].outputImage
        self.imageView2.image = self.operations[2].outputImage
      }
    }
  }
  
}

