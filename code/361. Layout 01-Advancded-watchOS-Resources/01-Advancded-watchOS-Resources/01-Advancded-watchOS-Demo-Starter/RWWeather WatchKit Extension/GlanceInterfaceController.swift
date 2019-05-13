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

import WatchKit
import Foundation

class GlanceInterfaceController: WKInterfaceController {
  lazy var dataSource: WeatherDataSource = {
    let defaultSystem = NSUserDefaults.standardUserDefaults().stringForKey("MeasurementSystem") ?? "Metric"

    if defaultSystem == "Metric" {
      return WeatherDataSource(measurementSystem: .Metric)
    }
    return WeatherDataSource(measurementSystem: .USCustomary)
  }()

  @IBOutlet var temperatureLabel: WKInterfaceLabel!
  @IBOutlet var conditionsImage: WKInterfaceImage!
  @IBOutlet var weatherDetailsLabel: WKInterfaceLabel!

  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)

    // Configure interface objects here.
  }

  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()

    let weather = dataSource.currentWeather

    temperatureLabel.setText(weather.temperatureString)
    conditionsImage.setImageNamed(weather.weatherConditionImageName)
    weatherDetailsLabel.setText("\(weather.weatherConditionString)\n\(weather.feelTemperatureString)")
  }

  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }

}
