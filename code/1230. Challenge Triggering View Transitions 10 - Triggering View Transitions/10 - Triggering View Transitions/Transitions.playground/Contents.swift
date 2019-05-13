import PlaygroundSupport
import UIKit

let view = TransitionsView(frame: CGRect(
  x: 0, y: 0,
  width: 400, height: 400
))
PlaygroundPage.current.liveView = view
/*:
 
 # Transitions
 Want to compare view transitions? It's your lucky day! We've crafted this playground just for you.
 
 1. Already displayed are the 3 general types of transitions available. Click the "Animate" button again after they've all vanished to see them transition back into view.
 2. Note that the `transitionCurl...` transitions only work well in one situation. CurlUp for hiding a view, and CurlDown for showing.
 3. `transitionFlipFrom...` has 4 possible directions: Top, Bottom, Right and Left. Try all four!
 4. Try adding easing options to similar transitions to see how they interact! (`.curveEaseIn`, `.curveEaseOut`, `.curveEaseInOut`, `.curveLinear`)
*/
view.duration = 2.0

let beachballOptions: UIViewAnimationOptions = [.transitionFlipFromTop]

let drinkOptions: UIViewAnimationOptions = [.transitionCrossDissolve]

let icecreamTransitionIn: UIViewAnimationOptions = [.transitionCurlUp]
let icecreamTransitionOut: UIViewAnimationOptions = [.transitionCurlDown]
//: The animation code is below, for easy reference. The remainder of the supporting code can be found in the "Sources" folder.
extension TransitionsView {
  @objc func transition() {
    let shouldHide = self.beachball.isHidden ? false : true
    
    UIView.transition(
      with: beachball,
      duration: duration,
      options: beachballOptions,
      animations: {
        self.beachball.isHidden = shouldHide
      },
      completion: nil
    )
    
    UIView.transition(
      with: drink,
      duration: duration,
      options: drinkOptions,
      animations: {
        self.drink.isHidden = shouldHide
      },
      completion: nil
    )
    
    UIView.transition(
      with: icecream,
      duration: duration,
      options: shouldHide ? icecreamTransitionIn : icecreamTransitionOut,
      animations: {
        self.icecream.isHidden = shouldHide
      },
      completion: {_ in
//        self.icecream.isHidden = true
      }
    )
  }
}
view.button.addTarget(view, action: #selector(view.transition), for: .touchUpInside)
