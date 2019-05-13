import UIKit
import PlaygroundSupport
/*:
 ## Animating Lines

 In this page you will animate the drawing of your chart line.

 This code creates a chart and data similar to the way you've done it in previous demos
*/
let points = randomPoints(100)
let path = CGMutablePath()
path.addLines(between: points)
let maxY = path.boundingBox.maxY
let chart = ChartView(maxX: 100, maxY: maxY)
PlaygroundPage.current.liveView = chart
let layer = chart.createShapeLayer(strokeColor: .red)
var scale = chart.scaleTransform
//: **Add an extra path here!**



layer.path = path.copy(using: &scale)
//: **Start your demo coding here!**





























