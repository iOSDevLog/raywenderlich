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

class ViewController: UIViewController {
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var innerView: UIView!
  
  @IBOutlet weak var frameXSlider: UISlider!
  @IBOutlet weak var boundsXSlider: UISlider!
  @IBOutlet weak var frameYSlider: UISlider!
  @IBOutlet weak var boundsYSlider: UISlider!

  @IBOutlet weak var frameOriginLabel: UILabel!
  @IBOutlet weak var boundsOriginLabel: UILabel!
  @IBOutlet weak var frameYOriginLabel: UILabel!
  @IBOutlet weak var boundsYOriginLabel: UILabel!
  
  //MARK:- Challenge
  
  @IBAction func frameXSliderChanged(_ sender: AnyObject) {
    containerView.frame.origin.x = CGFloat(frameXSlider.value)
    updateLabels()
  }
  
   @IBAction func boundsXSliderChanged(_ sender: AnyObject) {
    containerView.bounds.origin.x = CGFloat(boundsXSlider.value)
    updateLabels()
  }

  @IBAction func frameYSliderChanged(_ sender: AnyObject) {
    containerView.frame.origin.y = CGFloat(frameYSlider.value)
    updateLabels()
  }

  @IBAction func boundsYSliderChanged(_ sender: AnyObject) {
    containerView.bounds.origin.y = CGFloat(boundsYSlider.value)
    updateLabels()
  }

  //MARK:-
  override func viewDidLoad() {
    super.viewDidLoad()
    
    frameXSlider.value = Float(containerView.frame.origin.x)
    boundsXSlider.value = Float(containerView.bounds.origin.x)
    
    frameYSlider.value = Float(containerView.frame.origin.y)
    boundsYSlider.value = Float(containerView.bounds.origin.y)
    
    updateLabels()
  }

  fileprivate func updateLabels() {
    frameOriginLabel.text = "Frame x origin = \(Int(containerView.frame.origin.x))"
    boundsOriginLabel.text = "Bounds x origin = \(Int(containerView.bounds.origin.x))"
    frameYOriginLabel.text = "Frame y origin = \(Int(containerView.frame.origin.y))"
    boundsYOriginLabel.text = "Bounds y origin = \(Int(containerView.bounds.origin.y))"
  }

}
