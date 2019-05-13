//: [Previous](@previous)
/*:
 ## Challenge Time - Dictionaries!
 
 Create a dictionary with the following keys: name, profession, country, state, and city. For the values, put your own name, profession, country, state, and city.
 */


var catie = [
  "name": "Catie",
  "profession": "Video Tutorialist",
  "country": "USA",
  "state": "VA",
  "city": "Goochland"
]


/*:
 You suddenly decide to move to Cleveland. Update your city to Cleveland, your state to Ohio, and your country to USA.
 */


catie["city"] = "Cleveland"
catie["state"] = "OH"
catie["country"] == "USA"


/*:
 Given a dictionary in the above format, write a function that prints a given person's city and state.
 */


func printLocation(ofPerson person: [String: String]) {
  if let state = person["state"],
    let city = person["city"] {
    print("They live in \(city), \(state)")
  }
}

printLocation(ofPerson: catie)


//: [Next](@next)
