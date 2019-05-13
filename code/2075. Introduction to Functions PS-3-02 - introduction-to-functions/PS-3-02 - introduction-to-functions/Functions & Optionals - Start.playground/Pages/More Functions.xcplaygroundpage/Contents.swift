//: [Previous](@previous)
//: # More Functions
//: Function Overloading

func printMultipleOf(number: Int, multiplier: Int) {
    print("\(number) * \(multiplier) = \(number * multiplier)")
}

func printMultipleOf(_ number: Int, multiplier: Int = 1) {
    print("\(number) * \(multiplier) = \(number * multiplier)")
}

//: [Next](@next)
