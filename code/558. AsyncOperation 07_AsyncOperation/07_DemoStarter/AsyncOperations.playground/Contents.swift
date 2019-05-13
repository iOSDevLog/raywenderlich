import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: ## AsyncOperation: Wrapping Asynchronous Functions in Operation
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
  // TODO: State enum
  
  
  // TODO: keyPath property
  
  
  // TODO: state property
  
}
/*:
 Each of the state properties inherited from `Operation` are then overridden to defer to the new `state` property.
 
 The `asynchronous` property must be set to `true` to tell the system that you'll be managing the state manually.
 
 You also override `start()` and `cancel()` to wire in the new `state` property.
*/
extension AsyncOperation {
  // TODO: Operation Overrides
  
}
/*:
 Wrapping an asynchronous function then becomes as simple as overriding the `main()` function, remembering to set the `state` parameter on completion:
 */
class SumOperation: AsyncOperation {
  // TODO: Properties, init, main
  
}
//: Use this `OperationQueue` and array of number pairs:
let additionQueue = OperationQueue()
let input = [(1,5), (5,8), (6,1), (3,9), (6,12), (1,0)]
for (lhs, rhs) in input {
  // TODO: Create SumOperation object
  
  
  // TODO: Add SumOperation to additionQueue
  
}

sleep(5)
PlaygroundPage.current.finishExecution()
