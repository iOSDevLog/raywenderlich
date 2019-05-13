import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

//: # Dependencies
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
class TiltShiftOperation: Operation {
  var inputImage: UIImage?
  var outputImage: UIImage?
  
  override func main() {
    // TODO: Find out whether a dependency has inputImage if we don't
    guard let inputImage = inputImage else { return }
    outputImage = tiltShift(image: inputImage)
  }
}
//: Operations:
let imageLoad = ImageLoadOperation()
let filter = TiltShiftOperation()
//: Set imageLoad's input parameter:
imageLoad.inputName = "train_day.jpg"
//: Dependency data transfer
// TODO: Transfer data to dependent operation



// TODO: Set up dependency between imageLoad and filter



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

