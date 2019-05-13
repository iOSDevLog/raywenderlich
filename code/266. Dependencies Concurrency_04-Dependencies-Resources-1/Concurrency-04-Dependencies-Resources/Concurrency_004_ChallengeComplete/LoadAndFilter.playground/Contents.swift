import Compressor
import UIKit
//: # Compressor Operation
//: Continuing from the challenge in the previous video, your challenge for this video is to use an `NSOperationQueue` to decompress a collection of compressed images.

//: Input and output variables
let compressedFilePaths = ["01", "02", "03", "04", "05"].map {
  NSBundle.mainBundle().URLForResource("sample_\($0)_small", withExtension: "compressed")
}
var filteredImages = [UIImage]()


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

//: `TiltShiftOperation` is another familiar operation
class TiltShiftOperation : NSOperation {
  var inputImage: UIImage?
  var outputImage: UIImage?
  
  override func main() {
    if let imageProvider = dependencies
      .filter({ $0 is ImageFilterDataProvider })
      .first as? ImageFilterDataProvider
      where inputImage == .None {
        inputImage = imageProvider.image
    }
    
    guard let inputImage = inputImage else { return }
    let mask = topAndBottomGradient(inputImage.size)
    outputImage = inputImage.applyBlurWithRadius(4, maskImage: mask)
  }
}


//: Image filter input data transfer
protocol ImageFilterDataProvider {
  var image: UIImage? { get }
}

extension ImageDecompressionOperation: ImageFilterDataProvider {
  var image: UIImage? { return outputImage }
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

//: Create a filter operations for each of the iamges, adding a completionBlock
for compressedFile in compressedFilePaths {
  guard let inputURL = compressedFile else { continue }
  
  let loadingOperation = DataLoadOperation(url: inputURL)
  let decompressionOp = ImageDecompressionOperation()
  let filterOperation = TiltShiftOperation()
  filterOperation.completionBlock = {
    guard let output = filterOperation.outputImage else { return }
    appendQueue.addOperationWithBlock {
      filteredImages.append(output)
    }
  }
  
  loadingOperation |> decompressionOp |> filterOperation
  
  queue.addOperations([loadingOperation, decompressionOp, filterOperation], waitUntilFinished: false)
}

//: Need to wait for the queue to finish before checking the results
queue.waitUntilAllOperationsAreFinished()

//: Inspect the filtered images
filteredImages


