//: [Previous](@previous)
//: # Closures
//: Remember functions?
typealias Operate = (Int, Int) -> (Int)

func add(number1: Int, number2: Int) -> Int {
  return number1 + number2
}

func printResultOf(_ a: Int, _ b: Int, operation: Operate) {
  let result = operation(a, b)
  print("Result is \(result)")
}
printResultOf(5, 3, operation: add)

// TODO: Try Closures!







//: Closures close over values!
//////////////
var count = 0
let incrementCount = {
  count += 1
}
/////////////

// TODO: Try `incrementCount`


/////////////
func makeCountingClosure() -> () -> Int {
  var count = 0
  let incrementCount: () -> Int = {
    count += 1
    return count
  }
  return incrementCount
}
////////////

// TODO: Try `makeCountingClosure()`


//: [Next](@next)
