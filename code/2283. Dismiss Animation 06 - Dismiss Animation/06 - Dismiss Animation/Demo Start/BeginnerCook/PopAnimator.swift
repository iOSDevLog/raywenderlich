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

import Foundation
import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {

  let duration = 1.0
  var originFrame = CGRect.zero

  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		//1) Set views up for transition
		let containerView = transitionContext.containerView
    let toView = transitionContext.view(forKey: .to)!

		let initialFrame = originFrame
		let finalFrame = toView.frame

		toView.transform = CGAffineTransform(
			scaleX: initialFrame.width / finalFrame.width,
			y: initialFrame.height / finalFrame.height
		)
		toView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)

    containerView.addSubview(toView)
		
		//2) Animate!
    UIView.animate(
      withDuration: duration,
      delay:0.0,
      usingSpringWithDamping: 0.4,
      initialSpringVelocity: 0.0,
      animations: {
        toView.transform = .identity
        toView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
      },
      completion:{_ in
				//3) Complete transition
        transitionContext.completeTransition(true)
      }
    )
  }
}
