import UIKit
import PlaygroundSupport
//: ## Line Charts
//: In this page you will use the Axis and Tick models you learned about to draw a line chart! A lot of the code is implemented in the Sources folder of the playground. 
let points = randomPoints(100)

let path = CGMutablePath()
path.addLines(between: points)

let boringPoints = uniformPoints(100)
let boringPath = CGMutablePath()
boringPath.addLines(between: boringPoints)

let maxY = max(path.boundingBox.maxY, boringPath.boundingBox.maxY)

let xAxis = Axis(valueRange: 0...100, maximumTickCount: 11)!
let yAxis = Axis(valueRange: 0...maxY, maximumTickCount: 11)!

let chart = ChartView(xAxis: xAxis, yAxis: yAxis)
chart.bounds = CGRect(x:0, y:0, width: 400, height: 400)
chart.layoutIfNeeded()
PlaygroundPage.current.liveView = chart

let plotArea = chart.plotArea

let xRatio = plotArea.bounds.width / xAxis.valueRange.size
let yRatio = plotArea.bounds.height / yAxis.valueRange.size
var scale = CGAffineTransform(scaleX: xRatio, y: yRatio)

let layer = CAShapeLayer()
layer.frame = plotArea.bounds
plotArea.layer.addSublayer(layer)
layer.strokeColor = UIColor.red.cgColor
layer.fillColor = nil
layer.lineWidth = 2
layer.path = path.copy(using: &scale)

plotArea.layer.isGeometryFlipped = true

let boringLayer = CAShapeLayer()
boringLayer.frame = plotArea.bounds
plotArea.layer.addSublayer(boringLayer)
boringLayer.strokeColor = UIColor.gray.cgColor
boringLayer.fillColor = nil
boringLayer.lineWidth = 3
boringLayer.path = boringPath.copy(using: &scale)









































