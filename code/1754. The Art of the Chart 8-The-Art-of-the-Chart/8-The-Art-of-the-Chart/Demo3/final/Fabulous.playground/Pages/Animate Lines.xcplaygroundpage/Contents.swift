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
let midY = path.boundingBox.midY
let midPoints = points.map { CGPoint(x: $0.x, y: midY) }
let midPath = CGMutablePath()
midPath.addLines(between: midPoints)


layer.path = midPath.copy(using: &scale)
//: **Start your demo coding here!**
let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
strokeEnd.fromValue = 0
strokeEnd.toValue = 1
strokeEnd.duration = 1

CATransaction.begin()
CATransaction.setCompletionBlock {
    print("Finished!")
    let newPath = CABasicAnimation(keyPath: "path")
    let scaledPath = path.copy(using: &scale)
    newPath.fromValue = layer.path
    newPath.duration = 1
    layer.add(newPath, forKey: nil)
    layer.path = scaledPath
}
layer.add(strokeEnd, forKey: nil)
CATransaction.commit()



























