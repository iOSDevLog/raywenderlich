import Foundation

public func slowSum(input: (Int, Int)) -> Int {
  sleep(1)
  return input.0 + input.1
}