example(of: "using BidirectionalCollection") {
  var list = RefLinkedList<Int>()
  for i in 0...9 {
    list.push(i)
  }
  
  print(list)
  
  print("Reverse the list, and get the first 4 elements:")
  for value in list.reversed().suffix(4) {
    print(value)
  }
  
  print("drop last")
  for value in list.dropLast(2) {
    print(value)
  }
}

extension BidirectionalCollection where Element: Equatable {
  var isPalindrome: Bool {
    var start = startIndex
    var end = index(before: endIndex)
    while start < end {
      guard self[start] == self[end] else { return false }
      formIndex(after: &start)
      formIndex(before: &end)
    }
    return true
  }
}

example(of: "Given a word, find out if it is a palindrome.") {
  let string = "madam"
  print("\(string) is plaindrome: \(string.isPalindrome)")
  
  let string2 = "rwdevcon"
  print("\(string2) is plaindrome: \(string2.isPalindrome)")
}

