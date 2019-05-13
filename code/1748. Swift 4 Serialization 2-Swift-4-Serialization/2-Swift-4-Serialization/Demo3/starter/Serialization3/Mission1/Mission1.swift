// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

// # Mission 1
//
// For this mission you will allow the Sample date to be an
// iso8601 date with or without milliseconds.

import XCTest

class Sample: Codable, Equatable {
  var date: Date
  init(date: Date) {
    self.date = date
  }
  
  enum SampleCodingKeys: String, CodingKey {
    case date
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: SampleCodingKeys.self)
    self.date = try dateStringDecode(forKey: .date, from: container, with: .iso8601Milliseconds)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: SampleCodingKeys.self)
    try container.encode(date, forKey: .date)
    try container.encode(DateFormatter.iso8601Milliseconds.string(from: date), forKey: .date)
  }
}

class Mission1: XCTestCase {
  func testMultipleDates() throws {
    let jsonString = """
          [{"date":"2018-02-23T09:51:33.013-0800"},
           {"date":"2018-02-23T09:51:33.013-0800"},
           {"date":"2018-02-23T09:51:33-0800"}]
          """
    
    let data = jsonString.data(using: .utf8)!
    let decoder = JSONDecoder()
    let samples = try decoder.decode([Sample].self, from: data)
    XCTAssertEqual(samples.count, 3)
  }
}
