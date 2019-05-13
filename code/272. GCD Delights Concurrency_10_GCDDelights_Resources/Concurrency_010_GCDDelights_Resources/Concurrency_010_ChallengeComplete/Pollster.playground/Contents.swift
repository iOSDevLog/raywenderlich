import Foundation
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: # Pollster
//: __Challenge:__ Complete the following class to simulate a polling mechanism using `dispatch_after()`

class Pollster {
  let callback: (String) -> ()
  private var active: Bool = false
  private let isolationQueue = dispatch_queue_create("com.raywenderlich.pollster.isolation", DISPATCH_QUEUE_SERIAL)
  
  init(callback: (String) -> ()) {
    self.callback = callback
  }
  
  
  func start() {
    print("Start polling")
    active = true
    dispatch_async(isolationQueue) {
      self.makeRequest()
    }
  }
  
  func stop() {
    active = false
    print("Stop polling")
  }
  
  private func makeRequest() {
    if active {
      callback("\(NSDate())")
      let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * 1))
      dispatch_after(dispatchTime, isolationQueue) {
        self.makeRequest()
      }
    }
  }
}


//: The following will test the completed class

let pollster = Pollster(callback: { print($0) })
pollster.start()

delay(5) {
  pollster.stop()
  delay(2) {
    print("Finished")
    XCPlaygroundPage.currentPage.finishExecution()
  }
}

