/**
 * Copyright (c) 2018 Razeware LLC
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
 * LIABILITY, WHETHER IN  AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import CoreLocation

class ViewController: UIViewController {

  var locationManager: CLLocationManager?
  var currentLocation: CLLocation?
  
  @IBOutlet weak var address: UILabel!
  @IBOutlet weak var placeName: UILabel!
  @IBOutlet weak var locationDistance: UILabel!
  @IBOutlet weak var placeImage: UIImageView!
  
  var placesViewController: PlaceScrollViewController?
  var places:[InterestingPlace] = []
  var selectedPlace:InterestingPlace? = nil
  lazy var geocoder = CLGeocoder()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let childViewController = children.first as? PlaceScrollViewController {
      placesViewController = childViewController
      placesViewController?.delegate = self
      
    }
    loadPlaces()
    placesViewController?.addPlaces(places: places)
    
    locationManager = CLLocationManager()
    locationManager?.delegate = self
    locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
    locationManager?.allowsBackgroundLocationUpdates = true

    selectedPlace = places.first
    updateUI()
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func selectPlace() {
    print("place selected")
  }
  
  @IBAction func startLocationService(_ sender: UIButton) {
    if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways {
      activateLocationService()
    } else {
      locationManager?.requestAlwaysAuthorization()
    }
  }
  
  private func activateLocationService() {
    locationManager?.startUpdatingLocation()
  }
  
  private func updateUI() {
    printLocationDetails()
    printLocationDistance()
  }
  
  func loadPlaces() {
    
    guard let entries = loadPlist() else { fatalError("Unable to load data") }
    
    for property in entries {
      guard let name = property["Name"] as? String,
        let address = property["Address"] as? String,
        let image = property["Image"] as? String else { fatalError("Error reading data") }
      
      let place = InterestingPlace(address: address, name: name, imageName: image)
      places.append(place)
    }
  }
  
  private func printLocationDistance() {
    guard let selectedPlace = selectedPlace, let currentLocation = currentLocation else { return }
    if selectedPlace.location == nil {
      geocodeLocation()
    } else {
      let distanceInMeters = currentLocation.distance(from: selectedPlace.location!)
      let distance = Measurement(value: distanceInMeters, unit: UnitLength.meters).converted(to: .miles)
      locationDistance.text = "\(distance)"
    }
  }
  
  private func geocodeLocation() {
    guard let selectedPlace = selectedPlace else { return }
    geocoder.geocodeAddressString(selectedPlace.address) {
      [weak self] (placemarks, error) in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      guard let placemark = placemarks?.first else { return }
      selectedPlace.location = placemark.location
      self?.printLocationDistance()
    }
  }
  
  private func printLocationDetails() {
    placeName.text = selectedPlace?.name
    guard let imageName = selectedPlace?.imageName,
      let image = UIImage(named:imageName) else { return }
    placeImage.image = image
    self.address.text = selectedPlace?.address
  }
  
  private func loadPlist() -> [[String: Any]]? {
    guard let plistUrl = Bundle.main.url(forResource: "Places", withExtension: "plist"),
      let plistData = try? Data(contentsOf: plistUrl) else { return nil }
    var placedEntries: [[String: Any]]? = nil
    
    do {
      placedEntries = try PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [[String: Any]]
    } catch {
      print("error reading plist")
    }
    return placedEntries
  }
}

extension ViewController: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    currentLocation = locations.first
    
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    
    if status == .authorizedWhenInUse || status == .authorizedAlways {
      activateLocationService()
    }
    
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
  }
}

extension ViewController: PlaceScrollViewControllerDelegate {
  func selectedPlaceViewController(_ controller: PlaceScrollViewController, didSelectPlace place: InterestingPlace) {
    selectedPlace = place
    updateUI()
  }
}

