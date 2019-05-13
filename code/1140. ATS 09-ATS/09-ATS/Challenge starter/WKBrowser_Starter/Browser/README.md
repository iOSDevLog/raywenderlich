#  Browser

## 9 ATS

### Challenge Starter

App Transport Security prevents a WebKit web view from loading non-https URLs, so it's the easiest way to see the effects of ATS exceptions.

1. Open, build and run this app.
2. Tap **objc.io**: this loads fine; it got A+ on [SSL Server Test](https://www.ssllabs.com/ssltest/).
3. Tap one of the lower 2 buttons: it won't load, because they're http-only - they don't use SSL.

### Exception to allow insecure HTTP loads from your site

The scenario is: you want to build an app for the mokacoding site, so either it has to start using SSL, or your app must make it an ATS exception.

1. Open **Info.plist** and add **App Transport Security Settings\Exception Domains\mokacoding.com**.
2. Change the type of mokacoding.com to `dictionary`, then add `NSExceptionAllowsInsecureHTTPLoads:YES` and `NSIncludesSubdomains:YES`.
3. Check that **App Transport Security Settings\Allow Arbitrary Load**s is NO.
4. **Change the simulator** to a different iPhone size. I find this is a reliable way to make Xcode process Info.plist during build, so it actually changes the ATS settings.
5. Build and run. Tap **mokacoding**. It should load.
6. Tap **PBS**: it still won't load.

You'll still have to justify the exception for App Store review, but it should be much easier than trying to justify Allow Arbitrary Loads: YES.

### Exception to protect your site

Alternatively, your app might need to allow arbitrary loads from as-yet-unknown servers, perhaps for displaying ads, or subscribing to mail servers. But you want to keep ATS protection for your own back-end server — we'll pretend that mokacoding is your back-end server.

1. Change **App Transport Security Settings\Allow Arbitrary Loads** to YES.
2. In the **Exception Domain**, change `NSExceptionAllowsInsecureHTTPLoads` to NO.
3. Change the simulator to a different iPhone size.
4. Build and run. Tap **PBS**: it should load.
5. Tap **mokacoding**: it won't load.

### SafariServices alternative

A SafariServices Safari view controller is not subject to ATS.

1. Open, build and run the Browser app in **Challenge Starter/SafariBrowser**.
2. Tap any button.
3. The **Safari** browser view loads, and shows a progress bar while the site loads.
4. Look at **Info.plist**: no ATS settings at all!

Apple recommends **SafariServices** for apps that need a general purpose browser, with all the features users expect from Safari, including login autofill.

Use **WebKit** to present specific domains, especially if you need to customize the presentation.

