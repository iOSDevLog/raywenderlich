// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

import UIKit
import PlaygroundSupport

// Start with a class definition

class Shape {
  var origin: CGPoint
  var size: CGSize
  var color: UIColor
  var fillColor: UIColor
  var lineWidth: CGFloat
  
  init(origin: CGPoint, size: CGSize, color: UIColor, fillColor: UIColor, lineWidth: CGFloat) {
    self.origin = origin
    self.size = size
    self.color = color
    self.fillColor = fillColor
    self.lineWidth = lineWidth
  }
  func draw(on context: CGContext) {
    fatalError("overide \(#function)")
  }
  func area() -> CGFloat {
    return size.width * size.height
  }
}

class Circle: Shape {
  var diameter: CGFloat {
    return size.width
  }
  
  var radius: CGFloat {
    return size.width / 2
  }
  
  override func area() -> CGFloat {
    return .pi * radius * radius
  }
  
  init(origin: CGPoint, radius: CGFloat, color: UIColor, fillColor: UIColor, lineWidth: CGFloat) {
    let size = CGSize(width: radius*2, height: radius*2)
    super.init(origin: origin, size: size, color: color, fillColor: fillColor, lineWidth: lineWidth)
  }
  
  override func draw(on context: CGContext) {
    context.setFillColor(fillColor.cgColor)
    let rect = CGRect(x: origin.x-radius, y: origin.y-radius, width: diameter, height: diameter)
    context.addEllipse(in: rect)
    context.fillPath()
    context.setStrokeColor(color.cgColor)
    context.addEllipse(in: rect)
    context.setLineWidth(lineWidth)
    context.strokePath()
  }
}

////////////////////////////////////////////////////////////////////////////////

final class RenderView: UIView {
  
  var shapes: [Shape] = [] {
    didSet {
      setNeedsDisplay()
    }
  }
  
  override func draw(_ rect: CGRect) {
    guard let context = UIGraphicsGetCurrentContext() else {
      return
    }
    context.setFillColor(backgroundColor?.cgColor ?? UIColor.white.cgColor)
    context.fill(rect)
    
    for shape in shapes {
      shape.draw(on: context)
    }
  }
}

extension UIColor {
  static func rgb(_ r: UInt8, _ g: UInt8, _ b: UInt8) -> UIColor {
    return UIColor(displayP3Red: CGFloat(r)/255,
                   green: CGFloat(g)/255,
                   blue: CGFloat(b)/255, alpha: 1)
    
  }
}

let renderView = RenderView(frame: CGRect(origin: .zero, size: CGSize(width: 400, height: 400)))
renderView.backgroundColor = .lightGray

var shapes: [Shape] = []

for _ in 1 ... 5 {
  
  let position = CGPoint(x: CGFloat.random(in: 0...renderView.frame.size.width),
                         y: CGFloat.random(in: 0...renderView.frame.size.width))
  let size = CGSize(width: CGFloat.random(in: 50...80),
                    height: CGFloat.random(in: 50...80))
  let lineWidth = CGFloat.random(in: 5...15)
  

  
  let colors: [UIColor] = [.rgb(255,0,156),
                           .rgb(255,0,113),
                           .rgb(255,0,219),
                           .rgb(255,0,182),
                           .rgb(255,0,94)]
  
  let shape = Circle(origin: position, radius: size.width,
                     color: .rgb(255,0,15),
                     fillColor: colors.randomElement()!,
                     lineWidth: lineWidth)
  shapes.append(shape)
}

renderView.shapes = shapes
PlaygroundPage.current.liveView = renderView




