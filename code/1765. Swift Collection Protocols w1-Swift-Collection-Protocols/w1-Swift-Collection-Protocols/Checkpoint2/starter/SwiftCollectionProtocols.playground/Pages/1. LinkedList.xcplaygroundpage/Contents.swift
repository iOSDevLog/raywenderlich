var list: LinkedList<Int> {
  var list = LinkedList<Int>.end
  list.push(3)
  list.push(2)
  list.push(1)
  return list
}

example(of: "building a LL") {
  print(list)
}

example(of: "getting count of LL") {
  var current = list, count = 0
  while case .node(_, let next) = current {
    count += 1
    current = next
  }
  print(count)
}

