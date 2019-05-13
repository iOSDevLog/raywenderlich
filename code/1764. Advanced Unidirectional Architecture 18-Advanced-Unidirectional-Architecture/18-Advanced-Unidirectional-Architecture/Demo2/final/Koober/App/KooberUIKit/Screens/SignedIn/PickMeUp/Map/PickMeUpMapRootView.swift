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
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import KooberKit
import MapKit

class PickMeUpMapRootView: MKMapView {
  let defaultMapSpan = MKCoordinateSpan(latitudeDelta: 0.006, longitudeDelta: 0.006)
  let mapDropoffLocationSpan = MKCoordinateSpan(latitudeDelta: 0.023, longitudeDelta: 0.023)

  var imageCache: ImageCache

  init(imageCache: ImageCache) {
    self.imageCache = imageCache
    super.init(frame: .zero)
    delegate = self
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) is not supported by PickMeUpMapRootView.")
  }

  var viewModel = MapViewModel() {
    didSet {
      let currentAnnotations = (annotations as! [MapAnnotation]) // In real world, cast instead of force unwrap.
      let updatedAnnotations = viewModel.availableRideLocationAnnotations
        + viewModel.pickupLocationAnnotations
        + viewModel.dropoffLocationAnnotations

      let diff = MapAnnotionDiff.diff(currentAnnotations: currentAnnotations, updatedAnnotations: updatedAnnotations)
      if !diff.annotationsToRemove.isEmpty {
        removeAnnotations(diff.annotationsToRemove)
      }
      if !diff.annotationsToAdd.isEmpty {
        addAnnotations(diff.annotationsToAdd)
      }

      if !viewModel.dropoffLocationAnnotations.isEmpty {
        zoomOutToShowDropoffLocation(pickupCoordinate: viewModel.pickupLocationAnnotations[0].coordinate)
      } else {
        zoomIn(pickupCoordinate: viewModel.pickupLocationAnnotations[0].coordinate)
      }
    }
  }

  func zoomIn(pickupCoordinate: CLLocationCoordinate2D) {
    let center = pickupCoordinate
    let span = defaultMapSpan
    let region = MKCoordinateRegion(center: center, span: span)
    setRegion(region, animated: false)
  }

  func zoomOutToShowDropoffLocation(pickupCoordinate: CLLocationCoordinate2D) {
    let center = pickupCoordinate
    let span = mapDropoffLocationSpan
    let region = MKCoordinateRegion(center: center, span: span)
    setRegion(region, animated: true)
  }

}

extension PickMeUpMapRootView: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard let annotation = annotation as? MapAnnotation else {
      return nil
    }
    let reuseID = reuseIdentifier(forAnnotation: annotation)
    guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) else {
      return MapAnnotationView(annotation: annotation, reuseIdentifier: reuseID, imageCache: imageCache)
    }
    annotationView.annotation = annotation
    return annotationView
  }

  func reuseIdentifier(forAnnotation annotation: MapAnnotation) -> String {
    return annotation.imageIdentifier
  }
}
