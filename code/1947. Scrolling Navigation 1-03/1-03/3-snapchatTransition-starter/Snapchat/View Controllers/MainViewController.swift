/// Copyright (c) 2018 Razeware LLC
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

protocol ColoredView {
  var controllerColor: UIColor { get set }
}

class MainViewController: UIViewController {
  
  // MARK: - Properties
  var scrollViewController: ScrollViewController!
  
  lazy var chatViewController: UIViewController! = {
    return self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController")
  }()
  
  lazy var discoverViewController: UIViewController! = {
    return self.storyboard?.instantiateViewController(withIdentifier: "DiscoverViewController")
  }()
  
  lazy var lensViewController: UIViewController! = {
    return self.storyboard?.instantiateViewController(withIdentifier: "LensViewController")
  }()
  
  var cameraViewController: CameraViewController!
  
  // MARK: - IBOutlets
  @IBOutlet var navigationView: NavigationView!
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let controller = segue.destination as? CameraViewController {
      cameraViewController = controller
    } else if let controller = segue.destination as? ScrollViewController {
      scrollViewController = controller
    }
  }
}

// MARK: - IBActions
extension MainViewController {
  
  @IBAction func handleChatIconTap(_ sender: UITapGestureRecognizer) {
    print("Chat!")
  }
  
  @IBAction func handleDiscoverIconTap(_ sender: UITapGestureRecognizer) {
    print("Discover!")
  }
  
  @IBAction func handleCameraButton(_ sender: UITapGestureRecognizer) {
    print("Snap, snap!")
  }
}

