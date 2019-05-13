/*
* Copyright (c) 2015 Razeware LLC
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

protocol RestorableActivity {
  var restorableActivities : Set<String> { get }
}

protocol RestorableActivityContainer : RestorableActivity {
  func primaryRestorableResponderForActivityType(activityType: String) -> UIResponder?
}

extension RestorableActivityContainer where Self : UIViewController {
  var restorableActivities : Set<String> {
    var activities = Set<String>()
    for vc in childViewControllers {
      if let ra = vc as? RestorableActivity {
        activities = activities.union(ra.restorableActivities)
      }
    }
    return activities
  }
  
  func primaryRestorableResponderForActivityType(activityType: String) -> UIResponder? {
    let compatibleVCs = childViewControllers.reverse().filter {
      vc in
      guard let vc = vc as? RestorableActivity else {
        return false
      }
      return vc.restorableActivities.contains(activityType)
    }
    return compatibleVCs.first
  }
}
