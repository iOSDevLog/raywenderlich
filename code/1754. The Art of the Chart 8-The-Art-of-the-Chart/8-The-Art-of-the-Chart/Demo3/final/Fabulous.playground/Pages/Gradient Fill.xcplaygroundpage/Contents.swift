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
    let fill = chart.createShapeLayer(fillColor: .black)
    fill.path = fillPath.copy(using: &scale)

    let gradient = CAGradientLayer()
    gradient.frame = fill.frame
    let rainbow: [CGColor] = (0...10).map {
        UIColor(hue: CGFloat($0) / 10,
                saturation: 1,
                brightness: 1,
                alpha: 0.5).cgColor
    }
    gradient.colors = rainbow
    chart.plotArea.layer.addSublayer(gradient)
    fill.removeFromSuperlayer()
    gradient.mask = fill
    let group = CAAnimationGroup()
    group.duration = 1
    group.repeatCount = .greatestFiniteMagnitude
    group.autoreverses = true
    
    let startPoint = CABasicAnimation(keyPath: "startPoint")
    startPoint.fromValue = NSValue(cgPoint: CGPoint(x: 0, y: 0))
    startPoint.toValue = NSValue(cgPoint: CGPoint(x: 1, y: 0))
    
    let endPoint = CABasicAnimation(keyPath: "endPoint")
    endPoint.fromValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
    endPoint.toValue = NSValue(cgPoint: CGPoint(x: 0, y: 1))
    group.animations = [startPoint, endPoint]
    
    gradient.add(group, forKey: nil)
}

let layer = chart.createShapeLayer(strokeColor: .red)
layer.path = path.copy(using: &scale)




























