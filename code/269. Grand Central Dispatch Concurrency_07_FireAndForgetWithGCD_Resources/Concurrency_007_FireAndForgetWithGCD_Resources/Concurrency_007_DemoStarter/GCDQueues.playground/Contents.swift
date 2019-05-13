import UIKit
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: # GCD Queues
//: ## Using a Global Queue
//: iOS has some global queues, where every task eventually ends up being executed. You can use these directly. You need to use the main queue for UI updates.



//: ## Creating your own Queue
//: Creating your own queues allow you to specify a label, which is super-useful for debugging.
//: You can specify whether the queue is serieal (default) or concurrent (see later).
//: You can also specify the QOS or priority (here be dragons)



//: ## Getting the queue name
//: You can't get hold of the "current queue", but you can obtain its name - useful for debugging



//: ## Dispatching work asynchronously
//: Send some work off to be done, and then continue on—don't await a result
print("=== Sending asynchronously to Worker Queue ===")

print("=== Completed sending asynchronously to worker queue ===\n")



//: ## Dispatching work synchronously
//: Send some work off and wait for it to complete before continuing (here be more dragons)
print("=== Sending SYNChronously to Worker Queue ===")

print("=== Completed sending synchronously to worker queue ===\n")



//: ## Concurrent and serial queues
//: Serial allows one job to be worked on at a time, concurrent multitple
func doComplexWork() {
  // TODO: Create some complex work
}

startClock()
print("=== Starting Serial ===")




sleep(5)

// TODO: Create a concurrent queue

startClock()
print("\n=== Starting concurrent ===")





sleep(5)

XCPlaygroundPage.currentPage.finishExecution()

