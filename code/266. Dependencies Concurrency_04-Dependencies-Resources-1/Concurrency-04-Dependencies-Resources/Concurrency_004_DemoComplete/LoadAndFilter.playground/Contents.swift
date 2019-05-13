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
    if let dependencyData = dependencies
      .filter({ $0 is ImageDecompressionOperationDataProvider })
      .first as? ImageDecompressionOperationDataProvider
      where inputData == .None {
      inputData = dependencyData.compressedData
    }
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
protocol ImageDecompressionOperationDataProvider {
  var compressedData: NSData? { get }
}

extension DataLoadOperation: ImageDecompressionOperationDataProvider {
  var compressedData: NSData? { return loadedData }
}


//: Showing off with custom operators
infix operator |> { associativity left precedence 160 }
func |>(lhs: NSOperation, rhs: NSOperation) -> NSOperation {
  rhs.addDependency(lhs)
  return rhs
}


//: Create the queue with the default constructor
let queue = NSOperationQueue()
let appendQueue = NSOperationQueue()
appendQueue.maxConcurrentOperationCount = 1

//: Create operations for each of the compressed files and set up dependencies
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
  
  loadingOperation |> decompressionOp
  
  queue.addOperations([loadingOperation, decompressionOp], waitUntilFinished: false)
}

//: Need to wait for the queue to finish before checking the results
queue.waitUntilAllOperationsAreFinished()

//: Inspect the decompressed images
decompressedImages


