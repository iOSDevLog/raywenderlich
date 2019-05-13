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

import UIKit
import MessageUI
import WebKit
import SafariServices

class StaffDetailViewController: StaffDetailBaseViewController {
  
  // Properties provided by the StaffDetailBaseViewController
  // let staffMember: Staff!
  
  // MARK: IB Outlets
  
  @IBOutlet var nameField: UITextField!
  @IBOutlet var emailField: UITextField!
  @IBOutlet var mobileField: UITextField!
  @IBOutlet var bioWebView: WKWebView!
  
  // MARK: View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NSLog("staffMember: \(staffMember.name)")
    updateStaffValues()
    
    // Set the navigation delagate for our WKWebView to this controller so we can receive its navigation events
    bioWebView.navigationDelegate = self
    
    // Set delegates for fields where we want to track tap and do something other than edit
    emailField.delegate = self
    mobileField.delegate = self
    
  }
  
  // MARK: Implementation
  
  /**
   Set our fields
   */
  fileprivate func updateStaffValues() {
    // Set our fields. Just in case this was called from the BG, let's force main
    DispatchQueue.main.async {
      self.nameField.text = self.staffMember.name
      self.emailField.text = self.staffMember.email
      self.mobileField.text = self.staffMember.mobile
      // Load our WKWebView but note we pass the bundleURL so we can load bundle resources!
      self.bioWebView.loadHTMLString(HtmlHelper.wrap(html: self.staffMember.bio, withClass: "bio showBadge"), baseURL: Bundle.main.bundleURL)
    }
  }
  
  /**
   Display a message VC with the staff member email pre-populated
   */
  fileprivate func sendEmail() {
    guard MFMailComposeViewController.canSendMail() else {
      NSLog("Mail services are not available on this device!")
      AlertHelper.showSimpleAlert(title: "Unsupported Feature", message: "This device does not support sending email.", viewController: self)
      return
    }
    
    // TODO: Add logic to verify for valid email
    guard staffMember.email.count > 0 else {
      // we just exit quietly if we don't have an email
      return
    }
    
    // Grab a reference to the email VC and set the delegate
    let composeVC = MFMailComposeViewController()
    composeVC.mailComposeDelegate = self
    
    // Set the email
    composeVC.setToRecipients([staffMember.email])
    
    // Present the email VC
    self.present(composeVC, animated: true, completion: nil)
    
  }
  
  /**
   Handles placing a call
   */
  fileprivate func startCall() {
    // If we end up with a valid tel url, and we can open "tel://", then we place the call.
    if let url = URL(string: "tel://\(staffMember.mobileDigits())"), UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url)
    } else {
      NSLog("Unable to call: \(staffMember.mobileDigits())")
      AlertHelper.showSimpleAlert(title: "Unsupported Feature", message: "This device does not support calls.", viewController: self)
    }
  }
  
  /**
   Handles showing a passed URL in a Safari View Controller
  */
  fileprivate func openWithSafariVC(url: URL) {
    let safariVC = SFSafariViewController(url: url)
    safariVC.modalPresentationStyle = .overFullScreen
    self.present(safariVC, animated: true, completion: nil)
  }
  
}

// MARK: UITextFieldDelegate

extension StaffDetailViewController: UITextFieldDelegate {
  
  /**
   Catch when the user has tried to edit our fields, we cancel the edit and do something else!
   */
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    if textField == self.emailField {
      // Send an email to the staff member
      sendEmail()
    } else if textField == self.mobileField {
      // Place a call to the staff member
      startCall()
    }
    return false
  }
}

// MARK: MFMailComposeViewControllerDelegate

extension StaffDetailViewController: MFMailComposeViewControllerDelegate {
  
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    // Dismiss the mail compose view controller.
    controller.dismiss(animated: true, completion: nil)
  }
}

// MARK: Web View Navigation (click handling) delegate

extension StaffDetailViewController: WKNavigationDelegate {
  
  /**
   Decide if a WebKit Web View Navigation action should be allowed (a click on a link, etc.)
   */
  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    
    guard let urlTarget = navigationAction.request.url else {
      // Somehow we did not receive a URL or perhaps it's invalid, so we exit rejecting the URL
      decisionHandler(.cancel)
      return
    }
    
    NSLog("navigation urlTarget: \(urlTarget)")
    
    // Extract the URL as a string
    let urlString = urlTarget.absoluteString
    
    // Check to see if the Navigation Target is the bundle path (which is how the WKWebView loads initially), or starts with bundle path (which is how we load bundle resources), and allow it
    if urlString.hasPrefix(Bundle.main.bundleURL.absoluteString) || urlString == "about:blank" {
      decisionHandler(.allow)
      return
    }
    
    // Assert: We have an intent to load/navigate to a URL other than the bundle path
    
    if urlString.hasPrefix("https://twitter.com")  {
      // The link is to Twitter
      
      // So, since we want to handle that ourselves, we actually CANCEL the navigation on the WKWebView
      decisionHandler(.cancel)
      
      // Then let's do what we really want, which is to use a SafariVC
      openWithSafariVC(url: urlTarget)
      
      // Since we've called decisionHandler already, we must return or we crash!
      return
    }
    
    // For anything else, disallow it
    decisionHandler(.cancel)
    
  }
  
}

