import Foundation
//: # Operation Cancellation
//: It's important to make sure that individual operations respect the `cancelled` property, and therefore can be cancelled.
//:
//: However, in addition to cancelling a single operation you can cancel all the operations on a queue. This is especially helpful when you have a collection of operations all working towards a single goal - either splitting up an operation to run in parallel or a dependency graph of operations acting as a pipeline.
//:
//: In this challenge you will achieve the same as in the demo, but by using lots of the following single-shot `SumOperation`s:
class SumOperation: NSOperation {
  let inputPair: (Int, Int)
  var output: Int?
  
  init(input: (Int, Int)) {
    inputPair = input
    super.init()
  }
  
  override func main() {
    if cancelled { return }
    output = slowAdd(inputPair)
  }
}

//: `GroupAdd` is a vanilla class that manages an operation queue and multiple `SumOperation`s to calculate the sum of all the pairs in the input array.
//: > __TODO__: There are 3 places in this class that you need to add implementation
class GroupAdd {
  let queue = NSOperationQueue()
  var outputArray = [(Int, Int, Int)]()
  let appendQueue = NSOperationQueue()
  
  init(input: [(Int, Int)]) {
    queue.suspended = true
    queue.maxConcurrentOperationCount = 2
    appendQueue.maxConcurrentOperationCount = 1
    generateOperations(input)
  }
  
  func generateOperations(numberArray: [(Int, Int)]) {
    for pair in numberArray {
      let operation = SumOperation(input: pair)
      operation.completionBlock = {
        // TODO: Implement this
        // UPDATE: Ensure you append to the array on the appendQueue. This is different
        //         to the video.
      }
      queue.addOperation(operation)
    }
  }
  
  func start() {
    // TODO: implement this
  }
  
  func cancel() {
    // TODO: implement this
  }
  
  func wait() {
    queue.waitUntilAllOperationsAreFinished()
  }
}

//: Input array
let numberArray = [(1,2), (3,4), (5,6), (7,8), (9,10)]


//: Create the group add
let groupAdd = GroupAdd(input: numberArray)

//: Start the operation and
startClock()
groupAdd.start()


//: __TODO:__ Try uncommenting this call to `cancel()` to check that you've implemented it correctly. You should see the `stopClock()` result reduce, as should the length of the output.
//groupAdd.cancel()

groupAdd.wait()
stopClock()

//: Inspect the results
groupAdd.outputArray

