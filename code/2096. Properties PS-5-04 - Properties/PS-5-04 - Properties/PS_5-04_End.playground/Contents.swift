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
struct Wizard {
  static var commonMagicalIngredients: [String] {
    return [
      "Polyjuice Potion",
      "Eye of Haystack Needle",
      "The Force"
    ]
  }
  
  var firstName: String {
    willSet {
      print("\(firstName) will be set to \(newValue)")
    }
    didSet {
      if firstName.contains(" ") {
        print("No spaces allowed! \(firstName) is not a first name. Reverting name to \(oldValue).")
        firstName = oldValue
      }
    }
  }
  
  var lastName: String
  
  var fullName: String {
    get { return "\(firstName) \(lastName)" }
    set {
      let nameSubstrings = newValue.split(separator: " ")
      
      guard nameSubstrings.count >= 2 else {
        print("\(newValue) is not a full name.")
        return
      }
      
      let nameStrings = nameSubstrings.map(String.init)
      firstName = nameStrings.first!
      lastName = nameStrings.last!
    }
  }
  
  lazy var magicalCreature = summonMagicalCreature(summoner: fullName)
  
  init(firstName: String, lastName: String) {
    self.firstName = firstName
    self.lastName = lastName
  }
}

var wizard = Wizard.init(firstName: "Gandalf", lastName: "Greyjoy")
wizard.firstName = "Hermione"
wizard.lastName = "Kenobi"
wizard.fullName

wizard.fullName = "Severus Wenderlich"
wizard.firstName = "Merlin Rincewind"

print(wizard.magicalCreature)
wizard.fullName = "Qui-Gon Crayskull"
print(wizard.magicalCreature)

Wizard.commonMagicalIngredients
