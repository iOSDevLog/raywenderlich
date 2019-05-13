import Compressor
import UIKit
//: # Compressor Operation
//: You've decided that you want to use some funky new compression algorithm to store the images in your app. Unfortunately this compression algorithm isn't natively supported by `UIImage`, so you need to use your own custom Decompressor.
//:
//: Decompression is a fairly expensive process, so you'd like to be able to wrap it in an `NSOperation` and eventually have the images decompressing in the background.
//:
//: The `Compressor` struct accessible within this playground has a decompression function on it that will take a path to a file and return the decompressed `NSData`
//: 
//: > __Challenge:__ Your challenge is to create an `NSOperation` subclass that decompresses a file. Use __dark\_road\_small.compressed__ as a test file.

let compressedFilePath = NSBundle.mainBundle().pathForResource("dark_road_small", ofType: "compressed")!

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

let decompOp = ImageDecompressor()
decompOp.inputPath = compressedFilePath

if(decompOp.ready) {
  decompOp.start()
}

decompOp.outputImage


