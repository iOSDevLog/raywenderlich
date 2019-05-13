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
import MapKit
import MobileCoreServices
import CoreSpotlight

let storeDetailsActivityID = "com.razeware.GreenGrocer.storeDetails"

class StoreViewController: UIViewController {
  
  @IBOutlet weak var mapView: MKMapView!
  let coordinate = CLLocationCoordinate2D(latitude: 35.816667, longitude: -80.258611)
  let phoneNumber = "2025550198"
  let streetAddress = "2627 Mulberry Street\nLexington, NC 27292"
  let storeName = "Ray's Fruit Emporium"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    let mapRect = MKCoordinateRegionMakeWithDistance(coordinate, 10000, 10000)
    mapView.setRegion(mapRect, animated: false)
    
    userActivity = prepareUserActivity()
  }
  
}


extension StoreViewController {
  override func updateUserActivityState(activity: NSUserActivity) {
    
    activity.title = storeName
    activity.keywords = Set(["shopping", "fruit", "lists", "greengrocer", storeName])
    let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeContact as String)
    attributeSet.contentDescription = "The best greengrocer in town!"
    attributeSet.phoneNumbers = [phoneNumber]
    attributeSet.longitude = coordinate.longitude
    attributeSet.latitude = coordinate.latitude
    attributeSet.supportsPhoneCall = true
    
    activity.contentAttributeSet = attributeSet
  }
  
  private func prepareUserActivity() -> NSUserActivity {
    let activity = NSUserActivity(activityType: storeDetailsActivityID)
    activity.eligibleForHandoff = true
    activity.eligibleForPublicIndexing = true
    activity.eligibleForSearch = true
    return activity
  }
}
