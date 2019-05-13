import Foundation
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: # GCD Delights
//: You've covered a lot of what GCD has to offer—but there's so much more. This final video takes a look at a couple of the most useful other bits
//:
//: ## `dispatch_once()`
//: `dispatch_once()` is a low-level GCD API that allows you to specify a clouser that will be run just once.
//:
//: It requires a token to store the status of the block (i.e. has it been called before?)
var onceToken: dispatch_once_t = 0

func onceTest() {
  dispatch_once(&onceToken) {
    print("Performing setup the first time this is ever run")
  }
  print("Runs every time")
}

onceTest()
onceTest()
onceTest()
onceTest()


//: ### Threadsafe `lazy var`
//: Take a look at the following class. The `lazy store` property is loaded from "disc" the first time it is used, and then cached. Or is it? What happens when accessed from multiple threads?
class NaiveCache {
  private lazy var store: [String : String]? = self.loadStoreFromDisc()
  
  func getValueForKey(key: String) -> String? {
    return store?[key]
  }
  
  private func loadStoreFromDisc() -> [String : String] {
    print("Loading cache from disc...")
    randomDelay(5)
    return [
      "banana" : "yellow",
      "orange" : "orange",
      "apple"  : "green"
    ]
  }
}

let naiveCache = NaiveCache()

let workerQueue = dispatch_queue_create("com.raywenderlich.cacheQueue", DISPATCH_QUEUE_CONCURRENT)

dispatch_async(workerQueue) { print(naiveCache.getValueForKey("apple")) }
dispatch_async(workerQueue) { print(naiveCache.getValueForKey("banana")) }




//: ## `dispatch_after()`
//: Allows you to say that a closure should be executed at some point in the future, on a specified queue


func delay(delay: Double, closure: () -> ()) {
  let startTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
  dispatch_after(startTime, dispatch_get_main_queue(), closure)
}

print("One")
delay(0.5) { print("Two") }
print("Three")





