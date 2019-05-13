/*:
 Copyright (c) 2018 Razeware LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 distribute, sublicense, create a derivative work, and/or sell copies of the
 Software in any work that is designed, intended, or marketed for pedagogical or
 instructional purposes related to programming, coding, application development,
 or information technology.  Permission for such use, copying, modification,
 merger, publication, distribution, sublicensing, creation of derivative works,
 or sale is expressly withheld.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 ---
 */
//: # Closures & Collections
var names = ["Zeus", "Poseidon", "Ares", "Demeter"]

// sort() & sort(by:) - Sorts in place / mutates the original
names.sort()
names.sort(by: { (a, b) -> Bool in
  a > b
})

// sorted() & sorted(by:) - Returns a new collection that is sorted
let longToShortNames = names.sorted {
  $0.count > $1.count
}

longToShortNames
names


//: `filter`
var prices = [1.50, 10.00, 4.99, 2.30, 8.19]

//let largePrices = prices.filter { price -> Bool in
//  return price > 5
//}
let largePrices = prices.filter { $0 > 5 }

// `filter` as a `for` loop
var arrayForFilteredResults: [Double] = []
for price in prices where price > 5 {
  arrayForFilteredResults.append(price)
}
arrayForFilteredResults

//: `map`
let salePrices = prices.map { price -> Double in
  return price * 0.9
}

// `map` as a `for` loop
var arrayForSalePrices: [Double] = []
for price in prices {
  arrayForSalePrices.append(price * 0.9)
}
arrayForSalePrices

//: `reduce`
//let sum = prices.reduce(0) { result, price -> Double in
//  return result + price
//}

let sum = prices.reduce(0, +)

// `reduce` as a `for` loop - `array` version
var doubleForSum = 0.0
for price in prices {
  doubleForSum += price
}
doubleForSum


var stock = [1.50: 5, 10.00: 2, 4.99: 20, 2.30: 5, 8.19: 30]

let stockSum = stock.reduce(into: []) { result, pair in
  result.append(pair.key * Double(pair.value))
}

// `reduce` as a `for` loop - `dictionary` version
var arrayForStockValues: [Double] = []
for (price, quantity) in stock {
  let value = price * Double(quantity)
  arrayForStockValues.append(value)
}
arrayForStockValues


//: `compactMap` & `flatMap`
let userInput = ["meow!", "15", "37.5", "seven"]

let validInput = userInput.compactMap { input in
  Int(input)
}

// `compactMap` as a `for` loop
var arrayForValidInput: [Int] = []
for input in userInput {
  guard let input = Int(input) else {
    continue
  }
  arrayForValidInput.append(input)
}
arrayForValidInput


let arrayOfDwarfArrays = [
  ["Sleepy", "Grumpy", "Doc"],
  ["Thorin", "Nori"]
]

// TODO: Use `flatMap` and `filter` to create a new array that only contains the dwarves with names starting after "M"
let dwarvesAfterM = arrayOfDwarfArrays.flatMap { array -> [String] in
  return array.filter { dwarf -> Bool in
    dwarf > "M"
  }
}
let sortedDwarves = dwarvesAfterM.sorted()


// `flatMap` as a `for` loop - I've leave this one as a bonus challenge!
