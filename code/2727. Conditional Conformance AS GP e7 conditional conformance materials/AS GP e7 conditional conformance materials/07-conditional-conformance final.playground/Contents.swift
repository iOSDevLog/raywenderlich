// Copyright (c) 2018 Razeware LLC
// See Copyright Notice page for details about the license.

import Foundation

struct Pair<Element> {
  var first: Element
  var second: Element
}

extension Pair {
  var flipped: Pair { return Pair(first: second, second: first) }
}

extension Pair: Equatable where Element: Equatable {
}

extension Pair: Comparable where Element: Comparable {
  static func < (lhs: Pair<Element>, rhs: Pair<Element>) -> Bool {
    return lhs.first < rhs.second
  }
}

protocol Orderable {
  associatedtype Element
  func min() -> Element
  func max() -> Element
  func sorted() -> Self
}

extension Pair: Orderable where Element: Comparable {
  func min() -> Element { return first < second ? first : second }
  func max() -> Element { return first > second ? first : second }
  func sorted() -> Pair { return first < second ? self : flipped }
}

let bools = Pair(first: true, second: false)
let ints = Pair(first: 1000, second: 300)

ints.sorted()
ints.max()


