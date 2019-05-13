import Compressor
import UIKit
//: # Dependencies
//: You've now created operations for loading a file over a network, and decompressing a file into an image. These should work together - with the decompression happening only when the file has loaded. That's precisely what dependencies offer within `NSOperation`

//: Input and output variables
let compressedFilePaths = ["01", "02", "03", "04", "05"].map {
  NSBundle.mainBundle().URLForResource("sample_\($0)_small", withExtension: "compressed")
}
var decompressedImages = [UIImage]()


//: `ImageDecompressionOperation` is familiar
class ImageDecompressionOperation: NSOperation {
  var inputData: NSData?
  var outputImage: UIImage?
  
  override func main() {
    // TODO: Find out whether a dependency has input data if we don't
    guard let inputData = inputData else { return }
    
    if let decompressedData = Compressor.decompressData(inputData) {
      outputImage = UIImage(data: decompressedData)
    }
  }
}

//: `DataLoadOperation` is also familiar
class DataLoadOperation: ConcurrentOperation {
  private let url: NSURL
  var loadedData: NSData?
  
  init(url: NSURL) {
    self.url = url
    super.init()
  }
  
  override func main() {
    NetworkSimulator.asyncLoadDataAtURL(url) {
      data in
      self.loadedData = data
      self.state = .Finished
    }
  }
}

//: Dependency data transfer
// TODO: Transfer data between dependent operations


//: Showing off with custom operators
// TODO create custom dependency operator


//: Create the queue with the default constructor
let queue = NSOperationQueue()
let appendQueue = NSOperationQueue()
appendQueue.maxConcurrentOperationCount = 1

//: Create operations for each of the compresed files, and set up dependencies
for compressedFile in compressedFilePaths {
  guard let inputURL = compressedFile else { continue }
  
  let loadingOperation = DataLoadOperation(url: inputURL)
  
  let decompressionOp = ImageDecompressionOperation()
  decompressionOp.completionBlock = {
    guard let output = decompressionOp.outputImage else { return }
    appendQueue.addOperationWithBlock {
      decompressedImages.append(output)
    }
  }
  
  // TODO: Link and enqueue these operations
}

//: Need to wait for the queue to finish before checking the results
queue.waitUntilAllOperationsAreFinished()

//: Inspect the decompressed images
decompressedImages


