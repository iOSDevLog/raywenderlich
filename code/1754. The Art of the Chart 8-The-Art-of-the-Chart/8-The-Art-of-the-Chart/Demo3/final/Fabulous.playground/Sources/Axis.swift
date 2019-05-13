import UIKit

public struct Tick {
    public let position: CGFloat
    public let value: CGFloat
    public let labelValue: String
}

public struct Axis {
    public let valueRange: ClosedRange<CGFloat>
    public let ticks: [Tick]
    
    public init?(valueRange: ClosedRange<CGFloat>, maximumTickCount: Int, formatter: NumberFormatter = NumberFormatter()) {
        
        let ticks = valueRange.ticks(maximumTickCount: maximumTickCount, formatter: formatter)
        guard ticks.count > 1, let first = ticks.first, let last = ticks.last else {
            return nil
        }
        
        self.valueRange = first.value...last.value
        self.ticks = ticks
    }
}

public extension ClosedRange where Bound: FloatingPoint {
    var size: Bound {
        return upperBound - lowerBound
    }
}

extension Axis: CustomDebugStringConvertible {
    public var debugDescription: String {
        guard ticks.count > 1 else {
            return "Invalid Axis"
        }
        let tickSize = valueRange.size / CGFloat(ticks.count - 1)
        return "\(valueRange), \(ticks.count) ticks, size \(tickSize)"
    }
}

extension ClosedRange where Bound == CGFloat {
    func ticks(maximumTickCount: Int, formatter: NumberFormatter = NumberFormatter()) -> [Tick] {
        
        let targetTickSize = size / CGFloat(maximumTickCount - 1)
        let tickSizeTenFactor = floor(log10(targetTickSize))
        let tickMultiple = pow(10, tickSizeTenFactor)
        let tickMultiplier = ceil(targetTickSize / tickMultiple)
        let tickWidth = tickMultiple * tickMultiplier
        
        let lastTickIndex = ceil(size / tickWidth)
        let fullSize = (lastTickIndex * tickWidth) - lowerBound
        
        return (0...Int(lastTickIndex)).map {
            let tickValue = lowerBound + CGFloat($0) * tickWidth
            
            let labelValue = formatter.string(from: NSNumber(value: Float(tickValue))) ?? "\(tickValue)"
            let position = (tickValue - lowerBound) / fullSize
            return Tick(position: position, value:tickValue, labelValue: labelValue)
        }
    }
}
