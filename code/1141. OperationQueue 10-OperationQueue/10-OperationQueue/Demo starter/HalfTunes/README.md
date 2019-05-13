# HalfTunes

## 10 OperationQueue Demo Starter

Add breakpoints to examine operation queues used by `URLSession`.

### 07 Demo Finished
* `downloadsSession` is background configuration
* `downloadSession` created in SearchViewController, to specify delegate.
* Uses delegate methods to monitor progress and save downloaded files.
* Contains commented out main thread error in `urlSession(_:downloadTask:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:)`, to demonstrate main thread API checker.
