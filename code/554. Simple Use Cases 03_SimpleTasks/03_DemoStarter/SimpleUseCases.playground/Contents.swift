import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # Simple Use Cases
//: ## Make Synchronous Asynchronous
let userQueue = DispatchQueue.global(qos: .userInitiated)
let defaultQueue = DispatchQueue.global()
//: A slow synchronous function:
func slowAdd(_ input: (Int, Int)) -> Int {
  sleep(1)
  return input.0 + input.1
}


// TODO: Dispatch slowAdd to userQueue



sleep(3)
//: ### 2. Reusable task
//: Wrap the `async` dispatch as an asynchronous function, with arguments for the input, queues and completion handler:
// TODO: Create asyncAdd function



//: Call `asyncAdd`:
// TODO: Call asyncAdd; use defaultQueue for completion


//: __Note:__ In an app, you would return to the main queue, but that doesn't work in playgrounds.
sleep(3)
//: ## Chain of Synchronous Tasks
//: A common use case is a chain of synchronous tasks. The output of each task is the input for the next task, for example, the TiltShift app downloads a compressed file, decompresses the file to extract an image, then transforms the image.
//:
//: Some simple tasks with output and input
func task0() -> String {
  return "One, "
}

func task1(inString: String) -> String {
  return inString + "Two, "
}

func task2(inString: String) -> String {
  return inString + "Three, "
}

print("=== Starting chain of tasks ===")
//: Dispatch the tasks asynchronously to userQueue, in the correct order:
// TODO




sleep(2)
//: __Note:__ In practice, the transfer of objects will be more complex than this, but you'll see in a future video that simple protocols can provide the glue.
//: ## Similar Independent Synchronous Tasks
//: For example, transforming an array of images: the tasks are similar, so would use the same qos level; but each task works on a different image, so the tasks are independent, in terms of their resource access needs, and can run concurrently.
//: Run tasks on the default dispatch queue:
// Allow for random sleep times
let sleepMax: UInt32 = 5
func randomTask(_ value: Int) {
  let sleepTime = arc4random_uniform(sleepMax)
  sleep(sleepTime)
  print(String(value) + " slept for " + String(sleepTime))
}

print("=== Starting concurrent queue of tasks ===")
let values = [Int](1...12)
// TODO: Loop over values to dispatch randomTasks on defaultQueue
for value in values {

  
}

sleep(5)
PlaygroundPage.current.finishExecution()