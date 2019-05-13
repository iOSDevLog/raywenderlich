import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # Operation
//: An `Operation` represents a 'unit of work', and can be constructed as a `BlockOperation` or as a custom subclass of `Operation`.
//: ## BlockOperation
//: Create a `BlockOperation` to add two numbers
var result: Int?
// DONE: Create and run summationOperation
let summationOperation = BlockOperation {
  result = 2 + 3
  sleep(3)
}
duration {
  summationOperation.start()
}
result
//: Create a `BlockOperation` with multiple blocks:
// DONE: Create and run multiPrinter
let multiPrinter = BlockOperation()
multiPrinter.completionBlock = {
  print("Finished multiPrinting!")
}

multiPrinter.addExecutionBlock {  print("Hello"); sleep(2) }
multiPrinter.addExecutionBlock {  print("my"); sleep(2) }
multiPrinter.addExecutionBlock {  print("name"); sleep(2) }
multiPrinter.addExecutionBlock {  print("is"); sleep(2) }
multiPrinter.addExecutionBlock {  print("Audrey"); sleep(2) }

duration {
  multiPrinter.start()
}
//: ## Subclassing `Operation`
//: Allows you more control over precisely what the `Operation` is doing
let inputImage = UIImage(named: "dark_road_small.jpg")
// DONE: Create and run TiltShiftOperation
class TiltShiftOperation: Operation {
  var inputImage: UIImage?
  var outputImage: UIImage?
  
  override func main() {
    outputImage = tiltShift(image: inputImage)
  }
}

let tsOp = TiltShiftOperation()
tsOp.inputImage = inputImage

duration {
  tsOp.start()
}
tsOp.outputImage


PlaygroundPage.current.finishExecution()