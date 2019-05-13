# HalfTunes

## 12 Testing & Metrics

### Challenge Starter: 12 Demo Finished

It's very easy to get metrics for session tasks.

In __SearchVC+URLSessionDelegates__, add this delegate method to the `URLSessionDownloadDelegate` extension:

```swift
func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
print(metrics)
}
```

Build and run the app, enter a search, then download a tune: a large amount of info appears in the debug console.

Save this output in a text file, so you can compare it with the slow connection you're about to simulate.

### Network Link Conditioner

If you’re on a fast network, that’s great for development, but it may be hard to see issues that your users will have when they’re on less-fantastic networks.  It’s a good idea to simulate slow network conditions just to see how usable your apps are in those conditions, but can also be helpful for seeing what your app looks like while a network request is in progress.

Apple provides a tool, called a **Network Link Conditioner** on both OS X and iOS that you can use to simulate different network conditions.
For step-by-step instructions, read on.

#### OS X

- In Xcode, select **Xcode\Open Developer Tool\More Developer Tools…**  This opens Apple’s **Downloads for Apple Developers** site. Sign in and click the entry **Additional Tools for Xcode 9** (or whatever Xcode version you’re using).
- Download and open the DMG
- Open the **Hardware** folder
- Double click on the **Network Link Conditioner.prefPane**.  The system will prompt to install it. Click **Install**

System Preferences should open with Network Link Conditioner, or it will appear at the bottom of your **System Preferences**

- Click this item to see the **Network Link Conditioner**. It has several preset profiles. You can add your own profiles if there are specific conditions you want to simulate

You may have to restart your Mac to get the link conditioner to work, but when you pick a profile and turn it on, your network for all requests from your Mac will simulate the conditions in the profile.

Pick a slow setting, such as **High Latency DNS**, then run HalfTunes. Run a search, then download a tune. If you picked a *really* slow setting, you might not see any progress at all!

Compare the task metrics with those for the normal connection.

**Remember to turn it off!**

Remember to turn off the link conditioner, or you’ll wonder why your Mac is so slow! Ask Siri to remind you, or leave something in the wrong place, where you're sure to notice it — wear your watch on the other wrist, leave a box in the doorway, or play slower music than usual — when you notice this unusual circumstance, it should remind you to turn off the link conditioner :].

#### iOS
If you’ve been using your iOS device for development, you should have a “Developer” menu item in the Settings app.

Select that option and you should see a section for “Network Link Conditioner”. Select that item and you can choose a profile, create a new profile, and turn the link conditioner on and off.

### Link

**Apple documentation: URLSession Task Transaction Metrics**

  * https://developer.apple.com/reference/foundation/urlsessiontasktransactionmetrics