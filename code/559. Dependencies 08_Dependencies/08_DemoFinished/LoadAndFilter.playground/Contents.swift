import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: ## Dependencies
//: `ImageLoadOperation` is familiar:
class ImageLoadOperation: AsyncOperation {
  var inputName: String?
  var outputImage: UIImage?
  
  override func main() {
    duration {
      simulateAsyncNetworkLoadImage(named: self.inputName) {
        [unowned self] (image) in
        self.outputImage = image
        self.state = .Finished
      }
    }
  }
}
//: And `TiltShiftOperation`:
// DONE: Transfer data to dependent operation
protocol FilterDataProvider {
  var image: UIImage? { get }
}

extension ImageLoadOperation: FilterDataProvider {
  var image: UIImage? { return outputImage }
}

class TiltShiftOperation: Operation {
  var inputImage: UIImage?
  var outputImage: UIImage?
  
  override func main() {
    // DONE: Find out whether a dependency has inputImage if we don't
    if let dependencyImageProvider = dependencies
      .filter({ $0 is FilterDataProvider})
      .first as? FilterDataProvider,
      inputImage == .none {
      inputImage = dependencyImageProvider.image
    }
    outputImage = tiltShift(image: inputImage)
  }
}
//: Operations:
let imageLoad = ImageLoadOperation()
let filter = TiltShiftOperation()
//: Set imageLoad's input parameter:
imageLoad.inputName = "train_day.jpg"
//let dataTransferOp = BlockOperation {
//  filter.inputImage = imageLoad.outputImage
//}
//: Dependency data transfer
// DONE: Set up dependency between imageLoad and filter
filter.addDependency(imageLoad)
//dataTransferOp.addDependency(imageLoad)
//: Add both operations to the operation queue
let queue = OperationQueue()
duration {
  queue.addOperations([imageLoad, filter], waitUntilFinished: true)
}
//: And see what comes out:
imageLoad.outputImage
filter.outputImage

sleep(3)
PlaygroundPage.current.finishExecution()