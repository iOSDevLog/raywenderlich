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

import Foundation

class PancakeHouseCollection {
  private var _pancakeHouses = [PancakeHouse]()
  private var _favorite: PancakeHouse?

  /** Get the number of pancake houses in the collection */
  var count: Int {
    return _pancakeHouses.count
  }

  /** Subscript access */
  subscript(index: Int) -> PancakeHouse {
    return _pancakeHouses[index]
  }

  /** Loads test data from the bundled plist. Replaces the contents of the collection with the test data. */
  func loadTestData() {
    if let testPancakeHouses = PancakeHouse.loadDefaultPancakeHouses() {
      _pancakeHouses = testPancakeHouses
    }
  }

  /** Read-only property on whether the collection is synced to the cloud or not. App must be running with a user logged in for this to be true. */
  var isCloudCollection: Bool {
    return false
  }

  /** Loads test data from the cloud if this is a cloud-enabled collection.

  This method returns immediately and calls the completion handler when finished, with a Boolean parameter on whether data was loaded or not.

  Replaces the contents of the collection with the test data on success. */
  func loadCloudTestData(completion: (Bool -> ())?) {
    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) {
      guard self.isCloudCollection else {
        completion?(false)
        return
      }

      if let testPancakeHouses = PancakeHouse.loadDefaultPancakeHouses() {
        self._pancakeHouses = testPancakeHouses
        completion?(true)
      }
    }
  }

  /** Stores the current favorite pancake house. The one you set _must_ already be in the collection. */
  var favorite: PancakeHouse? {
    get {
      return _favorite
    }
    set {
      if let newValue = newValue {
        if _pancakeHouses.contains(newValue) {
          _favorite = newValue
        }
      } else {
        _favorite = nil
      }
    }
  }

  /** Checks if the passed-in pancake house is the favorite */
  func isFavorite(pancakeHouse: PancakeHouse) -> Bool {
    guard let currentFavorite = favorite else {
      return false
    }

    return currentFavorite == pancakeHouse
  }

  /** Add a new pancake house to the collection. */
  func addPancakeHouse(pancakeHouse: PancakeHouse) {
    _pancakeHouses.append(pancakeHouse)
  }

  /** Remove a pancake house from the collection. If it's the current favorite, doesn't remove it. */
  func removePancakeHouse(pancakeHouse: PancakeHouse) {
    if let index = _pancakeHouses.indexOf(pancakeHouse) {
      _pancakeHouses.removeAtIndex(index)
    }
  }

}
