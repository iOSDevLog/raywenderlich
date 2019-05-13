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

import XCTest
@testable import DataStructures

final class PrimTestCase: XCTestCase {
  func test() {
    var graph = AdjacencyList<Int>()

    let one = graph.addVertex(1)
    let two = graph.addVertex(2)
    let three = graph.addVertex(3)
    let four = graph.addVertex(4)
    let five = graph.addVertex(5)
    let six = graph.addVertex(6)

    for edge in [
      // minimum spanning tree edges:
      GraphEdge(source: one, destination: three, weight: 1),
      GraphEdge(source: two, destination: three, weight: 5),
      GraphEdge(source: two, destination: five, weight: 3),
      GraphEdge(source: three, destination: six, weight: 4),
      GraphEdge(source: four, destination: six, weight: 2),

      // other edges:
      GraphEdge(source: one, destination: two, weight: 6),
      GraphEdge(source: one, destination: four, weight: 5),
      GraphEdge(source: three, destination: four, weight: 5),
      GraphEdge(source: three, destination: five, weight: 6),
      GraphEdge(source: five, destination: six, weight: 6)
    ] {
      graph.add(edge)
    }

    XCTAssertEqual(
      "",
      """
        0: 1 -> 3 (1.0)

        1: 2 -> 3 (5.0)
                5 (3.0)

        2: 3 -> 1 (1.0)
                2 (5.0)
                6 (4.0)

        3: 4 -> 6 (2.0)

        4: 5 -> 2 (3.0)

        5: 6 -> 3 (4.0)
                4 (2.0)
        """
    )
  }
}
