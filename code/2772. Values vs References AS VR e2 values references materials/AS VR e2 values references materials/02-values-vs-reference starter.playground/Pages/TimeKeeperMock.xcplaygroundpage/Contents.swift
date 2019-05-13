// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

import Foundation

struct Stopwatch {
  private var startTime: Date?
  private var accumulated: TimeInterval = 0
  
  var isRunning: Bool {
    return startTime != nil
  }
  
  var elapsed: TimeInterval {
    return accumulated + (startTime.map { Date().timeIntervalSince($0) } ?? 0)
  }
  
  mutating func start() {
    startTime = Date()
  }
  
  mutating func pause() {
    accumulated = elapsed
    startTime = nil
  }
  
  mutating func reset() {
    startTime = nil
    accumulated = 0
  }
}
