import UIKit
import XCPlayground

//: # Concurrent NSOperations
//: So far, you've discovered how to create an `NSOperation` subclass by overriding the `main()` method, but that will only work for synchronous tasks.
//: Need long running playground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: A abstract class for wrapping asynchronous functionality
class ConcurrentOperation: NSOperation {
  enum State: String {
    case Ready, Executing, Finished
    
    private var keyPath: String {
      return "is" + rawValue
    }
  }
  
  var state = State.Ready {
    willSet {
      willChangeValueForKey(newValue.keyPath)
      willChangeValueForKey(state.keyPath)
    }
    didSet {
      didChangeValueForKey(oldValue.keyPath)
      didChangeValueForKey(state.keyPath)
    }
  }
}


extension ConcurrentOperation {
  //: NSOperation Overrides
  override var ready: Bool {
    return super.ready && state == .Ready
  }
  
  override var executing: Bool {
    return state == .Executing
  }
  
  override var finished: Bool {
    return state == .Finished
  }
  
  override var asynchronous: Bool {
    return true
  }
  
  override func start() {
    if cancelled {
      state = .Finished
      return
    }
    
    main()
    state = .Executing
  }
  
  override func cancel() {
    state = .Finished
  }
}


//: Concrete subclass of `ConcurrentOperation` to load data from a URL.
//: This uses the async method on the network simulator to load it
class DataLoadOperation: ConcurrentOperation {
  
  private let url: NSURL
  var loadedData: NSData?
  
  init(url: NSURL) {
    self.url = url
    super.init()
  }
  
  override func main() {
    NetworkSimulator.asyncLoadDataAtURL(url) {
      data in
      self.loadedData = data
      self.state = .Finished
    }
  }
}

//: Create imageURL and queue
let imageURL = NSBundle.mainBundle().URLForResource("desert", withExtension: "jpg")!
let queue = NSOperationQueue()

//: Create the load operation and add it to the queue
let loadOperation = DataLoadOperation(url: imageURL)

queue.addOperation(loadOperation)

//: Wait for the queue to complete
queue.waitUntilAllOperationsAreFinished()

//: Take a look at the resultant image
if let readData = loadOperation.loadedData {
  UIImage(data: readData)
}



