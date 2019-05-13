# HalfTunes-APIManager

## 11 Architecture Demo Starter

- Improvement on massive view controller, but APIManager class can be split into `QueryService` and `DownloadsService`
- Demo creates a `QueryOperation` subclass of `AsyncOperation`, then `getSearchResults` uses this instead of creating a data task.

### Relevant Links

- [William Boles: Networking With NSOperation As Your Wingman](http://williamboles.me/networking-with-nsoperation-as-your-wingman/): APIManager with Operations
- [stackoverflow: Best architectural approaches for building iOS networking applications (REST clients)](http://stackoverflow.com/questions/24162051/best-architectural-approaches-for-building-ios-networking-applications-rest-cli): Micro services
- [Swift Blog: Working with JSON in Swift](https://developer.apple.com/swift/blog/?id=37): Embed `URLSession` details in data object