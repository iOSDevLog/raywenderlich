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
 
 # Challenge Time! 😃

 Create a class named `Animal` that has…
1. a single stored property named `name`, that is a `String`
2. a required initializer that takes `name` as a parameter
3.  a function `speak()` that does nothing.
*/
class Animal {
  var name: String

  required init(name: String) {
    self.name = name
  }

  func speak() { }
}
/*:
 Create a class named `Dog` that…
1. inherits from `Animal`
2. has a property that stores how many tricks it has learned
3. implements the required initializer, defaulting the trick count to `0`, and calling `speak()` at the end
4. overrides the function `speak()` to greet you and says its name
*/
class Dog: Animal {
  var tricksLearnedCount: Int
  
  convenience required init(name: String) {
    self.init(name: name, tricksLearnedCount: 0)
  }
  
  init(name: String, tricksLearnedCount: Int) {
    self.tricksLearnedCount = tricksLearnedCount
    super.init(name: name)
    speak()
  }
  
  override func speak() {
    print("Bow wow! My name is \(name)!")
  }
}

Dog(name: "Shadow")
/*:
 Add a second (non-required) initializer to `Dog` that takes both the `name` and `numTricksLearned` as parameters. Then call this initializer from the required initializer.
*/
Dog(name: "Chance", tricksLearnedCount: 3)
/*:
 In an extension, add a convenience initializer to `Dog` that defaults the dog's name to your favorite dog's name, with however many tricks the dog has learned.
*/
extension Dog {
  convenience init(tricksLearnedCount: Int = .max) {
    self.init(name: "Tramp", tricksLearnedCount: tricksLearnedCount)
  }
}

Dog().tricksLearnedCount
