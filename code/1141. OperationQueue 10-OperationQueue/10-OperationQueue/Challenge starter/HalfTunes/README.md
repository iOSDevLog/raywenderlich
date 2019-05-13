# HalfTunes

## 10 OperationQueue

### Challenge Starter: 10 Demo Finished

In __SearchViewController.swift__ replace the creation of `downloadsSession` with the following:

```swift
lazy var downloadsSession: URLSession = {
let delegateQueue = OperationQueue()
delegateQueue.name = "sessionDelegateQueue"
delegateQueue.qualityOfService = .userInitiated
let configuration = URLSessionConfiguration.background(withIdentifier: "bgSessionConfiguration")
return URLSession(configuration: configuration, delegate: self, delegateQueue: delegateQueue)
}()
```

Disable all breakpoints except the one in the `URLSessionDownloadDelegate` `didFinishDownloadingTo` method.

Build and run, enter a search term, then quickly download as many songs as you can before the breakpoint stops execution.

In the debug navigator, examine the thread where the breakpoint stopped: it doesn't show the name we gave it, or that its quality of service is USER_INITIATED (but the **previous** version of Xcode did). But you can see it's running one of the download delegate methods.

Continue execution, and more threads will appear, even though the delegate queue is serial! But only one is actually executing. Open the others, and you'll see they're all waiting.

Suppose we really want a **concurrent** delegate queue: we can specify a concurrent dispatch queue as the delegate queue's `underlyingQueue`. Add the following line:

```swift
delegateQueue.underlyingQueue = DispatchQueue.global(qos: .userInitiated)
```

The previous `qualityOfService` statement is now redundant, so you can comment it out.

Build and run, enter a search term, then quickly download as many songs as you can before the breakpoint stops execution.

In the debug navigator, the breakpoint thread still doesn't have the name `sessionDelegateQueue`, but it is marked `user-initiated-qos` and concurrent, so now you can see which threads are in the delegate queue.

Continue execution, and more `user-initiated-qos` threads will appear. If you're lucky, you'll see two executing at once. An iPhone has only 2 CPUs, so you won't get more than 2.

**Note:** You can create a custom (private) dispatch queue with a name:

```swift
// Serial private dispatch queue
let mySerialDelegateQueue = DispatchQueue(label: "serialDelegateQueue")
// Concurrent private dispatch queue
let myConcurrentDelegateQueue = DispatchQueue(label: "concurrentDelegateQueue", attributes: .concurrent)
```

Quality of service defaults to `.default`. You can set the private queue's `qos` property:

```swift
mySerialDelegateQueue.qos = .userInitiated
```
