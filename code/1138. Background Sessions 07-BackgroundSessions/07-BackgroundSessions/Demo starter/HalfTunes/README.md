# HalfTunes

## 07  Background Sessions

### 07 Demo Starter
* New `DownloadService` class contains download methods.
* `downloadService` property in view controller, specified where needed.
* `pauseDownload(_:)` implemented.
* `progressView` code in __TrackCell.swift__, __ProgressUpdateDelegate.swift__ added.

### Steps

1. Change `downloadsSession` to background session with view controller as delegate.
2. Create __SearchVC+URLSessionDelegates.swift__ with `SearchViewController` extension to conform to `URLSessionDownloadDelegate`.
3. Implement `urlSession(_:downloadTask:didFinishDownloadingTo:)` by moving and editing `saveDownload` from the view controller. Also move `trackIndex` to delegates file.
4. Implement `didWriteData` delegate method to calculate `download.progress` and update the appropriate `trackCell`.
5. Uncomment `handleEventsForBackgroundURLSession` in __AppDelegate.swift__
6. Add another extension for `URLSessionDelegate` to implement `urlSessionDidFinishEvents(forBackgroundURLSession:)`.
7. Build and run. Fix main thread error in `didWriteData` delegate method.
