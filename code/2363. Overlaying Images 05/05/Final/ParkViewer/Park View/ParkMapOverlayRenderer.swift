//
//  ParkMapOverlayRenderer.swift
//  Park View
//
//  Created by Brian on 10/22/18.
//  Copyright © 2018 Chris Wagner. All rights reserved.
//

import UIKit
import MapKit

class ParkMapOverlayRenderer: MKOverlayRenderer {

  var overlayImage: UIImage
  
  init(overlay: MKOverlay, overlayImage: UIImage) {
    self.overlayImage = overlayImage
    super.init(overlay: overlay)
  }
  
  override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
    
    guard let imageRef = overlayImage.cgImage else { return }
    let mapRect = overlay.boundingMapRect
    let theRect = rect(for: mapRect)
    context.scaleBy(x: 1.0, y: -1.0)
    context.translateBy(x: 0, y: -theRect.size.height)
    context.draw(imageRef, in: theRect)
    
  }
  
}
