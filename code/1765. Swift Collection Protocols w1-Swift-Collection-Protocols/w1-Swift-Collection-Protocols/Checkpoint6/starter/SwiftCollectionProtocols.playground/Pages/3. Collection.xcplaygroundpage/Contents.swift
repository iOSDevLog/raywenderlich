example(of: "using collection") {
  var list = RefLinkedList<Int>()
  for i in 0...3 {
    list.push(i)
  }
  
  for i in list {
    print(i)
  }
  print("List: \(list)")
  print("First element: \(list[list.startIndex])")
}

// Challenge: Create a function that checks if a collection is in another collection. If it is, return the start index of the matching collection.
extension Collection where Element: Equatable {
  
  func index<Elements: Collection>(for elements: Elements) -> Index? where Elements.Element == Element {
    first: for index in indices {
      var current = index
      for element in elements {
        guard current != endIndex, element == self[current] else { continue first }
        formIndex(after: &current)
      }
      return index
    }
    return nil
  }
}

example(of: "challenge") {
  let array1 = [1, 2, 3]
  let array2 = [2, 3]
  
  array1.index(for: array2)
}

