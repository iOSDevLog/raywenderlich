/*
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

internal struct SingleSignOnRequest {
  private let callbackUrl: String
  internal let secret: String
  internal let nonce: String
  private let endpoint: String
  private let reauthenticate: Bool
  
  internal init(endpoint: String, secret: String, callbackUrl: String, reauthenticate: Bool) {
    self.endpoint = endpoint
    self.secret = secret
    self.callbackUrl = callbackUrl
    self.nonce = randomHexString(length: 40)
    self.reauthenticate = reauthenticate
  }
  
  internal var url: URL? {
    var cmpts = URLComponents(string: endpoint)
    cmpts?.queryItems = payload
    return cmpts?.url
  }
  
  private var payload: [URLQueryItem]? {
    guard let unsignedPayload = unsignedPayload else { return .none }
    let contents = unsignedPayload.toBase64()
    let signature = contents.hmac(algorithm: .sha256, key: secret)
    var params = [
      URLQueryItem(name: "sso", value: contents),
      URLQueryItem(name: "sig", value: signature)
    ]
    if reauthenticate {
      params.append(URLQueryItem(name: "reauthenticate", value: "1"))
    }
    return params
  }
  
  private var unsignedPayload: String? {
    var cmpts = URLComponents()
    cmpts.queryItems = [
      URLQueryItem(name: "callback_url", value: callbackUrl),
      URLQueryItem(name: "nonce", value: nonce)
    ]
    return cmpts.query
  }
}
