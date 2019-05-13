import UIKit
//: # NSOperation
//: NSOperation represents a 'unit of work' and can be constructed in a few ways.
//: ## NSBlockOperation
//: NSBlockOperation allows you to create an NSOperation from one or more closures.

var result: Int?

//: Creating an NSBlockOperation to add two numbers
let summationOperation = NSBlockOperation(block: {
  result = 2 + 3
  sleep(5)
})

startClock()
summationOperation.start()
stopClock()

result

//: NSBlockOperations can have multiple blocks, that run concurrently

let multiPrinter = NSBlockOperation()

multiPrinter.addExecutionBlock({ print("Hello"); sleep(5) })
multiPrinter.addExecutionBlock({ print("my"); sleep(5) })
multiPrinter.addExecutionBlock({ print("name"); sleep(5) })
multiPrinter.addExecutionBlock({ print("is"); sleep(5) })
multiPrinter.addExecutionBlock({ print("Sam"); sleep(5) })

startClock()
multiPrinter.start()
stopClock()


//: ## Subclassing NSOperation
//: Allows you more control over precisely what the operation is doing
let inputImage = UIImage(named: "dark_road_small.jpg")

//: Creating an operation to add tilt-shift blur to an image

class TiltShiftOperation : NSOperation {
  var inputImage: UIImage?
  var outputImage: UIImage?
  
  override func main() {
    guard let inputImage = inputImage else { return }
    let mask = topAndBottomGradient(inputImage.size)
    outputImage = inputImage.applyBlurWithRadius(4, maskImage: mask)
  }
}

let tsOp = TiltShiftOperation()
tsOp.inputImage = inputImage

startClock()
tsOp.start()
stopClock()

tsOp.outputImage




