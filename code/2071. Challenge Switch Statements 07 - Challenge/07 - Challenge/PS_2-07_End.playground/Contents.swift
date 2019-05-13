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

 Write a switch statement that takes an age as an integer and assigns the life stage related to that age, to a `String`. You can make up the life stages, or use our categorization as follows:
 * 0-2 years: Infant
 * 3-12 years: Child
 * 13-19 years: Teenager
 * 20-39: Adult
 * 40-60: Middle aged
 * 61+: Elderly
 */
let lifeStage: String
switch 35 {
case ..<0:
  lifeStage = "Not born yet"
case 0...2:
  lifeStage = "Infant"
case 3...12:
  lifeStage = "Child"
case 13...19:
  lifeStage = "Teenager"
case 20...39:
  lifeStage = "Adult"
case 40...60:
  lifeStage = "Middle aged"
case 61...:
  lifeStage = "Elderly"
case let age:
  fatalError("Unaccounted for age: \(age)")
}
/*:
 Write a switch statement that takes a tuple containing a `String` and an `Int`.  The `String` is a name, and the `Int` is an age. Use the same cases that you used above, and binding with `let` syntax, to assign the the name, followed by the life stage, to a `String` constant. For example, for the author of these challenges, you'd assign "Matt is an adult." to your constant.
 */
let lifeStageForName: String
switch ("Jessy", 35) {
case (let name, ..<0):
  lifeStageForName = "\(name) has not been born yet."
case (let name, 0...2):
  lifeStageForName = "\(name) is an infant."
case (let name, 3...12):
  lifeStageForName = "\(name) is a child."
case (let name, 13...19):
  lifeStageForName = "\(name) is a teenager."
case (let name, 20...39):
  lifeStageForName = "\(name) is an adult."
case (let name, 40...60):
  lifeStageForName = "\(name) is middle aged."
case (let name, 61...):
  lifeStageForName = "\(name) is elderly."
case (_, let age):
  fatalError("Unaccounted for age: \(age)")
}
