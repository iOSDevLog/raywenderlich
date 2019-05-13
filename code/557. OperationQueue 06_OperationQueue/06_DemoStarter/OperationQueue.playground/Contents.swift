import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

//: # OperationQueue
//: `OperationQueue` is responsible for scheduling and running a set of operations, somewhere in the background.
//: ## Creating a queue
//: Creating a queue is simple, using the default initializer; you can also set the maximum number of queued operations that can execute at the same time:
// TODO: Create printerQueue

// TODO later: Set maximum to 2
//: ## Adding `Operations` to Queues
/*: `Operation`s can be added to queues directly as closures
 - important:
 Adding operations to a queue is really "cheap"; although the operations can start executing as soon as they arrive on the queue, adding them is completely asynchronous.
 \
 You can see that here, with the result of the `duration` function:
 */
// TODO: Add 5 operations to printerQueue



// TODO: Measure duration of all operations
//: ## Filtering an Array of Images
//: Now for a more real-world example.
let images = ["city", "dark_road", "train_day", "train_dusk", "train_night"].map { UIImage(named: "\($0).jpg") }
var filteredImages = [UIImage]()

//: Create the queue with the default initializer:
// TODO: Create filterQueue

//: Create a serial queue to handle additions to the array:
// TODO: Create serial appendQueue

//: Create a filter operation for each of the images, adding a `completionBlock`:
for image in images {
  // TODO: as above
  
  
}

//: Need to wait for the queue to finish before checking the results
// TODO: wait

//: Inspect the filtered images
filteredImages

PlaygroundPage.current.finishExecution()
