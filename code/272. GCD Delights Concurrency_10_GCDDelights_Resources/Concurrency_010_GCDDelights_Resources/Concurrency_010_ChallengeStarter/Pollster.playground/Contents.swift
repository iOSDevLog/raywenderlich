import Foundation
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: # Pollster
//: __Challenge:__ Complete the following class to simulate a polling mechanism using `dispatch_after()`

class Pollster {
  let callback: (String) -> ()

  init(callback: (String) -> ()) {
    self.callback = callback
  }
  
  
  func start() {
    print("Start polling")
    
  }
  
  func stop() {
    print("Stop polling")
  }
  
  private func makeRequest() {
    callback("\(NSDate())")
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

