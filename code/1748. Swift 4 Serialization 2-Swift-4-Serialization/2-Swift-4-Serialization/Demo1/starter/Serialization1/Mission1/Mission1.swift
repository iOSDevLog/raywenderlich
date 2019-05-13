// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

// # Mission 1
// Implement Codable and test it with some encoders and decoders.

import Foundation
import XCTest

// Mars Rover Implementation

struct Sols {
  var value: Double
  init(_ value: Double) {
    self.value = value
  }
}

enum Camera {
  case mahli, mast, navcams, chemcam
}

struct Photo {
  var url: URL?
  var camera: Camera
  var time: Sols
}

struct Rover {
  var name: String
  var photos: [Photo]
}

// Testing

class Mission1: XCTestCase {
  let curiosity = Rover(name: "Curiosity", photos:
    [Photo(url: URL(string:"https://go.nasa.gov/2nquyg9"),
           camera: .navcams,
           time: Sols(1949))])
  
  func testEncodeDecodeJSON() {
    XCTFail("not implemented")
  }
  
  func testEncodeDecodePlist() {
    XCTFail("not implemented")
  }
}

