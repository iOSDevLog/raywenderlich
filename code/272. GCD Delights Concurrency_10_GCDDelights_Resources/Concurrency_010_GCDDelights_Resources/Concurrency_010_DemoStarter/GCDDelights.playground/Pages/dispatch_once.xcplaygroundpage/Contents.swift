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

print("\n=== Naive Cache ===\n")

let naiveCache = NaiveCache()

let workerQueue = dispatch_queue_create("com.raywenderlich.cacheQueue", DISPATCH_QUEUE_CONCURRENT)

dispatch_async(workerQueue) { print(naiveCache.getValueForKey("apple")) }
dispatch_async(workerQueue) { print(naiveCache.getValueForKey("banana")) }

sleep(5)


//: There's a problem with this - the cache gets loaded twice

class BetterCache {
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
      "apple" : "green"
    ]
  }
}

print("\n=== BetterCache ===\n")

let betterCache = BetterCache()

dispatch_async(workerQueue) { print(betterCache.getValueForKey("apple")) }
dispatch_async(workerQueue) { print(betterCache.getValueForKey("banana")) }

//: [dispatch_after →](@next)



