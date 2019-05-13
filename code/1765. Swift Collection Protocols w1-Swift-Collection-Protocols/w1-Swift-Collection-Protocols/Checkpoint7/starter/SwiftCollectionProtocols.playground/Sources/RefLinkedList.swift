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

extension RefLinkedList: RangeReplaceableCollection, BidirectionalCollection, MutableCollection {
  
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
  
  public mutating func replaceSubrange<C>(_ subrange: Range<Index>, with newElements: C) where C : Collection, Element == C.Element {
    // removeFirst(), removeSubrange(range), removeFirst(n:Int), removeAll(capacity)
    if newElements.isEmpty {
      if subrange.lowerBound.node === head { // 1
        head = subrange.upperBound.node
        if subrange.upperBound.node === nil {
          tail = nil
        }
      } else if subrange.upperBound.node === nil { // 2
        tail = subrange.lowerBound.node?.previous
        tail?.next = nil
      } else { // 3
        subrange.lowerBound.node?.previous?.next = subrange.upperBound.node
        subrange.upperBound.node?.previous = subrange.lowerBound.node?.previous
      }
      
      return
    }
    
    var lowerBound = subrange.lowerBound
    var upperBound = subrange.upperBound
    
    for element in newElements {
      if lowerBound.node == nil && upperBound.node == nil { // append, or insert at the endIndex
        
        let newNode = LinkedListNode(element)
        tail?.next = newNode
        newNode.previous = tail
        tail = newNode
        
        if head == nil {
          head = tail
        }
      } else { // Insert subRange
        let newNode = LinkedListNode(element)
        
        if lowerBound.node === head && upperBound.node === head { // Update Head if inserting from head.
          head = newNode
        }
        
        // Connect new node with PREVIOUS node next/previous pointers.
        lowerBound.node?.previous?.next = newNode
        newNode.previous = lowerBound.node?.previous
        
        // Connect new node with NEXT node's next/previous pointer
        newNode.next = subrange.upperBound.node // connect new node to next node.
        upperBound.node?.previous = newNode
        
        lowerBound.node = newNode.next
        upperBound.node = newNode.next // update new lower/upper bounds if more than one element added.
      }
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

