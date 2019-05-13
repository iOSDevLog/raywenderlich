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

import AVFoundation
import UIKit

class ViewController: UIViewController {
  let chompPlayer = AVAudioPlayer(fileName: "chomp")
  let laughPlayer = AVAudioPlayer(fileName: "hehehe")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    interactiveSubviews.map {
      $0.gestureRecognizers!.first { $0 is UIPanGestureRecognizer }!
    }
    .forEach { panRecognizer in
      panRecognizer.view!.gestureRecognizers!
      .first { $0 is UITapGestureRecognizer }!
      .require(toFail: panRecognizer)
    }
  }
  
  @IBOutlet var interactiveSubviews: [UIImageView]! {
    didSet {
      for subview in interactiveSubviews {
        let tapRecognizer = UITapGestureRecognizer(
          target: self, action: #selector(handleTap)
        )
        tapRecognizer.delegate = self
        subview.addGestureRecognizer(tapRecognizer)
        
        let tickleRecognizer = TickleGestureRecognizer(
          target: self, action: #selector(handleTickle)
        )
        tickleRecognizer.delegate = self
        subview.addGestureRecognizer(tickleRecognizer)
      }
    }
  }
  
  @IBAction func handlePan(_ recognizer: UIPanGestureRecognizer) {
    guard let recognizerView = recognizer.view else {
      return
    }
    
    let translation = recognizer.translation(in: view)
    recognizerView.center += translation
    recognizer.setTranslation(.zero, in: view)
    
    guard recognizer.state == .ended else {
      return
    }
    
    let vectorToFinalPoint = recognizer.velocity(in: view) / 15
    let bounds = UIEdgeInsetsInsetRect(view.bounds, view.safeAreaInsets)
    let finalPoint = (recognizerView.center + vectorToFinalPoint).clamped(within: bounds)
    
    UIView.animate(
      withDuration: TimeInterval(vectorToFinalPoint.length / 1800),
      delay: 0,
      options: .curveEaseOut,
      animations: { recognizerView.center = finalPoint }
    )
  }
  
  @IBAction func handlePinch(_ recognizer: UIPinchGestureRecognizer) {
    guard let recognizerView = recognizer.view else {
      return
    }
    
    recognizerView.transform = recognizerView.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
    recognizer.scale = 1
  }
  
  @IBAction func handleRotate(_ recognizer: UIRotationGestureRecognizer) {
    guard let recognizerView = recognizer.view else {
      return
    }
    
    recognizerView.transform = recognizerView.transform.rotated(by: recognizer.rotation)
    recognizer.rotation = 0
  }
  
  @objc func handleTap(_: UITapGestureRecognizer) {
    chompPlayer.play()
  }
  
  @objc func handleTickle(_: TickleGestureRecognizer) {
    laughPlayer.play()
  }
}

extension ViewController: UIGestureRecognizerDelegate {
  func gestureRecognizer(_: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith _: UIGestureRecognizer) -> Bool {
    return true
  }
}

extension AVAudioPlayer {
  convenience init(fileName: String) {
    let url = Bundle.main.url(forResource: fileName, withExtension: "caf")!
    try! self.init(contentsOf: url)
    prepareToPlay()
  }
}
