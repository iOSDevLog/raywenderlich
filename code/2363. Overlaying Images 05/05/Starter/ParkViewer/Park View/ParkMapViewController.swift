//
//  ParkMapViewController.swift
//  Park View
//
//  Created by Niv Yahel on 2014-11-09.
//  Copyright (c) 2014 Chris Wagner. All rights reserved.
//

import UIKit
import MapKit

enum MapType: Int {
  case Standard = 0
  case Hybrid
  case Satellite
}

class ParkMapViewController: UIViewController, MKMapViewDelegate {
  
  // MKMapViewDelegate requires init(coder aDecoder: NSCoder)
  /*
  required init(coder aDecoder: NSCoder) {
    // give a default
    park = Park(filename: "MagicMountain")
    super.init(coder: aDecoder)
  } */
  
  
  @IBOutlet weak var mapTypeSegmentedControl: UISegmentedControl!
  @IBOutlet weak var mapView: MKMapView!
  
  var park = Park(filename: "MagicMountain")
  var selectedOptions = [MapOptionsType]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    let latDelta = park.overlayTopLeftCoordinate.latitude -
      park.overlayBottomRightCoordinate.latitude
    
    // think of a span as a tv size, measure from one corner to another
    let span = MKCoordinateSpan(latitudeDelta: fabs(latDelta), longitudeDelta: 0)
    let region = MKCoordinateRegion(center: park.midCoordinate, span: span)

    mapView.region = region
  }
  
  func loadSelectedOptions() {
    // To be iplemented ...
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let optionsViewController = segue.destination as! MapOptionsViewController
    optionsViewController.selectedOptions = selectedOptions
  }
  
  @IBAction func closeOptions(exitSegue: UIStoryboardSegue) {
    let optionsViewController = exitSegue.source as! MapOptionsViewController
    selectedOptions = optionsViewController.selectedOptions
    self.loadSelectedOptions()
  }
  
  @IBAction func mapTypeChanged(sender: AnyObject) {
    let mapType = MapType(rawValue: mapTypeSegmentedControl.selectedSegmentIndex)
    switch (mapType!) {
    case .Standard:
      mapView.mapType = .standard
    case .Hybrid:
      mapView.mapType = .hybrid
    case .Satellite:
      mapView.mapType = .satellite
    }
  }
}
