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

/**
 Define our custom errors
 */
enum HTTPClientError {
  case invalidUrl
  case connectionError(errorDescription: String)
  case anotherRequestIsRunning
}

/**
 An HTTP Client that reads data from remote resources
 - Allows only a single dataTask request at a time
 - Returns the received Data or an HTTPClient.RequestError
 */
class HTTPClient {
  
  // MARK: Instance Objects
  
  let defaultSession = URLSession(configuration: .default)
  var dataTask: URLSessionDataTask?
  let semaphore = DispatchSemaphore(value: 1)
  
  // MARK: Request handling
  
  /**
   A closure type for our request method.
   */
  typealias RequestCompletedClosure = (_ requestData: Data?, _ error: HTTPClientError?) -> ()
  /**
   Request data from a remote resource.
   - Expects url and a completion closure.
   */
  func requestFrom(_ url: String, requestCompleted: @escaping RequestCompletedClosure) {
    // If we have another dataTask running, we bail on this one
    guard dataTaskNotRunning() else {
      requestCompleted(nil, .anotherRequestIsRunning)
      return
    }
    // ASSERT: Another task is not running
    
    guard let validUrl = URL(string:url) else {
      requestCompleted(Data(), .invalidUrl)
      self.clearDataTask()
      return
    }
    
    // ASSERT: We have a validurl
    
    dataTask = defaultSession.dataTask(with: validUrl) { data, response, error in

      defer {
        self.clearDataTask()
      }

      if let error = error {
        requestCompleted(nil, .connectionError(errorDescription: error.localizedDescription))
      } else if let data = data,
        let response = response as? HTTPURLResponse,
        response.statusCode == 200 {
        requestCompleted(data, nil)
      } else {
        // We should never ever be here since data and error should be exclusive
        requestCompleted(nil, .connectionError(errorDescription: "Unknown Error"))
      }
      
    }
    
    dataTask?.resume()
    
  }
  
  // MARK: Synch the checking and clearing of our dataTask (to prevent multiple requests)
  
  /**
   Clear the dataTask, but only if another conflicting operation is not in progress.
   Note, this is BLOCKING.
   */
  fileprivate func clearDataTask() {
    self.semaphore.wait()
    self.dataTask = nil
    self.semaphore.signal()
  }
  
  /**
   Check to see if another dataTask is running/pending, but when another conflicting operation has finished.
   Note, this is BLOCKING.
   */
  fileprivate func dataTaskNotRunning() -> Bool {
    var dataTaskNotRunning: Bool
    self.semaphore.wait()
    dataTaskNotRunning = self.dataTask == nil
    self.semaphore.signal()
    return dataTaskNotRunning
  }
  
}

