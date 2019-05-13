import Foundation

public func delay(delay: Double, closure: () -> ()) {
  let startTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
  dispatch_after(startTime, dispatch_get_main_queue(), closure)
}