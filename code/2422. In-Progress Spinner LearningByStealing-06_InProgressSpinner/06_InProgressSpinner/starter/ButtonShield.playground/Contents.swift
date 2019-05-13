//: # ButtonShield
//: A demo playground that demonstrates how to use Core Animation layers
//: to create a fun button, shamelessly stolen from ExpressVPN
//: > Icon made by [Icon Works](https://www.flaticon.com/authors/icon-works) from [www.flaticon.com](https://www.flaticon.com/) is licensed by [CC 3.0 BY](http://creativecommons.org/licenses/by/3.0/)

import UIKit
import PlaygroundSupport

//: ### Extensions to store constants

fileprivate extension CGFloat {
  static var outerCircleRatio: CGFloat = 0.8
  static var innerCircleRatio: CGFloat = 0.55
  static var inProgressRatio: CGFloat = 0.58
}

fileprivate extension Double {
  static var animationDuration: Double = 0.5
  static var inProgressPeriod: Double = 2.0
}


class ButtonView: UIView {
  enum State {
    case off
    case inProgress
    case on
  }
  
  public var state: State = .off {
    didSet {
      switch state {
      case .inProgress:
        showInProgress(true)
      case .on:
        showInProgress(false)
      case .off:
        showInProgress(false)
      }
    }
  }

  
  private let buttonLayer = CALayer()
  private lazy var innerCircle: CAShapeLayer = {
    let layer = CAShapeLayer()
    layer.path = Utils.pathForCircleInRect(rect: buttonLayer.bounds, scaled: CGFloat.innerCircleRatio)
    layer.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    layer.strokeColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    layer.lineWidth = 3
    
    layer.shadowRadius = 15
    layer.shadowOpacity = 0.1
    layer.shadowOffset = CGSize(width: 15, height: 10)
    layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    return layer
  }()
  
  private lazy var outerCircle: CAShapeLayer = {
    let layer = CAShapeLayer()
    layer.path = Utils.pathForCircleInRect(rect: buttonLayer.bounds, scaled: CGFloat.outerCircleRatio)
    layer.fillColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    layer.opacity = 0.4
    return layer
  }()
  
  private lazy var badgeLayer: CAGradientLayer = {
    let layer = CAGradientLayer()
    layer.colors = [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)].map { $0.cgColor }
    layer.frame = self.layer.bounds
    layer.mask = createBadgeMaskLayer()
    return layer
  }()
  
  private lazy var inProgressLayer: CAGradientLayer = {
    let layer = CAGradientLayer()
    // TODO05
    return layer
  }()
  
  private func createBadgeMaskLayer() -> CAShapeLayer {
    let mask = CAShapeLayer()
    mask.path = UIBezierPath.badgePath.cgPath
    let scale = self.layer.bounds.width / UIBezierPath.badgePath.bounds.width
    mask.transform = CATransform3DMakeScale(scale, scale, 1)
    return mask
  }
  
  
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureLayers()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configureLayers()
  }
  
  private func configureLayers() {
    backgroundColor = #colorLiteral(red: 0.9600390625, green: 0.9600390625, blue: 0.9600390625, alpha: 1)
    buttonLayer.frame = bounds.largestContainedSquare.offsetBy(dx: 0, dy: -20)
    buttonLayer.addSublayer(outerCircle)
    buttonLayer.addSublayer(inProgressLayer)
    buttonLayer.addSublayer(innerCircle)
    
    layer.addSublayer(badgeLayer)
    layer.addSublayer(buttonLayer)
  }
  
  
  private func showInProgress(_ show: Bool = true) {
    // TODO05
  }

}

//: ### Present the button

let aspectRatio = UIBezierPath.badgePath.bounds.width / UIBezierPath.badgePath.bounds.height
let button = ButtonView(frame: CGRect(x: 0, y: 0, width: 300, height: 300 / aspectRatio))

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = button

let connection = PseudoConnection(connectionTime: 5) { (state) in
  switch state {
  case .disconnected:
    print("Disconnected")
    button.state = .off
  case .connecting:
    print("Connecting")
    button.state = .inProgress
  case .connected:
    print("Connected")
    button.state = .on
  }
}

let gesture = UITapGestureRecognizer(target: connection, action: #selector(PseudoConnection.toggle))
button.addGestureRecognizer(gesture)
