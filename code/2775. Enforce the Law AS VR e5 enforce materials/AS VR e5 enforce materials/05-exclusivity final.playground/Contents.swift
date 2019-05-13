// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

func compute(_ a: inout Int, _ b: inout Int) {
  b = 100
  a = 10
}

var x = 0
var y = 0

compute(&x, &y)
dump((x,y))

//compute(&x, &x)  // This will trigger an exclusivity error

//////////////////////////////////////////////////////////////////////

extension MutableCollection {
  
  mutating func mutateEach(_ body: (inout Element) -> Void) {
    for index in indices {
      body(&self[index])
    }
  }
}

var array = [1, 2, 3]

array.mutateEach { element in
  element *= 42
  //array.append(2) // In a real project an error will be triggered [*]
}
array.append(contentsOf: Array(repeating: 42, count: array.count))

dump(array)


// [*] Overlapping accesses to 'array', but modification requires exclusive access;
