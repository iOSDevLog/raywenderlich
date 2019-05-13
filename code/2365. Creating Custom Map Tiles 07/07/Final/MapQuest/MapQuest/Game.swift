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

import UIKit
import CoreLocation

let ENCOUNTER_RADIUS: CLLocationDistance = 10 //meters

enum FightResult {
  case HeroWon, HeroLost, Tie
}

enum ItemResult {
  case Purchased, NotEnoughMoney
}

let GameStateNotification = Notification.Name("GameUpdated")

protocol GameDelegate: class {
  func encounteredMonster(monster: Monster)
  func encounteredNPC(npc: NPC)
  func enteredStore(store: Store)
}

class Game {

  // MARK: - Properties
  static let shared = Game()
  var adventurer: Adventurer?
  var pointsOfInterest: [PointOfInterest] = []
  var lastPOI: PointOfInterest?
  var warps: [WarpZone] = []
  var reservoir: [CLLocationCoordinate2D] = []

  weak var delegate: GameDelegate?

  // MARK: - Initializers
  init() {
    adventurer = Adventurer(name: "Hero", hitPoints: 10, strength: 10)
    setupPOIs()
    setupWarps()
    setupResevoir()
  }

  private func setupPOIs() {
    pointsOfInterest = [.AppleStore, .Balto, .BoatHouse, .Castle, .Cloisters, .Hamilton, .Obelisk, .Met, .StrawberryFields, .StatueOfLiberty, .TavernOnGreen, .TimesSquare, .Zoo]
  }

