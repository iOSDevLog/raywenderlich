import Foundation
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: # Async Operations
//: In the demo you created an abstract subclass of `NSOperation` to assist with wrapping asynchronous APIs. You should now use this to wrap the extremely powerful `asyncAdd` function.
//:
//: Use this to find the pairwise sum of the following array of tuples:

let input = [(1,5), (5,8), (6,1), (3,9), (6,12), (1,0)]

//: Print the results to the debug log (e.g. `1 + 5 = 6`)
//: > __Note:__ Use an operation queue and an operation for each element of the arrays. The results are likely to be returned out of order. That's fine!

class SumOperation: ConcurrentOperation {
  
  let lhs: Int
  let rhs: Int
  var result: Int?
  
  init(lhs: Int, rhs: Int) {
    self.lhs = lhs
    self.rhs = rhs
    super.init()
  }
  
  override func main() {
    asyncAdd(lhs, rhs: rhs) {
      result in
      self.result = result
      self.state = .Finished
    }
  }
}

//: Create the queue
let queue = NSOperationQueue()

//: Add all the summation operations
for (lhs, rhs) in input {
  let operation = SumOperation(lhs: lhs, rhs: rhs)
  operation.completionBlock = {
    guard let result = operation.result else { return }
    print("\(lhs) + \(rhs) = \(result)")
  }
  queue.addOperation(operation)
}


queue.waitUntilAllOperationsAreFinished()



