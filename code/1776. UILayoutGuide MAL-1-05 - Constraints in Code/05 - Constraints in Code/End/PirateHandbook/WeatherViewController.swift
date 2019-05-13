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

final class WeatherViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let images = [#imageLiteral(resourceName: "weather-sun"), #imageLiteral(resourceName: "weather-windy"), #imageLiteral(resourceName: "weather-thunderstorm")]
    
    let imageViews: [UIImageView] = images.map {image in
      let imageView = UIImageView(image: image)
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
    }
    
    let spacerGuides = (0..<images.count - 1).map {_ in UILayoutGuide()}
    let containerGuide = UILayoutGuide()
    
    imageViews.forEach(view.addSubview)
    spacerGuides.forEach(view.addLayoutGuide)
    view.addLayoutGuide(containerGuide)
  }
}












