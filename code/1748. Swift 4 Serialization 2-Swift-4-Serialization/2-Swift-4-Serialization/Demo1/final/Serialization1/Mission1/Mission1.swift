// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

// # Mission 1
// Implement Codable and test it with some encoders and decoders.

import Foundation
import XCTest

// Mars Rover Implementation

struct Sols: Codable {
  var value: Double
  init(_ value: Double) {
    self.value = value
  }
}

enum Camera: String, Codable {
  case mahli, mast, navcams, chemcam
}

struct Photo: Codable {
  var url: URL?
  var camera: Camera
  var time: Sols
}

struct Rover: Codable {
  var name: String
  var photos: [Photo]
}

// Testing

class Mission1: XCTestCase {
  let curiosity = Rover(name: "Curiosity", photos:
    [Photo(url: URL(string:"https://go.nasa.gov/2nquyg9"),
           camera: .navcams,
           time: Sols(1949))])
  
  func testEncodeDecodeJSON() throws {
    let encoder = JSONEncoder()
    let data = try encoder.encode(curiosity)
    print(String(data: data, encoding: .utf8)!)
    
    let decoder = JSONDecoder()
    let restored = try decoder.decode(Rover.self, from: data)
    dump(restored)
  }
  
  func testEncodeDecodePlist() throws {
    let encoder = PropertyListEncoder()
    encoder.outputFormat = .xml
    let data = try encoder.encode(curiosity)
    print(String(data: data, encoding: .utf8)!)
    
    let decoder = PropertyListDecoder()
    let restored = try decoder.decode(Rover.self, from: data)
    dump(restored)
  }
}

