import UIKit

public func randomPoints(_ count: Int) -> [CGPoint] {
    var previousValue: CGFloat?
    return (0..<count).map {
        let x = CGFloat($0)
        if let previous = previousValue {
            let adjustment = CGFloat(arc4random_uniform(50))
            let direction = arc4random_uniform(3)
            let multiplier: CGFloat
            switch direction {
            case 0: multiplier = -1
            case 1: multiplier = 0
            default: multiplier = 1
            }
            let possibleY = previous + (adjustment * multiplier)
            let y = max(possibleY, 0)
            previousValue = y
            return CGPoint(x: x, y: y)
        } else {
            previousValue = 0
            return CGPoint(x: x, y: 0)
        }
    }
}

public func uniformPoints(_ count: Int) -> [CGPoint] {
    return (0..<count).map {
        let x = CGFloat($0)
        return CGPoint(x: x, y: x)
    }
}

