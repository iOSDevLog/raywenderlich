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

class InterfaceController: WKInterfaceController {

  @IBOutlet var windSpeedLabel: WKInterfaceLabel!
  @IBOutlet var conditionsImage: WKInterfaceImage!
  @IBOutlet var temperatureLabel: WKInterfaceLabel!
  @IBOutlet var feelsLikeLabel: WKInterfaceLabel!
  @IBOutlet var conditionsLabel: WKInterfaceLabel!

  @IBOutlet var shortTermForecastGroup1: WKInterfaceGroup!
  @IBOutlet var shortTermForecastGroup2: WKInterfaceGroup!

  @IBOutlet var shortTermForecastLabel1: WKInterfaceLabel!
  @IBOutlet var shortTermForecastLabel2: WKInterfaceLabel!
  @IBOutlet var shortTermForecastLabel3: WKInterfaceLabel!
  @IBOutlet var shortTermForecastLabel4: WKInterfaceLabel!
  @IBOutlet var shortTermForecastLabel5: WKInterfaceLabel!
  @IBOutlet var shortTermForecastLabel6: WKInterfaceLabel!

  @IBOutlet var longTermForecastTable: WKInterfaceTable!

  @IBOutlet var loadingImage: WKInterfaceImage!
  @IBOutlet var containerGroup: WKInterfaceGroup!

  lazy var dataSource: WeatherDataSource = {
    let defaultSystem = NSUserDefaults.standardUserDefaults().stringForKey("MeasurementSystem") ?? "Metric"

    if defaultSystem == "Metric" {
      return WeatherDataSource(measurementSystem: .Metric)
    }
    return WeatherDataSource(measurementSystem: .USCustomary)
  }()

  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)

    containerGroup.setHidden(false)
    loadingImage.setAlpha(0)
    loadingImage.setHeight(0)
    updateAllForecasts()
  }

  func updateAllForecasts() {
    updateCurrentForecast()
    updateShortTermForecast()
    updateLongTermForecast()
  }

  func updateLongTermForecast() {
    longTermForecastTable.setNumberOfRows(dataSource.longTermWeather.count, withRowType: "LongTermForecastRow")

    for (index, weather) in dataSource.longTermWeather.enumerate() {
      if let row = longTermForecastTable.rowControllerAtIndex(index) as? LongTermForecastRowController {
        row.dateLabel.setText(weather.intervalString)
        row.temperatureLabel.setText(weather.temperatureString)
        row.conditionsLabel.setText(weather.weatherConditionString)
        row.conditionsImage.setImageNamed(weather.weatherConditionImageName)
      }
    }
  }

  func updateCurrentForecast() {
    let weather = dataSource.currentWeather

    temperatureLabel.setText(weather.temperatureString)
    feelsLikeLabel.setText(weather.feelTemperatureString)
    windSpeedLabel.setText(weather.windString)
    conditionsLabel.setText(weather.weatherConditionString)

    conditionsImage.setImageNamed(weather.weatherConditionImageName)
  }

  func updateShortTermForecast() {
    let labels = [shortTermForecastLabel1, shortTermForecastLabel2, shortTermForecastLabel3, shortTermForecastLabel4, shortTermForecastLabel5, shortTermForecastLabel6]

    for i in 0..<labels.count {
      let label = labels[i]
      let weather = dataSource.shortTermWeather[i]
      label.setText("\(weather.intervalString)\n\(weather.temperatureString)")
    }
  }

  override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
    if segueIdentifier == "WeatherDetailsSegue" {
      let context: NSDictionary = [
        "dataSource": dataSource,
        "longTermForecastIndex": rowIndex
      ]

      return context
    }

    return nil
  }

  @IBAction func shortTermWeather1() {
    showShortTermForecastForIndex(0)
  }

  @IBAction func shortTermWeather2() {
    showShortTermForecastForIndex(dataSource.shortTermWeather.count/2)
  }

  @IBAction func shortTermWeather3() {
    showShortTermForecastForIndex(dataSource.shortTermWeather.count-1)
  }

  func showShortTermForecastForIndex(index: Int) {
    presentController([
      (name: "WeatherDetailsInterface", context: ["dataSource": dataSource, "shortTermForecastIndex": 0, "active": index == 0]),
      (name: "WeatherDetailsInterface", context: ["dataSource": dataSource, "shortTermForecastIndex": dataSource.shortTermWeather.count/2, "active": index == dataSource.shortTermWeather.count/2]),
      (name: "WeatherDetailsInterface", context: ["dataSource": dataSource, "shortTermForecastIndex": dataSource.shortTermWeather.count-1, "active": index == dataSource.shortTermWeather.count-1]),
    ])
  }

  @IBAction func switchToMetric() {
    dataSource = WeatherDataSource(measurementSystem: .Metric)
    updateAllForecasts()

    NSUserDefaults.standardUserDefaults().setObject("Metric", forKey: "MeasurementSystem")
    NSUserDefaults.standardUserDefaults().synchronize()
  }

  @IBAction func switchToUSCustomary() {
    dataSource = WeatherDataSource(measurementSystem: .USCustomary)
    updateAllForecasts()

    NSUserDefaults.standardUserDefaults().setObject("USCustomary", forKey: "MeasurementSystem")
    NSUserDefaults.standardUserDefaults().synchronize()
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
