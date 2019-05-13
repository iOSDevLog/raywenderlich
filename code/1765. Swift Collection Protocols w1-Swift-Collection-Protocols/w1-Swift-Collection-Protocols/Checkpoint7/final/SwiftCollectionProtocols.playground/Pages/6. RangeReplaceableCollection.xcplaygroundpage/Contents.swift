
example(of: "using RangeReplaceableCollection to remove elements") {
  var list = RefLinkedList<Int>()

  for i in 0...9 {
    list.push(i)
  }
  
  print(list)
  
  print("removing first")
  list.removeFirst()
  print(list)
  
  print("removing subrange")
  print(list)
  let index7 = list.index(of: 7)!
  let index4 = list.index(of: 4)!
  list.removeSubrange(index7...index4)
  print(list)
  
  print("removing first n")
  print(list)
  list.removeFirst(3)
  print(list)
  
  print("remove all")
  list.removeAll()
  print(list)
}


example(of: "using RangeReplaceableCollection to insert/append elements") {
  var list = RefLinkedList<Int>()

  print("appending elements")
  list.append(3)
  print(list)
  
  list.append(5)
  print(list)
  
  print("inserting a new element at a specific index")
  list.insert(8, at: list.startIndex)
  print(list)
  
  let index5 = list.index(of: 5)!
  list.insert(21, at: index5)
  print(list)
  
  print("inserting a collection at a specific index")
  var list2 = RefLinkedList<Int>()
  list2.push(9)
  list2.push(8)
  list2.push(7)
  list2.push(6)
  print("Insert \(list2) into \(list)")
  list.insert(contentsOf: list2, at: index5)
  print(list)
  
  print("appending a collection to the end of the list")
  list.append(contentsOf: list2)
  print(list)
  
}


func removeOccurrences<T: RangeReplaceableCollection & BidirectionalCollection>(source: inout T, matching subsequence: T.SubSequence) where T.Element: Equatable {
  var startIndex = source.startIndex
  first: while startIndex < source.endIndex {
    var endIndex = startIndex
    for value in subsequence {
      guard value == source[endIndex] else {
        source.formIndex(after: &startIndex)
        continue first
      }
      source.formIndex(after: &endIndex)
    }
    source.removeSubrange(startIndex..<endIndex)
    
    if (startIndex != source.startIndex) {
      source.formIndex(before: &startIndex)
    }
    
  }
}


example(of: "Remove Occurrences for LinkedList<String>") {
  var list = RefLinkedList<String>()
  list.push("hello")
  list.push("hello")
  list.push("world")
  list.push("bob")
  list.push("hello")
  list.push("world")
  list.push("hello")
  list.push("world")
  list.push("world")

  var list2 = RefLinkedList<String>()
  list2.push("hello")
  removeOccurrences(source: &list, matching: list2.prefix(1))
}

example(of: "Remove Occurrences for [String]") {
  var stringArray = "hello hello world bob hello world hello world world"
  removeOccurrences(source: &stringArray, matching: "hello")
  print(stringArray)
}

example(of: "Remove Occurrences for String") {
  var stringArray = ["hello", "hello", "world", "bob", "hello", "world", "hello", "world", "world"]
  print(stringArray)
  removeOccurrences(source: &stringArray, matching: ["hello", "hello"])
  print(stringArray)
}




