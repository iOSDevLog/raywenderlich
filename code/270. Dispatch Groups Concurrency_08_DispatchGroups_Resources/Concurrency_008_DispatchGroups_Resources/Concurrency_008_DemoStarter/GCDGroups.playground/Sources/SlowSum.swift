import Foundation

public func slowSum(input: (Int, Int)) -> Int {
  sleep(1)
  return input.0 + input.1
}

private let workerQueue = dispatch_queue_create("com.raywenderlich.slowsum", DISPATCH_QUEUE_CONCURRENT)

public func asyncSum(input: (Int, Int), completionQueue: dispatch_queue_t, completion:(Int) -> ()) {
  dispatch_async(workerQueue) {
    let result = slowSum(input)
    dispatch_async(completionQueue) {
      completion(result)
    }
  }
}
