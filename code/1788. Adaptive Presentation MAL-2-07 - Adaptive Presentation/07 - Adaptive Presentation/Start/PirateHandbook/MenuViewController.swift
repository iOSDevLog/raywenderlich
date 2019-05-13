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

final class MenuViewController: UIViewController {
  @IBOutlet private var buttonStackView: UIStackView!
  private var weatherViewController: WeatherViewController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if traitCollection.horizontalSizeClass == .regular {
      addWeatherView()
      weatherViewController?.view.isHidden = false
    }
  }
  
  override func willTransition(
    to newCollection: UITraitCollection,
    with coordinator: UIViewControllerTransitionCoordinator
  ) {
    super.willTransition(to: newCollection, with: coordinator)
    
    switch newCollection.horizontalSizeClass {
    case .regular:
      if newCollection.horizontalSizeClass != traitCollection.horizontalSizeClass {
        addWeatherView()
      }
    case .compact: removeWeatherView()
    case .unspecified: break
    }
    
    coordinator.animate(alongsideTransition: nil) {_ in
      self.weatherViewController?.view.isHidden = false
    }
  }
}

//MARK: private
private extension MenuViewController {
  func addWeatherView() {
    guard let weatherViewController =
      storyboard?.instantiateViewController(
        withIdentifier: String(describing: WeatherViewController.self)
      ) as? WeatherViewController
    else {return}
    
    weatherViewController.view.translatesAutoresizingMaskIntoConstraints = false
    weatherViewController.willMove(toParent: self)
    weatherViewController.view.isHidden = true
    weatherViewController.backgroundImageView.isHidden = true
    view.addSubview(weatherViewController.view)
    NSLayoutConstraint.activate([
      weatherViewController.view.centerYAnchor.constraint(equalTo: buttonStackView.centerYAnchor),
      weatherViewController.view.leadingAnchor.constraint(equalTo: buttonStackView.trailingAnchor, constant: 100)
    ])
    
    addChild(weatherViewController)
    
    setOverrideTraitCollection(
      UITraitCollection(
        traitsFrom: [
          UITraitCollection(horizontalSizeClass: .compact),
          UITraitCollection(verticalSizeClass: .compact)
        ]
      ),
      forChild: weatherViewController
    )
    
    self.weatherViewController = weatherViewController
  }
  
  func removeWeatherView() {
    guard let weatherViewController = weatherViewController
    else {return}
    
    weatherViewController.willMove(toParent: nil)
    weatherViewController.view.removeFromSuperview()
    weatherViewController.removeFromParent()
    self.weatherViewController = nil
  }
}
