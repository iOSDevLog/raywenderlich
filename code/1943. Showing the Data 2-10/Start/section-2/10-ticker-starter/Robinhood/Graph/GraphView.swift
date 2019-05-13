/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

// Layout constants
private extension CGFloat {
  static let graphLineWidth: CGFloat = 1.0
  static let scale: CGFloat = 15.0
  static let lineViewHeightMultiplier: CGFloat = 0.7
  static let baseLineWidth: CGFloat = 1.0
  static let timeStampPadding: CGFloat = 10.0
}

final class GraphView: UIView {
  
  private var dataPoints: RobinhoodChartData
  
  private lazy var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm a v, MMM d"
    return formatter
  }()
  
  private var lineView = UIView()
  private let timeStampLabel = UILabel()
  private var lineViewLeading = NSLayoutConstraint()
  private var timeStampLeading = NSLayoutConstraint()
  
  private let panGestureRecognizer = UIPanGestureRecognizer()
  private let longPressGestureRecognizer = UILongPressGestureRecognizer()
  
  private var height: CGFloat = 0
  private var width: CGFloat = 0
  private var step: CGFloat = 1
  
  private var xCoordinates: [CGFloat] = []
  
  init(data: RobinhoodChartData) {
    self.dataPoints = data
    super.init(frame: .zero)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func draw(_ rect: CGRect) {
    
    height = rect.size.height
    width = rect.size.width
    
    step = width/CGFloat(dataPoints.data.count)
    
    drawGraph()
    drawMiddleLine()
    
    configureLineIndicatorView()
    configureTimeStampLabel()
    
    addGestureRecognizer(panGestureRecognizer)
    panGestureRecognizer.addTarget(self, action: #selector(userDidPan(_:)))
    
    addGestureRecognizer(longPressGestureRecognizer)
    longPressGestureRecognizer.addTarget(self, action: #selector(userDidLongPress(_:)))
  }
  
  private func drawGraph() {
    
    let graphPath = UIBezierPath()
    graphPath.move(to: CGPoint(x: 0, y: height))
    
    for i in stride(from: 0, to: width, by: step) {
      xCoordinates.append(i)
    }
    
    for (index, dataPoint) in dataPoints.data.enumerated() {
      let midPoint = dataPoints.openingPrice
      let graphMiddle = height/2
      
      let y: CGFloat = graphMiddle + CGFloat(midPoint - dataPoint.price) * .scale
      
      let newPoint = CGPoint(x: xCoordinates[index], y: y)
      graphPath.addLine(to: newPoint)
    }
    
    UIColor.upAccentColor.setFill()
    UIColor.upAccentColor.setStroke()
    graphPath.lineWidth = .graphLineWidth
    graphPath.stroke()
  }
  
  private func drawMiddleLine() {
    let middleLine = UIBezierPath()
    
    let startingPoint = CGPoint(x: 0, y: height/2)
    let endingPoint = CGPoint(x: width, y: height/2)
    
    middleLine.move(to: startingPoint)
    middleLine.addLine(to: endingPoint)
    middleLine.setLineDash([0, step], count: 2, phase: 0)
    
    middleLine.lineWidth = .baseLineWidth
    middleLine.lineCapStyle = .round
    middleLine.stroke()
    
  }
  
  private func configureLineIndicatorView() {
    lineView.backgroundColor = UIColor.gray
    lineView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(lineView)
    
    lineViewLeading = NSLayoutConstraint(item: lineView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
    
    addConstraints([
      lineViewLeading,
      NSLayoutConstraint(item: lineView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint(item: lineView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 1.0),
      NSLayoutConstraint(item: lineView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height * .lineViewHeightMultiplier),
      ])
  }
  
  private func configureTimeStampLabel() {
    timeStampLabel.configureTitleLabel(withText: "09:00 AM ET, MAY 25")
    timeStampLabel.textColor = .lightTitleTextColor
    addSubview(timeStampLabel)
    timeStampLabel.translatesAutoresizingMaskIntoConstraints = false
    
    timeStampLeading = NSLayoutConstraint(item: timeStampLabel, attribute: .leading, relatedBy: .equal, toItem: lineView, attribute: .leading, multiplier: 1.0, constant: .timeStampPadding)
    
    addConstraints([
      NSLayoutConstraint(item: timeStampLabel, attribute: .bottom, relatedBy: .equal, toItem: lineView, attribute: .top, multiplier: 1.0, constant: 0.0),
      timeStampLeading
      ])
  }
  
  @objc func userDidLongPress(_ lpgr: UILongPressGestureRecognizer) {
    let touchLocation = lpgr.location(in: self)
    let x = convertTouchLocationToPointX(touchLocation: touchLocation)
    
    guard let xIndex = xCoordinates.index(of: x) else {return }
    
    let dataPoint = dataPoints.data[xIndex]
    updateIndicator(with: x, date: dataPoint.date)
  }
  
  @objc func userDidPan(_ pgr: UIPanGestureRecognizer) {
    let touchLocation = pgr.location(in: self)
    let velocity = pgr.velocity(in: self)
    
    switch pgr.state {
    case .changed, .began, .ended:
      
      let x = convertTouchLocationToPointX(touchLocation: touchLocation)
      
      guard let xIndex = xCoordinates.index(of: x) else {return }
      let dataPoint = dataPoints.data[xIndex]
      
      updateIndicator(with: x, date: dataPoint.date)
      
    default: break
    }
  }
  
  private func updateIndicator(with offset: CGFloat, date: Date) {
    
    timeStampLabel.text = dateFormatter.string(from: date).uppercased()
    lineViewLeading.constant = offset
    
    let tsMin = timeStampLabel.frame.width / 2 + .timeStampPadding
    let tsMax = width - timeStampLabel.frame.width / 2 - .timeStampPadding
    let tsWidth = timeStampLabel.frame.width
    
    let isCenter = offset > tsMin && offset < tsMax
    let isLeftEdge = offset + tsMin < tsMax
    
    if isCenter {
      timeStampLeading.constant = -tsWidth / 2
    }
    else if isLeftEdge {
      timeStampLeading.constant = -tsWidth / 2 + (tsWidth / 2 - offset) + .timeStampPadding
    }
    else {
      timeStampLeading.constant = -tsWidth + (width - offset) - .timeStampPadding
    }
  }
  
  // Check if touchLocation.x is in the bounds of the width of the view, and converts it to a graph value
  private func convertTouchLocationToPointX(touchLocation: CGPoint) -> CGFloat {
    let maxX: CGFloat = width
    let minX: CGFloat = 0
    
    var x = min(max(touchLocation.x, maxX), minX)
    
    xCoordinates.forEach { (xCoordinate) in
      let difference = abs(xCoordinate - touchLocation.x)
      if difference <= step {
        x = CGFloat(xCoordinate)
        return
      }
    }
    
    return x
  }
}

