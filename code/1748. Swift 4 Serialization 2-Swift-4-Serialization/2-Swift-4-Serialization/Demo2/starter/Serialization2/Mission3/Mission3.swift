// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

// # Mission 3
//
// Make an `AnyDistance` type that can handle `Distance<Meters>` or `Distance<Feet>`
// It should be able to read in a JSON archive that looks like this:
// [{"feet":3.25},{"meters":4.25},{"feet":0.25}]

import XCTest

enum AnyDistance: Codable {
  
  enum CodingKeys: String, CodingKey {
    case meters
    case feet
  }
  
  case meters(Distance<Meters>)
  case feet(Distance<Feet>)
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    switch self {
    case .meters(let meters):
      try container.encode(meters.value, forKey: .meters)
    case .feet(let feet):
      try container.encode(feet.value, forKey: .feet)
    }
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    guard container.allKeys.count == 1 else {
      let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "wrong number of keys")
      throw DecodingError.dataCorrupted(context)
    }
    enum Err: Error { case NotImplemented }
    throw Err.NotImplemented
  }
}

class Mission3: XCTestCase {
  func testVariantDistance() throws {
    let jsonString = """
      [{"feet":3.25},{"meters":4.25},{"feet":0.25}]
      """
    let jsonData = jsonString.data(using: .utf8)!
  
    let decoder = JSONDecoder()
    let restored = try decoder.decode([Distance<Meters>].self, from: jsonData)
    XCTAssertEqual(restored.count, 3)
  }
}
