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

enum Dijkstra<Graph: DataStructures.Graph> where Graph.Element: Hashable {
  typealias Edge = Graph.Edge
  typealias Vertex = Edge.Vertex

  static func getEdges(alongPathsFrom source: Vertex, graph: Graph) -> [Vertex: Edge] {
    var edges: [Vertex: Edge] = [:]

    func getWeight(to destination: Vertex) -> Double {
      return getShortestPath(to: destination, edgesAlongPaths: edges)
        .map { $0.weight }
        .reduce(0, +)
    }

    var priorityQueue = PriorityQueue { getWeight(to: $0) < getWeight(to: $1) }
    priorityQueue.enqueue(source)
    while let vertex = priorityQueue.dequeue() {
      graph.getEdges(from: vertex)
        .filter {
          $0.destination == source
          ? false
          : edges[$0.destination] == nil
            || getWeight(to: vertex) + $0.weight < getWeight(to: $0.destination)
        }
        .forEach { newEdgeFromVertex in
          edges[newEdgeFromVertex.destination] = newEdgeFromVertex
          priorityQueue.enqueue(newEdgeFromVertex.destination)
        }
    }

    return edges
  }

  static func getShortestPath(to destination: Vertex, edgesAlongPaths: [Vertex: Edge]) -> [Edge] {
    var shortestPath: [Edge] = []
    var destination = destination
    while let edge = edgesAlongPaths[destination] {
      shortestPath = [edge] + shortestPath
      destination = edge.source
    }
    return shortestPath
  }

  static func getShortestPath(
    from source: Vertex, to destination: Vertex,
    graph: Graph
  ) -> [Edge] {
    return getShortestPath(
      to: destination,
      edgesAlongPaths: getEdges(alongPathsFrom: source, graph: graph)
    )
  }
}
