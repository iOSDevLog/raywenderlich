import UIKit
import XCPlayground

//: # NSOperationQueue
//: NSOperationQueue is responsible for scheduling and running a set of operations, somewhere in the background. 

//: To prevent the playground from killing background tasks when the main thread has completed, need to specify indefinite execution



//: ## Creating a queue
//: Operations can be added to queues directly as closures







//: ## Adding NSOperations to queues
let images = ["city", "dark_road", "train_day", "train_dusk", "train_night"].map { UIImage(named: "\($0).jpg") }
var filteredImages = [UIImage]()

//: Create the queue with the default constructor


//: Create a filter operations for each of the iamges, adding a completionBlock
for image in images {

}

//: Need to wait for the queue to finish before checking the results


//: Inspect the filtered images
filteredImages









