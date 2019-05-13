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

public class KooberCloudNewRideRemoteAPI: NewRideRemoteAPI {
  let userSession: RemoteUserSession
  let urlSession: URLSession
  let domain = "localhost"

  public init(userSession: RemoteUserSession) {
    self.userSession = userSession

    let config = URLSessionConfiguration.default
    config.httpAdditionalHeaders = ["Authorization": "Bearer \(userSession.token)"]
    self.urlSession = URLSession(configuration: config)
  }

  public func getRideOptions(pickupLocation: Location) -> Promise<[RideOption]> {
    return Promise<[RideOption]> { fulfill, reject in
      // Build URL
      let urlString = "http://\(domain):8080/rideOptions?latitude=\(pickupLocation.latitude)&longitude=\(pickupLocation.longitude)"
      guard let url = URL(string: urlString) else {
        reject(RemoteAPIError.createURL)
        return
      }
      // Send Data Task
      urlSession.dataTask(with: url) { data, response, error in
        if let error = error {
          reject(error)
          return
        }
        guard let httpResponse = response as? HTTPURLResponse else {
          reject(RemoteAPIError.unknown)
          return
        }
        guard 200..<300 ~= httpResponse.statusCode else {
          reject(RemoteAPIError.httpError)
          return
        }
        guard let data = data else {
          reject(RemoteAPIError.unknown)
          return
        }
        do {
          let decoder = JSONDecoder()
          let rideOptions = try decoder.decode([RideOption].self, from: data)
          fulfill(rideOptions)
        } catch let error as NSError {
          reject(error)
        }
      }.resume()
    }
  }

  public func getLocationSearchResults(query: String, pickupLocation: Location) -> Promise<[NamedLocation]> {
    return Promise<[NamedLocation]> { fulfill, reject in
      // Build URL
      let urlString = "http://\(domain):8080/locations?query=\(query)&latitude=\(pickupLocation.latitude)&longitude=\(pickupLocation.longitude)"
      guard let url = URL(string: urlString) else {
        reject(RemoteAPIError.createURL)
        return
      }
      // Send Data Task
      urlSession.dataTask(with: url) { data, response, error in
        if let error = error {
          reject(error)
          return
        }
        guard let httpResponse = response as? HTTPURLResponse else {
          reject(RemoteAPIError.unknown)
          return
        }
        guard 200..<300 ~= httpResponse.statusCode else {
          reject(RemoteAPIError.httpError)
          return
        }
        guard let data = data else {
          reject(RemoteAPIError.unknown)
          return
        }
        do {
          let decoder = JSONDecoder()
          let searchResults = try decoder.decode([NamedLocation].self, from: data)
          fulfill(searchResults)
        } catch let error as NSError {
          reject(error)
        }
        }.resume()
    }
  }

  public func post(newRideRequest: NewRideRequest) -> Promise<()> {
    return Promise<Void> { fulfill, reject in
      // Build URL
      guard let url = URL(string: "http://\(domain):8080/ride") else {
        reject(RemoteAPIError.createURL)
        return
      }
      // Build Request
      var request = URLRequest(url: url)
      request.httpMethod = "POST"
      // Encode JSON
      do {
        let data = try JSONEncoder().encode(newRideRequest)
        request.httpBody = data
      } catch {
        reject(error)
        return
      }
      // Send Data Task
      urlSession.dataTask(with: request) { data, response, error in
        if let error = error {
          reject(error)
          return
        }
        guard let httpResponse = response as? HTTPURLResponse else {
          reject(RemoteAPIError.unknown)
          return
        }
        guard 200..<300 ~= httpResponse.statusCode else {
          reject(RemoteAPIError.httpError)
          return
        }
        fulfill(())
      }.resume()
    }
  }
}

extension RemoteAPIError: CustomStringConvertible {
  var description: String {
    switch self {
    case .unknown:
      return "Koober had a problem loading some data. Please try again soon!"
    case .createURL:
      return "Koober had a problem creating a URL. Please try again soon!"
    case .httpError:
      return "Koober had a problem loading some data. Please try again soon!"
    }
  }
}
