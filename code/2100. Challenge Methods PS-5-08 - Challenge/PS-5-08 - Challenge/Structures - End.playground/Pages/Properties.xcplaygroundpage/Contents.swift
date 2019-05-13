

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
        print("No spaces allowed! \(firstName) is not a first name. Reverting name to \(oldValue)")
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

var wizard = Wizard(firstName: "Gandalf", lastName: "Greyjoy")
wizard.firstName = "Hermione"
wizard.lastName = "Kenobi"
wizard.fullName

wizard.fullName = "Severus Wenderlich"
wizard.firstName = "Merlin Rincewind"

print(wizard.magicalCreature)
wizard.fullName = "Qui-Gon Crayskull"
print(wizard.magicalCreature)

Wizard.commonMagicalIngredients









//: [Next](@next)
