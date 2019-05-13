//: [Previous](@previous)
//: # Closures & Collections
var names = ["Zeus", "Poseidon", "Ares", "Demeter"]

// sort() & sort(by:) - Sorts in place / mutates the original



// sorted() & sorted(by:) - Returns a new collection that is sorted



//: `filter`
var prices = [1.50, 10.00, 4.99, 2.30, 8.19]

// TODO: Rewrite the loop below using `filter`

// `filter` as a `for` loop
var arrayForFilteredResults: [Double] = []
for price in prices where price > 5 {
  arrayForFilteredResults.append(price)
}
arrayForFilteredResults

//: `map`
// TODO: Rewrite the loop below using `map`

// `map` as a `for` loop
var arrayForSalePrices: [Double] = []
for price in prices {
  arrayForSalePrices.append(price * 0.9)
}
arrayForSalePrices

//: `reduce`
// TODO: Rewrite the loop below using `reduce`

// `reduce` as a `for` loop - `array` version
var doubleForSum = 0.0
for price in prices {
  doubleForSum += price
}
doubleForSum


var stock = [1.50: 5, 10.00: 2, 4.99: 20, 2.30: 5, 8.19: 30]

// TODO: Rewrite the loop below using `reduce(into)`

// `reduce` as a `for` loop - `dictionary` version
var arrayForStockValues: [Double] = []
for (price, quantity) in stock {
  let value = price * Double(quantity)
  arrayForStockValues.append(value)
}
arrayForStockValues


//: `compactMap` & `flatMap`
let userInput = ["meow!", "15", "37.5", "seven"]

// TODO: Rewrite the loop below using `compactMap`

// `compactMap` as a `for` loop
var arrayForValidInput: [Int] = []
for input in userInput {
  guard let input = Int(input) else {
    continue
  }
  arrayForValidInput.append(input)
}
arrayForValidInput


let arrayOfDwarfArrays = [["Sleepy", "Grumpy", "Doc"], ["Thorin", "Nori"]]

// TODO: Use `flatMap` and `filter` to create a new array that only contains the dwarves with names starting after "M"

// `flatMap` as a `for` loop - I've leave this one as a bonus challenge!


//: [Next](@next)
