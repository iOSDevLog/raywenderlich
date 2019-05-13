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
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import MapKit
import AVFoundation

class MapViewController: UIViewController {

  @IBOutlet weak var mapView: MKMapView!
  var place: InterestingPlace?
  var places: [InterestingPlace] = []
  var sourcelocation: CLLocation?
  var travelDirections: [String] = []
  var voice: AVSpeechSynthesizer?
  
  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
        super.viewDidLoad()
    mapView.delegate = self
    guard let place = place else { return }
    let regionRadius: CLLocationDistance = 1000.0
    let region = MKCoordinateRegion(center: place.location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    voice = AVSpeechSynthesizer()
    loadDirections()
    
    mapView.setRegion(region, animated: true)

    mapView.addAnnotations(places)
    mapView.register(InterestingPlaceView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    mapView.register(ClusterView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
    
    tableView.delegate = self
    tableView.dataSource = self
    
    produceOverlay()
  }
    
  @IBAction func close(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  
  @IBAction func changeMapType(_ sender: UISegmentedControl) {
    
    if sender.selectedSegmentIndex == 0 || sender.selectedSegmentIndex == 1 {
      mapView.isHidden = false
      tableView.isHidden = true
      if sender.selectedSegmentIndex == 0 {
        mapView.mapType = .standard
      } else if sender.selectedSegmentIndex == 1 {
        mapView.mapType = .satellite
      }
    } else {
      mapView.isHidden = true
      tableView.isHidden = false
    }

  }
  
  private func produceOverlay() {
    var points: [CLLocationCoordinate2D] = []
    points.append(CLLocationCoordinate2DMake(40.063965, -82.346642))
    points.append(CLLocationCoordinate2DMake(40.063921, -82.346185))
    points.append(CLLocationCoordinate2DMake(40.063557, -82.346185))
    points.append(CLLocationCoordinate2DMake(40.063561, -82.347200))
    points.append(CLLocationCoordinate2DMake(40.063961, -82.347150))
    points.append(CLLocationCoordinate2DMake(40.063965, -82.346800))
    let polygon = MKPolygon(coordinates: &points, count: points.count)
    mapView.addOverlay(polygon)
  }
  

  private func loadDirections() {
    
    guard let start = sourcelocation, let end = place else { return }
    let request = MKDirections.Request()
    let startMapItem = MKMapItem(placemark: MKPlacemark(coordinate: start.coordinate))
    let endMapItem = MKMapItem(placemark: MKPlacemark(coordinate: end.coordinate))
    request.source = startMapItem
    request.destination = endMapItem
    request.requestsAlternateRoutes = false
    request.transportType = .automobile
    let directions = MKDirections(request: request)
    directions.calculate() {
      [weak self] (response, error) in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      if let route = response?.routes.first {
        let formatter = MKDistanceFormatter()
        self?.mapView.addOverlay(route.polyline)
        formatter.unitStyle = .full
        for step in route.steps {
          let distance = formatter.string(fromDistance: step.distance)
          self?.travelDirections.append(step.instructions + " (\(distance)")
        }
        self?.tableView.reloadData()
      }
    }
    
  }
  
  
}

extension MapViewController: MKMapViewDelegate {
  
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    
    if overlay is MKPolygon {
      let polyRenderer = MKPolygonRenderer(overlay: overlay)
      polyRenderer.strokeColor = UIColor.green
      polyRenderer.lineWidth = 8.0
      return polyRenderer
    } else {
      
      let polyLine = MKPolylineRenderer(overlay: overlay)
      polyLine.strokeColor = UIColor.blue
      return polyLine
      
    }
    
    
    
  }
  
}

extension MapViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let text = travelDirections[indexPath.row]
    let utterance = AVSpeechUtterance(string: text)
    voice?.speak(utterance)
    
  }
}

extension MapViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return travelDirections.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DirectionCell", for: indexPath)
    cell.textLabel?.text = travelDirections[indexPath.row]
    return cell
  }
  
  
}
