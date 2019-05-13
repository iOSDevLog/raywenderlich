//: [Previous](@previous)
//: # More Functions
//: Function Overloading

func printMultipleOf(number: Int, multiplier: Int) {
  print("\(number) * \(multiplier) = \(number * multiplier)")
}

func printMultipleOf(_ number: Int, multiplier: Int = 1) {
  print("\(number) * \(multiplier) = \(number * multiplier)")
}

func printMultipleOf(number: Double, multiplier: Double) {
  print("\(number) * \(multiplier) = \(number * multiplier)")
}

printMultipleOf(number: 7.5, multiplier: 7.5)
printMultipleOf(17)

func getValue() -> Int {
  return 31
}

func getValue() -> String {
  return "meow"
}

let valueInt: Int = getValue()

func add(number1: Int, number2: Int) -> Int {
  return number1 + number2
}

var function = add
function(4, 2)

func subtract(number1: Int, number2: Int) -> Int {
  return number1 - number2
}
function = subtract
function(5, 7)

typealias Operate = (Int, Int) -> Int

func printResult(_ operation: Operate, _ a: Int, _ b: Int) {
  let result = operation(a, b)
  print(result)
}

printResult(add, 4, 2)
printResult(subtract, 4, 2)
//: [Next](@next)
