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

enum Prim<Graph: DataStructures.Graph> where Graph.Element: Hashable {
  typealias Edge = Graph.Edge
  typealias Vertex = Edge.Vertex
  typealias MinimumSpanningTree = AdjacencyList<Graph.Element>

  static func getMinimumSpanningTree(for graph: Graph) -> (cost: Double, minimumSpanningTree: MinimumSpanningTree) {
    var cost = 0.0
    var minimumSpanningTree = MinimumSpanningTree(vertices: graph.vertices)

    guard let start = graph.vertices.first else {
      return (cost, minimumSpanningTree)
    }

    var visited: Set<Vertex> = []
    var priorityQueue = PriorityQueue<Edge> { $0.weight < $1.weight }

    func enqueueAvailableEdges(for vertex: Vertex) {
      for edge in graph.getEdges(from: vertex)
      where !visited.contains(edge.destination) {
        priorityQueue.enqueue(edge)
      }
    }
    
    visited.insert(start)
    
    enqueueAvailableEdges(for: start)
    while let lightestEdge = priorityQueue.dequeue() {
      let destination = lightestEdge.destination
    
      guard !visited.contains(destination) else {
        continue
      }
      
      visited.insert(destination)
      cost += lightestEdge.weight
      minimumSpanningTree.add(lightestEdge)

      enqueueAvailableEdges(for: destination)
    }
    
    return (cost, minimumSpanningTree)
  }
}
