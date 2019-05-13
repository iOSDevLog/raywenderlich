import Foundation
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # Tilt-Shift
//: In the demo you discovered how you can use queues to dispatch work onto GCD queues asynchronously, and one of the top uses cases of this is to turn synchronous functions into asynchrnonous ones.
//:
//: In the first video, you saw the TiltShift starter app. Its painfully slow scrolling is partly because it calls the synchronous function `tiltShift(image:)` to filter the images. Your challenge is to use GCD to convert this into an asynchronous function.
// Demo of the sync function in Sources/TiltShift.swift
print("=== Starting Sync ===")
let image = UIImage(named: "dark_road_small.jpg")
duration {
  let result = tiltShift(image: image)
}
//: The async function should perform the task on `workerQueue`, which should be an argument.
let workerQueue = DispatchQueue(label: "com.raywenderlich.worker")
//: And return the result on `resultQueue`, which should also be an argument.
let resultQueue = DispatchQueue.global()
print("=== Starting Async ===")
//: __DONE__: Implement `asyncTiltShift` function here:
func asyncTiltShift(_ inputImage: UIImage?, runQueue: DispatchQueue, completionQueue: DispatchQueue, completion: @escaping (UIImage?) -> ()) {
  runQueue.async {
    let outputImage = tiltShift(image: inputImage)
    completionQueue.async {
      completion(outputImage)
    }
  }
}

//: __DONE__: Use `asyncTiltShift` to filter dark_road_small.jpg. Remember to call `PlaygroundPage.current.finishExecution()` in the completion handler.
asyncTiltShift(image, runQueue: workerQueue, completionQueue: resultQueue) { image in
  image
  PlaygroundPage.current.finishExecution()
}

print("=== End of File ===")
