import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # Async Operations
//: In the demo you created an abstract subclass of `Operation` to assist with wrapping asynchronous APIs. You should now use this to wrap the `simulateAsyncNetworkLoadImage` function (in Sources/NetworkSimulator.swift).
//:
//: Use this in an OperationQueue to "download" train_dusk.jpg

class ImageLoadOperation: AsyncOperation {
  var inputName: String?
  var outputImage: UIImage?
  
  override func main() {
    // TODO: implement this
    
    
    
  }
  
}
//: Create an OperationQueue
let queue = OperationQueue()
//: Create an ImageLoadOperation to load train_dusk.jpg
let imageLoad = ImageLoadOperation()
imageLoad.inputName = "train_dusk.jpg"

queue.addOperation(imageLoad)

duration {
  queue.waitUntilAllOperationsAreFinished()
}

imageLoad.outputImage

PlaygroundPage.current.finishExecution()
