import UIKit
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: # UIViewAnimationGroup
//: In the demo you learnt about how you can use GCD groups to be notified when a set of GCD tasks completes, and how you can wrap an existing asynchronous API to use dispatch groups.
//: 
//: __Challenge:__ The `UIView` animation API is asynchronous, but doesn't make it easy to determine when multiple simultaneous animations complete. Your challenge is to extend the `UIView` animation API to accept dispatch groups and hence determine when a set of animations completes.
//:
//: Add an implementation to this new `UIView` API

extension UIView {
  static func animateWithDuration(duration: NSTimeInterval, animations: () -> Void, group: dispatch_group_t, completion: ((Bool) -> Void)?) {
    
  // TODO: Fill in this implementation
  
  }
}

//: Use the following dispatch group:
let animationGroup = dispatch_group_create()

//: The animation uses the following views
let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
view.backgroundColor = UIColor.redColor()
let box = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
box.backgroundColor = UIColor.yellowColor()
view.addSubview(box)

XCPlaygroundPage.currentPage.liveView = view

//: And then rewrite the following animation to be notified when all animations complete:
UIView.animateWithDuration(1, animations: {
  box.center = CGPoint(x: 150, y: 150)
  }, completion: {
    _ in
    UIView.animateWithDuration(2, animations: {
      box.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
      }, completion: nil)
})

UIView.animateWithDuration(4, animations: { () -> Void in
  view.backgroundColor = UIColor.blueColor()
})


//: Should only print once all the animations are complete
dispatch_group_notify(animationGroup, dispatch_get_main_queue()) {
  print("Animations completed!")
  // TODO: Uncomment the following line once you've completed implemention
  //XCPlaygroundPage.currentPage.finishExecution()
}






