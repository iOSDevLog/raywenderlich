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

public struct KooberCloudAuthenticationRemoteAPI: AuthRemoteAPI {
  let domain = "localhost"

  public init() {}

  public func signIn(username:String, password: String) -> Promise<UserSession> {
    return Promise<UserSession> { fulfill, reject in
      // Build Request
      var request = URLRequest(url: URL(string: "http://\(domain):8080/login")!)
      request.httpMethod = "POST"
      // Build Auth Header
      let userPasswordData = "\(username):\(password)".data(using: .utf8)!
      let base64EncodedCredential = userPasswordData.base64EncodedString(options: [])
      let authString = "Basic \(base64EncodedCredential)"
      request.addValue(authString, forHTTPHeaderField: "Authorization")
      // Send Data Task
      let session = URLSession.shared
      session.dataTask(with: request) { (data, response, error) in
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
        if let data = data {
          do {
            let decoder = JSONDecoder()
            let payload = try decoder.decode(SignInResponsePayload.self, from: data)
            let remoteSession = RemoteUserSession(token: payload.token)
            fulfill(UserSession(profile: payload.profile, remoteSession: remoteSession))
          } catch {
            reject(error)
          }
        } else {
          reject(RemoteAPIError.unknown)
        }
      }.resume()
    }
  }

  public func signUp(account: NewAccount) -> Promise<UserSession> {
    return Promise<UserSession> { fulfill, reject in
      // Build Request
      let url = URL(string: "http://\(domain):8080/signUp")!
      var request = URLRequest(url: url)
      request.httpMethod = "POST"
      // Encode JSON
      do {
        let bodyData = try JSONEncoder().encode(account)
        request.httpBody = bodyData
      } catch {
        reject(error)
      }
      // Send Data Task
      let session = URLSession.shared
      session.dataTask(with: request) { (data, response, error) in
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
        if let data = data {
          do {
            let decoder = JSONDecoder()
            let payload = try decoder.decode(SignInResponsePayload.self, from: data)
            let remoteSession = RemoteUserSession(token: payload.token)
            fulfill(UserSession(profile: payload.profile, remoteSession: remoteSession))
          } catch {
            reject(error)
          }
        } else {
          reject(RemoteAPIError.unknown)
        }
        }.resume()
    }
  }
}

struct SignInResponsePayload: Codable {
  let profile: UserProfile
  let token: String
}
