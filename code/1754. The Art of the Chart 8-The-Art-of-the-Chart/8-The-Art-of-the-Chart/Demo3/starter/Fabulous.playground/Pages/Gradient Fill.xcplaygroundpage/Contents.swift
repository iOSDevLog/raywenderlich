import UIKit
import PlaygroundSupport
/*:
 ## Gradient Fills
 
 In this page you will add a gradient fill underneath your line chart.
 
 This code creates a chart, data and fill path similar to the way you've done it in previous demos
 */
let points = randomPoints(100)
let path = CGMutablePath()
path.addLines(between: points)

let maxY = path.boundingBox.maxY

let chart = ChartView(maxX: 100, maxY: maxY)
PlaygroundPage.current.liveView = chart
var scale = chart.scaleTransform

if let fillPath = path.mutableCopy() {
    let current = fillPath.currentPoint
    fillPath.addLine(to: CGPoint(x: current.x, y: 0))
    fillPath.addLine(to: .zero)
    fillPath.closeSubpath()
//: **Start your demo coding here!**
    
    
}

let layer = chart.createShapeLayer(strokeColor: .red)
layer.path = path.copy(using: &scale)




























