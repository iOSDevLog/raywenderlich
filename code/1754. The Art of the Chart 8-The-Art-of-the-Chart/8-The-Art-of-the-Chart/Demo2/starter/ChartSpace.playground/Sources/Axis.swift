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

public extension ClosedRange where Bound == CGFloat {
    func ticks(maximumTickCount: Int, formatter: NumberFormatter = NumberFormatter()) -> [Tick] {
        let size = upperBound - lowerBound
        
        let targetTickSize = size / CGFloat(maximumTickCount)
        let tickSizeTenFactor = floor(log10(targetTickSize))
        let tickMultiple = pow(10, tickSizeTenFactor)
        let excess = remainder(lowerBound, tickMultiple)
        let absExcess = abs(excess)
        let rangeStart: CGFloat
        if excess.isZero {
            rangeStart = lowerBound
        } else if excess > 0 {
            rangeStart = lowerBound - absExcess
        } else {
            rangeStart = lowerBound - (tickMultiple - absExcess)
        }
        
        var tickWidth = Int(tickMultiple)
        
        for tickFactor in 1...10 {
            tickWidth = Int(tickMultiple) * tickFactor
            let sizeWithTicks = CGFloat(tickWidth * (maximumTickCount - 1))
            
            if sizeWithTicks + rangeStart < upperBound {
                continue
            }
            break
        }
        
        var ticks = [Tick]()
        for tickIndex in 0... {
            let tickValue = rangeStart + CGFloat(tickIndex * tickWidth)
            
            let labelValue = formatter.string(from: NSNumber(value: Float(tickValue))) ?? "\(tickValue)"
            let position = (tickValue - rangeStart) / size
            ticks.append(Tick(position: position, value:tickValue, labelValue: labelValue))
            
            if tickValue >= upperBound {
                break
            }
        }
        
        return ticks
    }
}
