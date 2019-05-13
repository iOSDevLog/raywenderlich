import Foundation

private var lastStartTime = NSDate()

public func startClock(){
  lastStartTime = NSDate()
}

public func stopClock() -> NSTimeInterval {
  return NSDate().timeIntervalSinceDate(lastStartTime)
}
