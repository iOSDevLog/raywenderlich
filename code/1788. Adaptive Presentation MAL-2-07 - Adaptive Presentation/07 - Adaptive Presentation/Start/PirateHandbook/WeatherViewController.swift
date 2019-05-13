/**
 * Copyright (c) 2018 Razeware LLC
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
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

final class WeatherViewController: UIViewController {
  @IBOutlet private(set) var backgroundImageView: UIImageView!
  @IBOutlet private var stackView: UIStackView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpImages(traitCollection: traitCollection)
  }
  
  override func willTransition(
    to newCollection: UITraitCollection,
    with coordinator: UIViewControllerTransitionCoordinator
  ) {
    super.willTransition(to: newCollection, with: coordinator)
    
    switch (newCollection.horizontalSizeClass, newCollection.verticalSizeClass) {
    case (traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass): break
    default: setUpImages(traitCollection: newCollection)
    }
  }
  
  private func setUpImages(traitCollection: UITraitCollection) {    
    for subview in stackView.arrangedSubviews.dropFirst() {
      subview.isHidden = traitCollection.isCompact
    }
  }
}

private extension UITraitCollection {
  var isCompact: Bool {
    return
      [horizontalSizeClass, verticalSizeClass]
      .filter {$0 != .compact}
      .isEmpty
  }
}












