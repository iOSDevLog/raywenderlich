///// Copyright (c) 2017 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation

/**
 This singleton class allows us to read remote data. Access via `StaffAPI.shared`.
 */
final class StaffAPI {
  
  static let shared = StaffAPI()
  private let httpClient = HTTPClient()
  private let apiHost = "http://localhost:3000/api"
  private let genericError = "There was an issue loading data. Please contact your app support."
  
  /**
   Private initializer.
  */
  private init() {

  }
  /**
   A type to define our StaffLoaded closure.
  */
  typealias StaffLoadedClosure = (_ staffList: [Staff]?, _ error: String?) -> ()
  
  /**
   Load the staff list (asynch), calling the closure when the request ends with data or in error
  */
  func loadStaffList(staffLoaded: @escaping StaffLoadedClosure) {
    
    // Make our network request (notice this one is staff2)
    httpClient.requestFrom(apiHost + "/staff2") { (data, error) in
      // Ensure we have data and no errors
      guard let data = data else {
        // Oops, we have no data, check for error
        if let error = error {
          // We had an error. Check to see what it was
          switch error {
          case .anotherRequestIsRunning:
            // Another request is running, so we'll just not call the closure to let this one die
            return
          case .invalidUrl:
            // The URL was invalid, so let's pass this back up
            staffLoaded(nil, self.genericError + " (Invalid remote address.)")
            break;
          case .connectionError(let errorDescription):
            // Something else
            staffLoaded(nil, self.genericError + " (\(errorDescription))")
            break;
          }
        } else {
          // we had no data and no error. We should never be here
          staffLoaded(nil, self.genericError)
        }
        return
      }
      
      // ASSERT: We have a good response (we have data)
      
      // Decode the JSON, letting Swift 4 do all the heavy lifting!
      let decoder = JSONDecoder()
      do {
        let staffList = try decoder.decode([Staff].self, from: data)
        // Return data through our closure
        staffLoaded(staffList, nil)
      } catch {
        // Error with the remote data
        staffLoaded(nil, self.genericError + " (Invalid remote data.)")
      }
    
    }
  }
}
