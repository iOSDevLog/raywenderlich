import Foundation
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: # Slow Maths
//: In the demo you discovered how you can use queues to dispatch work onto GCD queues asynchronously, and one of the top uses cases of this is to turn synchronous functions into asynchrnonous ones.
//:
//: You've seen `slowSum(_:, _:)` in a previous video. It's a synchronous function that takes a long time to add two integers. Your challenge is to use GCD to convert this into an asynchronous function.

// Demo of the sync function
print("=== Starting Sync ===")
let result = slowSum((1, 2))
print("SYNC Result = \(result)")

//: The async function should use `workerQueue` to perform the work
let workerQueue = dispatch_queue_create("com.raywenderlich.worker", DISPATCH_QUEUE_SERIAL)
//: And return the result on `resultQueue`, which should be an argument
let resultQueue = dispatch_get_main_queue()

print("=== Starting Async ===")

//: __TODO__: Implement `asyncSum` function here:







//: __TODO__: Use `asyncSum` to calculate sum of two values. Remember to call `XCPlaygroundPlage.currentPage.finisheExecution()` in the completion handler.






print("=== End of File ===")
