import Compressor
import UIKit
//: # Compressor Operation
//: Continuing from the challenge in the previous video, your challenge for this video is to use an `NSOperationQueue` to decompress a collection of compressed images.

//: The `ImageDecompressor` class is as before
class ImageDecompressor: NSOperation {
  var inputPath: String?
  var outputImage: UIImage?
  
  override func main() {
    guard let inputPath = inputPath else { return }
    
    if let decompressedData = Compressor.loadCompressedFile(inputPath) {
      outputImage = UIImage(data: decompressedData)
    }
  }
}

//: The following two arrays represent the input and output collections:
let compressedFilePaths = ["01", "02", "03", "04", "05"].map {
  NSBundle.mainBundle().pathForResource("sample_\($0)_small", ofType: "compressed")
}
var decompressedImages = [UIImage]()

//: Create your implementation here:


//: Inspect the decompressed images
decompressedImages


