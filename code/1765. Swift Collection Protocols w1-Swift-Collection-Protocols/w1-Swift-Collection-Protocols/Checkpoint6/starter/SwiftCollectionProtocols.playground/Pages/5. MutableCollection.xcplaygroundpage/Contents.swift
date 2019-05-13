example(of: "using MutableCollection") {
  var list = RefLinkedList<Int>()
  
  for i in 0...9 {
    list.push(i)
  }
  
  print(list)
  
  let index3 = list.index(of: 3)!
  let index4 = list.index(of: 9)!
  
  list[index3] = 100
  print(list)
  
  list.swapAt(index3, index4)
  print(list)
  
  print(list.sorted(by: <))
}


// Generalize Selection Sort as an extension of MutableCollection

extension MutableCollection where Element: Comparable {
  mutating func selectionSort() {
    guard self.count >= 2 else { return }
    
    for current in indices {
      var lowest = current
      var other = index(after: current)
      while other < endIndex {
        if self[lowest] > self[other] {
          lowest = other
        }
        
        other = index(after: other)
      }
      
      if lowest != current {
        swapAt(lowest, current)
      }
    }
  }
}

var list = [21, 10, 12, 1]
list.selectionSort()
print(list)

