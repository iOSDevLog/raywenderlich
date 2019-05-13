// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

struct Stack {
  
  private var storage: [Any] = []
  
  mutating func push(_ element: Any) {
    storage.append(element)
  }
  
  mutating func pop() -> Any? {
    return storage.popLast()
  }
  
  var top: Any? {
    return storage.last
  }
  
  var isEmpty: Bool {
    return top == nil
  }
  
}

var stack = Stack()
stack.push(20)
stack.push(21)
stack.pop() as! Int





