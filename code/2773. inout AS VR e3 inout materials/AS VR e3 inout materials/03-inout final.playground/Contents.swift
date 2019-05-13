// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

struct Tracked<Value>: CustomDebugStringConvertible {
  
  private var _value: Value
  private(set) var readCount = 0
  private(set) var writeCount = 0
  
  init(_ value: Value) {
    self._value = value
  }
  
  var value: Value {
    mutating get {
      readCount += 1
      return _value
    }
    set {
      writeCount += 1
      _value = newValue
    }
  }
  
  mutating func resetCounts() {
    readCount = 0
    writeCount = 0
  }
  
  var debugDescription: String {
    return "\(_value) Reads: \(readCount) Writes: \(writeCount)"
  }
}

func computeNothing(input: inout Int) {
}

func compute100Times(input: inout Int) {
  for _ in 1...100 {
    input += 1
  }
}

var tracked = Tracked(42)
computeNothing(input: &tracked.value)
print("computeNothing", tracked)  // 1 Read and 1 Write for nothing

tracked.resetCounts()

compute100Times(input: &tracked.value)
print("compute100Times", tracked)  // Still only 1 Read and 1 Write

