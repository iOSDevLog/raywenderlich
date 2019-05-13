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

private typealias Graph = AdjacencyList<String>
private typealias Vertex = Graph.Vertex

final class DijkstraTestCase: XCTestCase {
  func test_getShortestPath() {
    let shortestPath = Dijkstra.getShortestPath(from: a, to: d, graph: graph)
    XCTAssertEqual(String(shortestPath: shortestPath), "AGCED")
  }

  func test_getShortestPaths() {
    let shortestPaths = [
      a: nil,
      b: "AGCEB",
      c: "AGC",
      d: "AGCED",
      e: "AGCE",
      f: "AGHF",
      g: "AG",
      h: "AGH"
    ]
    XCTAssertEqual(
      shortestPaths,
      Dijkstra.getShortestPaths(from: a, graph: graph)
        .mapValues( String.init(shortestPath:) )
    )
  }

  private let (graph, a, b, c, d, e, f, g, h): (Graph, Vertex, Vertex, Vertex, Vertex, Vertex, Vertex, Vertex, Vertex) = {
    var graph = AdjacencyList<String>()

    let a = graph.addVertex("A")
    let b = graph.addVertex("B")
    let c = graph.addVertex("C")
    let d = graph.addVertex("D")
    let e = graph.addVertex("E")
    let f = graph.addVertex("F")
    let g = graph.addVertex("G")
    let h = graph.addVertex("H")

    for edge in [
      GraphEdge(source: a, destination: b, weight: 8),
      GraphEdge(source: a, destination: f, weight: 9),
      GraphEdge(source: a, destination: g, weight: 1),
      GraphEdge(source: b, destination: f, weight: 3),
      GraphEdge(source: b, destination: e, weight: 1),
      GraphEdge(source: c, destination: b, weight: 3),
      GraphEdge(source: c, destination: e, weight: 1),
      GraphEdge(source: c, destination: g, weight: 3),
      GraphEdge(source: d, destination: e, weight: 2),
      GraphEdge(source: f, destination: h, weight: 2),
      GraphEdge(source: g, destination: h, weight: 5)
    ] {
      graph.add(edge)
    }

    return (graph, a, b, c, d, e, f, g, h)
  } ()
}

private extension String {
  init?(shortestPath: [Graph.Edge]) {
    guard !shortestPath.isEmpty else {
      return nil
    }

    self = shortestPath.reduce(into: shortestPath[0].source.element) { string, edge in
      string += edge.destination.element
    }
  }
}
