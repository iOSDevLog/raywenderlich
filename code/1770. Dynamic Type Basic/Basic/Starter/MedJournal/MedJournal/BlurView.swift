/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import GLKit

class BlurView: GLKView {
  let clampFilter = CIFilter(name: "CIAffineClamp")!
  let blurFilter = CIFilter(name: "CIGaussianBlur")!
  let ciContext: CIContext
  
  override init(frame: CGRect) {
    let glContext = EAGLContext(api: .openGLES2)!
    ciContext = CIContext(eaglContext: glContext, options: [kCIContextWorkingColorSpace: NSNull()])
    super.init(frame: frame, context: glContext)
    enableSetNeedsDisplay = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    let glContext = EAGLContext(api: .openGLES2)!
    ciContext = CIContext(eaglContext: glContext, options: [kCIContextWorkingColorSpace: NSNull()])
    super.init(coder: aDecoder)
    context = glContext
    enableSetNeedsDisplay = true
  }
  
  func setImage(fromView view: UIView) {
    UIGraphicsBeginImageContextWithOptions(view.frame.size, view.isOpaque, 0)
    view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    inputImage = image
  }
  
  @IBInspectable var inputImage: UIImage? {
    didSet {
      inputCIImage = inputImage.map { CIImage(image: $0)! }
    }
  }
  
  @IBInspectable var blurRadius: Float = 0 {
    didSet {
      blurFilter.setValue(blurRadius, forKey: "inputRadius")
      setNeedsDisplay()
    }
  }
  
  var inputCIImage: CIImage? {
    didSet { setNeedsDisplay() }
  }
  
  override func draw(_ rect: CGRect) {
    guard let inputCIImage = inputCIImage else { return }
    
    clampFilter.setValue(inputCIImage, forKey: kCIInputImageKey)
    blurFilter.setValue(clampFilter.outputImage!, forKey: kCIInputImageKey)
    let rect = CGRect(x: 0, y: 0, width: drawableWidth, height: drawableHeight)
    ciContext.draw(blurFilter.outputImage!, in: rect, from: inputCIImage.extent)
  }
}

extension UIWindow {
  private struct AssociatedKeys {
    static var window: UInt8 = 0
  }
  
  var blurWindow: UIWindow? {
    get {
      return objc_getAssociatedObject(self, &AssociatedKeys.window) as? UIWindow
    }
    set {
      objc_setAssociatedObject(self, &AssociatedKeys.window, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  
  func installBlurView() {
    let tripleTapGesture = UITapGestureRecognizer(target: self, action: #selector(setupBlurView))
    tripleTapGesture.numberOfTapsRequired = 3
    self.addGestureRecognizer(tripleTapGesture)
  }
  
  @objc func setupBlurView() {
    let controller: UIViewController
    let window: UIWindow
    if let blurWindow = blurWindow, let rootController = blurWindow.rootViewController {
      rootController.view.subviews.forEach({ subview in
        subview.removeFromSuperview()
      })
      controller = rootController
      window = blurWindow
    } else {
      window = UIWindow(frame: UIScreen.main.bounds)
      controller = UIViewController()
      window.rootViewController = controller
      window.windowLevel = UIWindowLevelAlert
      blurWindow = window
    }
    
    let blurView = BlurView(frame: self.bounds)
    blurView.blurRadius = 10
    blurView.setImage(fromView: self)
    controller.view.addSubview(blurView)
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeBlur))
    tapGesture.numberOfTapsRequired = 1
    controller.view.addGestureRecognizer(tapGesture)
    
    window.makeKeyAndVisible()
  }
  
  @objc func removeBlur() {
    blurWindow?.removeFromSuperview()
    blurWindow = nil
  }
}
