import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # Operation
//: An `Operation` represents a 'unit of work', and can be constructed as a `BlockOperation` or as a custom subclass of `Operation`.
//: ## BlockOperation
//: Create a `BlockOperation` to add two numbers
var result: Int?
// TODO: Create and run summationOperation




//: Create a `BlockOperation` with multiple blocks:
// TODO: Create and run multiPrinter


//: ## Subclassing `Operation`
//: Allows you more control over precisely what the `Operation` is doing
let inputImage = UIImage(named: "dark_road_small.jpg")
// TODO: Create and run TiltShiftOperation




PlaygroundPage.current.finishExecution()