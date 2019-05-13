import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: ## AsyncOperation: Wrap Asynchronous Function in Operation
/*:
 For synchronous tasks, you can create an `Operation` subclass by overriding the `main()` method.
 
 `AsyncOperation` is a custom subclass of `Operation` that handles state changes automatically. Then, to wrap an asynchronous function, you:
 
 1. Subclass `AsyncOperation`.
 2. Override `main()` and call your async function.
 3. Change the `state` property of the `AsyncOperation` subclass to `.Finished` in the async callback.
 
 - important:
 Step 3 of these instructions is *extremely* important - it's how the operation queue responsible for running the operation can tell that it has completed. Otherwise it'll sit uncompleted for eternity.
 */
class AsyncOperation: Operation {
  // DONE: State enum with keyPath property
  enum State: String {
    case Ready, Executing, Finished
    
    fileprivate var keyPath: String {
      return "is" + rawValue
    }
  }
  
  // DONE: state property
  var state = State.Ready {
    willSet {
      willChangeValue(forKey: newValue.keyPath)
      willChangeValue(forKey: state.keyPath)
    }
    didSet {
      didChangeValue(forKey: oldValue.keyPath)
      didChangeValue(forKey: state.keyPath)
    }
  }
}
/*:
 Each of the state properties inherited from `Operation` are then overridden to defer to the new `state` property.
 
 The `asynchronous` property must be set to `true` to tell the system that you'll be managing the state manually.
 
 You also override `start()` and `cancel()` to wire in the new `state` property.
*/
extension AsyncOperation {
  // DONE: Operation Overrides
  override var isReady: Bool {
    return super.isReady && state == .Ready
  }
  
  override var isExecuting: Bool {
    return state == .Executing
  }
  
  override var isFinished: Bool {
    return state == .Finished
  }
  
  override var isAsynchronous: Bool {
    return true
  }
  
  override func start() {
    if isCancelled {
      state = .Finished
      return
    }
    main()
    state = .Executing
  }
  
  override func cancel() {
    state = .Finished
  }
  
}
/*:
 Wrapping an asynchronous function then becomes as simple as overriding the `main()` function, remembering to set the `state` parameter on completion:
 */
class SumOperation: AsyncOperation {
  // DONE: Properties, init, main
  let lhs: Int
  let rhs: Int
  var result: Int?
  
  init(lhs: Int, rhs: Int) {
    self.lhs = lhs
    self.rhs = rhs
    super.init()
  }
  
  override func main() {
    asyncAdd_OpQ(lhs: lhs, rhs: rhs) { result in
      self.result = result
      self.state = .Finished
    }
  }
}
//: Use this `OperationQueue` and array of number pairs:
let additionQueue = OperationQueue()
let input = [(1,5), (5,8), (6,1), (3,9), (6,12), (1,0)]
for (lhs, rhs) in input {
  // DONE: Create SumOperation object
  let operation = SumOperation(lhs: lhs, rhs: rhs)
  operation.completionBlock = {
    guard let result = operation.result else { return }
    print("\(lhs) + \(rhs) = \(result)")
  }
  
  // DONE: Add SumOperation to additionQueue
  additionQueue.addOperation(operation)
}

sleep(5)
PlaygroundPage.current.finishExecution()
