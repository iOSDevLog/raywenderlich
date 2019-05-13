import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

//: # OperationQueue
//: `OperationQueue` is responsible for scheduling and running a set of operations, somewhere in the background.
//: ## Creating a queue
//: Creating a queue is simple, using the default initializer; you can also set the maximum number of queued operations that can execute at the same time:
// DONE: Create printerQueue
let printerQueue = OperationQueue()
// DONE later: Set maximum to 2
printerQueue.maxConcurrentOperationCount = 2
//: ## Adding `Operations` to Queues
/*: `Operation`s can be added to queues directly as closures
 - important:
 Adding operations to a queue is really "cheap"; although the operations can start executing as soon as they arrive on the queue, adding them is completely asynchronous.
 \
 You can see that here, with the result of the `duration` function:
 */
// DONE: Add 5 operations to printerQueue
duration {
//  printerQueue.addOperation { print("Hello"); sleep(3) }
//  printerQueue.addOperation { print("my"); sleep(3) }
//  printerQueue.addOperation { print("name"); sleep(3) }
//  printerQueue.addOperation { print("is"); sleep(3) }
//  printerQueue.addOperation { print("Audrey"); sleep(3) }
}

// DONE: Measure duration of all operations
duration {
  printerQueue.waitUntilAllOperationsAreFinished()
}
//: ## Filtering an Array of Images
//: Now for a more real-world example.
let images = ["city", "dark_road", "train_day", "train_dusk", "train_night"].map { UIImage(named: "\($0).jpg") }
var filteredImages = [UIImage]()
//: Create the queue with the default initializer:
// DONE: Create filterQueue
let filterQueue = OperationQueue()
//: Create a serial queue to handle additions to the array:
// DONE: Create serial appendQueue
let appendQueue = OperationQueue()
appendQueue.maxConcurrentOperationCount = 1
//: Create a filter operation for each of the images, adding a `completionBlock`:
for image in images {
  // DONE: as above
  let filterOp = TiltShiftOperation()
  filterOp.inputImage = image
  filterOp.completionBlock = {
    guard let output = filterOp.outputImage else { return }
    appendQueue.addOperation {
      filteredImages.append(output)
    }
  }
  filterQueue.addOperation(filterOp)
}
//: Need to wait for the queue to finish before checking the results
// DONE: wait
filterQueue.waitUntilAllOperationsAreFinished()
//: Inspect the filtered images
filteredImages

PlaygroundPage.current.finishExecution()
