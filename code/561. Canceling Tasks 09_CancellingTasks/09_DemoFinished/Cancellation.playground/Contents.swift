import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: ## Operation Cancellation
//: `ArraySumOperation` takes an array of `(Int, Int)` tuples, and uses the `slowAdd()` function provided in __Sources__ to generate an array of the sums.
class ArraySumOperation: Operation {
  let inputArray: [(Int, Int)]
  var outputArray = [Int]()
  
  init(input: [(Int, Int)]) {
    inputArray = input
    super.init()
  }
  
  override func main() {
    // DONE: Fill this in
    for pair in inputArray {
      if isCancelled { return }
      outputArray.append(slowAdd(pair))
    }
  }
}
//: `AnotherArraySumOperation` uses the `slowAddArray` function to add
class AnotherArraySumOperation: Operation {
  let inputArray: [(Int, Int)]
  var outputArray: [Int]?
  
  init(input: [(Int, Int)]) {
    inputArray = input
    super.init()
  }
  
  override func main() {
    // DONE: Fill this in
    outputArray = slowAddArray(inputArray) {
      progress in
      print("\(progress*100)% of the array processed")
      return !self.isCancelled
    }
  }
}
//: Input array
let numberArray = [(1,2), (3,4), (5,6), (7,8), (9,10)]
//: Operation and queue
let sumOperation = AnotherArraySumOperation(input: numberArray)
let queue = OperationQueue()
//: Start the operation, sleep a while, then cancel the operation
startClock()
queue.addOperation(sumOperation)

sleep(4)
sumOperation.cancel()

sumOperation.completionBlock = {
  
  stopClock()
  sumOperation.outputArray
  PlaygroundPage.current.finishExecution()
}
