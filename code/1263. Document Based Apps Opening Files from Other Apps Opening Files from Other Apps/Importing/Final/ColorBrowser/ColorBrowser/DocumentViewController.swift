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

class DocumentViewController: UIViewController {
  
  @IBOutlet weak var documentNameLabel: UILabel!
  @IBOutlet weak var colorSample: UIView!
  @IBOutlet weak var colorLabel: UILabel!
    
  
  @IBOutlet weak var RSlider: UISlider!
  @IBOutlet weak var BSlider: UISlider!
  @IBOutlet weak var GSlider: UISlider!
  
  var document: ColorDocument?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    RSlider.maximumValue = 255
    GSlider.maximumValue = 255
    BSlider.maximumValue = 255
  }
  
  @IBAction func dismissDocumentViewController() {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func didTapSave(_ sender: Any) {
    
    guard let document = document else { return }
    document.color = RGBColor(R: Int(RSlider.value), G: Int(GSlider.value), B: Int(BSlider.value))
    document.save(to: document.fileURL, for: .forOverwriting) {
      success in
        if success {
          self.showAlert(title: "Success", text: "Saved file")
        } else {
          self.showAlert(title: "Error", text: "Failed to save file")
        }
    }
    
    
    
  }
  
  @IBAction func didChangeSliderValue(_ sender: Any) {
    updateColorPreview(R: Int(RSlider.value), G: Int(GSlider.value), B: Int(BSlider.value))
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    guard let document = document else { return }
    if document.documentState == .normal {
      updateUI()
    } else {
      document.open {
        success in
          if success {
            self.updateUI()
          } else {
            self.showAlert(title: "Error", text: "Can't open document")
          }
        }
      }
  }
  
  
  
  
}

private extension DocumentViewController {
  func updateColorPreview(R: Int, G: Int, B: Int) {
    colorSample.backgroundColor = UIColor(red: CGFloat(R)/255, green: CGFloat(G)/255, blue: CGFloat(B)/255, alpha: 1)
    colorLabel.text = "Red: \(R), Green: \(G), Blue: \(B)"
  }
  
  func updateUI() {
    documentNameLabel.text = document?.fileURL.lastPathComponent
    if let color = document?.color {
      updateColorPreview(R: color.R, G: color.G, B: color.B)
      RSlider.value = Float(color.R)
      GSlider.value = Float(color.G)
      BSlider.value = Float(color.B)
    }
  }
}
