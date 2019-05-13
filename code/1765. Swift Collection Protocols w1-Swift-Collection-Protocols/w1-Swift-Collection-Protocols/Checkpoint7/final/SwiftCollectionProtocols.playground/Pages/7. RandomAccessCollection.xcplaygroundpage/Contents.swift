
extension RandomAccessCollection where Element: Comparable {
  
  public func binarySearch(for value: Element) -> Index? {
    if isEmpty { return nil }
    var lowerBound = startIndex
    var upperBound = index(before: endIndex)
    
    while lowerBound <= upperBound {
      let dist = distance(from: lowerBound, to: upperBound)
      let mid = index(lowerBound, offsetBy: dist/2)
      let candidate = self[mid]
      if candidate == value {
        return mid
      } else if candidate < value {
        lowerBound = index(after: mid)
      } else {
        upperBound = index(before: mid)
      }
    }
    
    return nil
  }
}


example(of: "Trying our binary search.") {
  let list = [1, 2, 8, 20, 50, 100, 150]
  print("index of 20 is: \(list.binarySearch(for: 20)!)")
}


