// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

import Foundation

protocol TimeKeeper {
  var now: Date { get }
}

struct RealTime: TimeKeeper {
  var now: Date {
    return Date()
  }
}

struct Stopwatch {
  private var startTime: Date?
  private var accumulated: TimeInterval = 0
  internal var timeKeeper: TimeKeeper
  
  init(timeKeeper: TimeKeeper = RealTime()) {
    self.timeKeeper = timeKeeper
  }
  
  var isRunning: Bool {
    return startTime != nil
  }
  
  var elapsed: TimeInterval {
    return accumulated + (startTime.map { timeKeeper.now.timeIntervalSince($0) } ?? 0)
  }
  
  mutating func start() {
    startTime = timeKeeper.now
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


final class TestTimeKeeper: TimeKeeper {
  var now = Date()
}

let testTimeKeeper = TestTimeKeeper()

var stopwatch = Stopwatch(timeKeeper: testTimeKeeper)
stopwatch.elapsed == 0
stopwatch.isRunning == false

stopwatch.start()
stopwatch.isRunning == true
stopwatch.elapsed == 0
testTimeKeeper.now += 10
stopwatch.elapsed == 10
stopwatch.isRunning

stopwatch.pause()
stopwatch.isRunning == false
stopwatch.elapsed == 10
testTimeKeeper.now + 3
stopwatch.elapsed == 10

