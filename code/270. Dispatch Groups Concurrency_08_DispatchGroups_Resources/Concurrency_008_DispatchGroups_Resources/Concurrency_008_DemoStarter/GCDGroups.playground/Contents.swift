import UIKit
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: # GCD Groups
//: It's often useful to get notifications when a set of tasks has been completed—and that's precisely what GCD groups are for

let workerQueue = dispatch_queue_create("com.raywenderlich.worker", DISPATCH_QUEUE_CONCURRENT)

let numberArray = [(0,1), (2,3), (4,5), (6,7), (8,9)]

//: ## Creating a group



//: ## Dispatching to a group
//: Very much like traditional `dispatch_async()`




//: ## Notification of group completion
//: Will be called only when everything in that dispatch group is completed




//: ## Waiting for a group to complete
//: __DANGER__ This is synchronous and can block
//: This is a synchronous call on the current queue, so will block it. You cannot have anything in the group that wants to use the current queue otherwise you'll block.




//: ## Wrapping an existing Async API
//: All well and good for new APIs, but there are lots of async APIs that don't have group parameters. What can you do with them?
print("\n=== Wrapping an existing Async API ===\n")

let wrappedGroup = dispatch_group_create()

//: Wrap the original function


for pair in numberArray {
  // TODO: use the new function here to calculate the sums of the array

}

// TODO: Notify of completion

