public class LinkedListNode<Element> {
  public var data: Element
  public var next: LinkedListNode?
  weak public var previous: LinkedListNode?
  
  public init(_ data: Element, next: LinkedListNode? = nil, previous: LinkedListNode? = nil) {
    self.data = data
    self.next = next
    self.previous = previous
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
    let previousHead = head
    head = Node(value, next: previousHead)
    
    if tail == nil {
      tail = head
    } else {
      previousHead?.previous = head
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

extension RefLinkedList: BidirectionalCollection, MutableCollection {
  
  public struct Index: Comparable {
    public var node: Node?
    
    static public func ==(lhs: Index, rhs: Index) -> Bool {
      switch (lhs.node, rhs.node) {
      case let (left?, right?):
        return left.next === right.next && left.previous === right.previous
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
  
  public func index(before i: Index) -> Index {
    if i == endIndex {
      return Index(node: tail)
    } else {
      return Index(node: i.node?.previous)
    }
  }
  
  public subscript(position: Index) -> Element {
    get {
      guard let node = position.node else {
        fatalError("Node does not exist")
      }
      return node.data
    }
    
    set {
      guard let node = position.node else {
        fatalError("Node does not exist")
      }
      node.data = newValue
    }
  }
  
}

