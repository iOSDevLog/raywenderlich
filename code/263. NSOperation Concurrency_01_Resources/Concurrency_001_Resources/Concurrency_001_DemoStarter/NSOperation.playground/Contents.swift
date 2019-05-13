import UIKit
//: # NSOperation
//: NSOperation represents a 'unit of work' and can be constructed in a few ways.
//: ## NSBlockOperation
//: NSBlockOperation allows you to create an NSOperation from one or more closures.

var result: Int?

//: Creating an NSBlockOperation to add two numbers






//: NSBlockOperations can have multiple blocks, that run concurrently

let multiPrinter = NSBlockOperation()




//: ## Subclassing NSOperation
//: Allows you more control over precisely what the operation is doing
let inputImage = UIImage(named: "dark_road_small.jpg")

//: Creating an operation to add tilt-shift blur to an image





