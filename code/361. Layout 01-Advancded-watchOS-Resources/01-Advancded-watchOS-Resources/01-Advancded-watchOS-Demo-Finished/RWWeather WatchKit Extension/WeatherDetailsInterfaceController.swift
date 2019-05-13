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

class WeatherDetailsInterfaceController: WKInterfaceController {

  @IBOutlet var intervalLabel: WKInterfaceLabel!
  @IBOutlet var temperatureLabel: WKInterfaceLabel!
  @IBOutlet var conditionImage: WKInterfaceImage!
  @IBOutlet var conditionLabel: WKInterfaceLabel!
  @IBOutlet var feelsLikeLabel: WKInterfaceLabel!
  @IBOutlet var windLabel: WKInterfaceLabel!
  @IBOutlet var highTemperatureLabel: WKInterfaceLabel!
  @IBOutlet var lowTemperatureLabel: WKInterfaceLabel!

  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)

    guard let context = context as? NSDictionary, dataSource = context["dataSource"] as? WeatherDataSource else {
      return
    }

    if let index = context["shortTermForecastIndex"] as? Int {
      let weather = dataSource.shortTermWeather[index]

      intervalLabel.setText(weather.intervalString)
      updateCurrentForecastForWeather(weather)

      if let active = context["active"] as? Bool where active {
        becomeCurrentPage()
      }
    }

    if let index = context["longTermForecastIndex"] as? Int {
      let weather = dataSource.longTermWeather[index]

      setTitle(weather.intervalString)

      intervalLabel.setHidden(true)
      updateCurrentForecastForWeather(weather)
    }

  }

  func updateCurrentForecastForWeather(weather: WeatherData) {
    temperatureLabel.setText(weather.temperatureString)
    conditionLabel.setText(weather.weatherConditionString)
    conditionImage.setImageNamed(weather.weatherConditionImageName)
    feelsLikeLabel.setText(weather.feelTemperatureString)
    windLabel.setText(weather.windString)
    highTemperatureLabel.setText(weather.highTemperatureString)
    lowTemperatureLabel.setText(weather.lowTemperatureString)
  }

  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }

  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }

}
