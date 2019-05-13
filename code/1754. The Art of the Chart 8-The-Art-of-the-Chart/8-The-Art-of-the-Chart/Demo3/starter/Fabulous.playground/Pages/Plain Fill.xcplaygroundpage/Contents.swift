import UIKit
import PlaygroundSupport
/*:
 ## Adding fills
 
 In this page you will add a fill underneath your line graph.
 
 This code creates a chart and data similar to the way you've done it in previous demos
 */
let points = randomPoints(100)
let path = CGMutablePath()
path.addLines(between: points)
let maxY = path.boundingBox.maxY
let chart = ChartView(maxX: 100, maxY: maxY)
PlaygroundPage.current.liveView = chart
var scale = chart.scaleTransform
//: **Start your demo coding here!**



let layer = chart.createShapeLayer(strokeColor: .red)
layer.path = path.copy(using: &scale)



























