import Foundation
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # Tilt-Shift
//: In the demo you discovered how you can use a concurrent queue to run similar independent tasks. And in the previous challenge, you created an asynchronous version of the `tiltShift` function, which was just a wrapper around the `async` dispatch of `tiltShift`:
func asyncTiltShift(_ inputImage: UIImage?, runQueue: DispatchQueue, completionQueue: DispatchQueue,
                    completion: @escaping (UIImage?) -> ()) {
  runQueue.async {
    let outputImage = tiltShift(image: inputImage)
    completion(outputImage)
  }
}
//: In this challenge, use `asyncTiltShift` in a loop, with a suitable completion handler, to transform an array of images.
//:
//: The array of images:
let imageNames = ["dark_road_small", "train_day", "train_dusk", "train_night"]
let images = imageNames.flatMap { UIImage(named: "\($0).jpg") }
images

// An array to store the transformed images
var tiltShiftedImages = [UIImage]()

// The concurrent queue to run the tasks on:
let workerQueue = DispatchQueue(label: "com.raywenderlich.worker", attributes: .concurrent)

duration {
  for image in images {
    // TODO: Call asyncTiltShift to transform each image, and store the output in tiltShiftedImages
    // Note: Playgrounds use the default global queue instead of the main queue.
    
  
  }
}

// Wait for work to finish, then view the transformed images:
sleep(5)
tiltShiftedImages

PlaygroundPage.current.finishExecution()