var list = LinkedList<Int>.end
list.push(3)
list.push(2)
list.push(1)


example(of: "using iterator directly") {
  var iterator = list.makeIterator()
  
  while let next = iterator.next() {
    print(next)
  }
}

example(of: "looping") {
  
  // for-in loop
  var forIn = ""
  for value in list {
    forIn += "\(value) "
  }
  print(forIn)
  
  // forEach
  var forEach = ""
  list.forEach { forEach += "\($0) " }
  print(forEach)
  
  // map
  let array = list.map { $0 }
  print(array)
  
  // filter
  let divisibleBy2 = list.filter { $0 % 2 == 0 }
  print(divisibleBy2)
  
  // reduce
  let sum = list.reduce(0, +)
  print(sum)
}

// Challenge: Find the value at the middle of the sequence
extension Sequence {
  var middle: Element? {
    var iterator1 = makeIterator()
    var iterator2 = makeIterator()
    
    while iterator2.next() != nil {
      guard iterator2.next() != nil else { return iterator1.next() }
      iterator1.next()
    }
    
    return iterator1.next()
  }
}

example(of: "finding middle value") {
  print(String(describing: list.middle))
}
