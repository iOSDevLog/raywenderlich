///// Copyright (c) 2017 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation

class HtmlHelper {
  
  /**
   Wraps artbitrary HTML into a "proper" structure with a HEAD, BODY, META-VIEWPORT
   and STYLE.
   */
  static func wrap(html: String, withClass wrapClass: String = "") -> String {
    // "Proper" Html needs some things:
    // <head></head><body></body>
    // in <head> ->
    //    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    //    <link href="style.css" rel="stylesheet" type="text/css">
    let wrappedHtml = """
      <head>
        <title>Deskbook WebView</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="style.css" rel="stylesheet" type="text/css">
      </head>
      <body>
        <div class="\(wrapClass)">\(html)</div>
      </body>
    """
    return wrappedHtml
  }
  
  /**
   Returns an inline CSS block <style> with the bundle-included css
   Why not use <style src="path/to/local/file"></style>?
   Since Swift 3, WKWebView's security settings disallows it from loading LOCAL files without some extra settings. To keep the code simple, we'll use the "string injection" trick!
   */
  static func getCss() -> String {
    // Check to see if we have a style.css in the bundle
    if let path = Bundle.main.path(forResource: "style", ofType: "css") {
      // We do have a style.css in the bundle!
      NSLog("Style sheet found in bundle: \(path)")
      // Read the CSS into a string. Why? WKWebView won't read it from file:// in some scenarios (blame AppTransportSecurity)
      var cssString: String
      do {
        cssString = try String(contentsOfFile: path)
        // Successful read... return the CSS wrapped in a <style> node
        return "<style type=\"text/css\">\(cssString)</style>"
      } catch (let error) {
        // Oh man... no css for whatever reason. Log it.
        NSLog("Error reading the css file: \(error)")
      }
    }
    // If we did not have a style.css in the bundle or had an issue reading, just return an empty string!
    return ""
  }
  
}
