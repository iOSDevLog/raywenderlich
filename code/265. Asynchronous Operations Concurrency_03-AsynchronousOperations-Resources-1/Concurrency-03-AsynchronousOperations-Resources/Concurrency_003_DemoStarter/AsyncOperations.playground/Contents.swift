import UIKit
import XCPlayground

//: # Concurrent NSOperations
//: So far, you've discovered how to create an `NSOperation` subclass by overriding the `main()` method, but that will only work for synchronous tasks.
//: Need long running playground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: A abstract class for wrapping asynchronous functionality
class ConcurrentOperation: NSOperation {

}


extension ConcurrentOperation {
  //: NSOperation Overrides

}


//: Concrete subclass of `ConcurrentOperation` to load data from a URL.
//: This uses the async method on the network simulator to load it
class DataLoadOperation: ConcurrentOperation {
  
}

//: Create imageURL and queue
let imageURL = NSBundle.mainBundle().URLForResource("desert", withExtension: "jpg")!
let queue = NSOperationQueue()

//: Create the load operation and add it to the queue


//: Wait for the queue to complete
queue.waitUntilAllOperationsAreFinished()

//: Take a look at the resultant image
//if let readData = loadOperation.loadedData {
//  UIImage(data: readData)
//}



