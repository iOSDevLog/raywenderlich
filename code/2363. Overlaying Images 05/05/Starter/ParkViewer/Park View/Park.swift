//
//  Park.swift
//  Park View
//
//  Created by Niv Yahel on 2014-11-09.
//  Copyright (c) 2014 Chris Wagner. All rights reserved.
//

import Foundation
import MapKit

class Park {
  var boundary: [CLLocationCoordinate2D]
  var boundaryPointsCount: NSInteger
  
  var midCoordinate: CLLocationCoordinate2D
  var overlayTopLeftCoordinate: CLLocationCoordinate2D
  var overlayTopRightCoordinate: CLLocationCoordinate2D
  var overlayBottomLeftCoordinate: CLLocationCoordinate2D
  var overlayBottomRightCoordinate: CLLocationCoordinate2D {
    get {
      return CLLocationCoordinate2DMake(overlayBottomLeftCoordinate.latitude,
        overlayTopRightCoordinate.longitude)
    }
  }
  
  var overlayBoundingMapRect: MKMapRect {
    get {
      let topLeft = MKMapPoint(overlayTopLeftCoordinate);
      let topRight = MKMapPoint(overlayTopRightCoordinate);
      let bottomLeft = MKMapPoint(overlayBottomLeftCoordinate);
      
      return MKMapRect(x: topLeft.x,
                       y: topLeft.y,
                       width: fabs(topLeft.x-topRight.x),
                       height: fabs(topLeft.y - bottomLeft.y))
    }
  }
  
  var name: String?
  
  init(filename: String) {
    let filePath = Bundle.main.path(forResource: filename, ofType: "plist")
    let properties = NSDictionary(contentsOfFile: filePath!)
    
    let midPoint = NSCoder.cgPoint(for: properties!["midCoord"] as! String)
    midCoordinate = CLLocationCoordinate2DMake(CLLocationDegrees(midPoint.x), CLLocationDegrees(midPoint.y))
    
    let overlayTopLeftPoint = NSCoder.cgPoint(for: properties!["overlayTopLeftCoord"] as! String)
    overlayTopLeftCoordinate = CLLocationCoordinate2DMake(CLLocationDegrees(overlayTopLeftPoint.x),
      CLLocationDegrees(overlayTopLeftPoint.y))
    
    let overlayTopRightPoint = NSCoder.cgPoint(for: properties!["overlayTopRightCoord"] as! String)
    overlayTopRightCoordinate = CLLocationCoordinate2DMake(CLLocationDegrees(overlayTopRightPoint.x),
      CLLocationDegrees(overlayTopRightPoint.y))
    
    let overlayBottomLeftPoint = NSCoder.cgPoint(for: properties!["overlayBottomLeftCoord"] as! String)
    overlayBottomLeftCoordinate = CLLocationCoordinate2DMake(CLLocationDegrees(overlayBottomLeftPoint.x),
      CLLocationDegrees(overlayBottomLeftPoint.y))
    
    let boundaryPoints = properties!["boundary"] as! NSArray
    
    boundaryPointsCount = boundaryPoints.count
    
    boundary = []
    
    for i in 0...boundaryPointsCount-1 {
      let p = NSCoder.cgPoint(for: boundaryPoints[i] as! String)
      boundary += [CLLocationCoordinate2DMake(CLLocationDegrees(p.x), CLLocationDegrees(p.y))]
    }
  }
}
