//
//  MockSession.swift
//  DogYears
//
//  Created by Brian on 12/12/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import Foundation

class MockSession: URLSessionProtocol {
  func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
    completionHandler(Data(), nil, nil)
    return MockDataTask()
  }
}
