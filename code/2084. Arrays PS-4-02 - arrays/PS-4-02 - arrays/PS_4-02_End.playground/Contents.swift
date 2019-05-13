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
//: # Arrays
//let pastries: [String] = ["cookie", "cupcake", "donut", "pie"]

var pastries: [String] = []
pastries.append("cookie")
pastries += ["cupcake", "donut", "pie", "brownie"]

//pastries.removeAll()
pastries.isEmpty

pastries.count
if let first = pastries.first,
  let min = pastries.min(),
  let max = pastries.max() {
  print(first, min, max)
}

let firstElement = pastries[0]
let firstThree = Array(pastries[1...3])
firstThree[0]

pastries.contains("donut")
pastries.contains("lasagna")

pastries.insert("tart", at: 0)

let removedTwo = pastries.remove(at: 2)
let removedLast = pastries.removeLast()

removedTwo
removedLast
pastries

pastries[0...1] = ["brownie", "fritter", "tart"]
pastries

pastries.swapAt(1, 2)

for (index, pastry) in pastries.enumerated() {
  print(index, pastry)
}
//: [Next](@next)
