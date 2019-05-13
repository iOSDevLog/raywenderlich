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

protocol Graph {
  associatedtype Element

  typealias Edge = GraphEdge<Element>
  typealias Vertex = Edge.Vertex

  var vertices: [Vertex] { get }

  @discardableResult mutating func addVertex(_: Element) -> Vertex
  func getEdges(from: Vertex) -> [Edge]
}

struct GraphVertex<Element> {
  let index: Int
  let element: Element
}

extension GraphVertex: Equatable where Element: Equatable { }
extension GraphVertex: Hashable where Element: Hashable { }

struct GraphEdge<Element> {
  typealias Vertex = GraphVertex<Element>

  let source: Vertex
  let destination: Vertex
  let weight: Double
}

extension GraphEdge: Equatable where Element: Equatable { }
extension GraphEdge: Hashable where Element: Hashable { }

extension Graph where Element: Hashable {
  func getPaths(from source: Vertex, to destination: Vertex) -> Set<[Edge]> {
    var completedPaths: Set<[Edge]> = []

    var activePaths = Set( getEdges(from: source).map { [$0] } )
    while !activePaths.isEmpty {
      for path in activePaths {
        defer { activePaths.remove(path) }

        let pathEnd = path.last!.destination

        if pathEnd == destination {
          completedPaths.insert(path)
          continue
        }

        getEdges(from: pathEnd)
        .filter {
          !path.map { $0.source } .contains($0.destination)
        }
        .forEach { activePaths.insert(path + [$0]) }
      }
    }

    return completedPaths
  }
}
