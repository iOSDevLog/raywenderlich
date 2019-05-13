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
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation
import CoreLocation

class PointOfInterest: NSObject { //has to be NSObject to use with MKAnnotation ... boo :(

  // MARK: - Properties
  let location: CLLocation
  let name: String
  let isRegenPoint: Bool
  let encounter: Encounter?

  // MARK: - Initializers
  init(name: String, location: CLLocation, isRegenPoint: Bool, encounter: Encounter? = nil) {
    self.name = name
    self.location = location
    self.isRegenPoint = isRegenPoint
    self.encounter = encounter
  }
}

extension PointOfInterest {
  static let AppleStore = PointOfInterest(name: "\"Fruit\" Store", location: CLLocation(latitude: 40.763560, longitude: -73.972321), isRegenPoint: true, encounter: Store.AppleStore)
  static let Balto = PointOfInterest(name: "Balto Statue", location: CLLocation(latitude: 40.7699631, longitude: -73.9732103), isRegenPoint: true)
  static let BoatHouse = PointOfInterest(name: "Entrance to Water Level", location: CLLocation(latitude: 40.7772265, longitude: -73.972275), isRegenPoint: true)
  static let Castle = PointOfInterest(name: "Castle", location: CLLocation(latitude: 40.7794379, longitude: -73.9712102), isRegenPoint: false, encounter: NPC.King)
  static let Cloisters = PointOfInterest(name: "Monastery", location: CLLocation(latitude: 40.8648668, longitude: -73.9339161), isRegenPoint: false)
  static let Hamilton = PointOfInterest(name: "Warrior's Memorial", location: CLLocation(latitude: 40.7796328, longitude: -73.9676018), isRegenPoint: false)
  static let Met = PointOfInterest(name: "Art Palace", location: CLLocation(latitude: 40.7790478, longitude: -73.96627832), isRegenPoint: false)
  static let Obelisk = PointOfInterest(name: "Obelisk", location: CLLocation(latitude: 40.7796328, longitude: -73.9676018), isRegenPoint: false)
  static let StatueOfLiberty = PointOfInterest(name: "Colossus", location: CLLocation(latitude: 40.6892534, longitude: -74.0466891), isRegenPoint: false)
  static let StrawberryFields = PointOfInterest(name: "Imagine Fields", location: CLLocation(latitude: 40.775556, longitude: -73.975), isRegenPoint: true)
  static let TavernOnGreen = PointOfInterest(name: "Tavern", location: CLLocation(latitude: 40.7721909, longitude: -73.9799102), isRegenPoint: true)
  static let TimesSquare = PointOfInterest(name: "Town", location: CLLocation(latitude: 40.758899, longitude: -73.9873197), isRegenPoint: false)
  static let Zoo = PointOfInterest(name: "Monster Menagerie", location: CLLocation(latitude: 40.767769, longitude: -73.971870), isRegenPoint: false, encounter: Monster.Goblin)
}