  private func setupWarps() {
    warps = [WarpZone(latitude: 40.765158, longitude: -73.974774, color: #colorLiteral(red: 0.9882352941, green: 0.8, blue: 0.03921568627, alpha: 1)),
             WarpZone(latitude: 40.768712, longitude: -73.981590, color: #colorLiteral(red: 1, green: 0.3882352941, blue: 0.09803921569, alpha: 1)),
             WarpZone(latitude: 40.768712, longitude: -73.981590, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
             WarpZone(latitude: 40.776219, longitude: -73.976247, color: #colorLiteral(red: 1, green: 0.3882352941, blue: 0.09803921569, alpha: 1)),
             WarpZone(latitude: 40.776219, longitude: -73.976247, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
             WarpZone(latitude: 40.781987, longitude: -73.972020, color: #colorLiteral(red: 1, green: 0.3882352941, blue: 0.09803921569, alpha: 1)),
             WarpZone(latitude: 40.781987, longitude: -73.972020, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
             WarpZone(latitude: 40.785253, longitude: -73.969638, color: #colorLiteral(red: 1, green: 0.3882352941, blue: 0.09803921569, alpha: 1)),
             WarpZone(latitude: 40.785253, longitude: -73.969638, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
             WarpZone(latitude: 40.791605, longitude: -73.964853, color: #colorLiteral(red: 1, green: 0.3882352941, blue: 0.09803921569, alpha: 1)),
             WarpZone(latitude: 40.791605, longitude: -73.964853, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
             WarpZone(latitude: 40.796089, longitude: -73.961463, color: #colorLiteral(red: 1, green: 0.3882352941, blue: 0.09803921569, alpha: 1)),
             WarpZone(latitude: 40.796089, longitude: -73.961463, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
             WarpZone(latitude: 40.799988, longitude: -73.958480, color: #colorLiteral(red: 1, green: 0.3882352941, blue: 0.09803921569, alpha: 1)),
             WarpZone(latitude: 40.799988, longitude: -73.958480, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
             WarpZone(latitude: 40.798493, longitude: -73.952622, color: #colorLiteral(red: 0.9333333333, green: 0.2078431373, blue: 0.1803921569, alpha: 1)),
             WarpZone(latitude: 40.755238, longitude: -73.987405, color: #colorLiteral(red: 0.7254901961, green: 0.2, blue: 0.6784313725, alpha: 1)),
             WarpZone(latitude: 40.754344, longitude: -73.987105, color: #colorLiteral(red: 0.9882352941, green: 0.8, blue: 0.03921568627, alpha: 1)),
             WarpZone(latitude: 40.865757, longitude: -73.927088, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
             WarpZone(latitude: 40.701789, longitude: -74.013004, color: #colorLiteral(red: 0.9333333333, green: 0.2078431373, blue: 0.1803921569, alpha: 1))
    ]
  }

  private func setupResevoir() {
    reservoir = [
      CLLocationCoordinate2D(latitude: 40.78884, longitude: -73.95857),
      CLLocationCoordinate2D(latitude: 40.78889, longitude: -73.95824),
      CLLocationCoordinate2D(latitude: 40.78882, longitude: -73.95786),
      CLLocationCoordinate2D(latitude: 40.78867, longitude: -73.95758),
      CLLocationCoordinate2D(latitude: 40.78838, longitude: -73.95749),
      CLLocationCoordinate2D(latitude: 40.78793, longitude: -73.95764),
      CLLocationCoordinate2D(latitude: 40.78744, longitude: -73.95777),
      CLLocationCoordinate2D(latitude: 40.78699, longitude: -73.95777),
      CLLocationCoordinate2D(latitude: 40.78655, longitude: -73.95779),
      CLLocationCoordinate2D(latitude: 40.78609, longitude: -73.95818),
      CLLocationCoordinate2D(latitude: 40.78543, longitude: -73.95867),
      CLLocationCoordinate2D(latitude: 40.78469, longitude: -73.95919),
      CLLocationCoordinate2D(latitude: 40.78388, longitude: -73.95975),
      CLLocationCoordinate2D(latitude: 40.78325, longitude: -73.96022),
      CLLocationCoordinate2D(latitude: 40.78258, longitude: -73.96067),
      CLLocationCoordinate2D(latitude: 40.78227, longitude: -73.96101),
      CLLocationCoordinate2D(latitude: 40.78208, longitude: -73.96136),
      CLLocationCoordinate2D(latitude: 40.782, longitude: -73.96172),
      CLLocationCoordinate2D(latitude: 40.78201, longitude: -73.96202),
      CLLocationCoordinate2D(latitude: 40.78214, longitude: -73.96247),
      CLLocationCoordinate2D(latitude: 40.78237, longitude: -73.96279),
      CLLocationCoordinate2D(latitude: 40.78266, longitude: -73.96309),
      CLLocationCoordinate2D(latitude: 40.7832, longitude: -73.96331),
      CLLocationCoordinate2D(latitude: 40.78361, longitude: -73.96363),
      CLLocationCoordinate2D(latitude: 40.78382, longitude: -73.96395),
      CLLocationCoordinate2D(latitude: 40.78401, longitude: -73.96453),
      CLLocationCoordinate2D(latitude: 40.78416, longitude: -73.96498),
      CLLocationCoordinate2D(latitude: 40.78437, longitude: -73.9656),
      CLLocationCoordinate2D(latitude: 40.78456, longitude: -73.96601),
      CLLocationCoordinate2D(latitude: 40.78479, longitude: -73.96636),
      CLLocationCoordinate2D(latitude: 40.78502, longitude: -73.96661),
      CLLocationCoordinate2D(latitude: 40.78569, longitude: -73.96659),
      CLLocationCoordinate2D(latitude: 40.78634, longitude: -73.9664),
      CLLocationCoordinate2D(latitude: 40.78705, longitude: -73.96623),
      CLLocationCoordinate2D(latitude: 40.78762, longitude: -73.96603),
      CLLocationCoordinate2D(latitude: 40.78791, longitude: -73.96571),
      CLLocationCoordinate2D(latitude: 40.78816, longitude: -73.96533),
      CLLocationCoordinate2D(latitude: 40.78822, longitude: -73.9649),
      CLLocationCoordinate2D(latitude: 40.7882, longitude: -73.96445),
      CLLocationCoordinate2D(latitude: 40.78819, longitude: -73.96404),
      CLLocationCoordinate2D(latitude: 40.78814, longitude: -73.96378),
      CLLocationCoordinate2D(latitude: 40.7882, longitude: -73.96354),
      CLLocationCoordinate2D(latitude: 40.78819, longitude: -73.96327),
      CLLocationCoordinate2D(latitude: 40.78817, longitude: -73.96301),
      CLLocationCoordinate2D(latitude: 40.7882, longitude: -73.96269),
      CLLocationCoordinate2D(latitude: 40.7882, longitude: -73.96245),
      CLLocationCoordinate2D(latitude: 40.7883, longitude: -73.96217),
      CLLocationCoordinate2D(latitude: 40.7885, longitude: -73.96189),
      CLLocationCoordinate2D(latitude: 40.78874, longitude: -73.96161),
      CLLocationCoordinate2D(latitude: 40.78884, longitude: -73.96127),
      CLLocationCoordinate2D(latitude: 40.78885, longitude: -73.96093),
      CLLocationCoordinate2D(latitude: 40.78879, longitude: -73.9606),
      CLLocationCoordinate2D(latitude: 40.78869, longitude: -73.96037),
      CLLocationCoordinate2D(latitude: 40.78864, longitude: -73.96009),
      CLLocationCoordinate2D(latitude: 40.78863, longitude: -73.95972),
      CLLocationCoordinate2D(latitude: 40.78863, longitude: -73.95936),
      CLLocationCoordinate2D(latitude: 40.78867, longitude: -73.95895)
    ]
  }

  func visitedLocation(location: CLLocation) {
    guard let currentPOI = poiAtLocation(location: location) else { return }

    if currentPOI.isRegenPoint {
      regenAdventurer()
    }

    switch currentPOI.encounter {
    case let npc as NPC:
      delegate?.encounteredNPC(npc: npc)
    case let monster as Monster:
      delegate?.encounteredMonster(monster: monster)
    case let store as Store:
      delegate?.enteredStore(store: store)
    default:
      break
    }
  }

  func poiAtLocation(location: CLLocation) -> PointOfInterest? {
    for point in pointsOfInterest {
      let center = point.location
      let distance = abs(location.distance(from: center))
      if distance < ENCOUNTER_RADIUS {
        //debounce staying in the same spot for awhile
        if point != lastPOI {
          lastPOI = point
          return point
        } else {
          return nil
        }
      }
    }
    lastPOI = nil
    return nil
  }

  func regenAdventurer() {
    guard let adventurer = adventurer else { return }

    adventurer.hitPoints = adventurer.maxHitPoints
    adventurer.isDefeated = false
  }

  func fight(monster: Monster) -> FightResult? {
    guard let adventurer = adventurer else { return nil }

    defer { NotificationCenter.default.post(name: GameStateNotification, object: self) }

    //give the hero a fighting chance
    monster.hitPoints -= adventurer.strength
    if monster.hitPoints <= 0 {
      adventurer.gold += monster.gold
      return .HeroWon
    }

    adventurer.hitPoints -= monster.strength
    if adventurer.hitPoints <= 0 {
      adventurer.isDefeated = true
      return .HeroLost
    }

    return .Tie
  }

  func purchaseItem(item: Item) -> ItemResult? {
    guard let adventurer = adventurer else { return nil }

    defer { NotificationCenter.default.post(name: GameStateNotification, object: self) }

    if adventurer.gold >= item.cost {
      adventurer.gold -= item.cost
      adventurer.inventory.append(item)
      return .Purchased
    } else {
      return .NotEnoughMoney
    }

  }
}

extension Game {

  func image(for monster: Monster) -> UIImage? {
    switch monster.name {
    case Monster.Goblin.name:
      return UIImage(named: "goblin")
    case NPC.King.name:
      return UIImage(named: "king")
    default:
      return nil
    }
  }

  func image(for store: Store) -> UIImage? {
    return UIImage(named: "store")
  }

  func image(for item: Item) -> UIImage? {
    switch item.name {
    case Weapon.Sword6Plus.name:
      return UIImage(named: "sword")
    default:
      return nil
    }
  }
}
