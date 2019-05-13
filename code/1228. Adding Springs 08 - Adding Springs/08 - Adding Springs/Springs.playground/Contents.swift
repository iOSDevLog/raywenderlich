import PlaygroundSupport
import UIKit

let view = SpringsView(frame: CGRect(
  x: 0, y: 0,
  width: 400, height: 800
))
PlaygroundPage.current.liveView = view
/*:
 
 # Springs!
 Change the properties below to quickly adjust the springy qualities of each view. Then, click the "Animate!" button in the live view to compare the effects!
*/
view.duration = 2.0

view.beachballSpringDamping = 0.1
view.beachballSpringInitialVelocity = 0.0

view.drinkSpringDamping = 0.5
view.drinkSpringInitialVelocity = 0.0

view.icecreamSpringDamping = 1.0
view.icecreamSpringInitialVelocity = 0.0
/*:
 **Remember:**
 
 *Damping* is a ratio ranging from 0 *(snappier oscilation)* to 1 *(no oscilation)*.
 
 *Initial Velocity* is a multiplier used to calculate the view's initial velocity in points/second. Here, 0 equates to *no velocity* and 1 equates to the velocity required for the view to travel the entire animated distance in 1 second.
 */

//: The animation code is below, for easy reference. The remainder of the supporting code can be found in the "Sources" folder.

extension SpringsView {
  @objc func animate() {
    UIView.animate(
      withDuration: duration, delay: 0.0,
      usingSpringWithDamping: beachballSpringDamping,
      initialSpringVelocity: beachballSpringInitialVelocity,
      options: [], animations: {
        view.beachballConY.constant = view.beachballConY.constant * -1
        view.layoutIfNeeded()
      }, completion: nil
    )
    UIView.animate(withDuration: duration, delay: 0.0,
      usingSpringWithDamping: drinkSpringDamping,
      initialSpringVelocity: drinkSpringInitialVelocity,
      options: [], animations: {
        view.drinkConY.constant = view.drinkConY.constant * -1
        view.layoutIfNeeded()
      }, completion: nil
    )
    UIView.animate(withDuration: duration, delay: 0.0,
      usingSpringWithDamping: icecreamSpringDamping,
      initialSpringVelocity: icecreamSpringInitialVelocity,
      options: [], animations: {
        view.icecreamConY.constant = view.icecreamConY.constant * -1
        view.layoutIfNeeded()
      }, completion: nil
    )
  }
}
view.button.addTarget(view, action: #selector(view.animate), for: .touchUpInside)
