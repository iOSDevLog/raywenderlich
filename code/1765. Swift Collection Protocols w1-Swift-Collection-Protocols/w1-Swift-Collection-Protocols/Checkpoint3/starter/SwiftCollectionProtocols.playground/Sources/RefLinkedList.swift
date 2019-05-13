public class LinkedListNode<Element> {
  public var data: Element
  public var next: LinkedListNode?
  
  public init(_ data: Element, next: LinkedListNode? = nil) {
    self.data = data
    self.next = next
  }
}

extension LinkedListNode: CustomStringConvertible {
  
  public var description: String {
    guard let next = next else {
      return "\(data)"
    }
    return "\(data) -> " + String(describing: next) + " "
  }
}

public struct RefLinkedList<Element> {
  public typealias Node = LinkedListNode<Element>
  
  public var head: Node?
  public var tail: Node?
  
  
  public init() {}
  
  public mutating func push(_ value: Element) {
    head = Node(value, next: head)
    if tail == nil {
      tail = head
    }
  }
}

extension RefLinkedList: CustomStringConvertible {
  
  public var description: String {
    guard let head = head else {
      return "Empty list"
    }
    return String(describing: head)
  }
}

extension RefLinkedList: Collection {
  
  public struct Index: Comparable {
    public var node: Node?
    
    static public func ==(lhs: Index, rhs: Index) -> Bool {
      switch (lhs.node, rhs.node) {
      case let (left?, right?):
        return left.next === right.next
      case (nil, nil):
        return true
      default:
        return false
      }
    }
    
    static public func <(lhs: Index, rhs: Index) -> Bool {
      guard lhs != rhs else {
        return false
      }
      let nodes = sequence(first: lhs.node) { $0?.next }
      return nodes.contains { $0 === rhs.node }
    }
  }
  
  public var startIndex: Index {
    return Index(node: head)
  }
  
  public var endIndex: Index {
    return Index(node: nil)
  }
  
  public func index(after i: Index) -> Index {
    return Index(node: i.node?.next)
  }
  
  public subscript(position: Index) -> Element {
    return position.node!.data
  }
}
