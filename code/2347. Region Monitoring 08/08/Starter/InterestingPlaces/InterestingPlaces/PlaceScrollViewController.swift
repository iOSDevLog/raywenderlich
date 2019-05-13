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

protocol PlaceScrollViewControllerDelegate {
  func selectedPlaceViewController(_ controller: PlaceScrollViewController, didSelectPlace place: InterestingPlace)
}

class PlaceScrollViewController: UIViewController {

  var scrollView: UIScrollView!
  var stackView: UIStackView!
  var places: [InterestingPlace]?
  var delegate: PlaceScrollViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .black
    scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(scrollView)
    
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: .alignAllCenterX, metrics: nil, views:  ["scrollView": scrollView]))
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", options: .alignAllCenterX, metrics: nil, views:  ["scrollView": scrollView]))
    

    stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.spacing = 8
    scrollView.addSubview(stackView)
      
    scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[stackView]|", options: .alignAllCenterX, metrics: nil, views:  ["stackView": stackView]))
    scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[stackView]", options: .alignAllCenterX, metrics: nil, views:  ["stackView": stackView]))
    
  }

  func addPlaces(places: [InterestingPlace]) {
    self.places = places
    for (index, place) in places.enumerated() {
      let placeButton = UIButton(type: .custom)
      let widthConstraint = NSLayoutConstraint(item: placeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60)
      let heightConstraint = NSLayoutConstraint(item: placeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60)
      NSLayoutConstraint.activate([widthConstraint, heightConstraint])
      let image = UIImage(named: place.imageName)
      placeButton.setImage(image, for: .normal)
      placeButton.addTarget(self, action: #selector(selectedPlace(_:)), for: .touchUpInside)
      placeButton.tag = index
      stackView.addArrangedSubview(placeButton)
    }
  }

  @objc func selectedPlace(_ sender: UIButton) {
    guard let place = places?[sender.tag] else { return }
    delegate?.selectedPlaceViewController(self, didSelectPlace: place)
  }
  
    
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    scrollView.contentSize = CGSize(width: stackView.frame.width, height: stackView.frame.height)
  }

}
