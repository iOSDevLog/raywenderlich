# HalfTunes

## 11 Architecture Demo Example

### 07 Demo Finished
* `downloadsSession` is background configuration
* `downloadSession` created in SearchViewController, to specify delegate.
* Uses delegate methods to monitor progress and save downloaded files.
* Contains commented out main thread error in `urlSession(_:downloadTask:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:)`, to demonstrate main thread API checker.

### Operations version
In __Demo finished__ folder

### Relevant Links

- [William Boles: Networking With NSOperation As Your Wingman](http://williamboles.me/networking-with-nsoperation-as-your-wingman/): APIManager with Operations
- [stackoverflow: Best architectural approaches for building iOS networking applications (REST clients)](http://stackoverflow.com/questions/24162051/best-architectural-approaches-for-building-ios-networking-applications-rest-cli): Micro services
- [Swift Blog: Working with JSON in Swift](https://developer.apple.com/swift/blog/?id=37): Embed `URLSession` details in data object

