/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.


func findIndices(of value: Int, in array: [Int]) -> CountableRange<Int>? {
  guard let startIndex = startIndex(of: value, in: array, range: 0..<array.count)
  else {
    return nil
  }
  guard let endIndex = endIndex(of: value, in: array, range: 0..<array.count)
  else {
    return nil
  }
  return startIndex..<endIndex
}

func startIndex(of value: Int, in array: [Int], range: CountableRange<Int>) -> Int? {
  let middleIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
  
  if middleIndex == 0 || middleIndex == array.count - 1 {
    if array[middleIndex] == value {
      return middleIndex
    } else {
      return nil
    }
  }
  
  if array[middleIndex] == value {
    if array[middleIndex - 1] != value {
      return middleIndex
    } else {
      return startIndex(of: value, in: array, range: range.lowerBound..<middleIndex)
    }
  } else if value < array[middleIndex] {
    return startIndex(of: value, in: array, range: range.lowerBound..<middleIndex)
  } else {
    return startIndex(of: value, in: array, range: middleIndex..<range.upperBound)
  }
}

func endIndex(of value: Int, in array: [Int], range: CountableRange<Int>) -> Int? {
  let middleIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
  
  if middleIndex == 0 || middleIndex == array.count - 1 {
    if array[middleIndex] == value {
      return middleIndex + 1
    } else {
      return nil
    }
  }
  
  if array[middleIndex] == value {
    if array[middleIndex + 1] != value {
      return middleIndex + 1
    } else {
      return endIndex(of: value, in: array, range: middleIndex..<range.upperBound)
    }
  } else if value < array[middleIndex] {
    return endIndex(of: value, in: array, range: range.lowerBound..<middleIndex)
  } else {
    return endIndex(of: value, in: array, range: middleIndex..<range.upperBound)
  }
}







extension RandomAccessCollection where Element: Comparable {
  func binarySearch(for value: Element, in range: Range<Index>? = nil) -> Index? {
    let range = range ?? startIndex..<endIndex

    guard range.lowerBound < range.upperBound else {
      return nil
    }

    let size = distance(from: range.lowerBound, to: range.upperBound)
    let middle = index(range.lowerBound, offsetBy: size / 2)
    if self[middle] == value {
      return middle
    } else if self[middle] > value {
      return binarySearch(for: value, in: range.lowerBound..<middle)
    } else {
      return binarySearch(for: value, in: index(after: middle)..<range.upperBound)
    }
  }
}
