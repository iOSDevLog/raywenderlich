// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

// # Mission 2
//
// Make `Distance<Units>` output {"feet" = 3} or {"meters" = 1} depending
// on the `Units` type being used.  Generate a runtime error
// if the wrong `Distance` type is loaded from.


import XCTest

// Length Phantom types and Distance definition.

protocol Length {}
struct Feet: Length {}
struct Meters: Length {}

struct Distance<Units: Length>: Codable, Equatable, ExpressibleByFloatLiteral {
  var value: Double
  init(floatLiteral value: Double) {
    self.value = value
  }
  
  enum CodingKeys: String, CodingKey {
    case value
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.value = try container.decode(Double.self, forKey: .value)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(value, forKey: .value)
  }
}

class Mission2: XCTestCase {
  func testThrowsKeyNotFound() {
    let measurements: [Distance<Feet>] = [3.25, 4.25, 0.25]
    let encoder = JSONEncoder()
    let data = try! encoder.encode(measurements)
    print(String(data: data, encoding: .utf8)!)
    
    let decoder = JSONDecoder()
    dump(decoder)
    XCTFail()
  }
  
    
}
