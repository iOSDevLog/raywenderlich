// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

// # Mission 5
// Just like photos Mission 4, "photos" are wrapped by a "mission_data" container
// and "photos" may or may not be present. This time you will solve it using
// a custom Codable implementation and not use a `MissionData` model.
//
// ```
// {"rover_name":"Curiosity","mission_data":{"photos":[{"url":"https://go.nasa.gov/2nquyg9","camera":"navcams","time":{"sols":1949}}]}}
// ```

import Foundation
import XCTest

// Mars Rover Implementation

struct Rover: Equatable, Codable {
  var name: String
  var photos: [Photo]
}

class Mission5: XCTestCase {
  func testCodable() throws {
    try roundTripTest(item: curiosity)
    try archiveTest(json: curiosityJSON, expected: curiosity)
  }
}

