// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

// # Mission 1
//
// Modify Photo so that when the `url` is `nil` it always outputs
// a url key with a JSON value of null.

import XCTest

struct Photo: Codable, Equatable {
  
  enum CodingKeys: String, CodingKey {
    case url, camera, time
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(url, forKey: .url)
    try container.encode(camera, forKey: .camera)
    try container.encode(time, forKey: .time)
  }
  
  var url: URL?
  var camera: Camera
  var time: Sols
}

class Mission1: XCTestCase {
    func testAlwaysIncludeNull() throws {
      let photo = Photo(url: nil, camera: .chemcam, time: Sols(2))
      let encoder = JSONEncoder()
      let data = try encoder.encode(photo)
      let string = String(data: data, encoding: .utf8)!
      print(string)
      XCTAssertNotNil(string.range(of: "\"url\":"))
      try roundTripTest(item: photo)
    }
}
