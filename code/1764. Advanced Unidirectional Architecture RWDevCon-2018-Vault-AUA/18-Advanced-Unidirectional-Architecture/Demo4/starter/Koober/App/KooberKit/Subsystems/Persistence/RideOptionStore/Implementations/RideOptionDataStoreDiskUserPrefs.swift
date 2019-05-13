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
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation
import PromiseKit

public class RideOptionDataStoreDiskUserPrefs: RideOptionDataStore {
  let accessQueue = DispatchQueue(label: "com.razeware.kooberkit.rideoptiondatastore.userprefs.access")

  public init() {}

  public func update(rideOptions: [RideOption]) -> Promise<[RideOption]> {
    return Promise { fulfill, reject in
      self.accessQueue.async {
        let dictionaries = rideOptions.map { rideOption in
          return rideOption.asDictionary()
        }
        UserDefaults.standard.set(dictionaries, forKey: "ride_options")
        fulfill(rideOptions)
      }
    }
  }

  public func read() -> Promise<[RideOption]> {
    return Promise { fulfill, reject in
      self.accessQueue.async {
        guard let dictionaries = UserDefaults.standard.array(forKey: "ride_options") as? [[String: Any]] else {
          fulfill([])
          return
        }
        let rideOptions = dictionaries.map(RideOption.make(withEncodedDictionary:))
        fulfill(rideOptions)
      }
    }
  }

  public func flush() {
    self.accessQueue.async {
      UserDefaults.standard.removeObject(forKey: "ride_options")
    }
  }
}

extension RemoteImage {
  static func make(withEncodedDictionary dictionary: [String: String]) -> RemoteImage {
    let at1xURL = URL(string: dictionary["at1xURL"]!)!
    let at2xURL = URL(string: dictionary["at2xURL"]!)!
    let at3xURL = URL(string: dictionary["at3xURL"]!)!
    return RemoteImage(at1xURL: at1xURL, at2xURL: at2xURL, at3xURL: at3xURL)
  }

  func asDictionary() -> [String: String] {
    return ["at1xURL" : at1xURL.absoluteString,
            "at2xURL" : at2xURL.absoluteString,
            "at3xURL" : at3xURL.absoluteString]
  }
}

extension RideOption {
  static func make(withEncodedDictionary dictionary: [String: Any]) -> RideOption {
    let id = dictionary["id"]! as! String
    let name = dictionary["name"]! as! String
    let buttonRemoteImages = (RemoteImage.make(withEncodedDictionary: dictionary["buttonSelectedRemoteImage"] as! [String: String]), RemoteImage.make(withEncodedDictionary: dictionary["buttonRemoteImage"] as! [String: String]))
    let availableMapMarkerRemoteImage = RemoteImage.make(withEncodedDictionary: dictionary["availableMapMarkerRemoteImage"] as! [String: String])
    return RideOption(id: id,
                      name: name,
                      buttonRemoteImages: buttonRemoteImages,
                      availableMapMarkerRemoteImage: availableMapMarkerRemoteImage)
  }

  func asDictionary() -> [String: Any] {
    return ["id": id,
            "name": name,
            "buttonRemoteImage": buttonRemoteImages.unselected.asDictionary(),
            "buttonSelectedRemoteImage": buttonRemoteImages.selected.asDictionary(),
            "availableMapMarkerRemoteImage": availableMapMarkerRemoteImage.asDictionary()]
    
  }
}
